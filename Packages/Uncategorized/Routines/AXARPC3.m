AXARPC3  ;WPB/CAM Local calls used by Delhi with RPC Broker
 ;;1.00;;;JAN 16, 1997;Build 2
 ;Return Patient Array to RPC Call  AXA PATIENT LIST
A(AXAY,X) ;
 W CYNDI
 I X="" S AXAY(1)="NO PATIENT REQUESTED" Q
 S AXAFORM=$P(X,"^",2),X=$P(X,"^")
 D FIND^DIC(2,,".01;.09;.03","MPS",X,500)
 I $G(DIERR) D CLEAN^DILF Q
 I $P(^TMP("DILIST",$J,0),"^")=0 S AXAY(1)="NO PATIENTS FOUND" Q
 F I=0:0 S I=$O(^TMP("DILIST",$J,I)) Q:I=""  D
 .S NAME=$P(^TMP("DILIST",$J,I,0),"^",2)
 .S SSN=$P(^TMP("DILIST",$J,I,0),"^",3)
 .S:DUZ=0 AXAY(I)="Sorry, problem logging onto Vista.",ASSN=0
 .S:DUZ'=0 ASSN=$P(^VA(200,DUZ,1),"^",9) I ASSN=SSN Q  ; S AXAY(I)="Sorry, accessing your own medical record."
 .S DOB=$P(^TMP("DILIST",$J,I,0),"^",4)
 .S DFN=$P(^TMP("DILIST",$J,I,0),"^")
 .S B=^DPT(DFN,0)
 .D AGE
 .S DATE=DOB
 .D ^AXAMDY S:NDATE'="" DOB=NDATE
 .D ^AXADGS
 .S AXAY(I)=NAME_U_SSN_U_AGE_U_DOB_U_AXAS_AXAC W !,AXAY(I)
 K NAME,SSN,DOB,DFN,B,AGE,AXAS,AXAC,DATE,AD,AY,NDATE,ASSN
 Q
IEN(AXAY,X) ;x=ssn return DFN
 I X="" S AXAY(1)="NO PATIENT REQUESTED" Q
 D DFN I DFN="" S AXAY(1)="INCORRECT SSN" Q
 S FLAG=0,DONE=0
 I $D(^DPT(DFN,.1)) I $P(^DPT(DFN,.1),"^")="" S FLAG=1 G OUTP
 I '$D(^DPT(DFN,.1)) S FLAG=1 G OUTP
 F II=0:0 S II=$O(^AUPNVSIT("AA",DFN,II)) Q:II=""!(FLAG="DONE")  Q:DONE=1  F JJ=0:0 S JJ=$O(^AUPNVSIT("AA",DFN,II,JJ)) Q:JJ=""!(FLAG="DONE")  Q:DONE=1   D
 .S VIS=$P(^AUPNVSIT(JJ,0),"^")
 .S ADM=$P(^DPT(DFN,.105),"^"),ADM=$P(^DGPM(ADM,0),"^")
 .I ADM=VIS S VISID=JJ,FLAG="DONE" Q
 .I FLAG=0 S:VIS=0 DONE=1,VISID=JJ
 .I FLAG=1 S:VIS=1 DONE=1,VISID=JJ
 G:'$D(VISID) OUTP G:VISID="" OUTP
 S DIC="^AUPNVSIT(",DIQ="A(",DIQ(0)="IE",DA=VISID
 S DR=".01;.22" D EN^DIQ1
 S AXAY(1)=DFN_"^"_VISID_"^"_A(9000010,VISID,.01,"E")_"^"_A(9000010,VISID,.22,"E")_"^"_$$FMTE^XLFDT(A(9000010,VISID,.01,"I"),2)
 Q
OUTP ;Just send DFN for outpatient
 S AXAY(1)=DFN_"^^^"
 Q
 ;
