PRXMI4P9 ;WISC/LEM-REBUILD 970.06 TEMPLATE & MAP ;12/22/94  12:52 PM
V ;;4.0;IFCAP;**9**;9/23/93
 ;
 ;  This is a one-time initialization routine for PRC*4*9.
 ;  It will replace both the DR string for the File 423
 ;  Input Template [PRCFA TT970.06] and the corresponding
 ;  template map in File 422.  Replacement will be done only
 ;  after the original code has been located and verified.
 ;
EN N DA,DIC,STR,X,Y
 N NEW422,NEW423,OLD422,OLD423,CONV422,CONV423,NONST422,NONST423
 S DIC="^DIE(",DIC(0)="XZ",X="PRCFA TT970.06" D ^DIC
 I Y<0 S X=$P($T(NO423),";",2,99) D MSG^PRCFQ Q
 S DA=+Y,STR=$G(^DIE(DA,"DR",1,423))
 I STR="" S X=$P($T(NO423),";",2,99) D MSG^PRCFQ Q
 S NEW422=$P($T(NEW422),";",2,99),NEW423=$P($T(NEW423),";",2,99)
 S OLD422=$P($T(OLD422),";",2,99),OLD423=$P($T(OLD423),";",2,99)
 I STR=NEW423 S X=$P($T(DONE423),";",2,99) D MSG^PRCFQ
 I STR'=OLD423,STR'=NEW423 S X=$P($T(NONST423),";",2,99) D MSG^PRCFQ
 I STR=OLD423 S ^DIE(DA,"DR",1,423)=NEW423,X=$P($T(CONV423),";",2,99) D MSG^PRCFQ
 S DIC="^PRCD(422,",DIC(0)="XZ",X="PRCFA TT970.06" D ^DIC
 I Y<0 S X=$P($T(NO422),";",2,99) D MSG^PRCFQ Q
 S DA=+Y,STR=$G(^PRCD(422,DA,1,1,0))
 I STR="" S X=$P($T(NO422),";",2,99) D MSG^PRCFQ Q
 I STR=NEW422 S X=$P($T(DONE422),";",2,99) D MSG^PRCFQ Q
 I STR'=OLD422,STR'=NEW422 S X=$P($T(NONST422),";",2,99) D MSG^PRCFQ Q
 I STR=OLD422 S ^PRCD(422,DA,1,1,0)=NEW422,X=$P($T(CONV422),";",2,99) D MSG^PRCFQ
 Q
OLD423 ;.1///CLM;S Y=4;1;3;4;5;S Y=104;55;23;104;6;56;57;S Y=998;26;82;58;84;82;58;84;60;46;47;48;49;50;998///$;
NEW423 ;.1///CLM;S Y=4;1;3;4;5;S Y=104;55;23;104;6;56;57;S Y=998;26;998///$;
OLD422 ;.1;0;10\1;0;2\3;0;4\4;0;5\5T;0;6\55;8;4\23T;1;18\104;8;14\6;1;1\56;8;5\57;8;6\26;1;20\82;6;19\58;8;7\84;6;21\82;6;19\58;8;7\84;6;21\60;8;9\46;6;10\47;6;11\48;6;12\49;6;13\50;6;14\998;1;16\
NEW422 ;.1;0;10\1;0;2\3;0;4\4;0;5\5T;0;6\55;8;4\23T;1;18\104;8;14\6;1;1\56;8;5\57;8;6\26;1;20\998;1;16\
NO423 ;Could not locate [PRCFA TT970.06] Input Template for File 423.  No changes made.
NO422 ;Could not locate PRCFA TT970.06 template map in File 422.  No changes made.
DONE422 ;PRCFA TT970.06 template map has already been converted.  No changes made.
DONE423 ;[PRCFA TT970.06] Input Template has already been converted.  No changes made.
CONV422 ;File 422: PRCFA TT970.06 template map being converted. . .  Done.
CONV423 ;File 423: [PRCFA TT970.06] Input Template being converted. . .  Done.
NONST422 ;Your PRCFA TT970.06 template map does not match the original release.  No changes made.
NONST423 ;Your [PRCFA TT970.06] Input Template has a non-standard DR string.  No changes made.
