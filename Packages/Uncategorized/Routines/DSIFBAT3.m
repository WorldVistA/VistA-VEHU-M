DSIFBAT3 ;DSS/RED - RPC FOR FEE BASIS BATCHES ;10/10/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,10,17,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ;        Integration Agreements
 ;  10000   NOW^%DTC                            5397   ^FB583(
 ;  10005   DT^DICRW                            5275   ^FBAA(161.4
 ;  10018   ^DIE                                5273   ^FBAA(161.7
 ;  2056    GETS^DIQ                            5107   ^FBAAC(
 ;  5081    PMNT^FBAACCB2                       5277   ^FBAAI(
 ;  5082    SITE^FBAACO                         5301   ^PRC(420
 ;  5088    CNTTOT^FBAARB                       5274   ^PRC(442
 ;  5090    $$DATX^FBAAUTL                      5573    UOKCERT^PRCEMOA
 ;  5093    $$PADZ^FBAAV01                      10076   ^XUSEC("FBAASUPERVISOR"
 ;  5098    $$ICD^FBCSV1, $$ICD0^FBCSV1, $$ICD9^FBCSV1
 ;  5211    $$PARAM^FBUCLET,AUTO^FBUCLET
 ;  5099    FBUCUTL $$ORDER, $$PAYST, LOCK
 ;  5100    $$FBUC^FBUCUTL2
 ;  315     EN2^PRCS58, EN3^PRCS58   
 ;  2171 - $$STA^XUAF4
 ;
RELBAT(FBOUT,FBBAT) ; RPC: DSIF BATCH RELEASE
 ; Mimic logic from FBAASCB, but it only supports B3 and B9 batches
 ; Input:  Batch # (IEN if passed in as "nnn;" changed with DSIF*3,2*1)
 ; Output:  FBOUT(0)=1 or -1^Message
 ; '*' Reimbursement to Patient   '+' Cancellation Activity
 ; If Type = B3 (Medical Payments) 
 ;   FBOUT(0)="Invoice"^B3^Invoice number^Totals
 ;   FBOUT(CNT)="Pat"^Patient Name^SSN (internal and ext)^Batch #^Date received^Vendor name^Vendor ID^Invoice^Invoice date
 ;   FBOUT(CNT.1)="CPT"^Service Date^CPT-Modifier^Service Provided^Claimed amt^Paid amt^Adj amt
 ;If type = B9 CH/CNH (Civil Hospital/Contract Nursing Home)
 ; ; FBOUT(CNT)="Pat"^Patient Name^SSN (internal and ext)^Batch #^Date received^Vendor name^Vendor ID^Invoice^Invoice date
 ;   FBOUT(CNT.1)="CPT"^Service Date^CPT-Modifier^Service Provided^Claimed amt^Paid amt^Adj amt
 ;   FBOUT(CNT.2)="FPPS"^FPPS Claim ID^FPPS Line^Discharge^???
 ;   FBOUT(CNT.3)="Dx"^Dx code^...(repeat for up to five Dx codes)
 ;   FBOUT(CNT.4)="Proc"^Procedure code^...(repeat for up to five procedures)
 ;   FBOUT(CNT.5)="Check"^Check # ^Date Paid^Interest^Amount paid altered to $^Date Check cancelled^Reason
 ;   ^TEXT(R=Check WILL be replaced or C=Check WILL be re-issued or X=Check WILL NOT be replaced)
 K FBOUT,^TMP("DSIFBAT3",$J) N A,B,I,J,K,DIC,N,FBTYPE,FBLCNT,%,IENS,CNT,FBN,FZ,PRCS,FBTOTAL,FBLCNT,FBERR,FBUOK,FBINV
 S:$G(U)="" U="^" S FBOUT=$NA(^TMP("DSIFBAT3",$J)),@FBOUT@(0)=""
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ))  S @FBOUT@(0)="-1^User does not hold the Supervisor Key, quitting" Q
 I $G(FBBAT)=""  S @FBOUT@(0)="-1^No batch number entered" Q
 D START^DSIFBAT1(.FBBAT) I FLAG S @FBOUT@(0)=FBERR Q
 I '$D(^FBAA(161.7,IEN,0)) S @FBOUT@(0)="-1^Not a valid batch selection, quitting" Q
 S Y(0)=^FBAA(161.7,IEN,0),X=$P(Y(0),U),Y=IEN_U_FBBAT,B=IEN,CNT=0
 I $G(^FBAA(161.7,+Y,"ST"))'="C",($G(^FBAA(161.7,+Y,"ST"))'="A") S @FBOUT@(0)="-1^Batch not pending release" Q
 S FBERR=0 D DT^DICRW
 S FBN=+Y
 D LOCK^FBUCUTL("^FBAA(161.7,",FBN) I 'FBLOCK S @FBOUT@(0)="-1^Try releasing batch at another time." Q
 S FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3),FBAAON=$P(FZ,"^",2),FBAAB=$P(FZ,"^")
 I $G(FBTYPE)="B9",$P(FZ,"^",15)="Y",$P(^FBAA(161.7,FBN,"ST"),"^")="C",$P(FZ,"^",18)'="Y" S @FBOUT@(0)="-1^Batch needs to be released to Pricer first." Q
 I $G(FBTYPE)="B9",$P(FZ,"^",15)="" S FBCNH=1
 S FBSTAT=^FBAA(161.7,FBN,"ST"),FBSTAT=$S(FBSTAT="C":"S",FBSTAT="A":"R",1:FBSTAT)
 S FBAAOB=$P(FZ,"^",8)_"-"_FBAAON,FBAAMT=$P(FZ,"^",9),FBCOMM="Release of batch "_FBAAB
 ;
 ; enforce segregation of duties DSIF*3.2*17 (FB*3.5*117 logic from FBAASCB)
 D UOKCERT^PRCEMOA(.FBUOK,FBAAOB,DUZ) ; IA #5573
 I 'FBUOK D  D Q  Q
 . S @FBOUT@(0)="-1^"_$P(FBUOK,U,2) ; return text returned by IFCAP API
 . I $P(FBUOK,U)="0" S @FBOUT@(1)="Due to segregation of duties, you cannot also certify an invoice for payment."
 . I $P(FBUOK,U)="E" S @FBOUT@(1)="This 1358 error must be resolved before the batch can be released."
 ;
 I FBTYPE="B5"!(FBTYPE="B2") G NOTSUP  ;Non supported batch types
 I FBTYPE="B9" D CHIN^DSIFBAT7 Q:$G(FBERR)=1   ;DSIF*3.2*2 (Quit on error)
 ;  Changed line below to only post if an outpt batch  10/21/09
 D POST:FBTYPE="B3" I $G(FBERR)=1 G SHORT
 ; use FileMan to update fields 5 and 6, store date & time (FB*3.5*117) DSIF*3.2*17
 S DA=FBN,DIE="^FBAA(161.7,"
 S DR="11////^S X=FBSTAT;6////^S X=DUZ;5////^S X=$$NOW^XLFDT" D ^DIE
 K DA,DIE,DIC,DR
 D UCAUTOP
 D ENM^DSIFBAT2:FBTYPE="B3"  ; NOT^DSIFBAT2:FBTYPE="B9"
 S @FBOUT@(0)="1^Batch has been Released!"
 ;
 ;DSIF*3.2*10 - HIPAA 5010 Enhancement - prevent 0.00 paid EDI invoices being queued at RELEASE A BATCH; EDI invoices will be queued at confirmation/cancellation time
 ;D LOG^FBFHLL(FBN,FBTYPE)
 D Q Q
Q I $G(FBN) L -^FBAA(161.7,FBN)
 K B,J,K,L,M,X,Y,Z,DIC,FBN,A,A2,DA,DL,DR,FBAAON,FBVP,FBIN,DK,N,FBTYPE,FZ,V,VID,ZS,FBAAB,FBAAMT,FBAAOB,FBCOMM,FBAUT,FBSITE,I,X,Y,Z,FBERR,DIRUT,FBSTAT,FBLOCK
 K FBAC,FBAP,FBCNH,FBFD,FBSC,FBTD
 Q
SHORT ; 
 I '$D(FBINV) S @FBOUT@(0)="-1^This batch CANNOT be released. Check your 1358." L -^FBAA(161.7,FBN) Q    ;FB*3.5*116/DSIF*3.2*10   Check invoices 
 N NUM S NUM=1 S:'$D(@FBOUT@(0)) NUM=0 S @FBOUT@(0)="-1^This batch CANNOT be released. Check your 1358." L -^FBAA(161.7,FBN) Q
POST ;FBAAOB=FULL OBLIGATION NUMBER(STA-CXXXXX)
 ;FBCOMM=COMMENT FOR 1358
 ;FBAAMT=TOTAL AMOUNT OF BATCH
 ;FBAAB=BATCH NUMBER
 ;IF CALL FAILS FBERR RETURNED=1
 ;FBN added as 7th piece of 'X'. It is the interface ID
 S FBERR=0
 S PRCS("X")=$G(FBAAOB),PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 S @FBOUT@(5)="1358 not available for posting!",FBERR=1 Q
 D NOW^%DTC S X=FBAAOB_"^"_%_"^^"_FBAAMT_"^"_$S($L(FBAAB)<3:$$PADZ^FBAAV01(FBAAB,4),1:FBAAB)_"^"_FBCOMM_"^"_FBN_"^"_1,PRCS("TYPE")="FB" D EN2^PRCS58 I +Y=0 S @FBOUT@(0)="-1^"_Y S FBERR=1 Q
 K PRCS("SITE"),PRCSI Q
UCAUTOP ; Unauthorized Claims Autoprint
 ; If unauthorized claims autoprint feature is enabled then check items
 ; in batch and print an unauthorized claim disposition letter if all
 ; payments for a claim have been released
 ; input FBN    - batch ien
 ;       FBTYPE - batch type
 ;       FBCNH  - (opt) equals 1 if batch is for community nursing home
 N DA,FBDA,FBORDER,FBUC,FBUCA,FBX,IEN
 I "^B3^B9^"'[(U_FBTYPE_U) S @FBOUT@(0)="-1^Not an applicable batch type" Q
 I $G(FBCNH)=1 S @FBOUT@(0)="-1^CNH batch won't have associated unauth claims" Q
 S FBUC=$$FBUC^FBUCUTL2(1)
 I '$$PARAM^FBUCLET(FBUC) S @FBOUT@(6)="autoprint feature not enabled" Q
 ;
 ; loop thru items in batch to build list of unauthorized claims
 K ^TMP("FBUC",$J)
 I FBTYPE="B3" D  ; if outpatient/ancillary batch
 . S DA(3)=0 F  S DA(3)=$O(^FBAAC("AC",FBN,DA(3))) Q:'DA(3)  D
 . . S DA(2)=0 F  S DA(2)=$O(^FBAAC("AC",FBN,DA(3),DA(2))) Q:'DA(2)  D
 . . . S DA(1)=0
 . . . F  S DA(1)=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 . . . . S DA=0
 . . . . F  S DA=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 . . . . . S FBX=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0)),U,13)
 . . . . . I FBX["FB583" S ^TMP("FBUC",$J,+FBX)=""
 I FBTYPE="B9" D  ; if inpatient batch
 . S DA=0 F  S DA=$O(^FBAAI("AC",FBN,DA)) Q:'DA  D
 . . S FBX=$P($G(^FBAAI(DA,0)),U,5)
 . . I FBX["FB583" S ^TMP("FBUC",$J,+FBX)=""
 ;
 ; loop thru unauthorized claim list and print letter when appropriate
 S FBDA=0 F  S FBDA=$O(^TMP("FBUC",$J,FBDA)) Q:'FBDA  D
 . Q:'$$PAYST^FBUCUTL(FBDA)  ; not all payments for claim released yet
 . S FBUCA=$G(^FB583(FBDA,0))
 . Q:$P(FBUCA,U,16)'=1  ; claim not flagged for printing
 . S FBORDER=$$ORDER^FBUCUTL($P(FBUCA,U,24))
 . D AUTO^FBUCLET(FBDA,FBORDER,FBUCA,FBUC) ; autoprint letter
 ;
 K ^TMP("FBUC",$J)
 Q
NOTSUP ;
 S @FBOUT@(0)="-1^Sorry, this batch type is not supported." D Q Q
 ;
STATBAT(FBOUT,FBBAT) ; RPC: DSIF BATCH STATUS
 ; Input: FBBAT = Batch Number(IEN if passed in as "nnn;" DSIF*3.2*1)
 ; Output:   (all dates in formatted FM date;External date
 ;   FBOUT(1)="1"^Batch #^Obligation #^Type^Date opened^Clerk who opened (Ien;name)^Lines allowed;Lines
 ;           or     -1^error message (if an error)
 ;   FBOUT(2)="2"^Date Supervisor closed^Supervisor who certified^Total $^Payment line count
 ;   FBOUT(3)="3"^Date clerk closed^Date transmitted^Person who completed^Rejects pending?^Status^Station#
 ;   FBOUT(4)="4"^CH batch(Y/N)^Batch exempt(Y/N)^Statistical Batch (Y/N)^Fund control point^Fee program^Date finalized^PO Date
 N LIST,MSG,ADAT,SITE,CPIEN,PODT,FCPNUM,FCP,PDAT,LIST1,FBLCNT,FBTOTAL,IEN,IENS K FBOUT
 S:$G(U)="" U="^"
 I $G(FBBAT)="" S FBOUT(1)="-1^No batch number passed in, quitting" Q
 D START^DSIFBAT1(.FBBAT) I FLAG S FBOUT(1)=FBERR Q
 D SITE^FBAACO S SITE=$$STA^XUAF4($P($G(FBSITE(1)),U,3)) I SITE="" S FBOUT(1)="-1^Site parameters not set, no site defined" Q
 S FBAAMPI=$P($G(^FBAA(161.4,1,"FBNUM")),"^",3),FBAAMPI=$S(FBAAMPI]"":FBAAMPI,1:100)
 S IEN=$O(^FBAA(161.7,"B",FBBAT,"")) I IEN="" S FBOUT(1)="-1^Batch not found, Quitting" Q
 S IENS=IEN_","
 D CNTTOT^FBAARB(IEN) ;Get number of payments and total
 D GETS^DIQ(161.7,IENS,"**","IE","LIST","MSG") S ADAT=$NA(LIST(161.7,IENS)),FCP=""
 I '$D(LIST) S FBOUT(1)="-1^Invalid Batch Number" Q
 S CPIEN=$O(^PRC(442,"B",SITE_"-"_$G(@ADAT@(1,"E")),"")) I 'CPIEN S PODT=";",FCP="N/A"
 I CPIEN D GETS^DIQ(442,CPIEN_",",".1;1","IE","LIST1","MSG1") D 
 . S PDAT=$NA(LIST1(442,CPIEN_",")),FCPNUM=$O(^PRC(420,SITE,1,"B",$P(@PDAT@(1,"E")," - "),"")) I 'FCPNUM S FCPNUM="Unknown/Invalid"
 . S FCP=+@PDAT@(1,"E")_";"_@PDAT@(1,"E"),PODT=@PDAT@(.1,"I")_";"_@PDAT@(.1,"E")
 S FBOUT(1)="1"_U_IEN_";"_@ADAT@(.01,"I")_U_$G(@ADAT@(1,"E"))_U_$G(@ADAT@(2,"E"))_U_$G(@ADAT@(3,"I"))_";"_$G(@ADAT@(3,"E"))_U_$G(@ADAT@(4,"I"))_";"_$G(@ADAT@(4,"E"))_U_$G(FBAAMPI)_";"_$G(FBLCNT)
 S FBOUT(2)="2"_U_$G(@ADAT@(5,"I"))_";"_$G(@ADAT@(5,"E"))_U_$G(@ADAT@(6,"I"))_";"_$G(@ADAT@(6,"E"))_U_$G(FBTOTAL)_U_$G(FBLCNT)
 S FBOUT(3)="3"_U_$G(@ADAT@(4.5,"I"))_";"_$G(@ADAT@(4.5,"E"))_U_$G(@ADAT@(12,"I"))_";"_$G(@ADAT@(12,"E"))_U_$G(@ADAT@(14,"I"))_";"_$G(@ADAT@(14,"E"))_U_$G(@ADAT@(15,"E"))_U_$G(@ADAT@(11,"I"))_";"_$G(@ADAT@(11,"E"))_U_$G(@ADAT@(16,"I"))
 S FBOUT(4)="4"_U_$G(@ADAT@(17,"E"))_U_$G(@ADAT@(18,"E"))_U_$G(@ADAT@(19,"E"))_U_FCP_U_$G(@ADAT@(2,"I"))_";"_$G(@ADAT@(2,"E"))_U_$G(@ADAT@(13,"I"))_";"_$G(@ADAT@(13,"E"))_U_PODT
 Q
WRITC ;  Called by DSIFBAT2
 N FBK,FBL,FBPROC
 S @FBOUT@(CNT,1)="",@FBOUT@(CNT,0)="Pat"_U_$S('$D(ZS):"",ZS="R":"*",1:"")
 S @FBOUT@(CNT,0)=@FBOUT@(CNT,0)_U_N_U_S_U_B(1617)_U_V_U_VID_U_FBIN_U_+FBIN(1)_";"_$$DATX^FBAAUTL($E(FBIN(1),1,7))
 I FBFPPSC]"" S @FBOUT@(CNT,2)="FPPS"_U_FBFPPSC_U_FBFPPSL
 S @FBOUT@(CNT,1)=@FBOUT@(CNT,1)_U_$S($D(QQ):QQ_")",1:"")_U_FBVP_U_$S($G(FBCAN)]"":"+",1:"")_U_$G(FBFD)_U_$G(FBTD)_U_$J(FBAC,6)_U_$J(FBAP,6)_U_$S($G(FBADJLR)]"":$G(FBADJLR),1:$G(FBSC))
 I $P(Z(0),"^",24) S $P(@FBOUT@(CNT,2),U,4,5)=$$ICD^FBCSV1(+$P(Z(0),"^",24)_U_$P(Z(0),"^",7))
 I $D(^FBAAI(I,"DX")) S FBDX=^("DX"),@FBOUT@(CNT,3)="Dx" F FBK=1:1:5 Q:$P(FBDX,"^",FBK)=""  D
 . S @FBOUT@(CNT,3)=@FBOUT@(CNT,3)_U_$$ICD9^FBCSV1($P(FBDX,"^",FBK),$P($G(Z(0)),"^",6))
 . S @FBOUT@(CNT,3)=@FBOUT@(CNT,3)_U_$$ICD9^FBCSV1($P(FBDX,"^",FBK)_U_$P($G(Z(0)),"^",6))
 I $D(^FBAAI(I,"PROC")) S @FBOUT@(CNT,4)="Proc",FBPROC=^FBAAI(I,"PROC") F FBL=1:1:5 Q:$P(FBPROC,"^",FBL)=""  D
 . S @FBOUT@(CNT,4)=@FBOUT@(CNT,4)_U_$$ICD0^FBCSV1($P(FBPROC,"^",FBL),$P($G(Z(0)),"^",6))
 S @FBOUT@(CNT,6)="CPTMod"
 S A2=FBAP D PMNT^FBAACCB2 K A2
 Q
