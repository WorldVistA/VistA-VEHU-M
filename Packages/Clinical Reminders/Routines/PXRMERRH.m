PXRMERRH ;SLC/PKR - Error handling routines. ;07/06/2016  13:05
 ;;2.0;CLINICAL REMINDERS;**4,17,18,47,45**;Feb 04, 2005;Build 566
 ;
 ;=================================================================
DERRHRLR ;PXRM error handler. Send a MailMan message to the mail group defined
 ;by the site and put the error in the error trap.
 ;References to %ZTER covered by DBIA #1621.
 N CNT,ERR,ERROR,INDEX,MGIEN,MGROUP,NL,XMDUZ,XMSUB,XMY,XMZ
 S ERROR=$$EC^%ZOSV
 ;Ignore the "errors" the unwinder creates.
 I ERROR["ZTER" D UNWIND^%ZTER
 ;If it is a framestack error do not try to send the message
 I ERROR["FRAMESTACK" Q
 ;Make sure we don't loop if there is an error during procesing of
 ;the error handler.
 N $ET S $ET="D ^%ZTER,DCLEAN^PXRMERRH,UNWIND^%ZTER"
 ;
 ;Save the error then put it in the error trap, this saves the correct
 ;last global reference.
 D ^%ZTER
 ;
 ;If this is a test run write out the error.
 ;I $G(PXRMDEBG) W !,ERROR
 ;
 K ^TMP("PXRMXMZ",$J)
 S CNT=0
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="The following error occurred while saving general findings:"
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=ERROR
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="Please contact the help desk for assistance."
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=" "
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="See below for the data that was not saved:"
 D ACOPY^PXRMUTIL("DATA","ERR()")
 S INDEX=0 F  S INDEX=$O(ERR(INDEX)) Q:INDEX'>0  S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=ERR(INDEX)
 ;
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 ;If the mail group has not been defined tell the user.
 I MGIEN="" D
 . S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)=" "
 . S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="You received this message because your IRM has not set up a mailgroup"
 . S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="to receive Clinical Reminder errors; please notify them."
 ;
 D SEND^PXRMMSG("PXRMXMZ","ERROR SAVING DATA","",DUZ)
 ;
 ;I '$G(PXRMDEBG) D DCLEAN
 S RETURN(0)="-1^A Mumps error occurred while saving data."
 D UNWIND^%ZTER
 Q
 ;
 ;=================================================================
ERRHDLR ;PXRM error handler. Send a MailMan message to the mail group defined
 ;by the site and put the error in the error trap.
 ;References to %ZTER covered by DBIA #1621.
 N ERROR,MGIEN,MGROUP,NL,REMINDER,XMDUZ,XMSUB,XMY,XMZ
 S ERROR=$$EC^%ZOSV
 ;Ignore the "errors" the unwinder creates.
 I ERROR["ZTER" D UNWIND^%ZTER
 ;If it is a framestack error do not try to send the message
 I ERROR["FRAMESTACK" Q
 ;Make sure we don't loop if there is an error during procesing of
 ;the error handler.
 N $ET S $ET="D ^%ZTER,CLEAN^PXRMERRH,UNWIND^%ZTER"
 ;
 ;Save the error then put it in the error trap, this saves the correct
 ;last global reference.
 D ^%ZTER
 ;
 ;If this is a test run write out the error.
 I $G(PXRMDEBG) W !,ERROR
 ;
 K ^TMP("PXRMXMZ",$J)
 S ^TMP("PXRMXMZ",$J,1,0)="The following error occurred:"
 S ^TMP("PXRMXMZ",$J,2,0)=ERROR
 I +$G(PXRMITEM)>0 S REMINDER=$P(^PXD(811.9,PXRMITEM,0),U,1)
 E  S PXRMITEM=999999,REMINDER="?"
 S ^TMP("PXRMXMZ",$J,3,0)="While evaluating reminder "_REMINDER
 S ^TMP("PXRMXMZ",$J,4,0)="For patient DFN="_$G(PXRMPDEM("DFN"))
 S ^TMP("PXRMXMZ",$J,5,0)="The time of the error was "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,6,0)="See the error trap for complete details."
 S NL=6
 ;Look for specific error text to append to the message.
 I $D(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP")) D
 . N ESOURCE,IND
 . S ESOURCE=""
 . F  S ESOURCE=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP",ESOURCE)) Q:ESOURCE=""  D
 .. S IND=0
 .. F  S IND=$O(^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP",ESOURCE,IND)) Q:IND=""  D
 ... S NL=NL+1
 ... S ^TMP("PXRMXMZ",$J,NL,0)=^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP",ESOURCE,IND)
 ;
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 ;If the mail group has not been defined tell the user.
 I MGIEN="" D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="You received this message because your IRM has not set up a mailgroup"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="to receive Clinical Reminder errors; please notify them."
 ;
 D SEND^PXRMMSG("PXRMXMZ","ERROR EVALUATING CLINICAL REMINDER","",DUZ)
 ;
 ;If the reminder exists mark that an error occured.
 I PXRMITEM=999999 Q
 S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","ERROR TRAP")=""
 N DEFARR,DUE,DUEDATE,FREQ,FIEVAL,PCLOGIC,RESDATE
 S (DUE,DUEDATE,FREQ,FIEVAL,PCLOGIC,RESDATE)=""
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 D OUTPUT^PXRMOUTD(5,.DEFARR,PCLOGIC,DUE,DUEDATE,RESDATE,FREQ,.FIEVAL)
 ;
 ;Set the first line of ^TMP("PXRHM") to ERROR.
 S ^TMP("PXRHM",$J,PXRMITEM,PXRMRNAM)="ERROR"
 ;
 I '$G(PXRMDEBG) D CLEAN
 D UNWIND^%ZTER
 Q
 ;
 ;=================================================================
CLEAN ;Clean-up scratch arrays
 K ^TMP("PXRM",$J)
 I $D(PXRMPID) K ^TMP(PXRMPID,$J)
 Q
 ;
DCLEAN ;
 Q
 ;
 ;=================================================================
NODEF(IEN) ;Non-existent reminder definition.
 N SUBJ
 K ^TMP("PXRMXMZ",$J)
 S ^TMP("PXRMXMZ",$J,1,0)="A request was made to evaluate a non-existent reminder; the ien is "_IEN_"."
 S ^TMP("PXRMXMZ",$J,2,0)="An entry was made in the error trap that does not have a description."
 S ^TMP("PXRMXMZ",$J,3,0)="Match the time of this message with the time in the error trap."
 S SUBJ="Request to evaluate a non-existent reminder"
 D SEND^PXRMMSG("PXRMXMZ",SUBJ,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 D ^%ZTER
 Q
 ;
 ;=================================================================
NOINDEX(FTYPE,IEN,FILENUM) ;Error handling for missing index.
 N ETEXT,SUBJ
 K ^TMP("PXRMXMZ",$J)
 S ETEXT(1)=""
 S ETEXT(2)="Index for file number "_FILENUM_" does not exist or is not complete."
 I FTYPE="D" S ETEXT(3)="Reminder "_IEN_" will not be properly evaluated!"
 I FTYPE="TR" S ETEXT(3)="Term "_IEN_" will not be properly evaluated!"
 I FTYPE="TX" S ETEXT(3)="Taxonomy "_IEN_" will not be properly evaluated!"
 I $D(PXRMPID) D
 . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","MISSING INDEX")=ETEXT(2)
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","MISSING INDEX")=ETEXT(2)
 ;Mail out the error message.
 S ^TMP("PXRMXMZ",$J,1,0)=ETEXT(2)
 S ^TMP("PXRMXMZ",$J,2,0)=ETEXT(3)
 S ^TMP("PXRMXMZ",$J,3,0)="Patient DFN="_$G(PXRMPDEM("DFN"))_", User DUZ="_DUZ_", Reminder="_$G(PXRMITEM)
 S SUBJ="Problem with index for file number "_FILENUM
 D SEND^PXRMMSG("PXRMXMZ",SUBJ,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
