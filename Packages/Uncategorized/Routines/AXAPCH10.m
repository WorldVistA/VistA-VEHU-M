AXAPCH10 ;WPB/DLB ; PATCHMAN POST-INSTALL INIT ; 03-OCT-2000
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
EN ; -- Main Entry Point for Post-Install Patch Package Init --
 ; loop through the package file and put info in the patch package
 ; 
 S (IEN,VER)=0,(NAME,NS)=""
 F IEN=0:0 S IEN=$O(^DIC(9.4,IEN)) Q:+$G(IEN)'>0  D
 . S NAME=$P($G(^DIC(9.4,IEN,0)),U,1),NS=$P($G(^DIC(9.4,IEN,0)),U,2)
 . S VER=$G(^DIC(9.4,IEN,"VERSION"))
 . I NAME'="" D
 .. S DIC="^AXA(548260,"
 .. S DIC(0)="",X=NAME
 .. S DIC("DR")=".02///^S X=NS;.17///^S X=VER;.18///^S X=VER"
 .. D FILE^DICN
 D EXIT
 Q
EXIT ; -- Exit & Cleanup Unit --
 K IEN,VER,NAME,NS,DIC,DIC(0),DIC("DR"),X
 Q
