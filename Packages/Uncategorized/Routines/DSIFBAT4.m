DSIFBAT4 ;DSS/RED - RPC FOR FEE BASIS PAYMENTS ;10/17/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2010, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ;  Integration Agreements
 ;  2053  FILE^DIE                       5273   ^FBAA(161.7
 ;  2056  GETS^DIQ                     5274   ^PRC(442
 ;  5300  ^PRC(424,"E")
 ;  5088  CNTTOT^FBAARB          10060   ^VA(200 
 ;  5090  STATION^FBAAUTL       10076   ^XUSEC("FBAASUPERVISOR" 
 ;  315   EN3^PRCS58                  2051   FIND1^DIC
 ;  831    ^PRCS58CC
 ;
 ; Routine for APIs used in Fee Basis batches: RPC's: DSIF EDIT BATCH
 Q  ;; no direct calls to routine
 ;
EDITBAT(FBOUT,FBIN) ; RPC: DSIF BATCH EDIT
 ; Input:   (All dates must be in FileMan format)
 ;  FBIN - Input array format:
 ;    FBIN(.01)=BATCH NUMBER (If "nnn;" is passed, then this is the IEN, changed with DSIF*3.2*1)
 ;    FBIN(1)=OBLIGATION NUMBER  (Do not send station number with obligation "500-C09045", only "C09045")
 ;    FBIN(3)=Date opened 
 ; Output: FBOUT=1^successful or -1^message
 ;  DSIF*3.2*2   -- user IEN input variable removed
 K FBOUT,DSIF N MSG,IENS,FILE,DSIF,FLAG,IEN,BTUSER,DSIFCP,PRCS,PRC,Y,FBBAT
 S FLAG=0,FBBAT=$G(FBIN(.01)) I FBBAT="" S FBOUT="-1^batch number missing" Q
 ;
 D START^DSIFBAT1(.FBBAT) I FLAG S FBOUT=FBERR Q
 I $G(FBIN(1))="" S FLAG=1
 I FLAG S FBOUT="-1^Not a valid Batch " Q
 S BTUSER=$P($G(^FBAA(161.7,IEN,0)),U,5) I 'BTUSER S FBOUT="-1^There is a problem with batch # "_FBIN(.01) Q
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ))&($G(BTUSER)'=DUZ) S FBOUT="-1^Must be the clerk who opened or supervisor" Q
 ;          Verify required variables
 ; Prepare data fields for filing
 S DSIFCP=FBIN(1) D CKOB Q:$D(FBOUT)
 S FBIN(1)=$S($P(FBIN(1),"-",2)'="":$P(FBIN(1),"-",2),1:FBIN(1))  ;Ensure station number is screened out
 S FILE="161.7",IENS=IEN_","                                                          ; Batch #
 S DSIF(FILE,IENS,1)=FBIN(1)                                                         ; Obligation Number
 S:$G(FBIN(3))]"" DSIF(FILE,IENS,3)=FBIN(3)                                    ; Date opened
 L +^FBAA(161.7,IEN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBOUT="-1^Please try again later, unable to edit at this time" Q
 D FILE^DIE("","DSIF","MSG") L -^FBAA(161.7,IEN)
 I '$D(MSG) S FBOUT="1^Edit was successful"
 ; Verify payment line item counts, reset if necessary
 N FILCNT,PMTCNT
 S FILCNT=$P(^FBAA(161.7,IEN,0),U,11),PMTCNT=0
 D PMCNT^DSIFBAT7(.PMTCNT,IEN) I FILCNT'=PMTCNT S $P(^FBAA(161.7,IEN,0),U,11)=PMTCNT  ;reset pmt count
 Q
 ;
CKOB D STATION^FBAAUTL I $D(FB("ERROR")) K FB("ERROR"),X S FBOUT="-1^Error in Site parameters" Q
 S PRC("SITE")=$S($D(PRC("SITE")):PRC("SITE"),1:FBSN) K FBSN,FBAASN
 S PRCS("X")=PRC("SITE")_"-"_DSIFCP,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 S FBOUT="-1^1358/Obligation not available for posting!" Q
 I '$D(^PRC(442,"B",PRC("SITE")_"-"_DSIFCP)) S FBOUT="-1^This Obligation number does not exist in the IFCAP file!" K PRC,X
 Q
 ;
REASSIGN(FBOUT,FBODUZ,FBNDUZ,FBBATIEN) ; RPC: DSIF BATCH REASSIGN
 ;Input:  FBODUZ = Person who opened batch, FBNDUZ = New person to assign batch to, FBBATIEN = Batch IEN
 ;Output:  FBOUT=1^Batch IEN;Batch Number^Old Username^New Username
 ;     or FBOUT=-1^Error message
 N FBOLDN,FBNEWN,FBIEN,DSIF,MSG,OUT,MENUIEN
 S:$G(U)="" U="^"
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) S FBOUT="-1^Sorry, you must be a supervisor to use this option" Q
 I $G(^FBAA(161.7,FBBATIEN,0))="" S FBOUT="-1^Not a valid Batch number" Q
 I $G(^VA(200,FBNDUZ,0))="" S FBOUT="-1^Invalid user selected to assign this batch to, quitting" Q
 I $P(^FBAA(161.7,FBBATIEN,0),U,6)'=""!($P(^FBAA(161.7,FBBATIEN,0),U,12)'="")!($P(^FBAA(161.7,FBBATIEN,0),U,14)'="") S FBOUT="-1^Batch is closed, cannot reassign"
 I $P(^FBAA(161.7,FBBATIEN,0),U,5)'=FBODUZ S FBOUT="-1^You cannot reassign this batch, wrong user name entered, please try again" Q
 I $P(^FBAA(161.7,FBBATIEN,0),U,14)'=""  S FBOUT="-1^Batch has been transmitted, quitting" Q
 S FBOLDN=$P($G(^VA(200,FBODUZ,0)),U),FBNEWN=$P($G(^VA(200,FBNDUZ,0)),U)
 L +^FBAA(161.7,FBBATIEN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBOUT="-1^Please try again later, unable to edit at this time" Q
 S DSIF(161.7,FBBATIEN_",",4)=FBNDUZ D FILE^DIE("","DSIF","MSG") L -^FBAA(161.7,FBBATIEN)
 I $D(MSG) S FBOUT="-1^File write error, please notify DSS" Q
 S FBOUT="1^"_FBBATIEN_";"_$P(^FBAA(161.7,FBBATIEN,0),U)_U_FBODUZ_";"_FBOLDN_U_FBNDUZ_";"_FBNEWN
 Q
BATDISP(FBOUT,FBBAT) ;RPC: DSIF BATCH DISP ITEMS
 ;FBBAT= Batch IEN
 ;FBOUT(1)="1" (or -1 on error)
 ;FBOUT(1)="L1"^batch number^Obligation^type^date opened^clerk who opened^date clerk closed
 ;FBOUT(2)="L2"^Date supervisor closed^Supervisor who certified^Total dollars^Invoice count^Payment line count^Status
 ;FBOUT(3)="L3"^Status^Date transmitted^Date Finalized^Person who completed^Rejects pending^Station number^contract hosp batch^Statistical batch
 ; 
 N IENS,FB,FBARR,FBLCNT,FBTOTAL
 I $G(FBBAT)="" S FBOUT(0)="-1^There was no required batch number passed in, cannot proceed" Q
 I '$D(^FBAA(161.7,FBBAT,0)) S FBOUT(0)="-1^Invalid batch number" Q
 S IENS=FBBAT_","
 D GETS^DIQ(161.7,IENS,"**","IE","FB") S FBARR=$NA(FB(161.7,IENS))
 D CNTTOT^FBAARB(FBBAT) ;Get number of payments and total
 S FBOUT(0)=1
 S FBOUT(1)="L1"_U_FBBAT_";"_@FBARR@(.01,"E")_U_$G(@FBARR@(1,"E"))_U_$G(@FBARR@(2,"I"))_";"_$G(@FBARR@(2,"E"))_U_$G(@FBARR@(3,"I"))_";"_$G(@FBARR@(3,"E"))
 S FBOUT(1)=FBOUT(1)_U_$G(@FBARR@(4,"I"))_";"_$G(@FBARR@(4,"E"))_U_$G(@FBARR@(4.5,"I"))_";"_$G(@FBARR@(4.5,"E"))
 S FBOUT(2)="L2"_U_$G(@FBARR@(5,"I"))_";"_$G(@FBARR@(5,"E"))_U_$G(@FBARR@(6,"I"))_";"_$G(@FBARR@(6,"E"))_U_$G(FBTOTAL)_U_$G(@FBARR@(9,"E"))_U_$G(FBLCNT)_U_$G(@FBARR@(11,"I"))_";"_$G(@FBARR@(11,"E"))
 S FBOUT(3)="L3"_U_$G(@FBARR@(12,"I"))_";"_$G(@FBARR@(12,"E"))_U_$G(@FBARR@(13,"I"))_";"_$G(@FBARR@(13,"E"))_U_$G(@FBARR@(14,"I"))_";"_$G(@FBARR@(14,"E"))_U_$G(@FBARR@(15,"E"))_U_$G(@FBARR@(16,"E"))_U_$G(@FBARR@(17,"E"))_U_$G(@FBARR@(18,"E"))
 Q
 ;
ADD ;call to add money back into 1358 when version of IFCAP>3.6
 ;uses interface ID look-up to get internal entry number
 ;interface ID = IEN of batch from 161.7
 ;find ien to 424 by $O(^PRC(424,"E",FBN,0))
 ;call NOT used for civil hospital/cnh
 ;  PRCSX=INT DAILY REF #^INTERNAL DATE/TIME^AMT OF PAYMENT^COMMENTS^COMPLETED FLAG^REFERENCE
 N FBADDX,FBAAMT S FBADDX=$O(^PRC(424,"E",+$G(FBN),0)) I 'FBADDX S FBERR=1 Q
 D NOW^%DTC
 S FBAAMT="-"_FBAARA
 S PRCSX=$G(FBADDX)_"^"_$G(%)_"^"_$G(FBAAMT)_"^"_$G(FBCOMM)_"^"_1
 D ^PRCS58CC I Y'=1 S FBOUT(0)="-1^"_$G(ID)_U_$P($G(Y),U,2),FBERR=1 Q
 Q
