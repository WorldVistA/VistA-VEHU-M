A3FSTIN2 ;PTD/BHAM ISC-VAMC Inputs Data for FSMB Requests, CONT. ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC; 8/3/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 ;ROUTINE IS CALLED BY A3FSTIN1, WHICH PASSES ALL VARIABLES.
 ;VARIABLES: PHYDA - File entry DA; PHYSSN - SSN as found in piece 4 for the file entry DA; PRDT - Date submitted by station when duplicate entry by same station; FMDT - For the file entry, the date received from FSMB;
 ;IF ENTRY IS A DUPLICATE - SAME SSN, GO TO DUPENT
 I $O(^DIZ(131000,"C",SSN,0)) S PHYDA=$O(^(0)) G DUPENT
 ;ELSE, ENTRY IS A NEW ONE OR SAME NAME WITH DIFFERENT SSN
DIC S (DIC,DIE)="^DIZ(131000,",DIC(0)="LM",X=""""_NM_"""" D ^DIC K DIC S (PHYDA,DA)=+Y,DR="1///"_ONM_";2///"_DOB_";3///"_SSN_";4///"_MS_";5///"_YR D ^DIE K DIE
 I '$O(^DIZ(131000,PHYDA,2)) S $P(^DIZ(131000,PHYDA,3,0),"^",2)="131000.01PA"
 ;
EDIT R !!,"Do you wish to EDIT this entry? ",EDIT:DTIME S:'$T!("^"[EDIT) EDIT="N" I "YyNn"'[$E(EDIT) W !!,"Answer ""yes"" to edit this entry; ""no"" if you do not want to edit." G EDIT
 I "Yy"[$E(EDIT) G REVIEW
STUFF ;ELSE USER DID NOT WANT TO EDIT, USE DIE TO STUFF SUBMITTING STATION SUBFILE FIELDS
 W !!,"One moment please...",!! S (DIC,DIE)="^DIZ(131000,"_PHYDA_",3,",DIC(0)="LM",X=STNM,DA(1)=PHYDA D ^DIC K DIC S DA=+Y,DR="1///"_FSMBDT_";2///"_BATCH D ^DIE K DIE
 ;
MORE R !!,"Do you wish to enter data for ANOTHER applicant? ",MORE:DTIME S:'$T!("^"[MORE) MORE="N" I "YyNn"'[$E(MORE) W !!,"Answer ""yes"" to process another applicant; ""no"" if you wish to quit." G MORE
 I "Yy"[$E(MORE) K NM,ONM,DOB,SSN,MS,YR,PHYDA,EDIT,MORE,DA,DIC,DIE,DR,AGN,FLG,LOC,PRDT,FMDT G NAME^A3FSTIN1
 G END^A3FSTIN1
 ;
 ;
REVIEW ;USE DIE TO ALLOW USER TO EDIT APPLICANT'S DATA
 W !!,"NAME: ",$P(^DIZ(131000,PHYDA,0),"^") S DIE="^DIZ(131000,",DA=PHYDA,DR="1:5" D ^DIE K DIE,DA,DR G EDIT
 ;
DUPENT ;SSN MATCH ONE IN FILE - DUPLICATE ENTRY
 W !!,*7,?25,"<DUPLICATE ENTRY>"
 ;DUPLICATE ENTRY BY SAME STATION NOT ALLOWED
 I $O(^DIZ(131000,PHYDA,3,"B",STPTR,0)) S PRDT=$P(^DIZ(131000,PHYDA,3,STPTR,0),"^",2) W !!,STNM,":",!,"You previously submitted this name on " S Y=PRDT X ^DD("DD") W Y,"." K PRDT G MORE
 ;ELSE, DUPLICATE ENTRY IS SUBMITTED BY A NEW STATION
 I $D(^DIZ(131000,PHYDA,1)) S FMDT=$P(^(1),"^",2) S STAT=$P(^(1),"^",3) I FMDT'="" S X1=FSMBDT,X2=-30 D C^%DTC I FMDT'<X D NOTIFY
 W !,"Person with this SSN has previously been submitted.",!,"I will now compare your answers with those on file.",!,"One moment please...",!!
 S FLG=0 S LOC=^DIZ(131000,PHYDA,0) I ONM'=$P(LOC,"^",2) S FLG=1
 I NM'=$P(LOC,"^") S FLG=1
 I DOB'=$P(LOC,"^",3) S FLG=1
 I MS'=$P(LOC,"^",5) S FLG=1
 I YR'=$P(LOC,"^",6) S FLG=1
 I FLG=0 W "No conflicts found...",! G STUFF
 I FLG=1 W "All of your answers DO NOT MATCH those on file.",!,"Please EDIT the file answers with extreme caution!",!,"You should verify that your answer is correct before making changes.",! G REVIEW
 ;
NOTIFY ;SET THE "ADUP" CROSS-REFERENCE AND SEND A MAIL MESSAGE TO RD'S QA PERSON
 Q:STAT'="0"  W !!,"One moment please...",! S ^DIZ(131000,"ADUP",STPTR,FSMBDT,PHYDA,FMDT)=BATCH
 K ^UTILITY($J,"MSG"),XMY S ^UTILITY($J,"MSG",1,0)="A duplicate entry has been entered into the FSMB file.",^UTILITY($J,"MSG",2,0)="Use the 'Print Duplicate Request Letter' option at this time."
 S XMSUB="FSMB DUPLICATE ENTRY CREATED",XMDUZ=DUZ,XMY(548)="",XMY(985)="",XMTEXT="^UTILITY($J,""MSG""," D ^XMD K ^UTILITY($J,"MSG"),XMSUB,XMDUZ,XMTEXT
 Q
 ;
