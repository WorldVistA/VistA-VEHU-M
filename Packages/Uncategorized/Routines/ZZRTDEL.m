ZZRTDEL ;JF/SGN/ISC1 - Delete xtra records for NOP ; 3 18 93
 ;;Ver 1 and only
 ;
 ;Set users, record types, and movement types involved in the
 ;deletion.  Be sure each code is surrounded by a "/".
 ;
 S USERS="/1252/11247/11248/10119/"
 S RECDS="/1/2/"
 S MOVES="/13/18/"
 ;
 ;Set maximum records to search and deletion count total.
 ;
 S MAXRECD=$P(^RT(0),"^",3)
 S TOTAL=0
 ;
 ;Loop thru the entire file looking for matching data
 ;
 F KOUNT=0:1:+MAXRECD I $D(^RT(KOUNT,"CL")) D MOVECHK
 ;
 ;Display the number of records deleted
 ;
 W !,"Total Number of Records Deleted = ",TOTAL
 ;
 ;Kill routine variables and quit routine
 ;
FINISH K USERS,RECDS,MOVES,DIK,MAXRECD,TOTAL,KOUNT,TEMP
 K MOVE,RECD,USER,DA,GLOBAL,ERASE,INDEX
 Q
 ;
 ;Check to see if the movement type is one we are looking for.
 ;If so check the record type.
 ;
MOVECHK S TEMP=^RT(KOUNT,"CL")
 S MOVE="/"_$P(TEMP,"^",8)_"/"
 I MOVES[MOVE D RECDCHK
 Q
 ;
 ;Check to see if the record type is one we are looking for.
 ;If so check the user.
 ;
RECDCHK S RECD="/"_$P(^RT(KOUNT,0),"^",3)_"/"
 I RECDS[RECD D USERCHK
 Q
 ;
 ;Check to see if the user is one we are looking for.  If
 ;so delete the record.
 ;
USERCHK S USER="/"_$P(TEMP,"^",7)_"/"
 I USERS[USER D DELRECD
 Q
 ;
 ;Delete the record.  Print corresponding user, record number & type,
 ;and movement type information.  Increment the deletion total.
 ;
DELRECD S DIK="^RT(",DA=KOUNT
 ;D ^DIK
 W !,"Movement Type ",$P(MOVE,"/",2),", Charged Out By ",$P(USER,"/",2),","
 W !,"Record Number ",KOUNT,", Type ",$P(RECD,"/",2)," has been deleted.",!!
 S GLOBAL=190.1,DIK="^RTV(190.1,"
 D DELASSOC
 I ERASE>0 W ERASE," associated requested records deleted.",!
 S GLOBAL=190.2,DIK="^RTV(190.2,"
 D DELASSOC
 I ERASE>0 W ERASE," associated missing records deleted.",!
 S GLOBAL=190.3,DIK="^RTV(190.3,"
 D DELASSOC
 I ERASE>0 W ERASE," associated movement history records deleted.",!
 S TOTAL=TOTAL+1
 Q
 ;
 ;Delete all associated requested, missing, and movement
 ;history records.  Count each occurance of each type.
 ;
DELASSOC S ERASE=0
 F INDEX=0:0 S INDEX=$O(^RTV(GLOBAL,"B",KOUNT,INDEX)) Q:INDEX=""  S ERASE=ERASE+1,DA=INDEX ;D ^DIK
 Q
