DGYRPOST ;ALB/CAW - Post init routine for Patch DG*5.3*45 ;12/7/94
 ;;5.3;Registration;**45**;Aug 13, 1993
 ;
 ;
EN N DGDEP
 W !!," Post Initialization Started at: " D NOW^%DTC W $$FTIME^VALM1(%),!
 ;
LISTTEM D ^DGYRL
 ;
PROTO D ^DGYRONIT
 ;
 D COV
 ;
 D KEY
 ;
 D CONSIS
 ;
 D DONE
 ;
 Q
COV W !,"Conversion routine:"
 W !,"  This is moving the means test pointer from file INDIVIDUAL ANNUAL INCOME"
 W !,"  (#408.21) to INCOME PERSON (#408.22) file."
 W !!,"         Conversion Started at: " D NOW^%DTC W $$FTIME^VALM1(%)
 ;
CONVT D ^DGYRCOV
 Q
 ;
KEY ; Add security key DG DEPDELETE
 W !!,"Adding security key DG DEPDELETE"
 S DIC="^DIC(19.1,",DIC(0)="M",X="DG DEPDELETE" D ^DIC
 I Y<0 D
 .N DA,DD,DIC,DLAYGO,X
 .S DIC="^DIC(19.1,",DIC(0)="L",X="DG DEPDELETE",DLAYGO=19.1
 .D FILE^DICN S DA=+Y
 .S DIE="^DIC(19.1,",DR=".02///^S X=""DEPDENDENT DELETE"";1///^S X=""This allows the user to delete a dependent.""" D ^DIE
 ;
RENAMEQ K DIE,DR,Y
 Q
 ;
CONSIS ; Consistency Checker change
 N I,TEXT
 W !!,"Changing names of consistency checks."
 F I=1:1 S TEXT=$P($T(LIST+I),";;",2) Q:TEXT="QUIT"  D
 . I $P($G(^DGIN(38.6,+TEXT,0)),"^",1)=$P(TEXT,"^",3) Q  ; already changed
 . W !?4,"Consistency check #",+TEXT," - ",$P(TEXT,"^",2),"..."
 . I $P($G(^DGIN(38.6,+TEXT,0)),"^",1)'=$P(TEXT,"^",2) W !?12,"set up incorrectly...please contact your ISC" Q
 . S DIE="^DGIN(38.6,",DA=+TEXT,DR=".01///"_$P(TEXT,"^",3) D ^DIE
 . W !?12,"name changed to ",$P(TEXT,"^",3)
 K DA,DIE,DR,X,Y
 Q
 ;
DONE W !!,"Post Initialization Finished at: " D NOW^%DTC W $$FTIME^VALM1(%)
 ;
ENQ Q
 ;
LIST ; list of consistency checks to change
 ;;49^INSURANCE 'YES' BUT NONE^INSURANCE YES BUT NONE ACTIVE
 ;;50^INSURANCE NOT 'YES' BUT SOME^INSUR. NOT YES BUT SOME ACTIVE
 ;;QUIT
