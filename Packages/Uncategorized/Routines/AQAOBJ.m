AQAOBJ ;PROVIDENCE/GD;APRIL 2000;TIU OBJECTS - LAB TESTS & PANELS (TRENDS); 
ST Q
 ;
PANEL(X) ;Panel Lab Test in a time period object (time=nM, nD, or nY)
 ;X should be "Display name^# of occurances^time period^print a second line? (0 or 1)^Specimen"
 ;Example: X="Chem 7^3^2Y^0^BLOOD"
 N C,CHK,ED,I,II,FLAG,HOLD,LINE2,SP,TEST,TN S C=0,$P(SP," ",20)=""
 K COMM,INP S COMM="",INP=""
 S TN=$P(X,U,1,2),T=$P(X,U,3),LINE2=$P(X,U,4),SPEC=$P(X,U,5)
 S TST1=""
 S TST=$P(TN,U) 
 I SPEC]"" S X1="",X1=$O(^LAB(61,"B",SPEC,X1)),SPEC=X1
 S PARM=0
 D GETEST
 I TST="" S ^TMP("APGKOB2",$J,1,0)=$P(TN,U)_" - INVALID TEST NAME" Q "~@^TMP(""APGKOB2"","_$J_")"
 I TST["CBC" S TEST1=TEST,TST1=TST,TST="DIFFERENTIAL (LAB USE ONLY)" D GETEST S TEST=TEST1_","_TEST,TST=TST1,TST1="DIFF"
 S CHK(1)=$P(TEST,","),CHK(2)=$P(TEST,",",2)
 F I=1,2 S TEST(I)=0 X "F II="_TEST_" S TEST(I,II)="""""
 D GET I FLAG D H(0),DAT(0),SET("") D
 .I LINE2 S HOLD(1)=HOLD D H(HOLD),DAT(HOLD(1))
 I 'FLAG S ^TMP("APGKOB2",$J,1,0)="No data for "_$P(TN,U)
 K SPEC,COMM,TSTREF,CHK,PRTST,TEST,REF
 Q "~@^TMP(""APGKOB2"","_$J_")"
 ;
ONE(TN) ;Single lab test in a time period object - TN=Test name, N=# of results
 ;TN should be "Data name^# of occurances^time period (nM, nD, or nY)^Specimen"
 N C,ED,I,N,SP,T,TEST S C=0,$P(SP," ",50)=""
 ;S C=0,$P(SP," ",50)=""
 K COMM,INP,PRTST,REF S COMM="",INP="",CHK=""
 D K
 S SPEC=$P(TN,U,4)
 I SPEC]"" S X1="",X1=$O(^LAB(61,"B",SPEC,X1)),SPEC=X1
 S TST=$P(TN,U)
 S PARM=1
 D GETEST
 S N=$P(TN,U,2),T=$P(TN,U,3)  ;,TEST=$O(^DD(63.04,"B",$P(TN,U),0))
 I TST="" S ^TMP("APGKOB2",$J,1,0)=$P(TN,U)_" - INVALID TEST NAME" Q "~@^TMP(""APGKOB2"","_$J_")"
 F I=1:1:N S TEST(I)=0,TEST(I,TEST)="" 
 S CHK(1)=TEST,CHK(2)=TEST,PARM=1 D GET
 I FLAG D H(0),DAT(0),SET("")
 I 'FLAG S ^TMP("APGKOB2",$J,1,0)="No data for "_$P(TN,U)
 K X1,REF,TSTREF,TEST,PRTST,COMM,SPEC,CHK
ONEQ Q "~@^TMP(""APGKOB2"","_$J_")"
 ;
GET ;Get data from ^LR(DFN,"CH")
 N LRDFN,X D K,AGO
 S CNT=0
 S N=1,FLAG=0,FLG=0,LRDFN=$G(^DPT(DFN,"LR")) Q:'LRDFN
 F I=0:0 S I=$O(^LR(LRDFN,"CH",I)) Q:'I!(I>ED)!(N>$P(TN,U,2))  D
 .;Q:'$D(^(I,CHK(1)))!('$D(^(I,CHK(2))))  S FLAG=0 ;Double check if tests are there
 .S CNT=0
 .I '$D(^(I,CHK(1))),$P(CHK(2),U)]"",'$D(^(I,CHK(2))) S FLG=0 Q
 .F TEST=1:0 S TEST=$o(^LR(LRDFN,"CH",I,TEST)) Q:'TEST  S X=^(TEST) D
 ..;I $P(X,U)["canc" Q
 ..I $P($P(X,U,5),"!")'=SPEC Q
 ..S CNT=CNT+1
 ..Q:'$D(TEST(N,TEST))  S:'TEST(N,TEST) TEST(N,TEST)=$P(X,U,1,2),STST=TEST,FLG=1
 .I FLG,PARM=1,CNT>1 D DEL  
 .I FLG,PARM=0,CNT=1 D DEL
 .S:FLG TEST(N)=I,N=N+1,FLAG=1
 .I FLG,$D(^LR(LRDFN,"CH",I,1,1)) D GETCM
 .S FLG=0
 Q
DEL ;
 S TEST(N,STST)=""
 S FLG=0
 Q
 ;
H(N) ;Header line
 S X=""
 N I,XX   ;S X=$E($P(TN,U)_" Col date"_SP,1,15)_"  "
 S X=$P(TN,U)_"; "_$P(^LAB(61,SPEC,0),U)
 D SET(X)
 S X=""
 S X="Coll. Date:     "
 F I=N:0 S I=$O(TEST(I)) Q:'I  D
 .S XX=$G(TEST(I)),XX=$$DATE^TIULS(9999999-XX,"MM/DD/YY HR:MIN")
 .S X=X_XX_"   " 
 D SET(X) S HOLD=I-.1  ;Q
 S X=""
 S X=$$SETSTR^VALM1("Test Name",X,1,9)
 S X=$$SETSTR^VALM1("Result",X,18,6)
 S X=$$SETSTR^VALM1("Result",X,35,6)
 S X=$$SETSTR^VALM1("Units",X,50,7)
 S X=$$SETSTR^VALM1("Range",X,62,15)
 D SET(X)
 Q
 ;
DAT(N) ;Data line
 N I,XX F I=1:1:2 Q:'TEST(I)  D  
 .F TEST=N:0 S TEST=$O(TEST(I,TEST)) Q:'TEST  D 
 ..S PRTST(TEST,I)=$G(TEST(I,TEST))
 S J="" F  S J=$O(PRTST(J)) Q:'J  D
 .S X=$E($P(REF(J),U),1,15)
 .S X=$$SETSTR^VALM1(X,X,1,15)
 .I $L(PRTST(J,1))=0&('$D(PRTST(J,2))) S X="" Q
 .I $L(PRTST(J,1))=0,$D(PRTST(J,2)),$L(PRTST(J,2))=0 S X="" Q
 .S J1="" F  S J1=$O(PRTST(J,J1)) Q:'J1  D
 ..S XX=$G(PRTST(J,J1))
 ..S XX=$P(XX,U)_" "_$P(XX,U,2)
 ..;S X=X_XX_"        "
 ..S:J1=1 X=$$SETSTR^VALM1(XX,X,18,10)
 ..S:J1=2 X=$$SETSTR^VALM1(XX,X,35,10)
 .S X=$$SETSTR^VALM1($P(REF(J),U,2),X,50,10)
 .S X=$$SETSTR^VALM1($P(REF(J),U,3),X,60,5)
 .S X=$$SETSTR^VALM1(" - ",X,65,3)
 .S X=$$SETSTR^VALM1($P(REF(J),U,4),X,68,8)
 .D SET(X)
 S J=0 F  S J=$O(COMM(J)) Q:'J  D
 .S J1=0 F  S J1=$O(COMM(J,J1)) Q:'J1  D
 ..S:J1 X="Comment - "_$$DATE^TIULS(9999999-J,"MM/DD/YY HR:MIN")_": "
 ..S X=X_$G(COMM(J,J1)) D SET(X)
 S X="",J=0 F  S J=$O(INP(J)) Q:'J  D
 .S X="Interpretation for "_$P(REF(J),U)_": "
 .S J1=0 F  S J1=$O(INP(J,J1)) Q:'J1  D
 ..S X=X_$G(INP(J,J1))
 ..D SET(X) S X="   "
 Q
 ;
CONV(X) S X=9999999-TEST(I),XX=$E($P(X,".",2)_"0000",1,4)
 S X=X_$E(XX,1,2)_":"_$E(XX,3,4)
 S X=+$E(X,4,5)_"/"_+$E(X,6,7)_"/"_$E(X,2,3)_" " 
 S X=X_$E(XX,1,2)_":"_$E(XX,3,4) Q X
 ;
SET(X) S C=C+1,^TMP("APGKOB2",$J,C,0)=X,X="" Q
 ;
AGO S X1=DT,X2=+T,X=$P(T,X2,2),X2=-X2
 S X2=X2*$S(X="M":30,X="W":7,X="D":1,1:365) D C^%DTC S ED=9999999-X Q
 ;
K K ^TMP("APGKOB2",$J) Q
GETCM ;
 S J=0 F  S J=$O(^LR(LRDFN,"CH",I,1,J)) Q:'J  D
 .S COMM(I,J)=$G(^LR(LRDFN,"CH",I,1,J,0))
 Q
GETREF(PARM) ;
 S REF=$G(^LAB(60,IEN,1,SPEC,0))
 S REFTST=$G(^LAB(60,IEN,0))
 S TESTNAME=$P(REFTST,U)
 S REFTST=$P(REFTST,U,12),REFTST=$P(REFTST,",",2)
 S X=""
 S TSTUNIT=$P(REF,U,7),TSTUNIT=$P(TSTUNIT,U)_" "_$P(TSTUNIT,U,2)
 I $P(REF,U,2)["$S(" S FLD=2,REC=$P(REF,U,2) D RESET
 I $P(REF,U,3)["$S(" S FLD=3,REC=$P(REF,U,3) D RESET
 S X=TESTNAME_U_TSTUNIT_U_$P(REF,U,2)_U_$P(REF,U,3)
 S REF(REFTST)=X
 I $D(^LAB(60,IEN,1,SPEC,1,0)) D GETINP
 Q
RESET ;
 S SX=$P(^DPT(DFN,0),U,2)
 S POS=$F(REC,":"),REC1=$E(REC,POS,$F(REC,",")-2)
 S REC2=$P(REC,":",3),REC2=$E(REC2,1,$L(REC2)-1)
 I REC[SX S $P(REF,U,FLD)=REC1
 E  S $P(REF,U,FLD)=REC2
 Q
GETINP ;
 S X="  Interpretation: "
 S I1=0 F  S I1=$O(^LAB(60,IEN,1,SPEC,1,I1)) Q:'I1  D
 .S INP(REFTST,I1)=$G(^LAB(60,IEN,1,SPEC,1,I1,0))
 Q
 Q
NONE S ^TMP("APGKOB2",$J,1,0)=$P(TN,U)_" - NONE FOUND" Q
GETEST ;
 S TEST=""
 I '$D(^LAB(60,"B",TST)) S TST="" Q
 S J="" S J=$O(^LAB(60,"B",TST,J))
 S J1=0 F  S J1=$O(^LAB(60,J,2,J1)) Q:'J1  D
 .S LIEN=$G(^LAB(60,J,2,J1,0))
 .S REC=$G(^LAB(60,LIEN,0))
 .I $P(REC,U,12)']"" D MORE
 .E  S REC=$P(REC,U,12),REC=$P(REC,",",2),TEST=TEST_REC_",",IEN=LIEN D GETREF(PARM)
 S TEST=$E(TEST,1,$L(TEST)-1)
 I TEST']"",PARM=1 S REC=$G(^LAB(60,J,0)),REC=$P(REC,U,12),REC=$P(REC,",",2),TEST=REC,IEN=J D GETREF(PARM)
 Q
MORE ;
 S I=0 F  S I=$O(^LAB(60,LIEN,2,I)) Q:'I  D
 .S MIEN=$G(^LAB(60,LIEN,2,I,0))
 .S MREC=$G(^LAB(60,MIEN,0))
 .S MREC=$P(MREC,U,12),MREC=$P(MREC,",",2)
 .S TEST=TEST_MREC_","
 .S IEN=MIEN D GETREF(PARM)
 Q
D(Y) D DD^%DT Q Y
 ;
