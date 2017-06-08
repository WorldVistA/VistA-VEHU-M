A1AXED ;SLL/ALB ISC; ALTERNATIVE ENTER/EDIT ROUTINE; 1/15/88
 ;;VERSION 1.0
 ;
ENT1 ;
 K DIC,DIC(0),DIC("S")
 I DUZ(2)'>999 S A1AXSTN=DUZ(2),A1AXST=$P(^DIZ(11837,DUZ(2),0),"^",1),DIC("DR")="2///"_A1AXST
 S DIC="^DIZ(11830,",DIC(0)="AEQMNZL"
 D ^DIC G:Y=-1 EXIT G:X["^" ENT1 S DA=+Y
 L ^DIZ(11830,DA):1 I '$T W !,"This entry is being edited by someone elase." L  G EXIT
 I $D(^DIZ(11830,DA,"O")) S A1AXO=$P(^DIZ(11831,^("O"),0),"^",1)
 I '$D(^DIZ(11830,DA,"O")) S DIC="^DIZ(11831,",DIC(0)="AEQMNZ" D ^DIC G:Y=-1 ENT1 W Y S A1AXO=$P(^DIZ(11831,+Y,0),"^",1)
 S:DUZ(2)'>999 A1AXF=DUZ(2)
 S:$D(^DIZ(11830,DA,"F")) A1AXF=^("F")
 S ^DIZ(11830,DA,"US")=$S($D(DUZ):$P(^DIC(3,DUZ,0),"^",1),1:"")
 S DR=$S(DUZ(2)>999:".01;2;3",DUZ(2)'>999:".01;2//"_A1AXST_";3")
 D @A1AXO S DIE("NO^")="OUTOK" D ^DIE
EXIT ;
 K DIE,DR,A1AXST,A1AXF,DIC,DIC(0),DIC("S")
 Q
JCAHO ; Querry program rating, flags, standard ref, type of response, no service rating
 ;
 S DR="6;7;5"
 S DR(2,11830.01)=".01;1;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;1;1.5;2;3;3.7;4;5//NO;S:X[""N"" Y=100;6;7;8;100;100.5;101;21//NO;23;24;11//NO;16;14;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 S DR(5,11830.11)=".01"
 Q
CAP ; Querry program rating, no type of response, no flag, no standard ref, no service rating
 ;
 S DR="6;7;5//LAB"
 S DR(2,11830.01)=".01//LAB;1;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;2;3.7;4;5//NO;S:X[""N"" Y=100;6;7;8;100;100.5;101;21//NO;23;24;11//NO;16;14;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 Q
SERP ; Querry service rating, standard ref, no program rating, no flags, no type of response,
 ;
 S DR="6;7;5//HOSPITAL"
 S DR(2,11830.01)=".01//HOSPITAL;2"
 S DR(3,11830.02)=".01;1;2"
 S DR(4,11830.03)=".01;2;3.7;4;5//NO;S:X[""N"" Y=100;6;7;8;100;100.5;101;21//NO;23;24;11//NO;16;14;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 Q
 ; No program rating, no service rating, no flags, no standard ref.
ACS ;
GAO ;
IG ;
MEDIPRO ;
OSHA ;
OTHER ;
SPG ;
 S DR="6;7;5//HOSPITAL"
 S DR(2,11830.01)=".01//HOSPITAL;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;2;3.7;4;5//NO;S:X[""N"" Y=100;6;7;8;100;100.5;101;21//NO;23;24;11//NO;16;14;102//I;S:X'[""C"" Y=104;103;104;S Y=$S(DUZ(2)=A1AXF:""105"",1:"""");105"
 Q
