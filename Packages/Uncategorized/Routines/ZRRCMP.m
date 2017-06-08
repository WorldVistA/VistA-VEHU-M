%ZRRCMP ;<543/REB> RCMP ACROSS UCIS ; 18-APR-86
 ; Modified 18-NOV-87; RPH/Troy ISC to allow compares between systems
 ; The global ^UTILITY must have WORLD access set to RWD in both UCIs.
 I '$D(DUZ) W !!,*7,"User Number Undefined",! Q
% S ERR=0,U="^",UA=$P($ZU(0),","),UAV=$P($ZU(0),",",2) ;UA=CURRENT UCI, UB=UCI TO COMPARE
 S UAN=$ZU(UA,UAV)
 ;
 K ^UTILITY($J),REM
 S S1="D SW^%ZRRCMP",X3="ZL @RN F I=1:1 S ^UTILITY($J,1,I)=$T(+I) I $T(+I)="""" S ^UTILITY($J,1,0)=I Q"
 S X2="F I=1:1 S ^UTILITY($J,N,I)=$T(+I) I $T(+I)="""" S ^UTILITY($J,N,0)=I Q"
 S X1="S $ZT=""ERR^%ZRRCMP"" ZL @RN S N=1 X X2 S FLAG=""UB"" X S1 ZL @RN S FLAG=""UA"" X S1 S N=2 X X2"
A ;GET LIST ROUTINES INTO ^UTILITY($J,RNAME); STD DSM CALL
 D ^%RSEL G:'$D(%GO) END
 ;
B ;GET UCI TO CHECK
 R !,"Enter UCI for comparison: ",UB:10 Q:UB="^"  S:UB["," UBV=$P(UB,",",2) S:UB'["," UBV=$P($ZU(0),",",2) S UB=$P(UB,","),ZT=$ZT,$ZT="NOUCI",DDD=$ZU(UB,UBV),$ZT=ZT
 I UB_UBV=(UA_UAV) W *7,"    *** YOU'RE ALREADY IN ",UA," ***" G B
 S UBN=$ZU(UB,UBV)
 ;
C ;GET THE DEVICE
 D ^%ZIS G:POP END U IO
DO ;LOOP THROUGH LIST OF ROUTINES
 S:'ERR RN="" F ZI=0:0 K ^UTILITY($J,1),^(2) S RN=$O(^UTILITY($J,RN)) Q:RN=""  S ERR=0 D:$D(REM) REM X:'$D(REM) X1 D:'ERR CMP
END S FLAG="UA" D SW^%ZRRCMP X ^%ZIS("C")
 K UA,UB Q
 ;
CMP ;COMPARE AND PRINT DIFFERENCES
 Q:'$D(UA)  Q:RN=""
 D SHDR S D=0,L1=1,L2=1
LOOP I ^UTILITY($J,1,L1)'=^UTILITY($J,2,L2) D DIFF
 I ^UTILITY($J,1,L1)=""&(^UTILITY($J,2,L2)="") W !,"There ",$S(D=1:"was ",1:"were "),D,$S(D=1:" difference",1:" differences")," found",! Q
 S L1=L1+1,L2=L2+1 S:'$D(^UTILITY($J,1,L1)) ^(L1)="" S:'$D(^UTILITY($J,2,L2)) ^(L2)="" G LOOP
DIFF W !,"******************** in ",UA,",",UAV," ***********************************************",$S(IOM<132:"",IOM>131:"****************************************************",1:""),!
 S P(1)=L1,P(2)=L2,P=0,D=D+1
DL S P=P+1#2,A=P+1,P(A)=P(A)+1 S:^UTILITY($J,A,0)'>P(A) P(A)=^UTILITY($J,A,0) I ^UTILITY($J,A,P(A))="" S A2=P+1#2+1,P(A2)=^UTILITY($J,A2,0) S J=P(1),K=P(2) G DONE
DL2 S J=P(1) F K=L2:1:P(2) G DONE:^UTILITY($J,1,J)=^UTILITY($J,2,K)
 S K=P(2) F J=L1:1:P(1) G DONE:^UTILITY($J,1,J)=^UTILITY($J,2,K)
 G DL
DONE S P(1)=J,P(2)=K F Z=L1:1:P(1) S LI=^UTILITY($J,1,Z) D LINE W ?2,Z,")",?7,B,?17,C,!
 W !,"-------------------- in ",UB,",",UBV," -----------------------------------------------",$S(IOM<132:"",IOM>131:"----------------------------------------------------",1:""),! F Z=L2:1:P(2) S LI=^UTILITY($J,2,Z) D LINE W ?2,Z,")",?7,B,?17,C,!
 W !,"*******************************************************************************",$S(IOM<132:"",IOM>131:"****************************************************",1:""),! S L1=P(1),L2=P(2) Q
LINE S B="",C="" Q:LI=""  S B=$P(LI," ",1),Q=$F(LI," "),C=$E(LI,Q,255) Q
SHDR W !!,"Comparing routine ",RN," in UCI: ",UA,",",UAV," with UCI: ",UB,",",UBV," on " D ^%D W !! Q
 ;
SW Q:$D(REM)  I FLAG="UA" V 148:$J:$V(148,$J)#256+($P(UAN,",")*256)+($P(UAN,",",2)*8192)
 I FLAG="UB" V 148:$J:$V(148,$J)#256+($P(UBN,",")*256)+($P(UBN,",",2)*8192)
 Q
ERR Q:'$D(UA)  I $ZE["<NOPGM"!($D(FLAG1)) K FLAG1 S FLAG="UA" X S1 W !!,"Routine ",RN," not found in directory ",UB,",",UBV,! S ERR=1 G DO^%ZRRCMP
 W !,$ZE,! G END
NOUCI I $ZE["NOUCI" W !!,*7,"There is no UCI called ",UB,",",UBV," on this system.",! G B
 S $ZT="NOSYS" S DDD=$D(^[UB,UBV]QQQQ),$ZT=ZT,REM="" G C
NOSYS W !!,*7,"There is no UCI called ",UB,",",UBV,".",! G B
REM Q:ERR  Q:'$D(UB)  S ^[UB,UBV]UTILITY("RCMP","UA")=UA,^("UAV")=UAV,^("RN")=RN,^("J")=$J X X3
 J ZJ^%ZRRCMP[UB,UBV]
HANG I '$D(^UTILITY($J,2,0)) H 2 G HANG
 I ^UTILITY($J,2,0)["NOPGM" S FLAG1="",ERR=1 G ERR
 Q
ZJ S UA=^UTILITY("RCMP","UA"),UAV=^("UAV"),RN=^("RN"),J=^("J")
 K ^UTILITY("RCMP")
 S X1="S $ZT=""NOPGM^%ZRRCMP"" ZL @RN F I=1:1 S ^[UA,UAV]UTILITY(J,2,I)=$T(+I) I $T(+I)="""" S ^(0)=I Q"
 X X1 H
NOPGM K ^[UA,UAV]UTILITY(J,1),^(2) S ^[UA,UAV]UTILITY(J,2,0)=$ZE H 
