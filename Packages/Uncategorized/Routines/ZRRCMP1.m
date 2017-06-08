%ZRRCMP1 ;<543/REB> RCMP ACROSS UCIS ; 18-APR-86
 ; Modified 30-NOV-87; RPH/Troy ISC 
 ; The global ^UTILITY must have WORLD access set to RWD in both UCIs.
 I '$D(DUZ) W !!,*7,"User Number Undefined",! Q
% ;
 K ^UTILITY($J),REM
 S X2="F I=1:1 S ^UTILITY($J,N,I)=$T(+I) I $T(+I)="""" S ^UTILITY($J,N,0)=I Q"
 S X1="ZL @RN1 S N=1 X X2 ZL @RN2 S N=2 X X2"
A ;
 R !,"First Routine: ",RN1 R !,"Second Routine: ",RN2
B ;
C ;
 D ^%ZIS G:POP END U IO
DO ;
 K ^UTILITY($J,1),^(2) X X1 D CMP
END ;
 X ^%ZIS("C")
 K UA,UB Q
CMP ;
 D SHDR S D=0,L1=1,L2=1
LOOP I ^UTILITY($J,1,L1)'=^UTILITY($J,2,L2) D DIFF
 I ^UTILITY($J,1,L1)=""&(^UTILITY($J,2,L2)="") W !,"There ",$S(D=1:"was ",1:"were "),D,$S(D=1:" difference",1:" differences")," found",! Q
 S L1=L1+1,L2=L2+1 S:'$D(^UTILITY($J,1,L1)) ^(L1)="" S:'$D(^UTILITY($J,2,L2)) ^(L2)="" G LOOP
DIFF W !,"******************** ",RN1," ***********************************************",$S(IOM<132:"",IOM>131:"****************************************************",1:""),!
 S P(1)=L1,P(2)=L2,P=0,D=D+1
DL S P=P+1#2,A=P+1,P(A)=P(A)+1 S:^UTILITY($J,A,0)'>P(A) P(A)=^UTILITY($J,A,0) I ^UTILITY($J,A,P(A))="" S A2=P+1#2+1,P(A2)=^UTILITY($J,A2,0) S J=P(1),K=P(2) G DONE
DL2 S J=P(1) F K=L2:1:P(2) G DONE:^UTILITY($J,1,J)=^UTILITY($J,2,K)
 S K=P(2) F J=L1:1:P(1) G DONE:^UTILITY($J,1,J)=^UTILITY($J,2,K)
 G DL
DONE S P(1)=J,P(2)=K F Z=L1:1:P(1) S LI=^UTILITY($J,1,Z) D LINE W ?2,Z,")",?7,B,?17,C,!
 W !,"-------------------- ",RN2," -----------------------------------------------",$S(IOM<132:"",IOM>131:"----------------------------------------------------",1:""),! F Z=L2:1:P(2) S LI=^UTILITY($J,2,Z) D LINE W ?2,Z,")",?7,B,?17,C,!
 W !,"*******************************************************************************",$S(IOM<132:"",IOM>131:"****************************************************",1:""),! S L1=P(1),L2=P(2) Q
LINE S B="",C="" Q:LI=""  S B=$P(LI," ",1),Q=$F(LI," "),C=$E(LI,Q,255) Q
SHDR W !!,"Comparing routine ",RN1," in UCI: ",$ZU(0)," with ",RN2 Q
