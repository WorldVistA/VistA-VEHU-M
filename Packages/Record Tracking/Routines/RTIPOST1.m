RTIPOST1 ;ISC-ALBANY/PKE-postinit; 6/26/90 10:00AM
 ;;v 2.0;Record Tracking;;10/22/91 
EN D ADD,REMOV,MOVE Q
 ;add 'new person' to to application file subfile-borrower
 ;remove 'person' from application file subfile-borrower
 ;move add entries to 'record type movement'
 ;
ADD W !!?3,"Checking Applications in file #195.1 ..."
 F RTA="MEDICAL ADMINISTRATION","RADIOLOGY" S DIC(0)="",DIC="^DIC(195.1,",X=RTA D ^DIC K DIC S RTAPL=+Y D LKUP
 W !
 Q  K RTA,RTAPL,RTB,DIC,DA,DQ,DE,Y Q
LKUP ;find borrowers subfile
 I 'RTAPL W !!,"Not able to find '",RTX,"' application in file #195.1",!! Q
 S DIC(0)="",DIC="^DIC(195.1,"_RTAPL_",""BOR"",",X=200
 S DA(1)=RTAPL,DA(2)=195.1
 D ^DIC S RTB=+Y
 I RTB>0 Q  ;new person already added
 S DIC(0)="L",X=200
 S DIC("DR")="2///y;3///n;4///y;"
 K DD,DO D FILE^DICN K DIC S RTB=+Y
 I RTB<0 W !!,"Not able to add 'New Person' to '",RTAPL,"' Application-borrowers" Q
 W !?5,"Added 'New Person' to '",RTA,"' application-borrowers"
 Q
 ;
REMOV ;remove person from application-borrower
 W !!?5,"Removing 'Provider, Person' from borrowers in file #195.1"
 F RTA="MEDICAL ADMINISTRATION","RADIOLOGY" S DIC="^DIC(195.1,",DIC(0)="",X=RTA D ^DIC K DIC S RTAPL=+Y D DIK
 K RTA,RTAPL,DIC,DA,DIK,X,Y Q
 Q
DIK ;
 I 'RTAPL W !!,"Not able to find '",X,"' application in file #195.1",!! Q
 S DIK="^DIC(195.1,"_RTAPL_",""BOR"","
 S DA(1)=RTAPL,DA(2)=195.1
 S DA=$O(^DIC(195.1,RTAPL,"BOR","B",16,0)) I DA D ^DIK
 S DA=$O(^DIC(195.1,RTAPL,"BOR","B",6,0)) I DA D ^DIK
 K DIK,DA Q
 ;
MOVE ;add new movements to file 195.3 for mas and rad applications
 W !!,"Adding new movements to Record movement type file #195.3",!
 F RTA="MEDICAL ADMINISTRATION","RADIOLOGY" S DIC="^DIC(195.1,",DIC(0)="",X=RTA D ^DIC K DIC S RTAPL=+Y I RTAPL>0 D ADMOV
 W !!
 K RTNUM,RTNUM0,RTA,RTAPL,RTM,Y,X,DIC Q
 Q
ADMOV ;add transfer create, transfer retire by application
 F RTNUM0=0:0 S RTNUM0=$O(^DIC(195.3,RTNUM0)) Q:'RTNUM0  S RTNUM=RTNUM0
 S RTNUM=RTNUM+1
 F RTM="TRANSFER CREATE INITIAL","TRANSFER RETIRE" I '$O(^DIC(195.3,"AA",RTAPL,RTM,0)) S DIC="^DIC(195.3,",DIC(0)="L",X=RTM,DINUM=RTNUM D FILE
 Q
FILE S DIC("DR")="2///"_$S(RTM["CREATE":"Transferred/created",RTM["RETIRE":"transferred/retired",1:"")_";3///`"_RTAPL_";4///n;"
 S DIC(0)="L"
 K DD,DO D FILE^DICN K DIC,D0,DQ,DE,DINUM
 I +Y<0 W !!,"Lookup failed" Q
 I '$P(Y,"^",3) W !!?3,"Not able to add '",RTX,"' Application '",RTM,"' to file #195.3",!! Q
 W !?3,"Added '",RTM,"' movement for '",RTA,"'"
 S RTNUM=RTNUM+1
 Q
