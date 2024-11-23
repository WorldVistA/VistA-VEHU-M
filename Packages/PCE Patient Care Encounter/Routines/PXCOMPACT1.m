PXCOMPACT1 ;ALB/BPA,CMC - Routine for COMPACT Act APIs;05/06/2024@12:01
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**240**;Aug 12, 1996;Build 55
 ; *240* APIs for Episode of Care APIs (^PXCOMP(818))
 ; 
 Q
 ;
FILEMANERR(DFN,DATA,MSG) ;
 N COUNT,ERR,FROM,NODE,NOW,PXEOCNUM,PXIEN,PXFIELD,PXFILE,PXVAL,SEQ,SUBJECT,TO,TXTCOUNT,TYP
 S (ERR,FROM,NODE,NOW,PXEOCNUM,PXIEN,PXFIELD,PXFILE,PXVAL,SUBJECT,TO,TYP)="",(SEQ,TXTCOUNT)=0,COUNT=8
 S NODE="PXCOMPERR",NOW=$$HTFM^XLFDT($H)
 S SUBJECT="COMPACT ACT Issue filing Episode of Care entry"
 S FROM="COMPACT Act new episode of care processing"
 S TO("G.COMPACT ACT COORDINATORS")=""
 S TO(DUZ)=""
 K ^TMP(NODE,$J)
 S ^TMP(NODE,$J,1,0)="This episode of care failed to file for this patient."
 S ^TMP(NODE,$J,2,0)="Please enter a Service NOW ticket referencing this error "
 S ^TMP(NODE,$J,3,0)="and contact your local COMPACT Act Coordinator"
 S ^TMP(NODE,$J,4,0)=""
 S ^TMP(NODE,$J,5,0)="Processed by: "_$$NAME^XUSER(DUZ)_" on "_$$FMTE^XLFDT(NOW)
 I $G(DFN)'="" D
 . S ^TMP(NODE,$J,6,0)="Patient ID:   "_DFN
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN) I PXEOCNUM="" S PXEOCNUM="(not valid)"
 E  D
 . S ^TMP(NODE,$J,6,0)="Patient ID:   Patient ID is null",PXEOCNUM="n/a"
 S ^TMP(NODE,$J,7,0)="EoC number:   "_PXEOCNUM
 F  S ERR=$O(MSG(ERR)) Q:ERR=""  D
 . F  S SEQ=$O(MSG(ERR,SEQ)) Q:SEQ=""  D
 . . F  S TYP=$O(MSG(ERR,SEQ,TYP)) Q:TYP=""  D
 . . . I TYP="TEXT" D 
 . . . . F  S TXTCOUNT=$O(MSG(ERR,SEQ,TYP,TXTCOUNT)) Q:TXTCOUNT=""  S ^TMP(NODE,$J,COUNT,0)="Error: "_$G(MSG(ERR,SEQ,TYP,TXTCOUNT)),COUNT=COUNT+1
 ;
 F  S PXFILE=$O(DATA(PXFILE)) Q:PXFILE=""  D
 . F  S PXIEN=$O(DATA(PXFILE,PXIEN)) Q:PXIEN=""  D
 . . F  S PXFIELD=$O(DATA(PXFILE,PXIEN,PXFIELD)) Q:PXFIELD=""  D
 . . . S PXVAL=$G(DATA(PXFILE,PXIEN,PXFIELD)),COUNT=COUNT+1
 . . . S ^TMP(NODE,$J,COUNT,0)="Data entered - File: "_PXFILE_" IEN: "_PXIEN_" Field: "_PXFIELD_" Value: "_PXVAL
 ;
 D SEND^PXMSG(NODE,SUBJECT,.TO,FROM)
 K ^TMP(NODE,$J)
 Q
 ;
COMPACTERR(PXERRMSG,DFN) ;
 N FROM,NODE,NOW,PXEOCNUM,SUBJECT,TO
 S PXEOCNUM=""
 S NODE="PXCOMPERR",NOW=$$HTFM^XLFDT($H)
 S SUBJECT="COMPACT Act Issue filing Episode of Care entry"
 S FROM="COMPACT Act new episode of care processing"
 S TO("G.COMPACT ACT COORDINATORS")=""
 S TO(DUZ)=""
 K ^TMP(NODE,$J)
 S ^TMP(NODE,$J,1,0)="This episode of care failed to file for this patient."
 S ^TMP(NODE,$J,2,0)="Please enter a Service NOW ticket referencing this error "
 S ^TMP(NODE,$J,3,0)="and contact your local COMPACT Act Coordinator"
 S ^TMP(NODE,$J,4,0)=""
 S ^TMP(NODE,$J,5,0)="Processed by: "_$$NAME^XUSER(DUZ)_" on "_$$FMTE^XLFDT(NOW)
 I $G(DFN)'="" D
 . S ^TMP(NODE,$J,6,0)="Patient ID:   "_DFN
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN) I PXEOCNUM="" S PXEOCNUM="(not valid)"
 E  D
 . S ^TMP(NODE,$J,6,0)="Patient ID:   Patient ID is null",PXEOCNUM="n/a"
 S ^TMP(NODE,$J,7,0)="EoC number:   "_PXEOCNUM
 S ^TMP(NODE,$J,8,0)="Error:        "_PXERRMSG
 D SEND^PXMSG(NODE,SUBJECT,.TO,FROM)
 W !,"A MailMan message has been sent regarding a COMPACT Act error during processing and will need follow up."
 W !!,"Error: "_$G(PXERRMSG)
 K ^TMP(NODE,$J),FROM,NODE,SUBJECT,TO
 Q
