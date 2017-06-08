DSIFBAT5 ;DSS/RED - RPC FOR FEE BASIS BATCHES ;10/17/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ;   Integration Agreements
 ;     315  EN3^PRCS58
 ;    2056  GETS^DIQ                           5273  ^FBAA(161.7
 ;    5081  FBCKO^FBAACCB2               5107  ^FBAAC(
 ;    5083  ALLM^FBAADD                     5278  ^FBAAV(
 ;    5085  $$ADJLRA^FBAAFA               5301  ^PRC(420     
 ;    5088  CNTTOT^FBAARB                10076   ^XUSEC("FBAASUPERVISOR"
 ;    5091  $$CPT^FBAAUTL4,$$MODL^FBAAUTL4 
 ;    5095  ^FBAAVR0,VCHNH^FBAAVR0
 ;    5327  PLUSOB^FBAAUTL1               5274  ^PRC(442
 ;    5300  ^PRC(424,"E"),^PRC(424,"B")
 ;   10005  DT^DICRW                       10061 DEM^VADPT
 ;   10018  ^DIE                                  5275  ^FBAA(161.4
 ;   10103  $$FMTE^XLFDT                    5444  INTER^FBAASCB0
 ;
 Q  ;; no direct calls to routine
 ;
GETOBLIG(FBOUT,FUNDCP,FBYEAR) ; RPC: DSIF GET OBLIG
 ;  FUNDCP = fund control point
 ;  FBYEAR = Years back to show obligations (if Null show current year only)
 ;              if 1 is entered, show current year and - last year.
 ;  ^TMP($J,"DSIFBAT5",0)=-1^Error message (on error only)
 ;  ^TMP($J,"DSIFBAT5",n)=Obligation number^Fund control point^Supply Status^Obligation date^Total amount^Actual 1358 balance^Estimated remaining 1358 Bal (#94-#96)
 ;Use this to get a list of obligations available for the batch
 K ^TMP($J,"DSIFBAT5"),FBOUT N IEN,IENS,CNT,LIST,FBYR,FBBACK
 S (CNT,IEN)=0
 I $G(FUNDCP)="" S ^TMP($J,"DSIFBAT5",0)="-1^No Fund control point entered" D RES Q
 I '$D(^PRC(442,"E",FUNDCP)) S ^TMP($J,"DSIFBAT5",0)="-1^Fund control point entered is invalid" D RES Q
 F IEN=0:0 S IEN=$O(^PRC(442,"E",FUNDCP,IEN)) Q:IEN<1  D
 . K LIST,ADAT
 . S CNT=CNT+1,FBYR=0
 . D GETS^DIQ(442,IEN_",",".01;.5;1;.1;91;94;96","IE","LIST","MSG")
 . S ADAT=$NA(LIST(442,IEN_","))
 . I $G(FBYEAR)="" S FBYEAR=1     ; Default to current year-1
 . I $P($$FMTE^XLFDT(DT,5),"/",3)-FBYEAR>$P($$FMTE^XLFDT(@ADAT@(.1,"I"),5),"/",3) Q
 . S ^TMP($J,"DSIFBAT5",CNT)=@ADAT@(.01,"E")_U_@ADAT@(1,"I")_U_@ADAT@(.5,"I")_U_@ADAT@(.1,"I")_";"_@ADAT@(.1,"E")_U_@ADAT@(91,"E")_U_@ADAT@(94,"E")_U_(@ADAT@(94,"E")-@ADAT@(96,"E"))
 I '$D(^TMP($J,"DSIFBAT5")) S ^TMP($J,"DSIFBAT5",0)="-1^No obligations found for that date range"
 D RES
 Q
RES S FBOUT=$NA(^TMP($J,"DSIFBAT5"))
 Q
FBCP(FBOUT,SITE) ; DSIF DISP FEE CP
 ;Display all fund control points, that the user has access to 
 ;Output:  ^TMP($J,"DSIFBAT5",IEN)=1st piece of Fund control point name*;Fund contol point name
 ; *This is the format that is used in the cross reference ^PRC(442,"E") so ^PRC(442,"E","038",is pointer to current FCP data)
 K ^TMP($J,"DSIFBAT5") S FBOUT=$NA(^TMP($J,"DSIFBAT5"))
 N FUNDCP,CNT S CNT=0,FUNDCP=""
 ; (T30) Added new input parameter SITE (optional, lookup value if not input manually) 
 ;         due to a site number mismatch reported at Orlando in file 161.4 [used IEN of 67 rather than 675 in piece 3 of ^FBAA(161.4,1,1)]
 I $G(SITE)="" S SITE=$P($G(^FBAA(161.4,1,1)),U,3)
 I $G(SITE)="" S @FBOUT@(0)="-1^Site number is undefined" Q
 F  S FUNDCP=$O(^PRC(420,SITE,1,"B",FUNDCP)) Q:FUNDCP=""  D
 . S IEN=$O(^PRC(420,SITE,1,"B",FUNDCP,""))
 . I '$D(^PRC(420,"A",DUZ,SITE,+FUNDCP)) Q  ;Not a valid user
 . Q:'$D(^PRC(442,"E",$P(FUNDCP," ")))  ; Exists but not properly defined in #442
 . S CNT=CNT+1,@FBOUT@(IEN)=$P(FUNDCP," ")_";"_$P(^PRC(420,SITE,1,IEN,0),U)
 I CNT<1 S @FBOUT@(1)="-1^No FCP's found for this Site" Q
 Q
 ;
FINALIZE(FBOUT,FBN,REJALL,FBREJL) ;  RPC: DSIF BATCH FINALIZE
 ;Input: FBN = Batch IEN, 
 ;   B3 batch -FBREJL = array of reject lines [FBREJL(Line)=LINE#^Pmt ID^Invoice^reject reason (2-40 characters)] 
 ;   B9 batch -FBREJL = array of reject lines [FBREJL(1)=Invoice^reject reason (2-40 characters)] 
 ;         REJALL[NOT USED!!] = 1 (yes) or 0 (no)^PMT ID^reject reason (2-40 characters)
 ;Output: FBOUT(0)=1 or -1^message
 ;     (batch display)
 ;            FBOUT("A")="1"^BatchIEN;Batch#^Obligation number^Type^date opened^clerk who opened^date supervisor closed
 ;                         [or -1^error message]
 ;                     ("B")="2"^Supervisor who certified^station number^total dollars^payment line count^status
 ;                     ("R"_n)=Rejects
 K FBOUT
 N FBTYPE,FBDATA,MSG,FBST,FBAAB,FBAAOB,FZ,FBCOMM,OUT,LINREJ,FBAARA,FBAAMT,FBINTOT,FBMODLE,FBVCHDT,N,PRC,FBMM,LINE
 N PRCS,S,T,V,VID,ZS,CPTDESC,FBAACPT,FBVCHDT,FBERR,FBTAMT,FBLCNT,FBIN,FBCNH,LIN,I,HX,ID,LIN,INVCNT,BATNUM,LIST,FBI78
 S (BATNUM,FBCOMM)="",(LINREJ,FBERR,FBRFLAG,FBAARA)=0
 I $D(FBREJL)>9 S LINREJ=1
 ;  Call DSIFBAT8 to verify batch and items in it before completing finalization
 D VERIFY^DSIFBAT8 Q:FBERR
 ; Reject all lines
 I REJALL D  Q:FBOUT(0)<0     ;Future use possible, not used resently
 . S FBOUT(0)="-1^Reject all is not supported at this time" Q
 . ;S FBRR=$P(REJALL,U,3) D ALLM^FBAADD:FBTYPE="B3",NOTNOW:FBTYPE="B2",NOTNOW:FBTYPE="B5",NOTNOW:FBTYPE="B9"
 ;Reject submitted lines for Med Batch
 I LINREJ,FBTYPE="B3" S (FBAAMT,QQ,HX,FBINTOT)=0 F LIN=0:0 S LIN=$O(FBREJL(LIN)) Q:'LIN!(FBERR)  D
 . S LINE=$P(FBREJL(LIN),U),ID=$P(FBREJL(LIN),U,2) S J=$P(ID,";"),K=$P(ID,";",2),L=$P(ID,";",3),M=$P(ID,";",4)
 . S FBAAMT=+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3),FBRR=$P(FBREJL(LIN),U,4),B=FBN,FBIN=$P(FBREJL(LIN),U,3)
 . S HX=HX+1,QQ(HX)=J_"^"_K_"^"_L_"^"_M,I=QQ(HX)
 . D SET,^FBAAVR0
 . S FBOUT("R"_LIN)=1_U_LINE_U_" ("_ID_") has been rejected"
 Q:FBERR
 ;Changed the line below to only run if rejects in a B3 batch.
 I FBTYPE="B3",$G(FBRFLAG) D ADD^DSIFBAT4 Q:FBERR
 ; B9 Batch rejects
 I LINREJ,FBTYPE="B9" S (FBAAMT,QQ,HX,FBINTOT)=0 S BATNUM=+^FBAA(161.7,FBN,0),FBIN=$P(FBREJL(1),U),FBRR=$P(FBREJL(1),U,2) D
 . D RESET Q:FBERR  S FBOUT("R")=1_U_FBIN_" invoice has been rejected" Q
 I LINREJ,FBTYPE="B9",$G(FBOUT("R"))="" S FBOUT(0)="-1^Invoice reject process did not complete for batch: "_BATNUM_"!" Q
 S FBRFLAG=0
RDD1 D MEDV:FBTYPE="B3",VCHNH^FBAAVR0:FBTYPE="B9"
FIN ;  Rewrote to use FILE^DIE rather than straight old style ^DIE
 N FILE,IENS,DSIF,MSG1
 L +^FBAA(161.7,FBN):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S FBOUT(0)="-1^Unable to lock Batch file, try again later" Q
 S FILE=161.7,IENS=FBN_",",DSIF(FILE,IENS,11)="V",DSIF(FILE,IENS,13)=$G(DT),DSIF(FILE,IENS,14)=DUZ D FILE^DIE(,"DSIF","MSG1") L -^FBAA(161.7,FBN)
 I $D(MSG1) S FBOUT(0)="-1^Error in writing to batch, Job #"_$J Q
 I 'LINREJ D SHOWBAT Q:FBERR
 I LINREJ,FBTYPE="B3" D SHOWBAT Q:FBERR 
 ;  Verify that the status is reset to "V" (Vouchered), quit if not set to "V"
 I ^FBAA(161.7,FBN,"ST")'="V" S FBOUT(0)="-1^The batch status did not get set properly" Q
 S FBOUT(0)="1^Batch: "_+^FBAA(161.7,FBN,0)_" has been Finalized. "
Q K B,J,K,L,M,X,Y,Z,DIC,ERR,FBN,FBAAOUT,FBAC,FBAP,FBFD,FBPDT,FBSC,FBTD,FBVP,POP,FBRFLAG,QQ,A,A1,A2,DA,D,DX,FBAAAP,FBAARA,FBIN,FBRR,FBTYPE,HX,I,DIRUT
 K FBAAON,FBCOMM,FBI,PRCS("TYPE"),FBINOLD,FBK,FBL,FBPROC,FBCNH,FBII78
 Q
MEDV S B=FBN
 F J=0:0 S J=$O(^FBAAC("AC",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0  D SETXFR
 Q
SETXFR I '$D(^FBAAC(J,1,K,1,L,1,M,"FBREJ")),$D(^FBAAC(J,1,K,1,L,1,M,0)) S DA(3)=J,DA(2)=K,DA(1)=L,DA=M,DIE="^FBAAC(DA(3),1,DA(2),1,DA(1),1,",DR="5///^S X=DT" D ^DIE K DIE,DA,DR
 Q
NOTNOW ;Batch types not suported at this time
 S FBOUT(0)="-1^This batch type "_FBTYPE_" is not supported at this time",OUT=1 Q
SET ;
 N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,FBX,FBY3,TAMT
 S DFN=J D DEM^VADPT S N=VADM(1),S=+VADM(2),V=$S($D(^FBAAV(K,0)):$P(^FBAAV(K,0),"^",1),1:""),VID=$S(V]"":$P(^(0),"^",2),1:"") K VA,VADM
 S D=+$G(^FBAAC(J,1,K,1,L,0)) Q:'D
 S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)) Q:Y']""
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBFPPSC=$P(FBY3,U)
 S FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S T=$P(Y,"^",5),FBIN=$P(Y,"^",16),ZS=$P(Y,"^",20)
 S TAMT=$FN($P(Y,"^",4),"",2)
 S FBVP=$S($P(Y,"^",21)="VP":"#",1:"")
 S FBAACPT=$$CPT^FBAAUTL4($P(Y,U))
 S CPTDESC=$$CPT^FBAAUTL4($P(Y,U),1,D)
 S FBVCHDT=$P(Y,"^",6),FBIN(1)=$P(Y,"^",15) D FBCKO^FBAACCB2(J,K,L,M)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 S A1=$P(Y,"^",2)+.0001,A2=$P(Y,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBINTOT=FBINTOT+A2
 Q
 ;
 ; Cloned from: RESET^FBAAVR0  (logic retained screen writes removed)
RESET K DR S (DIC,DIE)="^FBAAI(",DA=FBIN,DR="20///^S X=""@"";13////^S X=""P"";14///^S X=FBRR;15///^S X=BATNUM" D ^DIE K DIC,DIE
 S INVCNT=$P(FZ,"^",10),INVCNT=INVCNT-1 I INVCNT'>0 S INVCNT=""
 S FBAAAP=+$P(^FBAAI(FBIN,0),"^",9),FBMM=$E($P(^(0),U,6),4,5),$P(FZ,"^",9)=$P(FZ,"^",9)-FBAAAP,$P(FZ,"^",10)=$G(INVCNT),$P(FZ,"^",11)=$P(FZ,"^",11)-1,$P(FZ,"^",17)="Y",^FBAA(161.7,FBN,0)=FZ,FBAARA=FBAARA+FBAAAP K QQ(HX)
 S FBAAMT=-FBAAAP,FBII78=$P(^FBAAI(FBIN,0),"^",5)
 ;
 ; Cloned from: INPOST^FBAARD3  (logic retained screen writes removed)
 ;call to put money back into 1358 for inpatient invoices
 ;call will handle both v4 and v3.6 of ifcap
 ;I $G(FBCNH),'$$VER^FBAAUTL1() D POST^FBAASCB Q
 I FBII78["FB583(" D POST^DSIFBAT3 Q
 ;find 7078 entry and build variables needed for call
 I '$D(^FB7078(+FBII78,0)) S FBOUT("R"_LIN)="-1^No 7078 on file for invoice "_J_".  Could not determine 1358." S FBERR=1 Q
 S FBI78=$P(^FB7078(+FBII78,0),"^"),DFN=+$P(^(0),"^",3),FBI78=$P(FZ,"^",8)_"-"_$P(FBI78,".")_"-"_$P(FBI78,".",2) D
 .I $D(FBCNH),'$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON_";"_FBMM)) D POST^DSIFBAT3 Q
 .D INPOST^DSIFBAT7:$$INTER^FBAASCB0()
 Q
SHOWBAT ;
 D GETS^DIQ(161.7,FBN_",","**","IE","LIST","MSG") I $D(MSG) S FBOUT(0)="-1^File #161.7 error, cannot return values",FBERR=1 Q
 S FBDATA=$NA(LIST(161.7,FBN_","))
 S FBOUT("A")="1"_U_FBN_";"_@FBDATA@(.01,"I")_U_$G(@FBDATA@(1,"I"))_U_$G(@FBDATA@(2,"I"))_";"_$G(@FBDATA@(2,"E"))_U_$G(@FBDATA@(3,"I"))_";"_$G(@FBDATA@(3,"E"))
 S FBOUT("A")=FBOUT("A")_U_$G(@FBDATA@(4,"I"))_";"_$G(@FBDATA@(4,"E"))_U_$G(@FBDATA@(5,"I"))_";"_$G(@FBDATA@(5,"E"))
 S FBOUT("B")="2"_U_$G(@FBDATA@(6,"I"))_";"_$G(@FBDATA@(6,"E"))_U_$G(@FBDATA@(16,"E"))_U_$G(@FBDATA@(8,"E"))_U_$G(@FBDATA@(10,"E"))_U_$G(@FBDATA@(11,"I"))_";"_$G(@FBDATA@(11,"E"))
 Q
