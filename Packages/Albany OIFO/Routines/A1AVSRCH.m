A1AVSRCH ;ISC1/JSH - SEARCHING INI ROUTINES FOR ITEMS ; 29 APRIL 91
 ;;V1
EN ;
 S DIC=9.4,DIC("A")="Select PACKAGE to Search: ",DIC(0)="AEMQFZ" D ^DIC K DIC I Y>0 S X=$P(^DIC(9.4,+Y,0),U,2)
 I Y<0&(U'=X) W !,"Not found in current Package File entries",!!,"Tell me the Namespace to search: " R X:300 Q:$L(X)'>1  Q:$L(X)>4  I Y>0 S X=$P(^DIC(9.4,+Y,0),U,2)
 S NMSP=X,PKG=+Y F I="DIE","DIBT","DIPT","KEY","FUN","OPT","PKG" S @I="$J,"_""""_I_""""
 S ROU=$E(NMSP_"INI",1,5),STOP=0,Y0=0 D ^%ZIS Q:POP  U IO W @IOF,"Searching the ""INI"" routines in the "_NMSP_" namespace in "_$ZU(0),!!
 S EXE(1)="F R=1001:1:1999 X EXE(2) I STOP Q"
 S EXE(2)="S DN=$S(R<2000:ROU_$E(R,2,4),1:0),R=$S(R=2000:2028,1:R),%C=R#52+65,%B=R-2028\52+65,%B=$S(%B>90:%B+6,1:%B),%C=$S(%C>90:%C+6,1:%C),DN=$S(R=2028:DN_$C(48,%B,%C),1:DN) X EXE(3)"
 S EXE(3)="S X=DN X ^%ZOSF(""TEST"") S:'$T STOP=1 I 'STOP ZL @DN X EXE(4)"
 S EXE(4)="F ZZ=1:1 S X=$T(Q+ZZ) Q:X=""""  X EXE(41) X:Y>0 EXE(Y) S ZZ=ZZ+1"
 S EXE(41)="S Y=$S(X[DIE:411,X[DIPT:412,X[DIBT:413,X[OPT:414,X[FUN:415,X[PKG:416,X[KEY:417,1:0)"
 S EXE(411)="W:Y'=Y0 !?15,""found Input Templates"" S Y0=Y,XX=$P(X,DIE,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 S EXE(412)="W:Y'=Y0 !?15,""found Print Templates"" S Y0=Y,XX=$P(X,DIPT,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 S EXE(413)="W:Y'=Y0 !?15,""found Sort Templates"" S Y0=Y,XX=$P(X,DIBT,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 S EXE(414)="W:Y'=Y0 !?15,""found Options"" S Y0=Y,XX=$P(X,OPT,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 S EXE(415)="W:Y'=Y0 !?15,""found Functions"" S Y0=Y,XX=$P(X,FUN,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 S EXE(416)="W:Y'=Y0 !?15,""found Package Entry"" S Y0=Y,XX=$P(X,PKG,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 S EXE(417)="W:Y'=Y0 !?15,""found Security Keys"" S Y0=Y,XX=$P(X,KEY,2) I XX?1"",""1.N1"",0)"" S XX=$T(Q+ZZ+1),XX=$P(XX,""="",2) W !?40,$P(XX,U)"
 ;
 X EXE(1)
 W !!,"done!" K EXE,I,Z,ZZ,X,XX,Y,Y0 D ^%ZISC Q
