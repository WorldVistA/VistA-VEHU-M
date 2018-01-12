AXAPCH2 ;WPB/JLTP ; BROWSE PATCH NOTES ; 26-SEP-1998
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
EN ; -- main entry point for AXAPCH NOTES
 D EN^VALM("AXAPCH NOTES")
 Q
 ;
HDR ; -- header code
 M VALMHDR=TITLE
 Q
 ;
INIT ; -- init variables and list array
 N RESP,L,X,Y K ^TMP("NOTES",$J)
 S VALMCNT=0
 S RESP=0
 I '$D(^XMB(3.9,+MSG,0)) D  Q
 .S VALMCNT=1,^TMP("NOTES",$J,1,0)="Message not found."
 I '$O(^XMB(3.9,MSG,3,0)) D  Q
 .S VALMCNT=1,^TMP("NOTES",$J,1,0)="No notes found."
 F  S RESP=$O(^XMB(3.9,MSG,3,RESP)) Q:'RESP  S RESPM=+^(RESP,0)  D
 .S X=^XMB(3.9,RESPM,0),Y=$P(X,U,2)
 .S:Y=+Y Y=$P($G(^VA(200,+Y,0)),U)
 .S VALMCNT=VALMCNT+1
 .S ^TMP("NOTES",$J,VALMCNT,0)=$P(X,U)_"  ("_Y_")  "_$$FMTE^XLFDT($P(X,U,3))
 .F L=0:0 S L=$O(^XMB(3.9,RESPM,2,L)) Q:'L  S X=^(L,0) D
 ..S VALMCNT=VALMCNT+1,^TMP("NOTES",$J,VALMCNT,0)=X
 .S VALMCNT=VALMCNT+1,^TMP("NOTES",$J,VALMCNT,0)=" "
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
