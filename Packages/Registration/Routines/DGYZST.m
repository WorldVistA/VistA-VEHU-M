DGYZST ;ALB/MIR - STATE FILE UPDATE FOR FY92 ; 17 SEP 91
 ;;MAS VERSION 5.1;;**8**;
 ;
 ;These routines will add/alter the appropriate state and county codes
 ;for the outlying areas of the United States.
 ;
 ;
CK ;
 W !!,">>>Checking to see that existing state code entries are accurate...",!
 ;
 F I=1:1 S X=$P($T(STATES+I),";;",2) Q:X="QUIT"  F IFN=0:0 S IFN=$O(^DIC(5,"C",+X,IFN)) Q:'IFN  I $D(^DIC(5,+IFN,0)) S Y=$P(^(0),"^",1) I $P(X,"^",2)'=Y&($P(X,"^",3)'=Y) W !?3,"State code ",+X," should be ",$P(X,"^",2),"!" S DGFL=1
 ;
 I $D(DGFL) W !!,">>>Please review the entries listed for accuracy and make name",!?3,"changes where necessary.  If you have multiple entries with",!?3,"the same VA STATE CODE, they must all have the correct name." G Q
 W !!,">>>All state codes are accurate.  Updates will begin..."
 ;
 W !!,">>>Now deleting obsolete state codes if they exist..."
 F DGCD=67,71,74,75,76,79 F IFN=0:0 S IFN=$O(^DIC(5,"C",DGCD,IFN)) Q:'IFN  I $D(^DIC(5,IFN,0)) S X=$P(^(0),"^",1),DA=IFN,DIK="^DIC(5," W !?3,"...",X," state has been removed (state code ",DGCD,")" D ^DIK S DGFL=1
 ;
 D ^DGYZST1,^DGYZST2
 W !!,">>>FY92 state file update is now complete."
Q K DA,DGCD,DGFL,DIK,I,IFN,X,Y
 Q
 ;
 ;
STATES ;list of states for comparison
 ;;60^AMERICAN SAMOA
 ;;66^GUAM
 ;;67^JOHNSTON ATOLL
 ;;71^MIDWAY ISLANDS
 ;;72^PUERTO RICO
 ;;74^SWAN ISLANDS^JOHNSTON ATOLL
 ;;75^TRUST TERRITORY PACIFIC ISLANDS
 ;;76^U.S. MISC. CARIBBEAN ISLANDS
 ;;78^VIRGIN ISLANDS
 ;;79^WAKE ISLAND
 ;;QUIT
