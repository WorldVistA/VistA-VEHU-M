ZVHFIX ;OIA/AJC+TJH - Check/fix BCMA data ; 6/18/14
 ;;0.1;NO PACKAGE;**NO PATCHES**;2/12/2014
 ;
 ; called by ZVHBC and ZVHBC3
 ;----------------------------------------------------------
 ;
STRING ; fix entries that have a string in one of the x-ref's
 D DOT
 D AORD
 D AADT
 D AEDT
 ;
 IF $GET(ZVHERR) DO CKERROR^ZVHBC ; check for errors
 ;
 Q  ; label STRING
 ;
 ;
CHECK(START,END,SILENT) ; entry point for a silent check (no auto-repair, but options to run the repairs)
 ;pass by value START and END dates in fileman format, SILENT as 0 or 1
 ;REQUIRED: new the error array ZVHERR before calling this label
 ;
 IF $GET(SILENT)="" SET SILENT=1 ; Default to silent
 ;
 DO AADT2(SILENT)
 DO AEDT2(SILENT)
 DO AORD2(START,END,SILENT)
 DO TIME2(SILENT)
 ;
 ;
 ;
 QUIT  ; label CHECK 
 ;
 ;
DOT(SILENT) ; fix the double .. errors
 W:'SILENT !,"========= DOT^ZVHFIX ========",!
 N ZVHPT S ZVHPT=0
 F  S ZVHPT=$ORDER(^PSB(53.79,"AORD",ZVHPT)) Q:ZVHPT=""  DO
 . ;debug W ZVHPT
 . NEW ZVHON SET ZVHON=0
 . F  S ZVHON=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON)) Q:ZVHON=""  DO
 . . ;debug W ?10,ZVHON
 . . NEW ZVHDATE SET ZVHDATE=0
 . . F  S ZVHDATE=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE)) Q:ZVHDATE=""  DO
 . . . ;debug W ?30,ZVHDATE,!
 . . . I ZVHDATE[".." DO
 . . . . NEW ZVHNUM S ZVHNUM=0
 . . . . F  S ZVHNUM=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE,ZVHNUM)) Q:ZVHNUM=""  DO
 . . . . . N ZVHFIX S ZVHFIX=$P(ZVHDATE,"..")_"."_$P(ZVHDATE,"..",2)
 . . . . . W:'SILENT !,ZVHPT,?10,ZVHON,?15,ZVHDATE,?30,ZVHFIX,?50,ZVHNUM,"  "
 . . . . . ; set the var to re-update fileman
 . . . . . N ZVHFDA,DIERR
 . . . . . S ZVHFDA(53.79,ZVHNUM_",",.13)=+ZVHFIX
 . . . . . D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.13) node
 . . . . . I $D(DIERR) DO 
 . . . . . . ZW ^TMP("DIERR",$J) 
 . . . . . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 . . . . . . DO ^DIR W !
 . . . . . . IF Y(0)="NO" QUIT
 . . . . . E  D
 . . . . . . W:'SILENT !,"FIX: ",$G(^PSB(53.79,"AORD",ZVHPT,ZVHON,+ZVHFIX,ZVHNUM)),!,$G(^PSB(53.79,+ZVHNUM,.1)),!
 ;
 W:'SILENT !,">>----> END OF DOT",!
 ;
 QUIT  ; label DOT
 ;
 ;
AORD(SILENT) ; fix the AORD x-ref
 ; Example: ^PSB(53.79,"AORD",100085,"11U","3140115.0900",3484)=""
 W:'SILENT "============ AORD x-ref ================",!
 N ZVHPT,ZVHON,ZVHDATE,ZVHNUM,DIERR S (ZVHPT,ZVHON,ZVHDATE,ZVHNUM)=0
 F  S ZVHPT=$ORDER(^PSB(53.79,"AORD",ZVHPT)) Q:ZVHPT=""  DO
 . ;W ZVHPT
 . F  S ZVHON=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON)) Q:ZVHON=""  DO
 . . ;W ?20,ZVHON
 . . F  S ZVHDATE=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE)) Q:ZVHDATE=""  DO
 . . . ;W ?30,ZVHDATE
 . . . ;W:+ZVHDATE'=ZVHDATE " STRING"
 . . . ;W !
 . . . I +ZVHDATE'=ZVHDATE DO
 . . . . F  S ZVHNUM=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE,ZVHNUM)) Q:ZVHNUM=""  DO
 . . . . . N ZVHFIX S ZVHFIX=+ZVHDATE
 . . . . . W:'SILENT !,ZVHPT,?10,ZVHON,?15,ZVHDATE,?30,ZVHFIX,?50,ZVHNUM,"  "
 . . . . . ; Set the var to re-update fileman
 . . . . . N ZVHFDA S ZVHFDA(53.79,ZVHNUM_",",.13)=ZVHFIX
 . . . . . ZW ZVHFDA
 . . . . . ;BREAK
 . . . . . D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.13) node
 . . . . . I $D(DIERR) DO 
 . . . . . . SET ZVHERR=1,ZVHERR("ZVHFIX","AORD",ZVHPT,ZVHON,ZVHDATE,ZVHFIX,ZVHNUM)=""
 . . . . . . IF 'SILENT DO 
 . . . . . . . ZW ^TMP("DIERR",$J) 
 . . . . . . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 . . . . . . . DO ^DIR W !
 . . . . . . . IF Y(0)="NO" QUIT
 . . . . . I $D(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHFIX,ZVHNUM)) DO
 . . . . . . IF 'SILENT WRITE "X-REF ADDED: " ZW ^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHFIX,ZVHNUM)
 . . . . . . I $D(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE,ZVHNUM)) DO
 . . . . . . . IF 'SILENT DO  
 . . . . . . . . W ! ZW ^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE,ZVHNUM)
 . . . . . . . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="WANT TO KILL THE OLD X-REF?",DIR("B")="YES"
 . . . . . . . . DO ^DIR
 . . . . . . . . IF Y(0)="YES" K ^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE,ZVHNUM)
 . . . . . . . ELSE  K ^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE,ZVHNUM)
 . . . . . E  DO
 . . . . . . Q:SILENT
 . . . . . . W "*** X-REF not added!!! You better check it out!",!!
 . . . . . . N OK R !,"Ctl-C to quit, Enter to continue ",OK
 W:'SILENT !,">>----> END OF AORD",!!
 ;
 QUIT  ; label AORD
 ;
 ;
AORD2(START,END,SILENT) ; silently check the AORD x-ref
 ; Pass by value: START and END dates in fileman format.
 N BADARRAY,ZVHPT,ZVHON,ZVHDATE,ZVHNUM,DIERR S (ZVHPT,ZVHON,ZVHDATE,ZVHNUM)=0
 F  S ZVHPT=$ORDER(^PSB(53.79,"AORD",ZVHPT)) Q:ZVHPT=""  DO
 . ;W ZVHPT
 . F  S ZVHON=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON)) Q:ZVHON=""  DO
 . . ;W ?20,ZVHON
 . . S ZVHDATE=START
 . . F  S ZVHDATE=$O(^PSB(53.79,"AORD",ZVHPT,ZVHON,ZVHDATE)) Q:ZVHDATE=""!(ZVHDATE>END)  DO
 . . . ;W ?30,ZVHDATE
 . . . ;W:+ZVHDATE'=ZVHDATE " STRING"
 . . . ;W !
 . . . I +ZVHDATE'=ZVHDATE DO
 . . . . SET BADARRAY("AORD",ZVHPT,ZVHON,ZVHDATE)=""
 . . ;W !
 ;
 IF $DATA(BADARRAY)>9 DO 
 . IF 'SILENT DO
 . . ZWRITE BADARRAY
 . . WRITE "There are date/times in the ^PSB AORD x-ref that contain a STRING!",!
 . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Do you want to repair them? ",DIR("B")="YES"
 . . DO ^DIR KILL DIR
 . . IF Y(0)="YES" KILL Y DO DOT(SILENT),AORD(SILENT)
 . . ELSE  KILL Y QUIT
 . ELSE  DO DOT(SILENT),AORD(SILENT)
 ;
 QUIT  ; label AORD2
 ;
 ;
