A1AXEDQK ;SLL/ALB ISC; Quick Access Options;1/6/88
 ;;VERSION 1.0
ENST ;
 S DR="102;S:X'[""C"" Y=""@130"";103;@130"
 G PROC
ENAC ;
 S DR="100;100.5;101;102;S:X'[""C"" Y=""@130"";103;@130"
 G PROC
ENAP ;
 S DR="5//NO;S:X[""N"" Y=""@100"";6;7;8;@100"
 G PROC
ENRD ;
 S DR="21//NO;23;22;S:X="""" Y=""@130"";24;@130"
 G PROC
ENCO ;
 S DR="11//NO;16;12;S:X="""" Y=""@130"";14;@130"
PROC ;
 S DIC="^DIZ(11831,",DIC(0)="AEQNZ" D ^DIC G:Y=-1 EXIT S A1AXO=$P(Y,"^",2),A1AXN=$P(Y,"^",1)
 D DICW^A1AXUTL
1 S DIC="^DIZ(11830,",DIC(0)="AEQNZ",DIC("S")="I +^DIZ(11830,+Y,""O"")=A1AXN" D ^DIC G:Y=-1 EXIT K DIC,DIC("S") S DA(3)=+Y,A1AXDT=$P(Y,"^",2),^DIZ(11830,DA(3),"O")=A1AXN,A1AXF=^DIZ(11830,DA(3),"F")
 I DUZ(2)<999 I $D(^DIZ(11830,DA(3),"D")) I $P(^("D"),"^",1)'="" W !,"Recommendation/Action Paln already released by FAcility Director, cannot edit." Q
 S D0=DA(3)
 I $D(^DIZ(11830,DA(3),"P"))=0 W !,"NO TYPE OF PROGRAM DATA ENTERED" G EXIT
2 S DIC="^DIZ(11830,DA(3),""P"",",DIC(0)="AEQNZ" D ^DIC G:Y=-1 EXIT S DA(2)=+Y
 S D1=DA(2)
 I $D(^DIZ(11830,DA(3),"P",DA(2),"S"))=0 W !,"NO SERVICE DATA ENTERED" G EXIT
3 S DIC="^DIZ(11830,DA(3),""P"",DA(2),""S"",",DIC(0)="AEQNZ" D ^DIC G:Y=-1 EXIT S DA(1)=+Y
 S D2=DA(1)
 I $D(^DIZ(11830,DA(3),"P",DA(2),"S",DA(1),"R"))=0 W !,"NO RECOMMENDATION DATA ENTERED" G EXIT
4 S DIC="^DIZ(11830,DA(3),""P"",DA(2),""S"",DA(1),""R"",",DIC(0)="AEQNZ",DIC("W")="W """"" D ^DIC G:Y=-1 EXIT S DA=+Y
 S D3=DA
 L ^DIZ(11830,DA(3)):1 I '$T W !,"This entry is being edited by someone else." L  G EXIT
 S ^DIZ(11830,DA(3),"US")=$S($D(DUZ):$P(^DIC(3,DUZ,0),"^",1),1:"")
 S DIE="^DIZ(11830,DA(3),""P"",DA(2),""S"",DA(1),""R"","
 D ^DIE
EXIT ;
 K A1AXDT,A1AXF,A1AXN,A1AXO,POP
 K %,%X,%Y,X,Y,C,D,D0,D1,D2,D3,DI,DIC,DIE,DIYS,DQ,DR
 K DA(3),DA(2),DA(1),DA
 Q