B(AXAY) ;Return employee data to RPC Call  AXA USER DUZ
 K AXAY N PTR,DONE,UCLASS,CPTR
 I '$G(DUZ) S AXAY="DUZ=0^0" Q
 S (PTR,DONE,RN)=0
  F  S PTR=$O(^USR(8930.3,"B",+DUZ,PTR)) Q:'PTR  D  Q:DONE
 .S CPTR=$P($G(^USR(8930.3,+PTR,0)),U,2)
 .I +CPTR=591 S (RN,DONE)=+CPTR
 I +$G(RN) S UCLASS=$P($G(^USR(8930,+CPTR,0)),U,1)
 S AXAY=$P(^VA(200,DUZ,0),"^")_"^"_DUZ
 S $P(AXAY,U,3)=$P($G(^DIC(3.1,+$P($G(^VA(200,+DUZ,0)),U,9),0)),U)
 S $P(AXAY,U,4)=$P($G(^VA(200,+DUZ,1)),U,9)
 S $P(AXAY,U,5)=$P($G(^DIC(49,+$P($G(^VA(200,+DUZ,5)),U,1),0)),U)
 S $P(AXAY,U,6)=$G(UCLASS)
 I +$P($G(^VA(200,DUZ,2,1,0)),U)>0 D
 .S DIVPTR=$P($G(^VA(200,DUZ,2,1,0)),U)
 .S $P(AXAY,U,7)=$P($G(^DIC(4,DIVPTR,0)),U)
 Q
 ;
C(AXAY,AXAX) ;Return location array to RPC call   AXA PATIENT DATA
 I AXAX="" S AXAY(1)="NO SSN REQUESTED" Q
 S X=AXAX
 S AXAY(1)="NO PATIENTS FOUND",AXAY(2)="",AXAY(3)="",AXAY(4)=""
 S (SEX,WARD,POS,RACE,SB,SCP,PE,POW,MS,DOD,REL,ATT,STATUS)=""
 ;D FIND^DIC(2,,".02;.1;.323;.325;.302;.361;.525;.05;.06;.31115;.08","MPS",X,500)
 ;I $G(DIERR) D CLEAN^DILF Q
 ;I $P(^TMP("DILIST",$J,0),"^")=0 S AXAY(1)="NO PATIENTS FOUND" Q
 ;S I=0 S I=$O(^TMP("DILIST",$J,I)) Q:I=""  D
 ;S DFN=$P(^TMP("DILIST",$J,I,0),"^",1)
 ;S SEX=$P(^TMP("DILIST",$J,I,0),"^",2)
 ;S WARD=$P(^TMP("DILIST",$J,I,0),"^",3)
 ;S POS=$P(^TMP("DILIST",$J,I,0),"^",4)  ;period of service
 ;S SB=$P(^TMP("DILIST",$J,I,0),"^",5)  ;service branch
 ;S SCP=$P(^TMP("DILIST",$J,I,0),"^",6)  ;service connected percent
 ;S DOD=$P(^TMP("DILIST",$J,I,0),"^",7)  ;primary elig
 ;S POW=$P(^TMP("DILIST",$J,I,0),"^",8)
 ;S MS=$P(^TMP("DILIST",$J,I,0),"^",9)  ;marital status
 ;S RACE=$P(^TMP("DILIST",$J,I,0),"^",10)
 ;S REL=$P(^TMP("DILIST",$J,I,0),"^",12)  ;religious preference
 ;I DOD["DOD" S DOD=$P(DOD,"DOD",2),DOD=$E(DOD,1,13)
 ;S STATUS=$P(^TMP("DILIST",$J,I,0),"^",11)
 ;S AXAY(I)=MS
 ;S DFN=$P(^TMP("DILIST",$J,I,0),"^")
 D DFN Q:DFN=""
 S ^DISV(DUZ,"^DPT(")=DFN
 S SEX=$P(^DPT(DFN,0),"^",2)
 S RACE=$P(^DPT(DFN,0),"^",6) S:RACE'="" RACE=$P(^DIC(10,RACE,0),"^")
 S MS=$P(^DPT(DFN,0),"^",5) S:MS'="" MS=$P(^DIC(11,MS,0),"^")
 S TYPE=$G(^DPT(DFN,"TYPE"),"^"),TYPE=$G(^DG(391,TYPE,0),"^") ;WPB/GTD
 ;S:$D(^DPT(DFN,.1)) WARD=^DPT(DFN,.1)
 K DIQ(0)
 S DR=".08;.1;.1041",DA=DFN,DIC="^DPT(",DIQ="CCC"
 D EN^DIQ1
 S DIQ(0)="I"
 D EN^DIQ1
 S REL=CCC(2,DFN,.08)
 S ATT=CCC(2,DFN,.1041,"I")_"^"_CCC(2,DFN,.1041)
 S WARD=CCC(2,DFN,.1)
 D ADD^VADPT
 S AXAY(1)=VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)_U_VAPA(8)
 D OAD^VADPT
 S AXAY(2)=VAOA(9)_U_VAOA(10)
 S VAOA("A")=5 D OAD^VADPT
 S AXAY(3)=VAOA(9)_U_MS_U_TYPE
 S AXAY(4)=DFN_U_SEX_U_WARD_U_POS_U_SB_U_SCP_U_RACE_U_POW_U_DOD_U_STATUS_U_REL
 ;W AXAY(4)
 S AXAY(5)=$P($G(^DPT(DFN,.291)),U,4) ; Guardian (CIVIL) field.
 K SEX,WARD,POS,SB,SCP,RACE,POW,DOD,STATUS,REL,TYPE
 K VAPA,VAOA
 Q
 ;Calculate patient age for call to label A of this routine