AADT(SILENT) ; fix the AADT x-ref of dates recorded as strings
 ; ex: ^PSB(53.79,"AADT",100847,"3131231.1750",1931)=""
 W:'SILENT "============== AADT x-ref ===============",!
 NEW PATIENT,DATETIME,NUM,DIERR SET (PATIENT,DATETIME,NUM)=0
 F  S PATIENT=$ORDER(^PSB(53.79,"AADT",PATIENT)) Q:PATIENT=""  DO
 .;W !,"----------------------------------",!,PATIENT,!
 .F  S DATETIME=$O(^PSB(53.79,"AADT",PATIENT,DATETIME)) Q:DATETIME=""  DO
 ..;ZW DATETIME
 ..I DATETIME'=+DATETIME DO  ; its a string, not a variable
 ...F  S NUM=$O(^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)) Q:NUM=""  DO
 ....N FIX S FIX=+DATETIME
 ....W:'SILENT !,PATIENT,?10,NUM,?15,"OLD:",DATETIME,?40,"NEW:",FIX,?60,NUM,!
 ....; get all the var to re-update fileman
 ....N ZVHFDA S ZVHFDA(53.79,NUM_",",.06)=+FIX
 ....;debug
 ....D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.06) node
 ....;ZW ZVHFDA
 ....;N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 ....;debug
 ....I $D(DIERR) DO 
 .....IF 'SILENT DO  
 ......ZW ^TMP("DIERR",$J) 
 ......NEW DIR,Y SET DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 ......DO ^DIR W !
 ......IF Y(0)="NO" QUIT
 ....E  D
 .....W:'SILENT !,"FIXED: ",! ;ZW ^PSB(53.79,"AADT",PATIENT,FIX,NUM),^PSB(53.79,NUM,.1)
 ....I $D(^PSB(53.79,"AADT",PATIENT,FIX,NUM)) DO
 .....W:'SILENT "X-REF ADDED: " ZW ^PSB(53.79,"AADT",PATIENT,FIX,NUM)
 .....I $D(^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)) DO
 ......W:'SILENT "OLD:" ZW ^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)
 ......;W !,"WANT TO KILL THE OLD X-REF? (YES/NO)"
 ......;NEW YESKILL READ YESKILL
 ......;IF YESKILL="YES" K ^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)
 ......K ^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)
 ....E  DO
 .....SET ZVHERR=1,ZVHERR("ZVHFIX","AADT",PATIENT,DATETIME,FIX,NUM)=""
 .....IF 'SILENT DO  
 ......W "*** X-REF not added!!! You better check it out!",!!
 ......NEW DIR,Y SET DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 ......DO ^DIR W !
 ......IF Y(0)="NO" QUIT
 W:'SILENT !,">>----> END OF AADT",!!
 QUIT  ; label AADT
 ;
 ;
AADT2(SILENT) ; Silently check the AADT x-ref for dates recorded as strings
 NEW BADARRAY,PATIENT SET PATIENT=0
 F  S PATIENT=$ORDER(^PSB(53.79,"AADT",PATIENT)) Q:PATIENT=""  DO
 . ;W !,"----------------------------------",!,PATIENT,!
 . NEW DATETIME S DATETIME=""
 . F  S DATETIME=$O(^PSB(53.79,"AADT",PATIENT,DATETIME),-1) Q:'DATETIME  DO
 . . ;ZW DATETIME
 . . I DATETIME'=+DATETIME DO  ; its a string, not a variable
 . . . SET BADARRAY("AADT",PATIENT,DATETIME)=""
 ;
 IF $DATA(BADARRAY)>9 DO 
 . IF 'SILENT DO
 . . ZWRITE BADARRAY
 . . WRITE "There are date/times in the ^PSB AADT x-ref that contain a STRING!",!
 . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Do you want to repair them? ",DIR("B")="YES"
 . . DO ^DIR KILL DIR
 . . IF Y(0)="YES" KILL Y DO AADT(SILENT)
 . . ELSE  KILL Y QUIT
 . ELSE  DO AADT(SILENT)
 ;
 QUIT  ; label AADT2
 ;
 ;
