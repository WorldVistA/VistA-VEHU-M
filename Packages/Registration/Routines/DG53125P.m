DG53125P ;ALB/ABR - QUARTERLY PATIENT CENSUS CLOSEOUT OF PTF; 7/18/96
 ;;5.3;Registration;**125**;Aug 13, 1993
 ;
 ;
CENSUS ;--- add new census date
 ;    These dates should be updated each quarter, per MAS VACO.
 ;
 ; **NOTE - the input transform for the .01 field of file 45.86
 ;   needs to be updated annually to the last date of the current FY
 ;   for this routine to run successfully.
 ;
 ;   Patch will include routine to update dates, and Data Dictionary
 ;   for .01 field               -abr
 ;
 ;   [DG*5.3*125 does not contain DD - only needed for Q1 PATCH; abr]
 ;
EN ;
 N CENDATE,CLOSDATE,OKTOXM,ACTIVE,CPSTART,ERR
 N DA,DD,DIC,DIE,DO,DR,X,Y
 ;
 S ERR=0
 ;
 ;-- ALL DATES ARE FOR FY97, Q3 CENSUS
 ;
 ;-- Census Date 6-30-97
 S CENDATE=2970630
 ;-- Close-out Date 7-18-97
 S CLOSDATE=2970718
 ;
 ;-- ok to x-mit PTF date 3-31-97
 ; **no need to change, per Austin
 S OKTOXM=2970331
 ;-- currently active
 S ACTIVE=1
 ;-- Census Period Start Date 4-1-97
 S CPSTART=2970401
 ;
 D BMES^XPDUTL(">>> Updating PTF Census Date File (#45.86) for 3rd Quarter, FY 1997.")
 ;
 S X=$O(^DG(45.86,"AC",0)) I X S X=$O(^DG(45.86,"AC",X,0)),DIE="^DG(45.86,",DA=X,DR=".04////0" D ^DIE K DIE,DR,DA
 S DIC="^DG(45.86,",X=CENDATE,DIC(0)="L" K DD,DO D ^DIC K DIC
 I Y'>0 S ERR=1 D ERR Q  ;checks to see if record is created
 S DIE="^DG(45.86,",DA=+Y,DR=".02////"_CLOSDATE_";.03////"_OKTOXM_";.04////"_ACTIVE_";.05////"_CPSTART
 D ^DIE K DIE,DR,DA
 ;
 D MES^XPDUTL("Done.")
 Q
 ;
 ; This will update the PTF CENSUS DATE File (#45.86).  The EN tag may be re-run
ERR ;
 I +ERR D BMES^XPDUTL("Problem with PTF CENSUS DATE File (#45.86) Update.  Call Customer Support.")
 Q
