DPTV52PR ;ALB/MTC - DPT PRE-INIT FOR VERSION 5.2 ; 5/19/92 2:55 pm
 ;;5.2;PATIENT FILE;;JUL 29,1992
 ;
EN ;
 D HNY,TEMP
 Q
 ;
HNY ;remove honeywell (and other) cross-references from the PATIENT file
 W !!,">>> Removing obsolete cross-references from the PATIENT file..."
 F DGI=1:1 S X=$P($T(HNYXRF+DGI),";;",2) Q:X="QUIT"  S DA(2)=$P(X,"^",1),DA(1)=$P(X,"^",2),DA=$P(X,"^",3),DIK="^DD("_DA(2)_","_DA(1)_",1," I $D(^DD($P(X,"^",1),$P(X,"^",2),1,$P(X,"^",3),0)),$P(^(0),"^",2)=$P(X,"^",4) D ^DIK W "."
 K DA,DIK,DGI,X
 Q
 ;
HNYXRF ;honeywell (and other) x-refs to delete
 ;;2^.01^3^AHNY1
 ;;2^.09^6^AHNY
 ;;2.011^3^3^AHNY2
 ;;2^1901^4
 ;;QUIT
 ;
TEMP ;change name of registration template due to change in screen placement
 S X=$O(^DIE("B","DG LOAD EDIT SCREEN 8",0)) I 'X Q
 W !!,">>> Renaming DG LOAD EDIT SCREEN 8 template to DG LOAD EDIT SCREEN 7..."
 S DIE="^DIE(",DR=".01///DG LOAD EDIT SCREEN 7;1815///@;1816///@",DA=X D ^DIE
 K DA,DIE,X
 Q
 ;