AEDT(SILENT) ; fix the AEDT x-ref of dates recorded as strings
 ; ex: ^PSB(53.79,"AEDT",100847,"3131001.2140",567)=""
 W:'SILENT "================== AEDT X-ref ==================",!
 NEW DFN SET DFN=0
 FOR  SET DFN=$O(^PSB(53.79,"AEDT",DFN)) QUIT:DFN=""  DO
 . ;WRITE !,"----------------- Patient: ",DFN," -----------------",!
 . NEW DATETIME SET DATETIME=0
 . FOR  SET DATETIME=$O(^PSB(53.79,"AEDT",DFN,DATETIME)) Q:DATETIME=""  DO
 . . IF DATETIME'=+DATETIME DO  ; its a string
 . . . W:'SILENT "STRING!!!  ",DATETIME,!
 . . . ; fix fileman first
 . . . NEW IEN SET IEN=0
 . . . FOR  SET IEN=$O(^PSB(53.79,"AEDT",DFN,DATETIME,IEN)) QUIT:IEN=""  DO  
 . . . . N FIX S FIX=+DATETIME
 . . . . W:'SILENT !,?5,IEN,?15,"OLD:",DATETIME,?40,"NEW:",FIX,!
 . . . . N ZVHFDA S ZVHFDA(53.79,IEN_",",.04)=+FIX ;ZW ZVHFDA
 . . . . D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.04) node
 . . . . ;debug
 . . . . ;N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 . . . . ;debug
 . . . . I $D(DIERR) DO 
 . . . . . SET ZVHERR=1,ZVHERR("ZVHFIX","AEDT",DFN,DATETIME,IEN)=""
 . . . . . IF 'SILENT DO  
 . . . . . . ZW ^TMP("DIERR",$J) 
 . . . . . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 . . . . . . DO ^DIR W !
 . . . . . . IF Y(0)="NO" QUIT
 . . . . E  D
 . . . . . W:'SILENT !,"FIXED: " ;,$G(^PSB(53.79,"AEDT",DFN,FIX,IEN)),!,$G(^PSB(53.79,IEN,.1)),!
 . . . . ; check for correct AEDT x-ref - set if not there
 . . . . I '$D(^PSB(53.79,"AEDT",DFN,FIX,IEN)) S ^PSB(53.79,"AEDT",DFN,FIX,IEN)=""
 . . . . I $D(^PSB(53.79,"AEDT",DFN,FIX,IEN)) DO
 . . . . . IF 'SILENT W "X-REF ADDED: " ZW ^PSB(53.79,"AEDT",DFN,FIX,IEN)
 . . . . . I $D(^PSB(53.79,"AEDT",DFN,DATETIME,IEN)) DO
 . . . . . . IF 'SILENT W !,"OLD X-REF: " ZW ^PSB(53.79,"AEDT",DFN,DATETIME,IEN)
 . . . . . . ;W !,"WANT TO KILL THE OLD X-REF? (YES/NO)"
 . . . . . . ;NEW YESKILL READ YESKILL
 . . . . . . ;IF YESKILL["Y" K ^PSB(53.79,"AEDT",DFN,DATETIME,IEN)
 . . . . . . K ^PSB(53.79,"AEDT",DFN,DATETIME,IEN)
 . . . . E  DO
 . . . . . QUIT:SILENT
 . . . . . W "*** X-REF not added!!! You better check it out!",!!
 . . . . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 . . . . . DO ^DIR W !
 . . . . . IF Y(0)="NO" QUIT
 W:'SILENT !,">>----> END OF AEDT",!!
 ;
 QUIT  ; label AEDT
 ;
 ;
AEDT2(SILENT)   ; silently check the AEDT x-ref for dates recorded as strings
 NEW DFN,BADARRAY SET DFN=0
 FOR  SET DFN=$O(^PSB(53.79,"AEDT",DFN)) QUIT:DFN=""  DO
 . ;WRITE !,"----------------- Patient: ",DFN," -----------------"
 . NEW DATETIME SET DATETIME=""
 . FOR  SET DATETIME=$O(^PSB(53.79,"AEDT",DFN,DATETIME),-1) Q:'DATETIME  DO
 . . ;W !,DATETIME
 . . IF DATETIME'=+DATETIME DO  ; its a string
 . . . ;W "  STRING!"
 . . . SET BADARRAY("AEDT",DFN,DATETIME)=""
 ;
 IF $DATA(BADARRAY)>9 DO 
 . IF 'SILENT DO
 . . ZWRITE BADARRAY
 . . WRITE "There are date/times in the ^PSB AEDT x-ref that contain a STRING!",!
 . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Do you want to repair them? ",DIR("B")="YES"
 . . DO ^DIR KILL DIR
 . . IF Y(0)="YES" KILL Y DO AEDT(SILENT)
 . . ELSE  KILL Y QUIT
 . ELSE  DO AEDT(SILENT)
 ;
 QUIT  ; label AEDT2
 ;
 ;
TIMECK(SILENT) ; check the time for bad entries caused by dropped zeros
 NEW I,BADARRAY SET BADARRAY="",I=0
 FOR  SET I=$ORDER(^PSB(53.79,I)) QUIT:'I  DO  ;
 . NEW DATETIME SET DATETIME=$P(^PSB(53.79,I,0),"^",4)
 . NEW TIME SET TIME=$P(DATETIME,".",2)
 . ;check the hours
 . IF +TIME=0 WRITE:'SILENT "." QUIT  ; midnight, leave as zero
 . IF $L(TIME)>6 SET BADARRAY(I)=DATETIME WRITE:'SILENT "*" QUIT  ; too long
 . IF $L(TIME)=1&(TIME>2) SET BADARRAY(I)=DATETIME WRITE:'SILENT "*" QUIT  ; 2 digit can only be 10:00 or 20:00
 . IF $E(TIME,1,2)>23 SET BADARRAY(I)=DATETIME WRITE:'SILENT "*" QUIT
 . ELSE  DO  ; hours OK, check minutes
 . . IF $L(TIME)<3 WRITE:'SILENT "." QUIT  ; length less then 3, no minutes
 . . NEW MINUTES SET MINUTES=$E(TIME,3,4)
 . . IF MINUTES>59 SET BADARRAY(I)=DATETIME WRITE:'SILENT "." QUIT
 . . ELSE  DO  ; minutes ok, check seconds
 . . . IF $L(TIME)<5 WRITE:'SILENT "." QUIT  ; length less then 5, no seconds
 . . . NEW SECONDS SET SECONDS=$E(TIME,5,6)
 . . . IF SECONDS>59 SET BADARRAY(I)=DATETIME WRITE:'SILENT "*" QUIT
 . . . ELSE  WRITE:'SILENT "." QUIT  ;
 W:'SILENT !
 IF $DATA(BADARRAY)>9 DO
 . IF 'SILENT DO  
 . . ZWRITE BADARRAY
 . . NEW DIR,Y SET DIR(0)="Y",DIR("B")="YES"
 . . SET DIR("A")="  Are ALL of the listed errors missing the leading zero of the time?  AND do you WANT to fix them right now?  Y or N:"
 . . DO ^DIR W !
 . . IF Y(0)="NO" QUIT
 . IF SILENT!(Y(0)="YES") DO  ; if this is a silent check, we have to assume yes...
 . . ;debug BREAK
 . . NEW IEN SET IEN=0
 . . FOR  SET IEN=$ORDER(BADARRAY(IEN)) QUIT:IEN=""  DO
 . . . NEW DATETIME SET DATETIME=BADARRAY(IEN)
 . . . NEW ZVHFDA
 . . . SET ZVHFDA(53.79,IEN_",",.04)=$P(DATETIME,".")_"."_0_$P(DATETIME,".",2)
 . . . SET ZVHFDA(53.79,IEN_",",.06)=$P(DATETIME,".")_"."_0_$P(DATETIME,".",2)
 . . . IF 'SILENT ZW DATETIME,IEN,ZVHFDA
 . . . ;debug BREAK
 . . . DO FILE^DIE("","ZVHFDA","")
 . . . IF $D(DIERR) DO  
 . . . . SET ZVHERR=1,ZVHERR("ZVHFIX","TIMECHK",DATETIME,IEN)=""
 . . . . IF 'SILENT ZW ^TMP("DIERR",$J) N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 . . . ELSE  IF 'SILENT ZW ^PSB(53.79,IEN,0)
 ;
 QUIT  ; label TIMECK
 ;
 ;
TIME2(SILENT)   ; Silently check the time
 NEW IEN,BADARRAY SET BADARRAY="",IEN=0
 FOR  SET IEN=$ORDER(^PSB(53.79,IEN)) QUIT:'IEN  DO  ;
 . NEW DATETIME SET DATETIME=$P(^PSB(53.79,IEN,0),"^",4)
 . NEW TIME SET TIME=$P(DATETIME,".",2)
 . ;W !,IEN,?10,DATETIME,?27,TIME
 . ;check the hours
 . IF +TIME=0 QUIT  ; midnight, leave as zero
 . IF $L(TIME)>6 SET BADARRAY(IEN)=DATETIME QUIT  ; too long
 . IF $L(TIME)=1&(TIME>2) SET BADARRAY(IEN)=DATETIME QUIT  ; 2 digit can only be 10:00 or 20:00
 . IF $E(TIME,1,2)>23 SET BADARRAY(IEN)=DATETIME QUIT
 . ELSE  DO  ; hours OK, check minutes
 . . IF $L(TIME)<3 QUIT  ; length less then 3, no minutes
 . . NEW MINUTES SET MINUTES=$E(TIME,3,4)
 . . ;W ?35,MINUTES
 . . IF MINUTES>59 SET BADARRAY(IEN)=DATETIME QUIT
 . . ELSE  DO  ; minutes ok, check seconds
 . . . IF $L(TIME)<5 QUIT  ; length less then 5, no seconds
 . . . NEW SECONDS SET SECONDS=$E(TIME,5,6)
 . . . ;W ?40,SECONDS
 . . . IF SECONDS>59 SET BADARRAY(IEN)=DATETIME QUIT
 . . . ELSE  QUIT  ;
 ;
 IF $DATA(BADARRAY)>9 DO 
 . IF 'SILENT DO
 . . ZWRITE BADARRAY
 . . WRITE "There are time related errors in the ^PSB array!",!
 . . NEW DIR,Y SET DIR(0)="Y",DIR("A")="  Do you want to repair them? ",DIR("B")="YES"
 . . DO ^DIR KILL DIR
 . . IF Y(0)="YES" KILL Y DO TIMECK(SILENT)
 . . ELSE  KILL Y QUIT
 . ELSE  DO TIMECK(SILENT)
 ;
 QUIT  ; label TIME2
 ;
 ;
  ;===========================================================
LNGDT(SILENT,ZVHFILE,ZVHDUZ) ; ENTRY TO FIX LONG DATES
 D AADTLD(SILENT)
 D AINJOILD(SILENT)
 D AOIPLD(SILENT)
 D AINJLD(SILENT)
 D AEDTLD(SILENT)
 D AINFUSING(SILENT,ZVHFILE,ZVHDUZ)
 ;
AADTLD(SILENT) ; fix the AADT x-ref  with long dates
 ; ex: ^PSB(53.79,"AADT",100847,"3131231.1750",1931)=""
 W:'SILENT "============== AADT x-ref ===============",!
 N PATIENT,DATETIME,NUM,DIERR S (PATIENT,DATETIME,NUM,TIME,DATE)=0
 F  S PATIENT=$O(^PSB(53.79,"AADT",PATIENT)) Q:PATIENT=""  D
 .;W !,"----------------------------------",!,PATIENT,!
 .F  S DATETIME=$O(^PSB(53.79,"AADT",PATIENT,DATETIME)) Q:DATETIME=""  D
 .. I $L(DATETIME)>14 D
 ... F  S NUM=$O(^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)) Q:NUM=""  D
 .... N TIME S TIME=$E($P(DATETIME,".",2),1,6)
 .... I +TIME=0 S TIME="0001"
 .... N DATE S DATE=$P(DATETIME,".",1)
 .... N FIX S FIX=DATE_"."_TIME
 .... W:'SILENT +FIX,!  ;BUG
 .... W:'SILENT !,PATIENT,?10,NUM,?15,"OLD:",DATETIME,!,"NEW:",+FIX,?60,NUM,!
 ....; get all the var to re-update fileman
 ....N ZVHFDA S ZVHFDA(53.79,NUM_",",.06)=+FIX
 ....; BREAK ; D FILE^DIE debug
 ....D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.06) node
 ....;ZW ZVHFDA
 ....; BREAK ;debug
 ....I $D(DIERR) ZW:'SILENT ^TMP("DIERR",$J) N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 ....I $D(DIERR) D:'SILENT
 .....ZW ^TMP("DIERR",$J) 
 .....N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 .....D ^DIR W !
 .....I Y(0)="NO" Q
 ....E  D:'SILENT
 .....W !,"FIXED: ",! ;
 ....I $D(^PSB(53.79,"AADT",PATIENT,+FIX,NUM)) D
 .....W:'SILENT "X-REF ADDED: " ZW:'SILENT ^PSB(53.79,"AADT",PATIENT,+FIX,NUM)
 .....I $D(^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)) D
 ......W:'SILENT "OLD:" ZW:'SILENT ^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)
 ......K ^PSB(53.79,"AADT",PATIENT,DATETIME,NUM)
 ....E  D:'SILENT
 .....W "*** X-REF not added!!! You better check it out!",!!
 .....N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 .....D ^DIR W !
 .....I Y(0)="NO" Q
 W:'SILENT !,">>----> END OF AADT",!!
 Q  ; label AADTTL
 ;
