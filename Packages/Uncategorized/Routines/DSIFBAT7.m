DSIFBAT7 ;DSS/RED - RPC FOR FEE BASIS BATCH MGT ;8/22/2007 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,10,17,8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  Integration Agreements
 ;  10000  NOW^%DTC
 ;  10009  FILE^DICN
 ;  10061 DEM^VADPT
 ;  2056   GETS^DIQ
 ;  5081   FBCKO^FBAACCB2
 ;  5085   $$ADJLRA^FBAAFA
 ;  5112   POST^FBAASCB
 ;  5090   $$SSN^FBAAUTL,GETNXB^FBAAUTL
 ;  5091   $$CPT^FBAAUTL4,$$MODL^FBAAUTL4
 ;  5097   $$NAME^FBCHREQ2
 ;  5300  ^PRC(424,"E",^PRC(424,"B"
 ;  315    EN3^PRCS58
 ;  831    ^PRCS58CC   
 ;
 Q    ;no direct calls to the routine
CHIN ; Called from DSIFBAT3 for B9 batch types
 N DFN
 K FBERR,^TMP($J) S FBRJC=0,FBINTOT=$P(FZ,U,10)
 I '$O(^FBAAI("AC",FBN,0)) S @FBOUT@(0)="-1^No invoices found for this batch. Unable to release." S FBERR=1 Q
 ;
 S FBII=0 F  S FBII=$O(^FBAAI("AC",FBN,FBII)) Q:'FBII!($D(FBERR))  S FBII78=$P($G(^FBAAI(FBII,0)),"^",5),FBAAMT=$P($G(^(0)),"^",9),FBMM=$E($P(^(0),U,6),4,5) D GETAP,GET78:FBII78["FB7078(",POST^FBAASCB:FBII78["FB583("
 I $G(FBRJC),FBRJC=FBINTOT S FBERR=1 D KILL Q
 I $G(FBRJC) K FBERR S (FBRJC,FBII)=0 F  S FBII=$O(^TMP($J,FBII)) Q:'FBII  S X=$G(^FBAAI(FBII,0)),FBII78=$P(X,U,5),FBAAMT=$P(X,U,9),FBMM=$E($P(X,U,6),4,5) K X,^TMP($J,FBII) D GET78
 I $G(FBRJC) S (FBAAMT,FBINTOT)=0 D NEWBT S FBII=0 F  S FBII=$O(^TMP($J,FBII)) Q:'FBII  D
 .S DA=FBII,DIE="^FBAAI(",DR="20////^S X=FBBN" D ^DIE K DR,DA,DIE
 .S FBAAMT=FBAAMT+$P(^FBAAI(FBII,0),U,9),FBINTOT=FBINTOT+1
 D:$G(FBRJC) RESETBT
 ; FB*3.5*116/DSIF*3.2*10  ; report zero dollar invoices
 I $D(FBINV) D
 . S FBII=0 F  S FBII=$O(FBINV(FBII)) Q:'FBII  S @FBOUT@(FBII,0)="-1^Invoice #: "_FBII_" totals $0.00",FBERR=1
 . S @FBOUT@(0)="-1^Batch cannot be released when zero dollar invoices exist. Invoices must be corrected or removed from the batch."
 Q
 ;
KILL K FBII,FBII78,FBI78,FBMM,PRCSX,FBRJC,FBSTN,FBBN,FBINTOT,FBCNH,^TMP($J) Q
 ;
GET78 I '$D(^FB7078(+FBII78,0)) S @FBOUT@(0)="-1^No associated 7078 for invoice "_FBII_". Unable to release batch." S FBERR=1 Q
 S FBI78=$P(^FB7078(+FBII78,0),"^"),DFN=+$P(^(0),"^",3),FBI78=$P(FZ,"^",8)_"-"_$P(FBI78,".")_"-"_$P(FBI78,".",2) D
 .D INPOST:$$INTER()
 .I $D(FBCNH),'$$INTER S FBERR=1 S @FBOUT@(0)="-1^"_$$NAME^FBCHREQ2(DFN)_"  "_$$SSN^FBAAUTL(DFN)_" Unable to locate reference number on 1358.  Run Post Commitments for Obligation option."
 .I $D(FBCNH),$D(FBERR) S ^TMP($J,+FBII)="",FBRJC=FBRJC+1 K FBERR
 Q
 ;
INPOST ;PRCSX=INTERNAL DAILY REF #^INTERNAL DATE/TIME^AMT OF PAYMENT^COMMENTS^COMPLETE FLAG
 ;FBI78=AUTHORIZATION NAME IN 424 (STA-CXXXXX-REF #)
 ;FBERR RETURNED IF IFCAP CALL FAILS
 ;FBCOMM=COMMENT
 ;FBAAMT=ACTUAL AMOUNT OF PAYMENT
 ;INTERFACE ID = DFN_";"_INTERNAL ENTRY NUMBER OF 7078_";"_FBAAON  (OBLIGATION)_";" if CNH _FBMM (month of service)
 ;INTERNAL DAILY REF # = $O(^PRC(424,"B","STA #-OBLIGATION #-REF #",0))
 ;NEW INTERNAL DAILY REF # LOOKUP=$O(^PRC(424,"E",INTERFACE ID,0))
 N %
 I '$$INTER() S @FBOUT@(0)="-1^Unable to locate reference number on 1358." S FBERR=1 Q
 S PRCS("X")=FBAAOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 S @FBOUT@(0)="-1^1358 not available for posting!" S FBERR=1 Q
 D NOW^%DTC
 S PRCSX=$$INTER()_"^"_%_"^"_FBAAMT_"^"_$S($D(FBCOMM):FBCOMM,1:"")_"^"_1
 D ^PRCS58CC I Y<1 S @FBOUT@(0)=-1_U_$P(Y,"^",2) S FBERR=1 Q
 Q
 ;
INTER() ;get internal entry number from file 424
 ;first check for new INTERFACE ID "E" x-ref in 424
 ;2nd check is to "B" x-ref to stay backward compatible with IFCAP 3.6
 ;
 I '$D(FBCNH),$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON)) Q $O(^(DFN_";"_+FBII78_";"_FBAAON,0))
 I $D(FBCNH),$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON_";"_FBMM)) Q $O(^(DFN_";"_+FBII78_";"_FBAAON_";"_FBMM,0))
 I '$D(FBCNH),$D(^PRC(424,"B",FBI78)) Q $O(^(FBI78,0))
 Q 0
 ;
NEWBT ;open new batch for cnh line items unable to post to 1358
 S FBSTN=$P(FZ,U,8) W ! D GETNXB^FBAAUTL
 S DIC="^FBAA(161.7,",DIC(0)="LQ",X=FBBN,DIC("DR")="1////^S X=FBAAON;2////^S X=""B9"";3////^S X=DT;4////^S X=$P(FZ,U,5);11////^S X=""O"";16////^S X=FBSTN",DLAYGO=161.7
 K DD,DO D FILE^DICN S FBBN=+Y K DIC,DLAYGO
 Q
RESETBT ;reset original batch total $ set new batch totals
 S X=$G(^FBAA(161.7,FBBN,0)),$P(X,U,9)=FBAAMT,$P(X,U,10)=FBINTOT,$P(X,U,11)=FBINTOT,^(0)=X K X
 S $P(FZ,U,9)=$P(FZ,U,9)-FBAAMT,$P(FZ,U,10)=$P(FZ,U,10)-FBINTOT,$P(FZ,U,11)=$P(FZ,U,11)-FBINTOT,^FBAA(161.7,FBN,0)=FZ
 ; FBERR was not being set below possibly causing an error to go unreported (T36)
 S @FBOUT@(0)="-1^A new batch, number "_$P(^FBAA(161.7,FBBN,0),U)_", was opened for invoices unable to post to 1358. Adjust 1358 and take action on new batch.",FBERR=1
 Q
PMCNT(GLOCNT,BIEN) ;Get number of payments for batch number manually
 N I,CNT,GLO,FIND
 S (CNT,I)=0
 Q:'BIEN!('$D(^FBAAC("AC",BIEN)))
 ;  Use $Q to look through the "AC" cross reference regardless of parent levels, set find ="AC",(Batch IEN) so that only the desired batch is counted
 S GLO="^FBAAC(""AC"",BIEN)",FIND="""AC"""_","_BIEN F  S GLO=$Q(@GLO) Q:GLO'[FIND  S CNT=CNT+1
 S GLOCNT=CNT
 Q
 ; 
