ZVHPAT ; OIA/TJH - PATIENT SELECTION FOR BCMA data ;8/26/14
 ;;0.1;NO PKG;**NO PATCHES**;Dec  1, 2013; no build
 ;
 ; called by ZVHBC, ZVHBC3, ZVHBCMN, ZVHOPM, ZVHOPM1, ZVHOPM2, ZVHRAD
 ;-----------------------------------------------------------------------
 ;
 WRITE "Not an entry point!  Use EN^ZVHBC",!! QUIT  ; labels in this routine are called by ZVHBC and ZVHBC3
 ;
EN ; Entry point
 ; Check for Production environment, quit if true
 ;
 ; TJH NEW CHECK
 ; TJH SET CHECK=$$PROD^XUPROD(1)
 ; TJH IF CHECK=1 DO  QUIT
 ; TJH . WRITE "This routine is for TEST systems only!!!",!!,"Goodbye!,"!!
 ; TJH ELSE  WRITE "This is a TEST account, proceeding...",!!
 ;
 ; DO Patient selection Label ; Single patient intially
 KILL ^TMP("ZVHPAT",$J) ;
 NEW PATIENTS SET PATIENTS="" ; Patient array of DFN's
 NEW Y,DIR  ;
 ; User to choose how they wish to enter patients
 S DIR(0)="SO^1:1. Select unique patients;2:2. Select a group of VeHU patients"
 S DIR("L",1)="Please enter 1 or 2:"
 S DIR("L",2)=""
 S DIR("L",3)="   1. Select unique patients"
 S DIR("L")="   2. Select a group of VeHU patients"
 D ^DIR
 ;
 I Y=1 D GETPAT1 Q
 I Y=2 D GETPAT2 Q
 IF $DATA(^TMP("ZVHPAT",$J))'>9 WRITE !,?5,"No patients selected",!! QUIT  ; exit
 ;
 ; DEBUG
 ;ZWRITE ^TMP("ZVHPAT",$J)
 ; DBUG
 ;
GETPAT2 ; Patient Selection using DI READ.  Pass in the PATIENTS
 ; array by reference, return the PATIENTS array
 ;===================================================================
 ;GET LIST OF PATIENTS TO UPDATE TJH ADDITION TO REPLACE EXISTING GETPAT
 N PTARR,PTAR,J ; TJH PATIENT ARRAY
 W !!,"Select patient numbers between"
 W !,"0 and 605 with the number corresponding to the VeHU patient that you want to"
 W !,"update.  For example, enter number 12 will update VeHU patient twelve",!! ; User instructions.
 S DIR("A")="Select patient(s) to be updated" ; instruction enter patient
 S DIR(0)="LO^0:605" D ^DIR K DIR  Q:Y=""!($D(DUOUT))!($D(DTOUT))  ; choose pt between 0-605
 D PARSE(Y,.PTARR) S J=0 F  S J=$O(Y(J)) Q:'+J  D PARSE(Y(J),.PTAR)  ;
 M ^TMP("ZVHPAT",$J)=PTARR ;
 Q  ;
 ;
PARSE(ARRAY,LIST) ; select pt ssN#
 N NUM,R,LNUM,L4,SSN ;
 S NUM=$L(ARRAY,",")-1 ;
 F R=1:1:NUM S LNUM=$P(ARRAY,",",R) S L4=$S(LNUM=0:"0000",1:$E("000",1,(4-$L(LNUM)))_LNUM) D
 . S SSN="66600"_L4
 . I $D(^DPT("SSN",SSN)) S LIST($O(^DPT("SSN",SSN,0)))=""
 Q  ;
 ;================================================================TJH
GETPAT1 ; TO ENTER A SINGLE or string of PATIENT OTHER THAN VEHU PATIENTs
 ; Instructions to user:
 WRITE !!,"INSTRUCTIONS: Select patient(s) below.  When done, hit enter without",!
 WRITE ?15,"a patient name to exit.",!!
 WRITE "WARNING: This routine does not check if the selected patients are currently",!
 WRITE ?10,"admitted to an inpatient location!!  Select carefully.",!!
 ;
 ; use DIR and file 2 pointer to select patients
 NEW DIR,DIRUT,DIROUT,X,Y,DTOUT,DUOUT,COUNT,PATIENTS
 SET Y=""
 FOR COUNT=1:1 QUIT:$GET(DIRUT)  DO  ; store DFN in PATIENTS(DFN)
 . SET DIR(0)="PO^2:MEQ" ;  FILEMAN ROUTINE      pointer file 2
 . SET:COUNT=1 DIR("A")="Select a Patient" ;             first time
 . SET:'COUNT=1 DIR("A")="Select another patient" ; each additional
 . SET DIR("A")="Select a patient"
 . DO ^DIR KILL DIR ;      do DI read with above settings
 . ;next line - Quit if not integer, time out, blank line, no ^DPT
 . QUIT:'+Y>0!($DATA(DUOUT))!($DATA(DTOUT))!('$DATA(^DPT(+Y,0)))  ;
 . SET PATIENTS(+Y)="" ; add patient DFN to the patients array
 . M ^TMP("ZVHPAT",$J)=PATIENTS
 ;
 WRITE !!,?5,"Patient Selection completed.",!!
 QUIT  ; label GETPAT
 ;
 ;
SINGLE(DFN)     ; single patient selection [8/26/2014 ajc]
 ; this label will support single patient selection
 ; Required: Pass by reference DFN.  The patient's IEN will be returned in it.
 NEW DIR,DIRUT,DIROUT,X,Y,DTOUT,DUOUT,DA
 SET DIR(0)="P^2:MEQ"
 DO ^DIR
 ;
 IF $DATA(DIRUT)!$DATA(DIROUT)!(Y=-1)!(+Y'?.N) DO  QUIT
 . WRITE !,?2,"ERROR: No patient selected.",!!!
 . SET DFN=-1
 . ;SET ZVHERR=1 ; need to think about error handeling
 ELSE  SET DFN=+Y
 ;
 QUIT  ; label SINGLE
 ;
 ;
GETPAT3()       ; select a patient.  Used by ZVHOPM and ZVHRAD
 ;Ext Ouput: -1 for error, 0 for failure, patient DFN if successful
 ;
 ;use dic to select a patient from ^DPT(
 NEW DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,OUT
 SET OUT=0
 SET DIC="^DPT("
 SET DIC(0)="QEATMN"
 DO ^DIC
 IF Y=-1!$GET(DTOUT)!$GET(DUOUT)!$GET(DIRUT)!$GET(DIROUT) DO  QUIT
 . WRITE !,"ERROR: No Patient Selected.",!!
 . SET OUT=0
 IF $DATA(Y) SET OUT=+Y ; patient's IEN in file 2
 ;
 QUIT $GET(OUT) ; label GETPT
 ;
 ;
