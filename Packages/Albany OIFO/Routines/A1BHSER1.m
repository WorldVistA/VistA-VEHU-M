A1BHSER1 ;ISC1/JAS;PROCESS THE A1BH LDRS UPDATE VIA SERVER [ 01/08/93  4:16 PM ]
 ;;V1.0;;
 S U="^"
 S (A1BHCNT,A1BHFLG,A1BHF,CNT1,CNT2,CNT3)=0
 S A1BHN=""
PROCESS ;
 X XMREC
 I $D(XMER) G QU:XMER<0
 S A1BHCNT=A1BHCNT+1
 S A1BH(A1BHCNT)=XMRG
 S ^JAS(A1BHCNT)=XMRG ;USED FOR DEBUGGING
 G PROCESS
QU ;
 D NOW^%DTC
 S A1BHN=$O(^A1BH(11181,"C",A1BH(3),A1BHN))
 I $P(^A1BH(11181,A1BHN,0),"^",2)'=A1BH(2) D OTHER
 I A1BHFLG<2 S $P(^A1BH(11181,A1BHN,0),"^",9)=A1BH(6),$P(^A1BH(11181,A1BHN,0),"^",10)=A1BH(7),$P(^A1BH(11181,A1BHN,0),"^",6)=A1BH(4),$P(^A1BH(11181,A1BHN,0),"^",7)=A1BH(1)
 I A1BHFLG<2 F I=8:1:A1BHCNT D:A1BHF=1 REST1 D:A1BHF=0 REST
 I CNT1>0 S ^A1BH(11181,A1BHN,2,0)="^^"_CNT1_"^"_CNT1_"^"_X
 I CNT2>0 S ^A1BH(11181,A1BHN,3,0)="^^"_CNT2_"^"_CNT2_"^"_X
 Q
OTHER ;   
 S A1BHFLG=A1BHFLG+1
 I A1BHFLG>2 Q
 S A1BHN=$N(^A1BH(11181,"C",A1BH(3),A1BHN))
 I $P(^A1BH(11181,A1BHN,0),"^",2)'=A1BH(2) G OTHER
 Q
REST ;
 I A1BH(I)["=====" S A1BHF=1 Q
 I A1BHF=0 S CNT1=CNT1+1 S ^A1BH(11181,A1BHN,2,CNT1,0)=A1BH(I)
 Q
REST1 ;
 I A1BHF=1 D:CNT3>0 L2 D:CNT3=0 L1 Q
 Q
L2 S CNT2=CNT2+1 S ^A1BH(11181,A1BHN,3,CNT2,0)=A1BH(I)
 Q
L1 ;
 S CNT3=CNT3+1 S $P(^A1BH(11181,A1BHN,0),"^",11)=A1BH(I)
 Q
