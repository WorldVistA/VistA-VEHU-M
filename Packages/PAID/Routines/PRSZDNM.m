PRSZDNM ;HISC/GWB-DINUM INDIVIDUAL 450 ENTRY -> 200 ;05/05/94  10:00
 ;;3.1;PAID;;Feb 25, 1994
 W !!,"This routine will do the following:",!
 W !,"1) Change a single PAID EMPLOYEE file (#450) entry's internal entry number and"
 W !,"2) Convert the PAID files which point to this file 450 entry.",!
 W ! S DIR("A")="Are you sure you want to do this",DIR(0)="Y" D ^DIR Q:Y'=1
R1 R !,"OLD IEN ",OLDIEN:30 I (OLDIEN="")!(OLDIEN["^") G EXIT
 I OLDIEN["?" W !!,"Enter the IEN of the 450 entry you want to change.",! G R1
 I '$D(^PRSPC(OLDIEN)) W "   No such 450 entry" G R1
R2 R !,"NEW IEN ",NEWIEN:30 I (NEWIEN="")!(NEWIEN["^") G EXIT
 I NEWIEN["?" W !!,"Enter the new IEN of the 450 entry you want to change.",! G R1
 I $D(^PRSPC(NEWIEN)) W "   This IEN already being used" G R2
 D 450,455,458,4581,4582,4583,4585,459
 W !!,"Conversion finished!"
EXIT D KILL^XUSCLEAN
 Q
450 ;Convert 450 file entry
 W !!,"*** Converting PAID EMPLOYEE (#450) file entry "
 S %X="^PRSPC(OLDIEN,",%Y="^PRSPC(NEWIEN," D %XY^%RCR
 S DIK="^PRSPC(",DA=OLDIEN D ^DIK
 S DIK="^PRSPC(",DA=NEWIEN D IX^DIK
 Q
455 ;Convert 455 file entries
 W !!,"*** Converting PAYPERIOD 8B (#455) file entries"
 S PP=0 F  S PP=$O(^PRST(455,PP)) Q:PP'>0  I $D(^PRST(455,PP,1,OLDIEN)) D
 .W !,"PAY PERIOD ",$P(^PRST(455,PP,0),"^",1)
 .S %X="^PRST(455,PP,1,"_OLDIEN_","
 .S %Y="^PRST(455,PP,1,"_NEWIEN_","
 .D %XY^%RCR
 .S $P(^PRST(455,PP,1,NEWIEN,0),"^",1)=NEWIEN
 .S ^PRST(455,PP,1,"B",NEWIEN,NEWIEN)=""
 .K ^PRST(455,PP,1,OLDIEN),^PRST(455,PP,1,"B",OLDIEN,OLDIEN)
 .I '$D(^PRST(455,PP,"A",OLDIEN)) Q
 .S %X="^PRST(455,PP,""A"","_OLDIEN_","
 .S %Y="^PRST(455,PP,""A"","_NEWIEN_","
 .D %XY^%RCR
 .S $P(^PRST(455,PP,"A",NEWIEN,0),"^",1)=NEWIEN
 .S ^PRST(455,PP,"A","B",NEWIEN,NEWIEN)=""
 .K ^PRST(455,PP,"A",OLDIEN),^PRST(455,PP,"A","B",OLDIEN,OLDIEN)
 Q
458 ;Convert 458 file entries
 W !!,"*** Converting TIME & ATTENDANCE RECORDS (#458) file entries"
 S PP=0
 F  S PP=$O(^PRST(458,PP)) Q:PP'>0  I $D(^PRST(458,PP,"E",OLDIEN)) D
 .W !,"PAY PERIOD ",$P(^PRST(458,PP,0),"^",1)
 .S %X="^PRST(458,PP,""E"","_OLDIEN_","
 .S %Y="^PRST(458,PP,""E"","_NEWIEN_","
 .D %XY^%RCR
 .S $P(^PRST(458,PP,"E",NEWIEN,0),"^",1)=NEWIEN
 .S DA(1)=PP,DA=OLDIEN,DIK="^PRST(458,"_DA(1)_",""E""," D ^DIK
 .K ^PRST(458,"ATC",OLDIEN)
 .S DA(1)=PP,DA=NEWIEN,DIK="^PRST(458,"_DA(1)_",""E""," D IX^DIK
 Q
4581 ;Convert 458.1 file entries
 W !!,"*** Converting LEAVE REQUESTS (#458.1) file entries"
 S IEN=0 F I=1:1 S IEN=$O(^PRST(458.1,IEN)) Q:IEN'>0  W:I#100=0 "." I $P(^PRST(458.1,IEN,0),"^",2)=OLDIEN S DIE="^PRST(458.1,",DA=IEN,DR="1///"_NEWIEN D ^DIE W !,"LEAVE REQUEST ",IEN
 Q
4582 ;Convert 458.2 file entries
 W !!,"*** Converting OT/CT REQUESTS (#458.2) file"
 S IEN=0 F I=1:1 S IEN=$O(^PRST(458.2,IEN)) Q:IEN'>0  W:I#100=0 "." I $P(^PRST(458.2,IEN,0),"^",2)=OLDIEN S DIE="^PRST(458.2,",DA=IEN,DR="1///"_NEWIEN D ^DIE W !,"OT/CT REQUEST ",IEN
 Q
4583 ;Convert 458.3 file
 W !!,"*** Converting ENVIRONMENTAL DIFF. REQUESTS (#458.3) file"
 S IEN=0 F I=1:1 S IEN=$O(^PRST(458.3,IEN)) Q:IEN'>0  W:I#100=0 "." I $P(^PRST(458.3,IEN,0),"^",2)=OLDIEN S DIE="^PRST(458.3,",DA=IEN,DR="1///"_NEWIEN D ^DIE W !,"ENVIRONMENTAL DIFF REQUEST ",IEN
 Q
4585 ;Convert 458.5 file
 W !!,"*** Converting PRIOR PP EXCEPTIONS (#458.5) file"
 S IEN=0 F I=1:1 S IEN=$O(^PRST(458.5,IEN)) Q:IEN'>0  W:I#100=0 "." I $P(^PRST(458.5,IEN,0),"^",2)=OLDIEN S DIE="^PRST(458.5,",DA=IEN,DR="1///"_NEWIEN D ^DIE W !,"PRIOR PP EXCEPTION ",IEN
 Q
459 ;Convert 459 file
 W !!,"*** Converting PAID PAYRUN DATA (#459) file"
 S PP=0 F  S PP=$O(^PRST(459,PP)) Q:PP'>0  I $D(^PRST(459,PP,"P",OLDIEN)) D
 .W !,"PAY PERIOD ",^PRST(459,PP,0)
 .S %X="^PRST(459,PP,""P"","_OLDIEN_","
 .S %Y="^PRST(459,PP,""P"","_NEWIEN_","
 .D %XY^%RCR
 .S $P(^PRST(459,PP,"P",NEWIEN,0),"^",1)=NEWIEN
 .S ^PRST(459,PP,"P","B",NEWIEN,NEWIEN)=""
 .K ^PRST(459,PP,"P",OLDIEN),^PRST(459,PP,"P","B",OLDIEN,OLDIEN)
 Q
