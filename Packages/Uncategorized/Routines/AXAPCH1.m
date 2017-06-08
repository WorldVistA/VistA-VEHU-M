AXAPCH1 ;WPB/JLTP ; BROWSE PATCH DESCRIPTION ; 15-SEP-1998
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
EN ; -- main entry point for AXAPCH DESCRIPTION
 D EN^VALM("AXAPCH DESCRIPTION")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$G(TITLE)
 S VALMHDR(2)=""
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=$G(^TMP("BROWSE",$J,0))
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
