AJK1UBX2 ;580/MRL - Collections, Pre-initialization; 23-Jul-98
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine performs many clean-up type functions necessary to
 ;initiate a proper installation.  In particular, during the initial
 ;testing phase, little things happened such as fields not getting
 ;removed which weren't in use, data getting duplicated in files, etc.
 ;This process should clean those things up prior to installing the
 ;new process.
 ;
EN ; --- enter preinit here
 ;
 D MSG(1,2,0,1,0),P1
 ;D MSG(2,2,0,1,0),P2
 D MSG(3,2,0,1,0),DE
 ;D MSG(4,2,0,1,2),MG
 ;D MSG(14,2,0,1,2),F18
 Q
 ;
P1 ; --- remove all parameter entries, except ien #1
 ;     These may have been inadvertently set during initial
 ;     installations.  Only DA=1 is valid (referenced).
 ;
 I $O(^DIZ(580950.1,1))'>0 D MSG(5,1,0,3,0) Q
 S AJKZ=0 F  S AJKZ=$O(^DIZ(580950.1,AJKZ)) Q:AJKZ'>0  D:AJKZ>1
 .S DIK="^DIZ(580950.1,",DA=+AJKZ D ^DIK
 D MSG(6,1,0,3,0)
 D END Q
 ;
P2 ; --- remove old parameter post-init notes, if desired.
 ;     just a precaution to make sure that new notes are updated
 ;     properly and not, as has happened in past, merged with old.
 ;
 K ^DIZ(580950.1,1,"IT")
 I $D(^DD(580950.1,100)) D
 .S DIK="^DD(580950.1,",DA=100 D ^DIK K DIK
 D MSG(7,1,0,3,0)
 Q
 ;
DE ; --- remove transmission data elements
 ;     so they get installed in distributed order
 ;
 S AJK=0 F  S AJK=$O(^DIZ(580950.5,AJK)) Q:AJK'>0  D
 .S DIK="^DIZ(580950.5,",DA=+AJK D ^DIK
 S AJK=0 F  S AJK=$O(^DIZ(580950.6,AJK)) Q:AJK'>0  D
 .S DIK="^DIZ(580950.6,",DA=+AJK D ^DIK
 D MSG(9,1,0,3,0)
 D END Q
 ;
MG ; --- update mailgroup, if it already exists
 ;     changes existing TRANSW@TRANSWORLDSYSTEMS.COM to new address
 ;
 S X="AJK1UBCP" X ^%ZOSF("TEST") I '$T Q  ;routine not there
 S X=$$TGP^AJK1UBCP I '+X D  G END ;group not there
 .D MSG(10,1,0,3,0)
 K ^XMB(3.8,+X,6)
 D MSG(11,1,0,3,0)
 D END Q
 ;
F18 ; --- remove field .18 from file 580950.1
 ;     field was distributed to some sites.  Never actually used
 ;
 I '$D(^DD(580950.1,.18)) D  G END
 .D MSG(12,1,0,3,0)
 S DIK="^DD(580950.1,",DA=.18 D ^DIK
 D MSG(13,1,0,3,0)
 ;
END ; --- clean up
 ;
 K A,AJK,AJK1,AJKC,AJKD,AJKZ,B,C,D,DIK,DA,E,X,Y,DIE,DIC,DR Q
 ;
MSG(A,B,C,D,E) ; --- write message
 ;
 S X=$P($T(T+A),";;",2)
 D T^AJK1UBX(X,B,C,D,E)
 Q
 ;
T ; --- message text
 ;;Removing INVALID COLLECTION PARAMETER ENTRIES
 ;;Removing Old Post-Initialization Notes & field
 ;;Removing Errroneous Transmission Sets
 ;;Removing TSI Transmission Address (replace during init)
 ;;Collection Parameters Are Already Properly Defined
 ;;Erroneous Parameters Have Been Removed
 ;;Old Post-Initialization notes data & field removed
 ;;Transmission Data Sets Are Already Properly Defined
 ;;Old Data Elements Have Been Removed
 ;;AJK1UB TRANSMISSION mailgroup will be installed during init.
 ;;Old Transmission Address Deleted...Will Be Updated In A Minute
 ;;Field .18 Does Not Exist In Your Parameter File...Nothing Updated
 ;;Field .18, No Longer In Use, Has Been Deleted From File 580950.1
 ;;Removing Field .18 From The AJK1UB SITE PARAMETER file
 ;;PRE-INITIALIZATION COMPLETED!!
