APGKOB2 ;PHOENIX/KLD; 2/9/99; TIU OBJECTS - LAB TESTS & PANELS (TRENDS); 1/28/00  1:54 PM
ST Q
 ;
PANEL(X) ;Panel Lab Test in a time period object (time=nM, nD, or nY)
 ;X should be "Display name^# of occurances^time period^print a second line? (0 or 1)^Test IENS from file 63.04"
 ;Example: X="Chem 7^3^2Y^1^2,3,4:1:8,790"
 N C,CHK,ED,I,II,FLAG,HOLD,LINE2,SP,TEST,TN S C=0,$P(SP," ",20)=""
 S TN=$P(X,U,1,2),T=$P(X,U,3),LINE2=$P(X,U,4),TEST=$P(X,U,5)
 S CHK(1)=$P(TEST,","),CHK(2)=$P(TEST,",",2)
 F I=1,2,3 S TEST(I)=0 X "F II="_TEST_" S TEST(I,II)="""""
 D GET I FLAG D H(0),DAT(0),SET("") D
 .I LINE2 S HOLD(1)=HOLD D H(HOLD),DAT(HOLD(1))
 Q "~@^TMP(""APGKOB2"","_$J_")"
 ;
ONE(TN) ;Single lab test in a time period object - TN=Test name, N=# of results
 ;TN should be "Data name^# of occurances^time period (nM, nD, or nY)"
 N C,CHK,ED,I,N,SP,T,TEST S C=0,$P(SP," ",50)=""
 S N=$P(TN,U,2),T=$P(TN,U,3),TEST=$O(^DD(63.04,"B",$P(TN,U),0))
 I 'TEST D  Q "~@^TMP(""APGKOB2"","_$J_")"
 .D K S ^TMP("APGKOB2",$J,1,0)=$P(TN,U)_" - INVALID TEST NAME"
 F I=1:1:N S TEST(I)=0,TEST(I,TEST)=""
 S (CHK(1),CHK(2))=TEST D GET
 I FLAG S X=$E($P(TN,U)_SP,1,27)_" " D
 .I 'TEST(1) S X=X_" NO DATA ON FILE" D SET(X) Q
 .F I=1:1:N D:TEST(I)
 ..S X=$S(I=1:X,1:$E(SP,1,27))_$$CONV()_SP
 ..S X=$E(X,1,45)_$P(TEST(I,CHK(1)),U)_" "_$P(TEST(I,CHK(1)),U,2)
 ..D SET(X)
ONEQ Q "~@^TMP(""APGKOB2"","_$J_")"
 ;
GET ;Get data from ^LR(DFN,"CH")
 N N,LRDFN,X D K,NONE,AGO
 S N=1,FLAG=0,LRDFN=$G(^DPT(DFN,"LR")) Q:'LRDFN
 F I=0:0 S I=$o(^LR(LRDFN,"CH",I)) Q:'I!(I>ED)!(N>$P(TN,U,2))  D
 .Q:'$D(^(I,CHK(1)))!('$D(^(CHK(2))))  S FLAG=0 ;Double check if tests are there
 .F TEST=1:0 S TEST=$o(^LR(LRDFN,"CH",I,TEST)) Q:'TEST  S X=^(TEST) D
 ..Q:'$D(TEST(N,TEST))  S:'TEST(N,TEST) TEST(N,TEST)=$P(X,U,1,2),FLAG=1
 .S:FLAG TEST(N)=I,N=N+1
 Q
 ;
H(N) ;Header line
 N I,X,XX S X=$E($P(TN,U)_" Coll. date"_SP,1,23)
 F I=N:0 S I=$O(TEST(1,I)) Q:'I!($L(X)>72)  D
 .S XX=$E($S($T(@I)]"":$P($T(@I),";",3),1:$P(^DD(63.04,I,0),U)),1,8)_SP
 .S X=X_$E(XX,1,8) Q:$L(X)>72
 D SET(X) S HOLD=I-.1 Q
 ;
DAT(N) ;Data line
 N I,X,XX F I=1:1:3 Q:'TEST(I)  D  D:$L(X)>72 SET(X)
 .S X=$$CONV()_SP,X=$E(X,1,23)
 .F TEST=N:0 S TEST=$O(TEST(I,TEST)) D:'TEST&($L(X)<73) SET(X) Q:'TEST  D  Q:$L(X)>72
 ..S XX=$P(TEST(I,TEST),U) S:XX>0&(XX<1)&($E(XX)=".") XX=0_XX
 ..S:$P(TEST(I,TEST),U,2)]"" XX=XX_" "_$P(TEST(I,TEST),U,2)
 ..S:$E(XX,8)?1A XX=$E(XX,1,7)_" " S X=X_$E(XX_SP,1,8)
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
NONE S ^TMP("APGKOB2",$J,1,0)=$P(TN,U)_" - NONE FOUND" Q
D(Y) D DD^%DT Q Y
 ;
3 ;;BUN
4 ;;CREAT
6 ;;K
7 ;;CHLOR
12 ;;CHOL
13 ;;TOT PRO
15 ;;BILI
17 ;;ALK PH.
47 ;;TRIG
162 ;;APPEAR
220 ;;BETA GL
260 ;;GAMMA G
292 ;;LDL
431 ;;PTT
444 ;;FIO2
453 ;;BASE EX
454 ;;BICARB
502 ;;LYMPH%
683 ;;COLOR
685 ;;SPEC GR
686 ;;UROB
687 ;;BLOOD
688 ;;BILIRU
689 ;;KETONE
690 ;;GLUC
691 ;;PROTEIN
702 ;;HYALINE
790 ;;ANION
795 ;;NITRITE
796 ;;LEU EST
857 ;;GRAN%
858 ;;MONO%
644060 ;;EPITH
644065 ;;UROB
644077 ;;AMPHET
644078 ;;ANALGES
644079 ;;ANTIDEP
644080 ;;BARBITU
644081 ;;BENZO
644082 ;;MISC AG
644083 ;;OPIATES
644084 ;;PHENO
644085 ;;SEDATIV
644135 ;;TP-ELP
644136 ;;ALB-ELP
644165 ;;U R RAN
644166 ;;U C RAN 
644168 ;;UR. SOD
644169 ;;UR. POT
644171 ;;U PR 24
644185 ;;COLL TM
644186 ;;MEAS VL
644333 ;;GAMMA
644379 ;;U PR Q
644419 ;;MALB MG
644448 ;;MALB MI
644449 ;;MALB VL
644564 ;;AL/CR R
644678 ;;COCAINE
644679 ;;CANNAB
644680 ;;ALCOHOL
644725 ;;C/H
