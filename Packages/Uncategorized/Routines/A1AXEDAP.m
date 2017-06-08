A1AXEDAP ;SLL/ALB ISC; Quick Access to Appeal Fields Only; 1/6/87
 ;;VERSION 1.0
 ;
ENT1 ;
 K DIC,DIC(0),DIC("S"),A1AXN,A1AXO
 S DIC="^DIZ(11831,",DIC(0)="AEQNZ" D ^DIC Q:Y=-1  S A1AXO=$P(Y,"^",2),A1AXN=$P(Y,"^",1)
 S DIC="^DIZ(11830,",DIC(0)="AEQNZL",DIC("S")="I +^DIZ(11830,+Y,""O"")=A1AXN" D ^DIC Q:Y=-1  K DIC,DIC(0),DIC("S") S DA=+Y,^DIZ(11830,DA,"O")=A1AXN,A1AXF=^DIZ(11830,DA,"F")
 L ^DIZ(11830,DA):1 I '$T W !,"This entry is being edited by someone else." L  G EXIT
 S DIE="^DIZ(11830," D @A1AXO D ^DIE
 S ^DIZ(11830,D0,"US")=$S($D(DUZ):$P(^DIC(3,DUZ,0),"^",1),1:"")
EXIT ;
 K DIE,DR,A1AXF,A1AXDT,A1AXN,A1AXO,A1AXST,A1AXSTN,DIC,DIC("S"),DIC(0)
 K %,%DT,D,D0,D1,D2,D3,DA,DI,DQ,DWLW,DZ
 Q
JCAHO ; Querry program rating, flags, standard ref, type of response, no service rating
 ;
 S DR=".01;2;3//JCAHO;5"
 S DR(2,11830.01)=".01;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;5;6;7;8"
 Q
CAP ; Querry program rating, no type of response, no flag, no standard ref, no service rating
 ;
 S DR=".01;2;3//CAP;5//LAB"
 S DR(2,11830.01)=".01//LAB;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;5;6;7;8"
 Q
SERP ; Querry service rating, standard ref, no program rating, no flags, no type of response,
 ;
 S DR=".01;2;3//SERP;5//HOSPITAL"
 S DR(2,11830.01)=".01//HOSPITAL;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;5;6;7;8"
 Q
 ; No program rating, no service rating, no flags, no standard ref.
ACS ;
GAO ;
IG ;
MEDIPRO ;
OSHA ;
OTHER ;
SPG ;
 S DR=".01;2;3//@A1AXO;5//HOSPITAL"
 S DR(2,11830.01)=".01//HOSPITAL;2"
 S DR(3,11830.02)=".01;2"
 S DR(4,11830.03)=".01;5;6;7;8"
 Q
