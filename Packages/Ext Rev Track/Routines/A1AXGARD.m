A1AXGARD ;SLL/ALBANY ISC; RD ACTION PLAN GROUP APPROVAL; 1/20/88;5/24/88  1:08 PM
 ;;VERSION 1.0
 ;
 D PROMPT G:Y<0 EXIT D EXCEPT G:%Y["^"!(X["^") EXIT D APRV,EXIT Q
PROMPT ;
 S A1AXM=1 K A1AXV
FAC ;
 S DIC="^DIZ(11837,",DIC(0)="AEQNZ" D ^DIC Q:Y<0  S A1AXF=+Y K Y
DATE ;
 S DIC="^DIZ(11830,",DIC(0)="AEQNZ",DIC("S")="I ^DIZ(11830,+Y,""F"")=A1AXF" D ^DIC Q:Y<0  K DIC("S") S AA=+Y K Y
 S A1AXDT=+^DIZ(11830,AA,0),A1AXO=+^DIZ(11830,AA,"O"),A1AXO=$P(^DIZ(11831,A1AXO,0),"^",1)
PGM ;
 I $D(^DIZ(11830,AA,"P"))=0 W !,"NO TYPE OF PROGRAM DATA ENTERED" S Y=-1 Q
 S:A1AXO="CAP" DIC("B")="LAB" S:A1AXO'="JCAHO"&(A1AXO'="CAP") DIC("B")="HOSPITAL"
 S DIC="^DIZ(11830,AA,""P"",",DIC(0)="AEQNZ" S D0=AA D ^DIC Q:Y<0  S AP=+Y K Y,DIC
SERV ;
 I $D(^DIZ(11830,AA,"P",AP,"S"))=0 W !,"NO SERVICE DATA ENTERED" S Y=-1 Q
 S DIC="^DIZ(11830,AA,""P"",AP,""S"",",DIC(0)="AEQNZ" D ^DIC Q:Y<0  S AS=+Y K Y,DIC
 ;
 ;RECOM LOOP
 I $D(^DIZ(11830,AA,"P",AP,"S",AS,"R"))=0 W !,"NO RECOMMENDATION DATA ENTERED" S Y=-1 Q
 S AR="" F I=1:1 S AR=$O(^DIZ(11830,AA,"P",AP,"S",AS,"R","B",AR)) S:AR="" Y=0 Q:AR=""  S ARN=$N(^DIZ(11830,AA,"P",AP,"S",AS,"R","B",AR,0)) D PR
 Q
 ;
PR ;
 S A1AXCOF=$S($D(^DIZ(11830,AA,"P",AP,"S",AS,"R",ARN,5)):$P(^(5),"^",3),1:"") S A1AXRDF=$S($D(^(7)):$P(^(7),"^",3),1:"")
 S A1AXRDT=$S($D(^DIZ(11830,AA,"P",AP,"S",AS,"R",ARN,9)):$P(^(9),"^",2),1:"") S:A1AXRDT'="" A1AXRD=$E(A1AXRDT,4,5)_"/"_$E(A1AXRDT,6,7)_"/"_$E(A1AXRDT,2,3) S:A1AXRDT="" A1AXRD=""
 S A1AXCDT=$S($D(^DIZ(11830,AA,"P",AP,"S",AS,"R",ARN,7)):$P(^(7),"^",2),1:"") S:A1AXCDT'="" A1AXCO=$E(A1AXCDT,4,5)_"/"_$E(A1AXCDT,6,7)_"/"_$E(A1AXCDT,2,3) S:A1AXCDT="" A1AXCO=""
 S A1AXAPR=$S($D(^DIZ(11830,AA,"P",AP,"S",AS,"R",ARN,9)):$P(^(9),"^",1),1:"") S A1AXAPC=$S($D(^(9)):$P(^(9),"^",3),1:"")
 W !,"  REC NO: ",AR,?18,"RD ACT RQ: ",A1AXRDF,?35,"RD APPV: ",A1AXAPR,?55,"RD APPV DATE: ",A1AXRD,!,?18,"CO ACT RQ: ",A1AXCOF,?35,"CO APPV: ",A1AXAPC,?55,"CO APPV DATE: ",A1AXCO
 W !,"  ACTION PLAN:"
 S AC=0 F J=1:1 S AC=$N(^DIZ(11830,AA,"P",AP,"S",AS,"R",ARN,10,AC)) Q:AC<0  W !,^(AC,0)
 I A1AXAPR=""!(A1AXAPR["D") S A1AXV(AR)=ARN S A1AXM=A1AXM+1
 Q
EXCEPT ;
 S A1AXM=A1AXM-1
 W !!,"TOTAL ",A1AXM," ACTION PLANS NOT YET RD APPROVED" Q:A1AXM=0  W ", LISTED AS FOLLOWS:"
 W !,"     " S X=0 F Q=0:0 S X=$O(A1AXV(X)) Q:X=""  W X_","
N S %=1 W !,"DO YOU WANT TO APPROVE ALL ACTION PLANS" D YN^DICN Q:%=1  W:%Y["?" !,"    ANSWER 'YES' OR 'NO'" Q:%Y["^"  G:%<1 N
ENT R !,"ENTER RECOM NO YOU DO NOT WANT TO APPROVE: ",X:DTIME Q:X="^"  Q:X=""
CK ;CK VALIDITY OF ENTRY
 S A1AXFG=0 S Y=0 F W=0:0 S Y=$N(A1AXV(Y)) Q:Y<0  I X=Y S A1AXFG=1 Q
 I A1AXFG=0 S XY=X_" NOT ON THE RD UNAPPROVED LIST, ENTRY DELETED!" W *7,!?10,XY G ENT
PASS K A1AXV(X) S A1AXM=A1AXM-1 G ENT
 Q
APRV ;
 Q:A1AXM'>0  W !,A1AXM," ACTION PLANS WILL NOW BE APPROVED:"
 W !,"     " S X=0 F Q=0:0 S X=$O(A1AXV(X)) Q:X=""  W X_","
N1 S %=1 W !,"ARE YOU SURE" D YN^DICN Q:%=2  W:%Y["?" !,"    ANSWER 'YES' OR 'NO'" Q:%Y["^"  G:%<1 N1
 S A1AX=0 F Q=0:0 S A1AX=$O(A1AXV(A1AX)) Q:A1AX=""  S $P(^DIZ(11830,AA,"P",AP,"S",AS,"R",A1AXV(A1AX),9),"^",1)="A" S $P(^(9),"^",2)=DT D MSG
 W !,"ACTION PLAN APPROVAL COMPLETED."
 I $P(^DIZ(11833,1,0),"^",13)["Y" W !,"MAIL MSG SENT TO SITE!"
 I $P(^DIZ(11833,1,0),"^",13)["Y" W !,"MAIL MSG SENT TO RD!"
 Q
MSG ;
 S D0=AA,D1=AP,D2=AS,D3=A1AXV(A1AX)
 D:$P(^DIZ(11833,1,0),"^",13)["Y" ENRD^A1AXAPRD
 D:$P(^DIZ(11833,1,0),"^",11)["Y" ENST^A1AXAPRD
 Q
EXIT ;
 K AA,AC,AP,AS,AR,ARN,I,J,M,Q,X,Y,ER,XY,A1AXV,A1AX,A1AXM,A1AXF,A1AXFG,A1AXO,A1AXDT,A1AXCOF,A1AXRDF,A1AXRD,A1AXCDT,A1AXRDT,A1AXFF,A1AXRD,A1AXCO,A1AXAPC,A1AXAPR,%,D0,D1,D2,D3
 K %X,%Y,C,DIYS,%H,%I,%Y1,K,XMKK,XMLOCK,XMQF,XMR,XMT,XMTEXT,XMZ,DIC
 Q
