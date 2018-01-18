A1AXEDIT ;SLL/ALB ISC; Ext Rev Enter/Edit Routine; 1/15/88
 ;;VERSION 1.0
 ;
ENT1 ;
 K DIC,A1AXN,A1AXO
 I DUZ(2)'>999 S A1AXSTN=DUZ(2),A1AXST=$P(^DIZ(11837,DUZ(2),0),"^",1)
 I DUZ(2)>999 S DIC="^DIZ(11837,",DIC(0)="AEQNZ" D ^DIC G:Y=-1 EXIT G:X="^" ENT1 S A1AXST=$P(Y,"^",2),A1AXSTN=$P(Y,"^",1)
 K DIC("S") S DIC="^DIZ(11831,",DIC(0)="AEQNZ" D ^DIC G:Y=-1 EXIT G:X="^" ENT1 S A1AXO=$P(Y,"^",2),A1AXN=$P(Y,"^",1)
 S DIC("DR")="2///"_A1AXST_";"_"3///"_A1AXO
 S DIC="^DIZ(11830,",DIC(0)="AEQMNZL"
 D DICW^A1AXUTL
 S DIC("S")="I +^DIZ(11830,+Y,""O"")=A1AXN&(^DIZ(11830,+Y,""F"")=A1AXSTN)"
 D ^DIC G:Y=-1 EXIT G:X["^" ENT1 K DIC,DIC(0),DIC("W"),DIC("S") S DA=+Y,^DIZ(11830,DA,"O")=A1AXN,A1AXF=^DIZ(11830,DA,"F")
 I $D(^DIZ(11830,DA,"D")) I $P(^("D"),"^",1)'="" W !,"Recommendation/Action Plan already released by Facility Director, no re-editing." Q
 L ^DIZ(11830,DA):1 I '$T W !,"This entry is being edited by someone else." L  G EXIT
 S ^DIZ(11830,DA,"US")=$S($D(DUZ):$P(^DIC(3,DUZ,0),"^",1),1:"")
 S A1AXX="RD/CO fields:",A1AXL="---------------------------"
 S DIE="^DIZ(11830," D @A1AXO S DIE("NO^")="OUTOK" D ^DIE
EXIT ;
 K DIE,DR,A1AXF,A1AXL,A1AXX,A1AXDT,A1AXN,A1AXO,A1AXZ,A1AXST,A1AXSTN,DIC,DIC(0),DIC("S")
 K %,%Y,A1AXDA,A1AXDA1,A1AXDA2,A1AXDA3,A1AX,X5,X7,X9,D,D0,D1,D2,D3,DA,DI,DQ,DWLW,Y
 Q
JCAHO ; Querry program rating, flags, standard ref, type of response, no service rating
 ;
 S DR=$S(DUZ(2)>999:".01;2;3//JCAHO;6;7;5",1:".01;2//@DUZ(2);3//JCAHO;6;7;5")
 S DR(2,11830.01)=".01;1;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;1;1.5;2;3;3.7;4;5//N;S:X[""N"" Y=100;6;7;8;100;100.5;101;D DPY^A1AXEDIT;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 S DR(5,11830.11)=".01"
 Q
CAP ; Querry program rating, no type of response, no flag, no standard ref, no service rating
 ;
 S DR=$S(DUZ(2)>999:".01;2;3//CAP;6;7;5//LAB;",1:".01;2//@DUZ(2);3//CAP;6;7;5//LAB;")
 S DR(2,11830.01)=".01//LAB;1;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;1;2;3.7;4;5//N;S:X[""N"" Y=100;6;7;8;100;100.5;101;D DPY^A1AXEDIT;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 Q
SERP ; Querry service rating, standard ref, no program rating, no flags, no type of response,
 ;
 S DR=$S(DUZ(2)>999:".01;2;3//SERP;6;7;5//HOSPITAL;",1:".01;2//@DUZ(2);3//SERP;6;7;5//HOSPITAL;")
 S DR(2,11830.01)=".01//HOSPITAL;2"
 S DR(3,11830.02)=".01;1;2"
 S DR(4,11830.03)=".01;1;2;3.7;4;5//N;S:X[""N"" Y=100;6;7;8;100;100.5;101;D DPY^A1AXEDIT;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 Q
 ; No program rating, no service rating, no flags, no standard ref.
ACS ;
GAO ;
IG ;
MEDIPRO ;
OSHA ;
OTHER ;
SPG ;
 S DR=$S(DUZ(2)>999:".01;2;3//@A1AXO;6;7;5//HOSPITAL;",1:".01;2//@DUZ(2);3//@A1AXO;6;7;5//HOSPITAL;")
 S DR(2,11830.01)=".01//HOSPITAL;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;2;3.7;4;5//N;S:X[""N"" Y=100;6;7;8;100;100.5;101;D DPY^A1AXEDIT;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 Q
DPY ;
 S A1AXDA=D0,A1AXDA1=D1,A1AXDA2=D2,A1AXDA3=D3
 S A1AXZ=^DIZ(11830,A1AXDA,"P",A1AXDA1,"S",A1AXDA2,"R",A1AXDA3,0) S:$D(^(5)) X5=^(5) S:$D(^(7)) X7=^(7) S:$D(^(9)) X9=^(9)
 W !!,A1AXX,!,A1AXL D RD^A1AXREC2,CO^A1AXREC2 W !,A1AXL,!
 Q
