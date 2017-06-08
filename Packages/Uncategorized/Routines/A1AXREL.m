A1AXREL ;SLL/ALB ISC; Release or Un-release a Recommend/Action Plan;5/31/88
 ;;VERSION 1.0
 ;
ENT1 ;
 I DUZ(2)>999&(DUZ(2)<9999) W !,"RD/CO cannot release/unrelease a recommendation/action plan." Q
 K DIC
 S DIC="^DIZ(11830,",DIC(0)="AEQMNZ"
 D DICW^A1AXUTL
 S DIC("S")="I +^DIZ(11830,+Y,""F"")=DUZ(2)"
 D ^DIC G:Y=-1 EXIT G:X["^" ENT1 K DIC,DIC(0),DIC("W"),DIC("S") S DA=+Y
 L ^DIZ(11830,DA):1 I '$T W !,"This entry is being edited by someone else." L  G EXIT
 W !!!,"RELEASE a recommendation/action plan by entering Facility Director's initials and release date."
 W !,"UN-RELEASE a recommend/action plan by deleting the Facility Director's initials using an ""@"" entry.",!!
 S DIE="^DIZ(11830,",DR="8;S:'$D(^DIZ(11830,DA,""D"")) Y=""@130"";I $D(^DIZ(11830,DA,""D"")) S:$P(^(""D""),""^"",1)="""" Y=""@130"";9;@130" D ^DIE 
 I $D(^DIZ(11830,DA,"D")) I $P(^("D"),"^",1)="" K ^DIZ(11830,DA,"D")
EXIT ;
 K DIC,DA
ZEXIT  ;
 K DIE,DR,DIC,DIC(0),DIC("S")
 K %,%Y,C,D,D0,DA,DI,DQ,Y
 Q