AINJOILD(SILENT) ; fix the AINJOI x-ref  with long dates
 ; ex: ^PSB(53.79,"AINJOI",100085,1757,"3140426.0000009371714","IV",7160)=""
 W:'SILENT "============== AINJOI x-ref ===============",!
 N PATIENT,DATETIME,NUM,DIERR,ZVHOI S (PATIENT,DATETIME,NUM,TIME,DATE,ZVHOI)=0
 F  S PATIENT=$O(^PSB(53.79,"AINJOI",PATIENT)) Q:PATIENT=""  D
 . W:'SILENT !,"----------------------------------",!,PATIENT,!
 . ;PATIENT
 . F  S ZVHOI=$O(^PSB(53.79,"AINJOI",PATIENT,ZVHOI)) Q:ZVHOI=""  D
 .. ;B ; ZVHOI
 .. F  S DATETIME=$O(^PSB(53.79,"AINJOI",PATIENT,ZVHOI,DATETIME)) Q:DATETIME=""  D
 ...; B;DATETIME
 ... I $L(DATETIME)>14 D
 .... W:'SILENT DATETIME,!
 .... N TIME S TIME=$E($P(DATETIME,".",2),1,6)
 .... I +TIME=0 S TIME="0001"
 .... N DATE SET DATE=$P(DATETIME,".",1)
 .... N FIX SET FIX=DATE_"."_TIME
 .... W:'SILENT +FIX,!  ;BUG
 .... S NUM=$O(^PSB(53.79,"AINJOI",PATIENT,ZVHOI,DATETIME,"IV",NUM)) Q:NUM=""
 .... W:'SILENT !,PATIENT,?10,NUM,?15,"OLD:",DATETIME,!,"NEW:",+FIX,?60,NUM,!
 .... ;get all the var to re-update fileman
 .... N ZVHFDA S ZVHFDA(53.79,NUM_",",.06)=+FIX
 .... ;BREAK ; D FILE^DIE debug
 .... D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.06) node
 .... ;ZW ZVHFDA
 .... ;BREAK ;DIERR
 .... I $D(DIERR) ZW:'SILENT ^TMP("DIERR",$J) N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 .... I $D(DIERR) DO 
 ..... ZW ^TMP("DIERR",$J) 
 ..... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 ..... D ^DIR W !
 ..... I Y(0)="NO" Q
 .... E  D
 ..... W:'SILENT !,"FIXED: ",! ;
 .... I $D(^PSB(53.79,"AINJOI",PATIENT,ZVHOI,+FIX,"IV",NUM)) D
 ..... W:'SILENT "X-REF ADDED: " ZW:'SILENT ^PSB(53.79,"AINJOI",PATIENT,ZVHOI,+FIX,"IV",NUM)
 ..... I $D(^PSB(53.79,"AINJOI",PATIENT,ZVHOI,DATETIME,"IV",NUM)) D
 ...... W:'SILENT "OLD:" ZW:'SILENT ^PSB(53.79,"AINJOI",PATIENT,ZVHOI,DATETIME,"IV",NUM)
 ...... K ^PSB(53.79,"AINJOI",PATIENT,ZVHOI,DATETIME,"IV",NUM)
 .... E  D:'SILENT
 ..... W:'SILENT "*** X-REF not added!!! You better check it out!",!!
 ..... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 ..... D ^DIR W !
 ..... I Y(0)="NO" Q
 W:'SILENT !,">>----> END OF AINJOI",!!
 Q  ; label AINJOI
 ;