AGE D NOW^%DTC S DT=X,X1=$S($G(^DPT(DFN,.351)):+^(.351),1:DT),X2=$P(B,U,3),X="" D:X2 ^%DTC:X1 S X=X\365.25,AGE=X S:AGE="" AGE=N
 Q
DFN ;
 N AA,XX,ZZ
 I $D(^DPT("SSN",X)) S DFN=$O(^DPT("SSN",X,0)) Q
 S FLAG=0 F ZZ=65:1:90 D  Q:FLAG
 .S AA=$C(ZZ),DFN=$O(^DPT("SSN",X_AA,0))
 .I +DFN S FLAG=1 Q
 Q:FLAG  S DFN=""
 Q
AUTO(AXAY,AXAX) ;Set autosign on to on and off depending on axax
 S:AXAX="OFF" $P(^VA(200,DUZ,200),"^",18)=0
 S:AXAX="ON" $P(^VA(200,DUZ,200),"^",18)=1
 S AXAY(0)=$P(^VA(200,DUZ,200),"^",18)
 Q
 ;
R(OKYN,MSGNO,MSGTEXT) ;
 F M=-1:0 S M=$O(MSGTEXT(M)) Q:M=""  S MM(M+1)=MSGTEXT(M)
 S X=$$ENT^XMA2R(MSGNO,"RESPONSE",.MM,"",DUZ)
 S OKYN=X
 Q
 ;
F(AXAY,AXAX) ;
 N MAILGRP,XMY,XMZ
 S XMZ=$P($G(AXAX),U,1)
 S MAILGRP=$P($G(AXAX),U,3)
 S XMY(MAILGRP)=""
 I ($G(XMZ)']"")!($G(MAILGRP)']"") S AXAY="ERROR" Q
 D ENT1^XMD
 S AXAY="DONE"
 ;
USEROK(AXAY,AXAX) ;
 S AXAY="OK"
 S IEN=$O(^VA(200,"B",AXAX,0))
 I +$O(^VA(200,"B",AXAX,0))=0 D  Q
 .S AXAY=AXAX_" IS NOT A VALID NAME."
 I +$P(^VA(200,IEN,0),U,7)>0 D  Q
 .S AXAY=AXAX_" DOES NOT HAVE VISTA ACCESS."
 I (+$P(^VA(200,IEN,0),U,11)>0)&(+$P(^VA(200,IEN,0),U,11)<DT) D  Q
 .S AXAY=AXAX_" HAS BEEN TERMINATED."
 Q
 ;
GROUPOK(AXAY,AXAX) ;
 S AXAY="OK"
 I +$O(^XMB(3.8,"B",AXAX,0))=0 S AXAY=AXAX_" IS NOT A VALID MAIL GROUP."
 Q
 ;
ESIG(AXAY,AXAX) ;
 S AXAY=$P($G(^VA(200,AXAX,20)),U,2)_U_$P($G(^VA(200,AXAX,20)),U,3)
 Q
 ;
K(R,X) ; Return a list of user's security keys
 N I,K K R S X=+$G(X) I '$D(^VA(200,X,0)) D  Q
 .S R(1)="-1^Invalid User"
 S I=0,K="A" F  S K=$O(^XUSEC(K)) Q:K=""  S:$D(^(K,X)) I=I+1,R(I)=K
 I 'I S R(1)="0^User Holds No Keys"
 Q
