%A1CRCOM ;ISC1/JSH RCMP ACROSS UCIS ; 18-APR-86
 ; 
 W !,*7," The global ^UTILITY must have WORLD access set to RWD in both UCIs."
 ;
% S ERR=0,U="^",UA=$P($ZU(0),","),UAV=$P($ZU(0),",",2) ;UA=CURRENT UCI, UB=UCI TO COMPARE
 S UAN=$ZU(UA,UAV)
 K ^UTILITY($J),REM
 S S1="D SW^%A1CRCOM"
 S X3="ZL @RN F I=1:1 S ^UTILITY($J,1,I)=$T(+I) I $T(+I)="""" S ^UTILITY($J,1,0)=I Q"
 S X2="F I=1:1 S ^UTILITY($J,N,I)=$T(+I) I $T(+I)="""" S ^UTILITY($J,N,0)=I Q"
 S X1="S $ZT=""ERR^%A1CRCOM"" ZL @RN S N=1 X X2 S FLAG=""UB"" X S1 ZL @RN S FLAG=""UA"" X S1 S N=2 X X2"
A X ^%ZOSF("RSEL") G:'$D(^UTILITY($J)) END
B R !,"Enter UCI for comparison: ",UB:10 Q:UB="^"  S:UB["," UBV=$P(UB,",",2) S:UB'["," UBV=$P($ZU(0),",",2) S UB=$P(UB,","),ZT=$ZT,$ZT="NOUCI",DDD=$ZU(UB,UBV),$ZT=ZT
 I UB_UBV=(UA_UAV) W *7,"    *** YOU'RE ALREADY IN ",UA," ***" G B
 S UBN=$ZU(UB,UBV)
 ;S DIR("A")="Which compare do you want to run",DIR(0)="S^A:All lines;F:First line ignored;S:Second and first line ignored" D ^DIR G:"SFA"'[Y END  S COM=Y K DIR
BB W !!,?10,"Select one of the following:",!!
 W ?20,"A",?25,"All lines",!,?20,"F",?25,"First line ignored",!,?20,"S",?25,"Second and first line ignored",!!
 R "Which compare do you want to run: ",ANS:300 G:"SFA"'[$E(ANS) END S COM=$E(ANS)
C D ^%ZIS G:POP END U IO W @IOF,!!,"Routine Comparison between ",UA,",",UAV," and ",UB,",",UBV,!!
 W "Comparison Selected: ",$S(COM="A":"All lines in the routine",COM="F":"First line ignored",COM="S":"First and second lines ignored",1:"All lines"),!!
 W !!,"Routines Selected: ",! S RN="" F ZI=0:0 S RN=$O(^UTILITY($J,RN)) Q:RN=""  W $J(RN,10) I $X>(IOM-10) W !
 W !!
DO S:'ERR RN="" F ZI=0:0 K ^UTILITY($J,1),^(2) S RN=$O(^UTILITY($J,RN)) Q:RN=""  S ERR=0 D:$D(REM) REM X:'$D(REM) X1 D:'ERR CMP
END S FLAG="UA" D SW^%A1CRCOM X ^%ZIS("C") K DIR
 K UA,UB Q
CMP ;COMPARE AND PRINT DIFFERENCES
 Q:'$D(UA)  Q:RN=""  S FL1=1
 S D=0 S (L1,L2)=$S(COM="F":2,COM="S":3,1:1)
LOOP I ^UTILITY($J,1,L1)'=^UTILITY($J,2,L2) D SHDR:FL1,DIFF
 S TS=(^UTILITY($J,1,L1)=""&(^UTILITY($J,2,L2)=""))
 I TS Q
 ;
 S L1=L1+1,L2=L2+1 S:'$D(^UTILITY($J,1,L1)) ^(L1)="" S:'$D(^UTILITY($J,2,L2)) ^(L2)="" G LOOP
DIFF W !,"---- ",UA,",",UAV," ----",!!
 S P(1)=L1,P(2)=L2,P=0,D=D+1
DL S P=P+1#2,A=P+1,P(A)=P(A)+1 S:^UTILITY($J,A,0)'>P(A) P(A)=^UTILITY($J,A,0) I ^UTILITY($J,A,P(A))="" S A2=P+1#2+1,P(A2)=^UTILITY($J,A2,0) S J=P(1),K=P(2) G DONE
DL2 S J=P(1) F K=L2:1:P(2) G DONE:^UTILITY($J,1,J)=^UTILITY($J,2,K)
 S K=P(2) F J=L1:1:P(1) G DONE:^UTILITY($J,1,J)=^UTILITY($J,2,K)
 G DL
DONE S P(1)=J,P(2)=K F Z=L1:1:P(1) S LI=^UTILITY($J,1,Z) D LINE W ?2,Z,")",?7,B,?17,C,!
 W !,"---- ",UB,",",UBV," ----",!!
 F Z=L2:1:P(2) S LI=^UTILITY($J,2,Z) D LINE W ?2,Z,")",?7,B,?17,C,!
 W ! X "F KK=1:1:IOM W ""=""" W ! S L1=P(1),L2=P(2) Q
LINE S B="",C="" Q:LI=""  S B=$P(LI," ",1),Q=$F(LI," "),C=$E(LI,Q,255) Q
SHDR W !!,"Comparing routine ",RN," in UCI: ",UA,",",UAV," with UCI: ",UB,",",UBV," on " D ^%D W ! S FL1=0 Q
 ;
SW Q:$D(REM)  I FLAG="UA" V 148:$J:$V(148,$J)#256+($P(UAN,",")*256)+($P(UAN,",",2)*8192)
 I FLAG="UB" V 148:$J:$V(148,$J)#256+($P(UBN,",")*256)+($P(UBN,",",2)*8192)
 Q
ERR Q:'$D(UA)  I $ZE["<NOPGM"!($D(FLAG1)) K FLAG1 S FLAG="UA" X S1 W !!,"Routine ",RN," not found in directory ",UB,",",UBV,! S ERR=1 G DO^%A1CRCOM
 W !,$ZE,! G END
NOUCI I $ZE["NOUCI" W !!,*7,"There is no UCI called ",UB,",",UBV," on this system.",! G B
 S $ZT="NOSYS" S DDD=$D(^[UB,UBV]QQQQ),$ZT=ZT,REM="" G C
NOSYS W !!,*7,"There is no UCI called ",UB,",",UBV,".",! G B
REM Q:ERR  Q:'$D(UB)  S ^[UB,UBV]UTILITY("RCMP","UA")=UA,^("UAV")=UAV,^("RN")=RN,^("J")=$J X X3
 S ZTRTN="ZJ^%A1CRCOM",ZTUCI=UB,ZTCPU=UBV,ZTDTH=$H,ZTIO="" D ^%ZTLOAD ;J ZJ^%A1CRCOM[UB,UBV]
HANG I '$D(^UTILITY($J,2,0)) H 2 G HANG
 I ^UTILITY($J,2,0)["NOPGM" S FLAG1="",ERR=1 G ERR
 Q
ZJ S UA=^UTILITY("RCMP","UA"),UAV=^("UAV"),RN=^("RN"),J=^("J")
 K ^UTILITY("RCMP")
 S X1="S $ZT=""NOPGM^%A1CRCOM"" ZL @RN F I=1:1 S ^[UA,UAV]UTILITY(J,2,I)=$T(+I) I $T(+I)="""" S ^(0)=I Q"
 X X1 H
NOPGM K ^[UA,UAV]UTILITY(J,1),^(2) S ^[UA,UAV]UTILITY(J,2,0)=$ZE H 