AOIPLD(SILENT)  ;fix the AEDT x-ref with long dates 
 ;^PSB(53.79,"AEDT",100085,"3140426.0011571714286",7431)=""
 W:'SILENT "============== AEDT x-ref ===============",!
 N PATIENT,DATETIME,NUM,DIERR S (PATIENT,DATETIME,NUM,TIME,DATE)=0
 F  S PATIENT=$O(^PSB(53.79,"AEDT",PATIENT)) Q:PATIENT=""  D
 .;W !,"----------------------------------",!,PATIENT,!
 .F  S DATETIME=$O(^PSB(53.79,"AEDT",PATIENT,DATETIME)) Q:DATETIME=""  D
 .. I $L(DATETIME)>14 D
 ... F  S NUM=$O(^PSB(53.79,"AEDT",PATIENT,DATETIME,NUM)) Q:NUM=""  D
 ...; BREAK ;DATETIME
 ... I $L(DATETIME)>14 D
 ....W:'SILENT DATETIME,!
 .... N TIME S TIME=$E($P(DATETIME,".",2),1,6)
 .... I +TIME=0 S TIME="0001"
 .... N DATE S DATE=$P(DATETIME,".",1)
 .... N FIX S FIX=DATE_"."_TIME
 ....W:'SILENT +FIX,!  ;BUG
 .... S NUM=$O(^PSB(53.79,"AOIP",PATIENT,ZVHOI,DATETIME,NUM)) Q:NUM=""
 ....W:'SILENT !,PATIENT,?10,NUM,?15,"OLD:",DATETIME,!,"NEW:",+FIX,?60,NUM,!
 .... ;get all the var to re-update fileman
 .... N ZVHFDA S ZVHFDA(53.79,NUM_",",.06)=+FIX
 .... ;B ; D FILE^DIE debug
 .... D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.06) node
 .... ;ZW ZVHFDA
 .... ;BREAK ;DIERR
 .... I $D(DIERR) ZW:'SILENT ^TMP("DIERR",$J) N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 .... I $D(DIERR) D:'SILENT
 ..... ZW ^TMP("DIERR",$J) 
 ..... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 ..... D ^DIR W !
 ..... I Y(0)="NO" Q
 .... E  D
 ..... W:'SILENT !,"FIXED: ",! ;
 .... I $D(^PSB(53.79,"AOIP",PATIENT,ZVHOI,+FIX,NUM)) D
 ..... W:'SILENT "X-REF ADDED: " ZW ^PSB(53.79,"AOIP",PATIENT,ZVHOI,+FIX,NUM)
 ..... W:'SILENT PATIENT,!
 ..... I $D(^PSB(53.79,"AOIP",PATIENT,ZVHOI,DATETIME,NUM)) D
 ......W:'SILENT "OLD:" ZW:'SILENT ^PSB(53.79,"AOIP",PATIENT,ZVHOI,DATETIME,NUM)
 ...... K ^PSB(53.79,"AOIP",PATIENT,ZVHOI,DATETIME,NUM)
 .... E  D:'SILENT
 ..... W "*** X-REF not added!!! You better check it out!",!!
 ..... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 ..... D ^DIR W !
 ..... I Y(0)="NO" Q
 W:'SILENT !,">>----> END OF AOIP",!!
 Q  ; label AOIP
 ;
AINJLD(SILENT) ;  fix the AINJ x-ref of dates recorded as strings
 ; ex: ^PSB(53.79,"AINJ",100085,"3140426.0000009371714","IV",7160)=""
 W:'SILENT "============== AINJ x-ref ===============",!
 N PATIENT,DATETIME,NUM,DIERR,ZVHOI S (PATIENT,DATETIME,NUM,TIME,DATE,ZVHOI)=0
 F  S PATIENT=$O(^PSB(53.79,"AINJ",PATIENT)) Q:PATIENT=""  D
 .W:'SILENT !,"----------------------------------",!,PATIENT,!
 . ;PATIENT
 . F  S DATETIME=$O(^PSB(53.79,"AINJ",PATIENT,DATETIME)) Q:DATETIME=""  D
 ..; BREAK ;DATETIME
 .. I $L(DATETIME)>14 D
 ...W:'SILENT DATETIME,!
 ... N TIME S TIME=$E($P(DATETIME,".",2),1,6)
 ... I +TIME=0 S TIME="0001"
 ... N DATE SET DATE=$P(DATETIME,".",1)
 ... N FIX SET FIX=DATE_"."_TIME
 ... W:'SILENT +FIX,!  ;BUG
 ... S NUM=$O(^PSB(53.79,"AINJ",PATIENT,DATETIME,"IV",NUM)) Q:NUM=""
 ... W:'SILENT !,PATIENT,?10,NUM,?15,"OLD:",DATETIME,!,"NEW:",+FIX,?60,NUM,!
 ... ;get all the var to re-update fileman
 ... N ZVHFDA S ZVHFDA(53.79,NUM_",",.06)=+FIX
 ... ;BREAK ; D FILE^DIE debug
 ... D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.06) node
 ... ;B ;DIERR
 ... I $D(DIERR) ZW:'SILENT ^TMP("DIERR",$J) N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 ... I $D(DIERR) D:'SILENT 
 .... ZW ^TMP("DIERR",$J) 
 .... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 .... D ^DIR W !
 .... I Y(0)="NO" Q
 ... E  D
 ....W:'SILENT !,"FIXED: ",! ;
 ... I $D(^PSB(53.79,"AINJ",PATIENT,+FIX,"IV",NUM)) D
 ....W:'SILENT "X-REF ADDED: " ZW ^PSB(53.79,"AINJ",PATIENT,+FIX,"IV",NUM)
 .... I $D(^PSB(53.79,"AINJ",PATIENT,DATETIME,"IV",NUM)) D
 .....W:'SILENT "OLD:" ZW:'SILENT ^PSB(53.79,"AINJ",PATIENT,DATETIME,"IV",NUM)
 ..... K ^PSB(53.79,"AINJ",PATIENT,DATETIME,"IV",NUM)
 ... E  D:'SILENT
 .... W "*** X-REF not added!!! You better check it out!",!!
 .... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 .... D ^DIR W !
 .... I Y(0)="NO" Q
 W:'SILENT !,">>----> END OF AINJ",!!
 Q  ; label AINJ
 ;
AEDTLD(SILENT)  ; fix the AEDT x-ref with long dates 
 ;^PSB(53.79,"AEDT",100085,"3140426.0011571714286",7431)=""
 W:'SILENT "============== AEDT x-ref ===============",!
 N PATIENT,DATETIME,NUM,DIERR S (PATIENT,DATETIME,NUM,TIME,DATE)=0
 F  S PATIENT=$O(^PSB(53.79,"AEDT",PATIENT)) Q:PATIENT=""  D
 .;W !,"----------------------------------",!,PATIENT,!
 .F  S DATETIME=$O(^PSB(53.79,"AEDT",PATIENT,DATETIME)) Q:DATETIME=""  D
 .. I $L(DATETIME)>14 D
 ... F  S NUM=$O(^PSB(53.79,"AEDT",PATIENT,DATETIME,NUM)) Q:NUM=""  D
 .... N TIME S TIME=$E($P(DATETIME,".",2),1,6)
 .... I +TIME=0 S TIME="0001"
 .... N DATE S DATE=$P(DATETIME,".",1)
 .... N FIX S FIX=DATE_"."_TIME
 ....W:'SILENT +FIX,!  ;BUG
 ....W:'SILENT !,PATIENT,?10,NUM,?15,"OLD:",DATETIME,!,"NEW:",+FIX,?60,NUM,!
 .... ; get all the var to re-update fileman
 .... N ZVHFDA S ZVHFDA(53.79,NUM_",",.04)=+FIX
 .... ZW
 .... ;B; D FILE^DIE debug
 .... D FILE^DIE("","ZVHFDA","") ; updates the file, and the ^psb(53.79,ien,.06) node
 .... ZW:'SILENT ZVHFDA
 .... ZW:'SILENT DATETIME,IEN,ZVHFDA
 .... ;BREAK
 .... I $D(DIERR) ZW:'SILENT ^TMP("DIERR",$J) N OK R !,"Ctl-C to quit, Enter to continue ",OK,!
 .... I $D(DIERR) D:'SILENT
 ..... ZW ^TMP("DIERR",$J) 
 ..... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue ",DIR("B")="YES"
 ..... D ^DIR W !
 ..... I Y(0)="NO" Q
 .... E  D
 .....W:'SILENT !,"FIXED: ",! ;
 .... I $D(^PSB(53.79,"AEDT",PATIENT,+FIX,NUM)) D
 .....W:'SILENT "X-REF ADDED: " ZW:'SILENT ^PSB(53.79,"AEDT",PATIENT,+FIX,NUM)
 ..... I $D(^PSB(53.79,"AEDT",PATIENT,DATETIME,NUM)) D
 ......W:'SILENT "OLD:" ZW:'SILENT ^PSB(53.79,"AEDT",PATIENT,DATETIME,NUM)
 ...... K ^PSB(53.79,"AEDT",PATIENT,DATETIME,NUM)
 .... E  D:'SILENT
 .....W:'SILENT "*** X-REF not added!!! You better check it out!",!!
 ..... N DIR,Y S DIR(0)="Y",DIR("A")="Ctl-C to quit, Yes to continue",DIR("B")="YES"
 ..... D ^DIR W !
 ..... I Y(0)="NO" Q
 W:'SILENT !,">>----> END OF AEDT",!!
 Q  ; label AEDT
 ;
