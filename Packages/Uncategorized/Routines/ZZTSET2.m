ZZTSET2 ;bciofo/maw-part 2 of test system reset procedures ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 W !!,"PART 2:  CLOSE DOMAINS (routine ^ZZTSET2)"
 W !!,"This will set the FLAGS field of the Domain File equal to C(LOSED) for all"
 W !,"domains except this one (your Test system) and its parent domain"
 W !,"(yoursite.va.gov)."
 S DIR(0)="YA"
 S DIR("A")="Okay to continue with Part 2? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W !,"Aborted!  WARNING:  Outgoing mail from this domain could be misconstrued"
 .W !,"as actual production data/information from your site with unpredictable"
 .W !,"results."
 ;
 ; get this domain name...
 S ZZDOM=$G(^XMB(1,1,0))
 I ZZDOM="" D  Q
 .D ERR("NO KERNEL SITE PARAMETER FILE!!??")
 .D KILL
  S ZZTHIS=+ZZDOM
 S ZZTHIS=$P($G(^DIC(4.2,+ZZDOM,0)),"^")
 I ZZTHIS="" D  Q
  .D ERR("NO DOMAIN ENTRY FOUND AT ^XMB(1,1,0)!!")
 .D KILL
 W !!,"This domain is: ",ZZTHIS
 I $P(ZZTHIS,".")'="TEST" D  I $D(DIRUT) D ERR("PROCESS ABORTED!!"),KILL Q
 .W $C(7)
 .W !!,"It doesn't appear to be a TEST domain?"
 .S DIR(0)="YA"
 .S DIR("A")="Are you sure you want me to continue? "
  .S DIR("B")="NO"
 .S DIR("?")="'YES' if you are SURE this is the name of your TEST system domain."
 .S DIR("?",1)="You may be using a different name for the TEST domain.  Answer"
 .W ! D ^DIR K DIR
 .I Y'=1!($D(DIRUT)) D  Q
 ..W $C(7)
 ..W !," ...Part 2 ABORTED!!"
 ..D KILL
 .W !!,"Okay, continuing..."
 ;
 ; next, get parent for this domain...
 S ZZPARENT=$P($G(^DIC(4.2,+$P(ZZDOM,U,3),0)),U)
 W "  Parent Domain is: ",$S(ZZPARENT="":"*NOT DEFINED*",1:ZZPARENT)
 I ZZPARENT="" D
 .W $C(7)
 .W !!,"The parent domain for ",ZZTHIS," is not defined."
 .W !!,"Please edit the Domain file PARENT field for this domain now.  Hint:  enter"
 .W !,"the name of your production domain in this field (i.e., yoursite.va.gov)"
 .S DIE="^DIC(4.2,"
 .S DA=+ZZDOM
 .S DR=3
 .D ^DIE
 .I $P(^DIC(4.2,+ZZDOM,0),U,3)="" D
 ..W $C(7)
 ..W !,"?? -- Parent Domain is still undefined!"
 .K DA,DIE,DR
 ;
 ; launch the process...
 W !!,"Okay, I'm ready to start.  I will close all domains except:"
 W !!?5,ZZTHIS
 W !?5,$S(ZZPARENT'="":ZZPARENT,1:"**PARENT DOMAIN NOT DEFINED!**")
 S DIR(0)="YA"
 S DIR("A")="Okay to continue? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W " ...Part 2 ABORTED!!"
 .D KILL
 W !!,"Beginning"
 S ZZXDOM=""
 F  S ZZXDOM=$O(^DIC(4.2,"B",ZZXDOM)) Q:ZZXDOM=""  D
 .I ZZXDOM=ZZTHIS!(ZZXDOM=ZZPARENT) Q
 .S ZZXDA=0
 .F  S ZZXDA=$O(^DIC(4.2,"B",ZZXDOM,ZZXDA)) Q:'ZZXDA  D
 ..S DIE="^DIC(4.2,"
 ..S DA=ZZXDA
 ..S DR="1///^S X=""C"""
 ..D ^DIE
 ..K DA,DIE,DR
 ..W "."
 D KILL
 I $X>75 W !
 W !!,"Part 2 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,X,Y
 Q
 ;
KILL ; kill variables before exit...
 K ZZDOM,ZZPARENT,ZZTHIS,ZZXDA
 Q
 ;       
ERR(X) ; display error message...
 W $C(7),!,"ERROR!! "
 W X
 Q
