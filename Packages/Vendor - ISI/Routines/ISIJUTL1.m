ISIJUTL1 ; ISI/JHC - ISI Rad subroutines ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,106,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ;
 Q
 ;
ERR ;
 S @MAGRY@(0)="0^4~ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q:$Q 1 Q
 ;
 ;
ASIGME(ASIGNEE,LIST,STATUS) ; ISI  calc truth value re assignment status vs user type
 ; Called by: Exam Open code to control locking of an exam,
 ;            Exam List compile to control display of an exam 
 ; Input:
 ;   ASIGNEE--DUZ of assignee, required
 ;      LIST--optional, = List # for List compile to filter appropriately for Lists
 ;    STATUS--optional, exam Status code, used for List compile ...
 ; Returns:
 ;    TRUE--ok for this user to lock an exam, or see exam list entry, acc to calling routine
 ;   FALSE--otherwise; see logic below
 N ASIGMINE,RESULT,RADTECH
 S LIST=$G(LIST,0),STATUS=$G(STATUS,0)
 S RESULT=1 ; default = allow LIST display; allow locking
 I ASIGNEE D  ; only matters if case is assigned
 . S ASIGMINE=ASIGNEE=DUZ
 . I ASIGMINE Q  ; OK if it is my assignment, for any purpose
 . I 'LIST S RESULT=$S(+MAGJOB("USER",1):0,1:1) Q  ; Lock request: prevent for rist, else OK
 . I $$ASSTATUS(STATUS) Q  ; exam list checks below only matter for certain status values
 . S RADTECH=$D(^VA(200,"ARC","T",+DUZ))
 . I +MAGJOB("USER",1)!RADTECH D  ;
 . . ; line below: user has key to view "master" lists of all assigned exams
 . . I $D(MAGJOB("KEYS","ISIJ ASSIGN EXAMS-VIEW ALL")),((LIST=9802)!(LIST=9803)) Q
 . . I RADTECH,'((LIST=9800)!(LIST=9801)) Q:'+MAGJOB("USER",1)  ; tech--filter out the "My Assigned"; other lists allow
 . . S RESULT=0  ; block display or lock of another's assigned exam
 Q:$Q RESULT Q
 ;
ASSTATUS(STS) ; return False if status is Waiting or Examined
 ;  exams in these statuses are of interest regarding locks & list display
 N OK,X
 S OK=1
 I STS]"" D
 . S X=^RA(72,STS,0)
 . I $P(X,U,3)=1 S OK=0 Q  ; Waiting
 . I $P(X,U,9)="R" S OK=0 Q  ; Ready for Interp  ; P106
 . I $P(X,U,9)="E" S OK=0 Q  ; Examined
 Q:$Q OK Q
 ;
ASENA(MAGRY) ; RPC: ISIJ ASSIGN ENABLE
 ;  Deprecated functionality--reply will disable function in client
 ;  RETURN:  0 ^ Menu
 ;  Menu -- Hard code to nil
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJUTL1"
 N CT,MAGLST,REPLY
 S DIQUIET=1 D DT^DICRW
 S CT=0,MENU="",MAGLST="ISIASSIGNENA"
 K MAGRY S MAGRY=$NA(^TMP($J,MAGLST)) K @MAGRY  ; assign MAGRY value
 S REPLY=CT_U_MENU
 S @MAGRY@(0)=REPLY
 Q
 ;
QRYSTAT ; Inquire into ISIJ DYNAMIC QUERY STATS file entries
 N MAGIEN,IENCT,TEMP
 W !!?5,"NOTE: the output for this report works best on a 132 column display."
QRYSLOOP S IENCT=0,TEMP="ISIJTEMP" K ^TMP($J,TEMP)
 W !!?15,"Display ISI Rad Query Statistics",!!
 S DIC=23450,DIC(0)="AMEQ"
 F  D  Q:Y=-1
 . D ^DIC I Y=-1 Q
 . S DA=+Y,IENCT=IENCT+1,^TMP($J,TEMP,IENCT,DA)=""
 W !
 I 'IENCT K DIC,DA,DR W ! Q
 S L(0)=2,BY(0)="^TMP($J,TEMP"
 S FLDS="[ISIJ QUERY STATS]"
 D EN1^DIP W !
 G QRYSLOOP
 Q
 ;
END Q
 ;