AINFUSING(SILENT,ZVHFILE)  ;   fix the AINFUSING x-ref  with completed order listed as infusing
 D ZVHAI 
 W:'SILENT "============== AINFUSING x-ref ===============",!
 N ZPATIENT,ZADAT,ZNUM,DIERR,ZRATE,ZVOL,ZIVET,ZVHERR S (ZPATIENT,ZADAT,ZNUM,ZRATE,ZVOL,ZIVET,ZVHERR)=""
 F  S ZPATIENT=$O(^PSB(53.79,"AINFUSING",ZPATIENT)) Q:'ZPATIENT  D
 . W:'SILENT "ZPATIENT: ",ZPATIENT
 . F  S ZADAT=$O(^PSB(53.79,"AINFUSING",ZPATIENT,ZADAT)) Q:ZADAT=""  D ; START DATE OF ORDER
 .. F  S ZNUM=$O(^PSB(53.79,"AINFUSING",ZPATIENT,ZADAT,ZNUM)) Q:ZNUM=""  D
 ... S ZRATE=$P(^PSB(53.79,ZNUM,0),U,11) ;="25^7 NORTH SURGERY 710-B^21788^3140515.0108^20195^3140515.0108^20195^513^C^25V5^125 ml/hr"
 ... W:'SILENT "ZPT:  ",ZPATIENT,!       ;.1)="2V^C^^^^IV";
 ... W:'SILENT "ZNUM: ",ZNUM,! ; DEBUB 
 ... I $D(^PSB(53.79,ZNUM,.7,1,0))  D
 .... S ZVOL=$P(^PSB(53.79,ZNUM,.7,1,0),U,3)  ;="DEXTROSE 5%/0.2% SOD CHLORIDE^1000 ML^1000 ML"
 .... W:'SILENT "ZVOL: ",ZVOL,!,"ZRATE: ",ZRATE,!
 .... S ZIVET=(+ZVOL)/(+ZRATE)
 .... I ZIVET'>0 SET ZVHERR=1 Q
 .... S ZIVET=$E((ZIVET),-1,3)
 ... W:'SILENT "ZIVET: ",ZIVET,!,"ZADAT: ",ZADAT,!  ; DEBUG 
 ... N ZVHIVSD SET ZVHIVSD=$$FMADD^XLFDT(ZADAT,0,(+ZIVET),0,0)
 ... I ZVHIVSD="" SET ZVHERR=1
 ... W:'SILENT "ZVHIVSD: ",ZVHIVSD,!,"NOW: ",$$NOW^XLFDT,!  ;DEBUG
 ... I ZVHIVSD'>$$NOW^XLFDT Q:ZVHIVSD>$$NOW^XLFDT  D
 .... N ZVHFDAF ; fileman data array for the infusing IV bag we will remove
 .... S ZVHFDAF(53.79,ZNUM_",",.09)="C" ; set to status=Completed
 .... K:$D(^PSB(53.79,"AINFUSING",ZPATIENT,ZADAT,ZNUM)) ^PSB(53.79,"AINFUSING",ZPATIENT,ZADAT,ZNUM)
 .... D:ZVHFILE FILE^DIE("","ZVHFDAF","ZVHERR") ; save the data
 .... D:ZVHFILE AUDIT^ZVHBC2(ZNUM,53.79,.09,"C","S",ZADAT,ZVHDUZ) ; (PSBREC,PSBDD,PSBFLD,PSBDATA,PSBSK,AADT,ZVHDUZ)
 .... I $D(DIERR) DO  QUIT  
 ..... S MED=$P(PSB(53.79,ZNUM,.7,1,0),"^",1) ;PSB(53.79,6645,.7,1,0
 ..... S (ERROR,ZVHERR)=1 
 ..... S ZVHERR("AINFU",ZVHPT,ZVHIVED,ZNUM,MED,ZVHDUZ)=""
 ..... MERGE ZVHERR("IV marked as infusing","DIERR",ZPATIENT,ZVHIVSD,ZNUM,ZON)=^TMP("DIERR")
 .... I $D(^PSB(53.79,"AINFUSING",ZPATIENT,ZADAT,ZNUM)) D:'SILENT
 ..... W:'SILENT "X-REF not removed: ",! ZW:'SILENT ^PSB(53.79,"AINFUSING",ZPATIENT,ZADAT,ZNUM)
 ... ;AINFUSING setup for infusing orders                                  Set Logic:  
 ... I ZVHIVSD>$$NOW^XLFDT D
 .... N ZVHFDAF ; fileman data array for the infusing IV bag we will remove
 .... S ZVHFDAF(53.79,ZNUM_",",.09)="I" ; set to status=INFUSING
 .... D:ZVHFILE FILE^DIE("","ZVHFDAF","ZVHERR") ; save the data
 .... D:ZVHFILE AUDIT^ZVHBC2(ZNUM,53.79,.09,"I","S",ZADAT,ZVHDUZ) ; (PSBREC,PSBDD,PSBFLD,PSBDATA,PSBSK,AADT,ZVHDUZ)
 .... I $D(DIERR) DO  QUIT  
 ..... S MED=$P(PSB(53.79,ZNUM,.7,1,0),"^",1) ;PSB(53.79,6645,.7,1,0
 ..... S (ERROR,ZVHERR)=1 
 ..... S ZVHERR("AINFU",ZVHPT,ZVHIVED,ZNUM,MED,ZVHDUZ)=""
 ..... MERGE ZVHERR("IV marked as infusing","DIERR",ZPATIENT,ZVHIVSD,ZNUM,ZON)=^TMP("DIERR")
 ... I $P(^PSB(53.79,ZNUM,0),U,9)="I"  D 
 .... W:'SILENT "AINFUSING X-REF SET",! ;
 W:'SILENT !,">>----> END OF AINFUSING",!!
 Q  ; label AINFUSING
        ;
ZVHAI    ; 
        ;Look for IV globalS with "I" infusing indicators and sets the AINFUSING X REF. use AINFUSING to validate the reference
 N ZSTAT,ZVHADAT,ZVNUM,ZVPAT S (ZVNUM,ZVPAT,ZVHADAT,ZSTAT)=""
 F ZVNUM=1:1 S ZVNUM=$O(^PSB(53.79,ZVNUM)) Q:'ZVNUM  D
 . Q:ZVNUM["A" ;W NUM
 . Q:ZVNUM="B" ;B
 . Q:$P(^PSB(53.79,ZVNUM,0),U,9)'="I"  W:'SILENT "Quitting ZVHAI ",!  ;
 . W:'SILENT ?3,ZVNUM," ",!
 . S ZVPAT=$P(^PSB(53.79,ZVNUM,0),U,1)   ;^PSB(53.79,7157,0)="100093^ZZBCMA 11-I^500^3140610.1535^20189^3140610.1535^20189^1758^C^100093V12^42 ml/hr"
 . S ZVHADAT=$P(^PSB(53.79,ZVNUM,0),U,6)
 . S ZSTAT=$P(^PSB(53.79,ZVNUM,0),U,9)
 . W:'SILENT "Order status: ", ZSTAT,! ; debug
 . I ZSTAT="I" Q:ZSTAT'="I"  D
 . . I '$D(^PSB(53.79,"AINFUSING",ZVPAT,ZVHADAT,ZVNUM)) S ^PSB(53.79,"AINFUSING",ZVHPAT,ZVHADAT,ZVNUM)=""
 . . W:'SILENT ^PSB(53.79,"AINFUSING",ZVPAT,ZVHADAT,ZVNUM) ;
 . I $P(^PSB(53.79,ZVNUM,0),U,9)'="I" D 
 .. K ^PSB(53.79,"AINFUSING",ZVPAT,ZVHADAT,ZVNUM)
 . N ZPT1,ZPT2,SNUM S (ZPT1,ZPT2,SNUM)=""
 . F  S ZPT1=$O(^PSB(53.79,"AINFUSING",ZPT1)) Q:'ZPT1  D 
 .. F  S ZPT2=$O(^PSB(53.79,"AINFUSING",ZPT1,ZPT2)) Q:'ZPT2  D
 ... F  S SNUM=$O(^PSB(53.79,"AINFUSING",ZPT1,ZPT2,SNUM)) Q:'SNUM  D
 .... I ZPT1=ZPT2 K ^PSB(53.79,"AINFUSING",ZPT1,ZPT2,SNUM)
 Q ; LABEL ZVHAI
 ;
 ;
IVSTRNG(FIXALL) ; find and repair strings in the IV solutions and additives
 ; pass by value: FIXALL if fixall=1, user will not be prompted for each item
 ; bad example:
 ;^PSB(53.79,839,0)="237^NHCU NH12-B^500^3140130.095^20174^3140130.095^20174^1309^G^237V55"
 ;^PSB(53.79,839,.1)="13V^C^3140130.09^50^^IV"
 ;^PSB(53.79,839,.6,0)="^53.796P^1^1"
 ;^PSB(53.79,839,.6,1,0)="VANCOMYCIN INJ^1000 MG^1000 MG"
 ;^PSB(53.79,839,.6,"B","VANCOMYCIN INJ",1)=""
 ;^PSB(53.79,839,.7,0)="^53.797P^1^1"
 ;^PSB(53.79,839,.7,1,0)="DEXTROSE 5% IN WATER^250 ML^250 ML"
 ;^PSB(53.79,839,.7,"B","DEXTROSE 5% IN WATER",1)=""
 ;good example:
 ;^PSB(53.79,674,0)="237^MEDICAL INTENSIVE CARE UNIT ICU-29^500^3140813.112215^1108^3140813.112215^1108^2604^I^237V264^125 ml/hr"
 ;^PSB(53.79,674,.1)="14V^C^^^^IV/LOCK"
 ;^PSB(53.79,674,.7,0)="^53.797P^1^1"
 ;^PSB(53.79,674,.7,1,0)="97^D-5/0.45% NACL 20MEQ KCL^1000 ML^^0"
 ;^PSB(53.79,674,.7,"B",97,1)=""
 ;
 NEW PSBIEN,SOLUTION,ADDITIVE,DONE,EXIT,NOTFIXED SET (PSBIEN,SOLUTION,ADDITIVE)="" SET (DONE,EXIT)=0
 SET NOTFIXED="ARRAY OF ENTRIES NOT FIXED"
 FOR  SET PSBIEN=$ORDER(^PSB(53.79,PSBIEN)) QUIT:(PSBIEN="")!(PSBIEN'?.N)  DO  ; get ien for the PSB entry
 . ;W PSBIEN,! ; debug
 . ;get the string from the .6,num,0 sub
 . NEW ADDIEN SET ADDIEN=0 ; IEN of the additive subfile of the psb file 
 . FOR  SET ADDIEN=$ORDER(^PSB(53.79,PSBIEN,.6,ADDIEN)) QUIT:'ADDIEN!EXIT  DO  
 . . ;next line: if the first piece is NOT an integer (it's a bad one)
 . . IF $P(^PSB(53.79,PSBIEN,.6,ADDIEN,0),"^")'=+$P(^PSB(53.79,PSBIEN,.6,ADDIEN,0),"^") DO  
 . . . SET DONE=0 ; not successful yet for this loop
 . . . NEW STRING,ADDITIVE SET STRING=^PSB(53.79,PSBIEN,.6,ADDIEN,0)
 . . . SET ADDITIVE=$PIECE(STRING,"^")
 . . . ;W !!,PSBIEN,?10,"Additive: ",ADDITIVE,! ;debug
 . . . ;
 . . . NEW IENADD SET IENADD=0 ; this will be the IEN in the IV Additives file
 . . . ;B
 . . . FOR  SET IENADD=$ORDER(^PS(52.6,IENADD)) QUIT:(IENADD'=+IENADD)!DONE!EXIT  DO
 . . . . ;B
 . . . . NEW ADDNAME SET ADDNAME=$PIECE(^PS(52.6,IENADD,0),"^")
 . . . . ;W ?5,"AddName: ",ADDNAME,! ;debug
 . . . . IF ADDITIVE=ADDNAME DO  
 . . . . . WRITE PSBIEN,"  MATCH: ",ADDITIVE," = ",ADDNAME,!
 . . . . . WRITE "IV Additive IEN: ",IENADD,"     "
 . . . . . ; check if its active
 . . . . . NEW DRUGIEN SET DRUGIEN=$PIECE(^PS(52.6,IENADD,0),"^",2) ; This is the drug IEN in file 50
 . . . . . IF '$DATA(^PS(52.6,"AC",DRUGIEN,IENADD))!($P(^PSDRUG(DRUGIEN,0),"^")["ZZ") DO  QUIT
 . . . . . . W ADDNAME," is inactive.",! ; if it's inactive, we quit and find the next one.
 . . . . . . ;B
 . . . . . ; this is where we will set up the fix
 . . . . . ELSE  WRITE ADDNAME," is active!  Here's the repair:",!
 . . . . . NEW FIX SET FIX=IENADD_"^"_STRING
 . . . . . W "Fix: ",FIX,!
 . . . . . IF $GET(FIXALL)'=1 DO 
 . . . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . . . SET DIR(0)="Y"
 . . . . . . SET DIR("A")="OK to fix this?"
 . . . . . . DO ^DIR
 . . . . . . IF $GET(DIRUT)!$GET(DIROUT) SET EXIT=1 QUIT
 . . . . . . QUIT:$GET(Y(0))="NO"
 . . . . . . IF Y(0)="YES" DO
 . . . . . . . ;setup to file^die to fix
 . . . . . . . ;W "          fix will be here",!! ;
 . . . . . . . NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; vars for di Edit
 . . . . . . . SET ZVHFDA(53.796,ADDIEN_","_PSBIEN_",",.01)=IENADD ; pointer to ien in additives file
 . . . . . . . SET ZVHFDA(53.796,ADDIEN_","_PSBIEN_",",.02)=ADDNAME ; display name stored in dose ordered field
 . . . . . . . DO FILE^DIE("K","ZVHFDA","") ; Update the additive
 . . . . . . . IF $D(DIERR) ZW ^TMP("DIERR",$J) DO
 . . . . . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . . . . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out.  Ready to continue?",DIR("B")="YES"
 . . . . . . . . DO ^DIR
 . . . . . . . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") SET EXIT=1 QUIT
 . . . . . . . ELSE  SET DONE=1 ; this is the flag that it was successful
 . . . . . ELSE  DO
 . . . . . . NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; vars for di Edit
 . . . . . . SET ZVHFDA(53.796,ADDIEN_","_PSBIEN_",",.01)=IENADD ; pointer to ien in additives file
 . . . . . . SET ZVHFDA(53.796,ADDIEN_","_PSBIEN_",",.02)=ADDNAME ; display name stored in dose ordered field
 . . . . . . DO FILE^DIE("K","ZVHFDA","") ; Update the additive
 . . . . . . IF $D(DIERR) ZW ^TMP("DIERR",$J) DO
 . . . . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . . . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out.  Ready to continue?",DIR("B")="YES"
 . . . . . . . DO ^DIR
 . . . . . . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") SET EXIT=1 QUIT
 . . . . . . ELSE  SET DONE=1 ; this is the flag that it was successful
 . . . IF DONE'=1 DO  
 . . . . IF '$GET(FIXALL) WRITE !,?2,"No match found for IV Additive for PSBIEN ",PSBIEN,!! ; if done is not 1, then no match was found
 . . . . SET NOTFIXED(PSBIEN,.6)="ADDITIVE(S) NOT FIXED"
 . . . . SET NOTFIXED(PSBIEN,.6,ADDIEN)=^PSB(53.79,PSBIEN,.6,ADDIEN,0)
 . . ;get the string from the .7,num,0 sub
 . . ;look it up in the SOULTIONS file
 . . ;reset it with file^die
 . . ;
 . ; now fix strings in the solutions
 . NEW SOLUTION SET SOLUTION=0 ; IEN of the solution in the subfile of the psb file 
 . FOR  SET SOLUTION=$ORDER(^PSB(53.79,PSBIEN,.7,SOLUTION)) QUIT:'SOLUTION!EXIT  DO  
 . . ;next line: if the first piece is NOT an integer (it's a bad one)
 . . IF $P(^PSB(53.79,PSBIEN,.7,SOLUTION,0),"^")'=+$P(^PSB(53.79,PSBIEN,.7,SOLUTION,0),"^") DO  
 . . . SET DONE=0 ; not successful yet for this loop
 . . . NEW STRING,SOLUTIONSTR SET STRING=^PSB(53.79,PSBIEN,.7,SOLUTION,0)
 . . . SET SOLUTIONSTR=$PIECE(STRING,"^")
 . . . W !!,PSBIEN,?10,"Solution: ",SOLUTIONSTR,! ;debug
 . . . ;
 . . . NEW IENSOL SET IENSOL=0 ; this will be the IEN in the IV Solutions file
 . . . ;B
 . . . FOR  SET IENSOL=$ORDER(^PS(52.7,IENSOL)) QUIT:(IENSOL'=+IENSOL)!DONE!EXIT  DO
 . . . . ;B
 . . . . NEW SOLNAME SET SOLNAME=$PIECE(^PS(52.7,IENSOL,0),"^")
 . . . . ;W ?5,"Solution Name: ",SOLNAME,! ;debug
 . . . . IF SOLUTIONSTR=SOLNAME DO  
 . . . . . WRITE !,?10,"MATCH: ",SOLUTIONSTR," = ",SOLNAME,!
 . . . . . WRITE "IV Solution IEN: ",IENSOL,"     "
 . . . . . ; check if its active
 . . . . . NEW DRUGIEN SET DRUGIEN=$PIECE(^PS(52.7,IENSOL,0),"^",2) ; This is the drug IEN in file 50
 . . . . . IF '$DATA(^PS(52.7,"AC",DRUGIEN,IENSOL))!($P(^PSDRUG(DRUGIEN,0),"^")["ZZ") DO  QUIT
 . . . . . . W SOLNAME," is inactive.",! ; if it's inactive, we quit and find the next one.
 . . . . . . ;B
 . . . . . ; this is where we will set up the fix
 . . . . . ELSE  WRITE SOLNAME," is active!  Here's the repair:",!
 . . . . . IF $GET(FIXALL)'=1 DO
 . . . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . . . SET DIR(0)="Y"
 . . . . . . SET DIR("A")="OK to fix this?"
 . . . . . . DO ^DIR
 . . . . . . IF $GET(DIRUT)!$GET(DIROUT) SET EXIT=1 QUIT
 . . . . . . QUIT:$GET(Y(0))="NO"
 . . . . . . IF Y(0)="YES" DO
 . . . . . . . NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; vars for di Edit
 . . . . . . . SET ZVHFDA(53.797,SOLUTION_","_PSBIEN_",",.01)=IENSOL ; pointer to ien in Solutions file
 . . . . . . . SET ZVHFDA(53.797,SOLUTION_","_PSBIEN_",",.02)=SOLNAME ; display name stored in dose ordered field
 . . . . . . . DO FILE^DIE("K","ZVHFDA","") ; Update the Solution
 . . . . . . . IF $D(DIERR) ZW ^TMP("DIERR",$J) DO
 . . . . . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . . . . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out.  Ready to continue?",DIR("B")="YES"
 . . . . . . . . DO ^DIR
 . . . . . . . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") SET EXIT=1 QUIT
 . . . . . . . ELSE  SET DONE=1 ; this is the flag that it was successful
 . . . . . ELSE  DO
 . . . . . . ;setup to file^die to fix
 . . . . . . NEW ZVHFDA,DIERR KILL ^TMP("DIERR",$J) ; vars for di Edit
 . . . . . . SET ZVHFDA(53.797,SOLUTION_","_PSBIEN_",",.01)=IENSOL ; pointer to ien in Solutions file
 . . . . . . SET ZVHFDA(53.797,SOLUTION_","_PSBIEN_",",.02)=SOLNAME ; display name stored in dose ordered field
 . . . . . . DO FILE^DIE("K","ZVHFDA","") ; Update the Solution
 . . . . . . IF $D(DIERR) ZW ^TMP("DIERR",$J) DO
 . . . . . . . NEW DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y ; vars for di Read
 . . . . . . . SET DIR(0)="Y",DIR("A")="ERROR! You better check it out.  Ready to continue?",DIR("B")="YES"
 . . . . . . . DO ^DIR
 . . . . . . . IF $GET(DIRUT)!$GET(DIROUT)!($GET(Y(0))="NO") SET EXIT=1 QUIT
 . . . . . . ELSE  SET DONE=1 ; this is the flag that it was successful
 . . . IF DONE'=1 DO  
 . . . . IF '$GET(FIXALL) WRITE !,?2,"No match found for IV Solution for PSBIEN ",PSBIEN,!! ; if done is not 1, then no match was found
 . . . . SET NOTFIXED(PSBIEN,.7)="SOLUTION(S) NOT FIXED"
 . . . . SET NOTFIXED(PSBIEN,.7,SOLUTION)=^PSB(53.79,PSBIEN,.7,SOLUTION,0)
 IF $DATA(NOTFIXED)>9 ZW NOTFIXED
 ;
 QUIT  ;  label IVSTRNG
 ;