GMORE ;    GMORE called by DSIFBAT2
 F K=0:0 S K=$O(^FBAAC("AJ",B,FBIN,J,K)) Q:K'>0!(DSIFERR)  F L=0:0 S L=$O(^FBAAC("AJ",B,FBIN,J,K,L)) Q:L'>0!(DSIFERR)  F M=0:0 S M=$O(^FBAAC("AJ",B,FBIN,J,K,L,M)) Q:M'>0!(DSIFERR)  D
 .N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,FBX,FBY3,TAMT,D2,A1,A2,CPTDESC,D
 .; Change the next line to eliminate direct reads from ^DPT
 .S DFN=J D DEM^VADPT S N=VADM(1),S=+VADM(2),V=$S($D(^FBAAV(K,0)):$P(^FBAAV(K,0),"^",1),1:""),VID=$S(V]"":$P(^FBAAV(K,0),"^",2),1:"") K VA,VADM
 .S D=+$G(^FBAAC(J,1,K,1,L,0)) Q:'D
 .S Y=$G(^FBAAC(J,1,K,1,L,1,M,0)),D2=$G(^FBAAC(J,1,K,1,L,1,M,2)),FBID=J_";"_K_";"_L_";"_M Q:Y']""
 .S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3)),FBFPPSC=$P(FBY3,U),FBFPPSL=$P(FBY3,U,2),FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 .;FBINPT is set to the 16th piece of the zero node, it is also in the "AJ" cross reference, use this to verify they are the same
 .S FBADJLR=$P(FBX,U),FBADJLA=$P(FBX,U,2),T=$P(Y,"^",5),FBINPT=$P(Y,"^",16),ZS=$P(Y,"^",20),TAMT=$FN($P(Y,"^",4),"",2)
 .S FBVP=$S($P(Y,"^",21)="VP":"#",1:""),FBAACPT=$$CPT^FBAAUTL4($P(Y,U)),CPTDESC=$$CPT^FBAAUTL4($P(Y,U),1,D)
 .S FBVCHDT=$P(Y,"^",15),FBIN(1)=$P(D2,"^",1) D FBCKO^FBAACCB2(J,K,L,M)
 .S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 .S A1=$P(Y,"^",2)+.0001,A2=$P(Y,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBINTOT=FBINTOT+A2
 .D WRT^DSIFBAT2:FBTYPE'="B2" S CNT=CNT+1
 .;  Set some default code to stop runaway job, reference - remedy ticket: HD0000000280681 
 .I CNT>108 S DSIFERR=1,@FBOUT@(0)="-1^task stopped by default, payment line count = "_CNT Q
 Q
PRICER(DSIFOUT,FBBAT) ;RPC: DSIF INP PRICER RELEASE
 ; Input = FBBAT (IEN passed as "nnn;" DSIF*3.2*1)  ;Logic from FBCHSCB
 K DSIFOUT
 N IEN,TEST,CNT,X,Y,FBNO,N,FBTYPE,SUP,FLAG,LIST,FBDAT,A,C,FZ,IENS,I,J,K,L,M,T,FBIN,MSG,SUPCL,MSG1,FBD
 D START^DSIFBAT1(FBBAT) I FLAG S DSIFOUT=FBERR Q
 S DA=+Y,B=+Y,FZ=^FBAA(161.7,B,0)
 I $G(^FBAA(161.7,DA,"ST"))'="C" S DSIFOUT="-1^This batch is not closed" Q
 I $P(FZ,U,15)'="Y" S DSIFOUT="-1^This is not a CH Batch" Q
 I $P(FZ,U,18)["Y" S DSIFOUT="-1^This Batch is exempt from the Pricer!!!  Please use the 'Release a Batch' option to forward this batch for payment."
 I $G(DT)="" D DT^DICRW
 L +^FBAA(161.7,B):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSIFOUT="-1^Unable to lock file 161.7, try again later" Q
 I $D(MSG) S DSIFOUT="-1^Problems saving fee program or authorization" Q
 K FBD,MSG
 ; use FileMan to update fields 5 and 6 (FB*3.5*117 - logic from FBCHSCB) DSIF*3.2*17
 S DIE="^FBAA(161.7,",DR="11////^S X=""S"";6////^S X=DUZ;5////^S X=DT" D ^DIE
 ;
 S IENS=B_"," D GETS^DIQ(161.7,IENS,"**","IE","LIST","MSG") S FBDAT=$NA(LIST(161.7,IENS)) I $D(MSG) S DSIFOUT="-1^Error in Batch #: "_B_";"_FBBAT_" is invalid" Q
 S DSIFOUT=1_U_@FBDAT@(.01,"E")_U_@FBDAT@(1,"E")_U_@FBDAT@(2,"E")_U_@FBDAT@(3,"I")_";"_@FBDAT@(3,"E")_U_@FBDAT@(4,"I")_U_@FBDAT@(4,"E")_U_@FBDAT@(16,"E")_U_@FBDAT@(8,"E")_U_@FBDAT@(10,"E")_U_@FBDAT@(11,"E")_U_@FBDAT@(5,"E")_U_@FBDAT@(6,"E")
 Q
 ;
GETAP ; FB*3.5*116/DSIF*3.2*10 build array of invoices in batch
 Q:$D(FBCNH)  ; do not build array if CNH batch
 Q:FBAAMT>0  ; do not place invoice reference in array if the amount paid is greater than 0.00
 S FBINV(FBII)=""
