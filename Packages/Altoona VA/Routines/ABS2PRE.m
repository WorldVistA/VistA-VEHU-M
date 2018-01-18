ABS2PRE ;ALTOONA/CTB - PREINIT FOR PATCH ABSV*4*6  ;8/3/95  11:09 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**6**;JULY 1994
DD ;delete Data dictionaries
 S X="     Beginning Deletion of Timekeeping Data Dictionaries." D MSG^ABSVQ
 W ! S X="          Don't worry, your data is safe.*" D MSG^ABSVQ
 F NEXT=1:1 S ZIU=$T(DDLIST+NEXT) Q:$P(ZIU,";",3)=""  D
 . S DIU=$P(ZIU,";",3),DIU(0)=$P(ZIU,";",4)
 . W !!,"File "_DIU,!
 . S:DIU(0)="" DIU(0)="ET" Q:DIU=""  D EN^DIU2
 . QUIT
 S X="     Data Dictionaries have been deleted." D MSG^ABSVQ
 QUIT
DDLIST ;data dictionaries to be removed - piece 4 contains DIU(0) parameters
 ;;503330;"E"
 ;;503331;"E"
 ;;503335;"E"
 ;;503338;"E"
