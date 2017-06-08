PRCH118 ;WISC/SC-Put "C" for contract flag field for prior to this patch entries
 ;;5.0;IFCAP;**118**;4/21/95
 ;
CONTRACT ;Enter 'C' in contract flag field, all contract entries prior
 ;to this patch118 will have 'C' (as BOA # is addition of patch118).
 ;
 N VENDOR,PRCHCONT,CONTLOOP
 S VENDOR=0
 F  S VENDOR=$O(^PRC(440,VENDOR)) Q:VENDOR'>0  D
 . S PRCHCONT=$G(^PRC(440,VENDOR,4,0))
 . Q:PRCHCONT=""
 . Q:$P(PRCHCONT,U,4)'>0
 . S CONTLOOP=0
 . F  S CONTLOOP=$O(^PRC(440,VENDOR,4,CONTLOOP)) Q:CONTLOOP'>0  D
 . . Q:$P(^PRC(440,VENDOR,4,CONTLOOP,0),U,6)]""
 . . S $P(^PRC(440,VENDOR,4,CONTLOOP,0),U,6)="C"
 . . Q
 . Q
 ;
FIELD1 ;Change the entry #1.
 N DA,MSG,DIE,DIC,DR,X,Y,DLAYGO,VAR1,VAR2,AUTH12,AUTH13
 S DA=$O(^PRC(442.4,"B",1,0))
 I DA'>0 D  G FIELD6
 . S MSG="Entry #1 in Purchase Authority File(# 442.4) not found.  Entry #1 needs to be added."
 . D MES^XPDUTL(MSG)
 . Q
 S DIE="^PRC(442.4,"
 S VAR1="JWOD"
 S VAR2="Javits-Wagner-O'Day"
 S DR="1////^S X=VAR1;2////^S X=VAR2"
 D ^DIE
 ;
FIELD6 ;Change the entry #6.
 S DA=$O(^PRC(442.4,"B",6,0))
 I DA'>0 D  G FIELD9
 . S MSG="Entry #6 in Purchase Authority File(# 442.4) not found.  Entry #6 needs to be added."
 . D MES^XPDUTL(MSG)
 . Q
 S DIE="^PRC(442.4,"
 S VAR1="FS"
 S VAR2="Federal Schedule Contracts by GSA"
 S DR="1////^S X=VAR1;2////^S X=VAR2"
 D ^DIE
 ;
FIELD9 ;Change the field #9.
 S DA=$O(^PRC(442.4,"B",9,0))
 I DA'>0 D  G FIELD12
 . S MSG="Entry #9 in Purchase Authority File(# 442.4) not found.  Entry #9 needs to be added."
 . D MES^XPDUTL(MSG)
 . Q
 S DIE="^PRC(442.4,"
 S VAR1="VAFS"
 S VAR2="Federal Schedule Contracts by VA NAC"
 S DR="1////^S X=VAR1;2////^S X=VAR2"
 D ^DIE
 ;
FIELD12 ;Entering new record.
 S AUTH12=$O(^PRC(442.4,"B",12,0))
 G:AUTH12>0 FIELD13
 S DIC="^PRC(442.4,"
 S DIC(0)="LE"
 S X=12
 S DLAYGO=442.4
 K DD
 K DO
 S DIC("DR")="1////^S X=""BOA"";2////^S X=""Basic Ordering Agreement"""
 D FILE^DICN
 ;
FIELD13 ;Entering new record.
 S AUTH13=$O(^PRC(442.4,"B",13,0))
 G:AUTH13>0 COMPILE
 S DIC="^PRC(442.4,"
 S DIC(0)="LE"
 S X=13
 S DLAYGO=442.4
 K DD
 K DO
 S DIC("DR")="1////^S X=""FPI/U"";2////^S X=""Federal Prison Industries/Unicor"""
 D FILE^DICN
 ;
 ;
COMPILE ;compile template PRCH2138
 N X,Y,DMAX,MSG
 S X="PRCHT1"
 S Y=$O(^DIE("B","PRCH2138",0))
 S DMAX=5000
 D EN^DIEZ
 ;compile template PRCHNREQ
 N X,Y,DMAX
 S X="PRCHT3"
 S Y=$O(^DIE("B","PRCHNREQ",0))
 S DMAX=5000
 D EN^DIEZ
 S MSG="Templates PRCH2138 and PRCHNREQ are compiled."
 D MES^XPDUTL(MSG)
 Q
 ;
 ;
PRE ;Delete all the entries in file 420.6.
 N PRE
 S PRE=^PRCD(420.6,0)
 S $P(PRE,U,3)=""
 S $P(PRE,U,4)=""
 K ^PRCD(420.6)
 S ^PRCD(420.6,0)=PRE
 Q
