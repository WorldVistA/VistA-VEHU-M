APGKOB4 ;PHOENIX/KLD; 3/19/99; TIU OBJECTS; 12/17/99  2:29 PM
ST Q
 ;
LADM(Z) ;Z=1 - |LAST ADMISSION|   Z=0 - |LAST ADMISSION DATE|
 N ADM,DA,DIS S X="LAST ADMISSION - NONE FOUND"
 S ADM=$O(^DGPM("ATID1",DFN,0)) I 'ADM D NONE("LAST ADMISSION") Q X
 S DA=$O(^(ADM,0)),DIS=$O(^DGPM("ATID3",DFN,0))
 S ADM=9999999.999999-ADM S:DIS DIS=9999999.999999-DIS
 S X="Last admission: "_$$D(ADM)
 I Z S X=X_"  DX: "_$P(^DGPM(DA,0),U,10) S:DIS>ADM X=X_"  **  DISCHARGED  **"
 Q X
 ;
LDIS() ;|LAST DISCHARGE|
 N ADM,DA,DIS S X="LAST DISCHARGE - NONE FOUND"
 S ADM=$O(^DGPM("ATID3",DFN,0)) I 'ADM D NONE("LAST DISCHARGE") Q X
 S DA=$O(^(ADM,0)),DIS=$O(^DGPM("ATID3",DFN,0))
 S ADM=9999999.999999-ADM S:DIS DIS=9999999.999999-DIS
 S X="Last discharge: "_$$D(ADM)
 Q X
 ;
RAD(P) ;Radiology procedures, specific or all
 ;P=Proc IEN from file 71^Number to print^time period (1M, 2Y, etc.)
 N C,CASE,ED,I,II,J,JJ,N,REC,T,X
 S C=0,T=$P(P,U,3) D AGO S ED=9999999.9999-ED,N=0
 D K,NONE($S($P(P,U)="ALL":"RADIOLOGY PROCEDURES",1:$P(^RAMIS(71,+P,0),U)))
 F I=0:0 S I=$O(^RADPT(DFN,"DT",I)) Q:'I!(I>ED)!(N=$P(P,U,2))  D
 .F II=0:0 S II=$o(^RADPT(DFN,"DT",I,"P",II)) Q:'II  D
 ..S REC=^(II,0),PROC=$P(REC,U,2) I $P(P,U)'="ALL" Q:+P'=PROC
 ..S CASE=9999999.9999-I,X="***  Exam date: "_$$D(CASE)_"    Proc: "
 ..S X=X_$P(^RAMIS(71,PROC,0),U)_"  ***",N=N+1 D SET
 ..S CASE=$E(CASE,4,7)_$E(CASE,2,3)_"-"_+REC
 ..I '$D(^RARPT("B",CASE)) S X="No report info on file!" D SET Q
 ..S CASE=$O(^(CASE,0)) Q:'CASE  F J="I","R" S X="" D SET D
 ...S X="*** "_$S(J="I":"IMPRESSION",1:"REPORT")_" TEXT: ***" D SET
 ...I '$D(^RARPT(CASE,J)) S X="  NONE" D SET Q
 ...F JJ=0:0 S JJ=$O(^RARPT(CASE,J,JJ)) Q:'JJ  S X=^(JJ,0) D SET
 ..S X="" D SET,SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
CY() ;|LAST CYTOLOGY REPORT|
 D K,NONE("CYTOLOGY REPORT") S C=0,LRDFN=$G(^DPT(DFN,"LR"))
 I 'LRDFN S X="CYTOLOGY REPORT - NO LRDFN ON FILE" D SET Q "~@^TMP(""APGKOB4"","_$J_")"
 S DATE=$O(^LR(LRDFN,"CY",0)) Q:'DATE "~@^TMP(""APGKOB4"","_$J_")"
 S X="LAST CYTOLOGY REPORT - "_$$D(9999999-DATE) D SET
 F I=.3,.5,1.1 D:$O(^LR(LRDFN,"CY",DATE,I,0))
 .S X="  "_$P("^^PREOP DIAG.^^POSTOP DIAG^^^^^^MICROSCOPIC EVAL",U,I*10)_":" D SET
 .F II=0:0 S II=$O(^LR(LRDFN,"CY",DATE,I,II)) Q:'II  D
 ..S FLAG=1,X="    "_^(II,0) D SET
 I $O(^LR(LRDFN,"CY",DATE,2,0)) S X="  MORPHOLOGY:" D SET
 F I=0:0 S I=$O(^LR(LRDFN,"CY",DATE,2,I)) Q:'I  D
 .F II=0:0 S II=$O(^LR(LRDFN,"CY",DATE,2,I,2,II)) Q:'II  D
 ..S X="    "_$P(^LAB(61.1,^(II,0),0),U) D SET S FLAG=1
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
RXTP() ;|TODAY'S OUTPATIENT MEDS FOR AUTHOR|
 N C,I,REC S C=0
 D K,NONE("TODAY'S OUTPATIENT MEDS FOR AUTHOR"),^PSOHCSUM
 F I=0:0 S I=$O(^TMP("PSOO",$J,I)) Q:'I  S REC=^(I,0) D
 .Q:+REC'=DT  Q:+$P(REC,U,4)'=DUZ  
 .S X=$P($P(REC,U,3),";",2) D SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
