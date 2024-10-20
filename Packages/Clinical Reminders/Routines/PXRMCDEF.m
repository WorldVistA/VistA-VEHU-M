PXRMCDEF ;SLC/AGP - Computed findings for Reminder Definition. ;06/30/2020
 ;;2.0;CLINICAL REMINDERS;**4,18,24,26,47,45,42**;Feb 04, 2005;Build 245
 ;
 ;======================================================
RDEF(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for returning a Reminder
 ;definition evaluation status.
 I $G(TEST)="" D  Q
 . S TEST=0
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","CF.VA-REMINDER DEFINITION")="No reminder definition"
 ;New PXRMFFSS and PXRMTDEB so that reminder test function finding
 ;and term output is not corrupted.
 N DEFARR,FIEVAL,NAME,PNAME,RIEN,TEMP,PARAM,PXRMDEBG,PXRMFFSS,PXRMTDEB
 N SAVETMP,OUTTYPE
 S NAME=$P(TEST,U,1)
 I NAME="" D  Q
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","CF.VA-REMINDER DEFINITION")="No reminder definition."
 I +NAME=NAME S RIEN=+NAME,NAME=$P(^PXD(811.9,RIEN,0),U,1)
 E  S RIEN=+$O(^PXD(811.9,"B",NAME,""))
 I RIEN=0 D  Q
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","CF.VA-REMINDER DEFINITION")="The reminder definition does not exist."
 I +$P(^PXD(811.9,RIEN,0),U,6)=1 D  Q
 . S ^TMP(PXRMPID,$J,PXRMITEM,"FERROR","CF.VA-REMINDER DEFINITION")="The reminder definition is inactive."
 . S TEST=0
 S PARAM=$P(TEST,U,2),PARAM=$P($G(PARAM),"=",2),SAVETMP=+$P(TEST,U,3),OUTTYPE=$P(TEST,U,4)
 I OUTTYPE="" S OUTTYPE=1
 S TEST=0,DATE=$$NOW^PXRMDATE
 K ^TMP("PXRHM",$J,RIEN)
 S PNAME=$S($P($G(^PXD(811.9,RIEN,0)),U,3)'="":$P(^PXD(811.9,RIEN,0),U,3),1:NAME)
 ;Load the definition into DEFARR.
 D DEF^PXRMLDR(RIEN,.DEFARR)
 D EVAL^PXRM(DFN,.DEFARR,OUTTYPE,0,.FIEVAL,DATE)
 S TEMP=$G(^TMP("PXRHM",$J,RIEN,PNAME))
 I SAVETMP,$G(PXRMSRCFF) D
 . K ^TMP("PXRM BL DATA",$J)
 . M ^TMP("PXRM BL DATA",$J,"FIEVAL")=FIEVAL
 . M ^TMP("PXRM BL DATA",$J,"PXRHM")=^TMP("PXRHM",$J)
 . S ^TMP("PXRM BL DATA",$J,"REMINDER IEN")=RIEN
 . S ^TMP("PXRM BL DATA",$J,"REMINDER NAME")=PNAME
 K ^TMP("PXRHM",$J,RIEN)
 S TEST=$S(TEMP="":0,TEMP["ERROR":0,TEMP["CNBD":0,1:1)
 Q:'TEST
 S TEXT="Reminder: "_NAME
 S VALUE=$P(TEMP,U)
 S VALUE("STATUS")=VALUE
 S VALUE("DUEDATE")=$P(TEMP,U,2)
 S VALUE("LASTDONE")=$P(TEMP,U,3)
 Q:PARAM=""
 I PARAM="DUE DATE",+VALUE("DUEDATE")>0 S DATE=VALUE("DUEDATE")
 I PARAM="LAST DONE",+VALUE("LASTDONE")>0 S DATE=VALUE("LASTDONE")
 Q
 ;