CP(N,T) ;Completed Procedures
 N C,ED,I,II,X D K,NONE("PROCEDURES") D AGO S C=0
 F I=0:0 S I=$O(^DGPT("B",DFN,I)) Q:'I!(C>N)  D
 .F II=0:0 S II=$O(^DGPT(I,"P",II)) Q:'II  S X=^(II,0) D
 ..Q:$P(X,U)<ED  S X(1)=^ICD0($P(X,U,5),0)
 ..S X=$$D(+X)_"   "_$P(X(1),U)_"  "_$P(X(1),U,4) D SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
PAIN(N,T) ;Pain object
 N C,ED,I,II,X D K,NONE("PAIN") D AGO S C=0
 F I=9E9:0 S I=$O(^GMR(120.5,"C",DFN,I),-1) Q:'I!(C=N)  D
 .S X=$G(^GMR(120.5,I,0)) Q:+X<ED  Q:$P(X,U,3)'=22  ;Date, Pain
 .S X=$$D(+X)_"   Rate: "_$P(X,U,8) D SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
VIT(N,T) ;VITALS object (trend) - temp, pulse, resp, bp, pain
 N C,ED,I,II,REC,SP,X D K,NONE("VITALS"),AGO S C=0,$P(SP," ",20)=""
 F I=0:0 S I=$O(^GMR(120.5,"C",DFN,I)) Q:'I!(C=N)  D
 .S X=$G(^GMR(120.5,I,0)) Q:+X<ED
 .S $P(REC(+X),U,$P(X,U,3))=$P(X,U,8)
 F I=0:0 S I=$O(REC(I)) Q:'I  K:$L(REC(I),U)<2 REC(I)
 I '$D(REC) Q "~@^TMP(""APGKOB4"","_$J_")"
 S X=$E("  DATE/TIME"_SP,1,20)
 F I="TEMP","PULSE","RESP","BP","PAIN" S X=X_$E(I_SP,1,10)
 D SET F I=9E9:0 S I=$O(REC(I),-1) Q:'I!(C>N)  D
 .S X=$E($$D1(I)_SP,1,20)
 .F II=2,5,3,1,22 S X=X_$E($P(REC(I),U,II)_SP,1,10)
 .D SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
VIS(N,T,V) ;Single Vital sign
 N C,ED,I,II,REC,SP,X D K,NONE("VITALS-SINGLE"),AGO
 S C=0,$P(SP," ",20)=""
 F I=9E9:0 S I=$O(^GMR(120.5,"C",DFN,I),-1) Q:'I!(C=N)  D
 .S X=$G(^GMR(120.5,I,0)) Q:+X<ED  Q:$P(X,U,3)'=V
 .S X=$E($$D1(+X)_SP,1,20)_$P(^GMRD(120.51,$P(X,U,3),0),U)_": "_$P(X,U,8)
 .D SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
PC() ;Past Clinic Appts
 N C,I,N,REC,T S C=0,N=10,T="2Y" D K,NONE("VITALS"),AGO
 F I=DT:0 S I=$O(^DPT(DFN,"S",I),-1) Q:'I!(I<ED)!(C=N)  S REC=^(I,0) D
 .S X=$$D1(I)_"   "_$P(^SC(+REC,0),U) D SET
 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
CL(T) ;Critical lab results
 N C,I,LRDFN,TEST,X D K,NONE("CRITICAL LAB RESULTS"),AGO
 S ED=9999999-ED,C=0,LRDFN=$G(^DPT(DFN,"LR"))
 I 'LRDFN S X="INVALID LRDFN - CANNOT ACCESS LAB DATA" D SET Q "~@^TMP(""APGKOB1"","_$J_")"
 D CL1 Q "~@^TMP(""APGKOB4"","_$J_")"
 ;
CL1 F I=0:0 S I=$o(^LR(LRDFN,"CH",I)) Q:'I!(I>ED)  D
 .F TEST=1:0 S TEST=$o(^LR(LRDFN,"CH",I,TEST)) Q:'TEST  S X=^(TEST) D
 ..Q:$P(X,U,2)'["*"  ;Non-critical range
 ..S X=$$D1(9999999-I)_"   "_$P(^DD(63.04,TEST,0),U)_": "_$P(X,U)_"  "_$P(X,U,2) D SET
 Q
 ;
SET S C=C+1,^TMP("APGKOB4",$J,C,0)=X Q
 ;
AGO S X1=DT,X2=+T,X=$P(T,X2,2),X2=-X2
 S X2=X2*$S(X="M":30,X="W":7,X="D":1,1:365) D C^%DTC S ED=X Q
 ;
K K ^TMP("APGKOB4",$J) Q
NONE(X) S ^TMP("APGKOB4",$J,1,0)=X_" - NONE FOUND" Q
D(Y) D DD^%DT Q Y
D1(Y) Q +$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_" @ "_$E($P(Y,".",2)_"0000",1,4)
