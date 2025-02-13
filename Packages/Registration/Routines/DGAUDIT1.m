DGAUDIT1 ; ISL/DKA - Dataset 1 of VAS VistA Audit Solution ; 03 Aug 2021  1:05 PM
 ;;5.3;Registration;**964,1097,1108,1120**;Aug 13, 1993;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^VA(200 in ICR #1262
 ; Reference to FILE^DID  in ICR #2052
 ; Reference to GETS^DIQ  in ICR #2056
 ; Reference to ^DIA in ICR #2602
 ; Reference to ENCODE^XLFJSON in ICR #6682
 ; Reference to ^DD(9000001 in ICR #7187
 ; Reference to ^DIC in ICR #10006
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to EN^DIQ1 in ICR #10015
 ; Reference to ^DIE in ICR #10018
 ; Reference to $$FMTH^XLFDT in ICR #10103
 ; Reference to $$FMTHL7^XLFDT in ICR #10103
 ; Reference to $$GETICN^MPIF001 in ICR #2701
 ; 
 ; Local process variable DGAUDMAX NEWed in calling routine ^DGAUDIT
 ; Local process variable DGAUDSHUT NEWed in calling routine ^DGAUDIT
 ; Local process variable DGAUDSTOP NEWed in calling routine ^DGAUDIT
 ; Local process variable DGBATSIZE NEWed in calling routine ^DGAUDIT
 ; Local process variable DGDONE NEWed in calling routine ^DGAUDIT
 ;
 Q  ; No entry from top
 ;
 ;
NEWAUDEX ; Export newly added AUDIT (#1.1) records
 ; Loop through the File Numbers in ^DIA()
 ; If there's a Patient-Related File that doesn't exist in DG VAS EXPORT,  ; FLS Changed VSRA TO VAS 3/16/2021
 ; then add a new record to that File and set the LAST RECORD EXPORTED to 0.
 ; Start with the next record following the LAST RECORD EXPORTED recorded in DG VAS EXPORT (#46.4)  ; FLS Changed VSRA TO VAS 3/16/2021
 N AUDGREF,CNTREC,D,D0,DA,DD,DIC,DICR,DIE,DIU,DIV,DO,DR,DTOUT,DUOUT,FILENUM,GREF,IEN,REC,RECDATA,DGABORT
 N VD,VM,X,Y,DGSEC,DGSTOPFLG,DGDEBUGON
 L +^DGAUDIT1(0):1 Q:'$T
 S DGDEBUGON=$$GET^XPAR("ALL","DG VAS DEBUGGING FLAG") ; Changed XPAR names from VSRA to VAS 3/17/21
 S AUDGREF=$NA(^DIA),GREF=$NA(^DGAUDIT1)
 S (CNTREC,FILENUM,DGABORT)=0
 F  S FILENUM=$O(@AUDGREF@(FILENUM)) Q:'FILENUM!$G(DGAUDSTOP)!'$G(DGAUDSHUT)!$$S^%ZTLOAD!$G(DGDONE)!$G(DGABORT)  D
 . S DGAUDSHUT=$$GET1^DIQ(46.5,1,.02,"I")                ; Check send switch. NEWed in DGAUDIT
 . N LASTDIA,RECDATA,SWITCHDT,EXPRTIEN,RECDATE
 . S LASTDIA=$$GET1^DIQ(1.1,FILENUM,.03) Q:(LASTDIA<1)
 . Q:'$$PATREL(FILENUM)
 . K DIC S DIC="^DGAUDIT1(",X=FILENUM D ^DIC D:Y<1  Q:Y'>0
 . . K DIC S DIC="^DGAUDIT1(",DIC(0)="",DIC("DR")=".02///0;.04///"_$$NOW^XLFDT,X=FILENUM D FILE^DICN
 . ; Y now contains the IEN of DG AUDIT EXPORT, whether newly created or not.
 . S EXPRTIEN=+Y S REC=+$$GET1^DIQ(46.4,EXPRTIEN,.02) S:'REC REC=$O(@AUDGREF@(FILENUM,+LASTDIA),-1) S:'REC REC=LASTDIA
 . ; If the REC is not in the AUDIT file, reset the REC to the next-to-last IEN in the AUDIT file.
 . I '$D(@AUDGREF@(FILENUM,+REC,0)) S REC=$O(@AUDGREF@(FILENUM,+LASTDIA),-1) Q:'REC
 . ; If starting record isn't already set to the last record in ^DIA, and the record's audit date is prior to the switch date, reset REC to last IEN in the AUDIT file.
 . I REC'=LASTDIA S RECDATA=$G(@AUDGREF@(FILENUM,REC,0)),RECDATE=$P(RECDATA,"^",2),SWITCHDT=$P($G(^DGAUDIT1(EXPRTIEN,0)),"^",4) D  Q:'REC
 .. I SWITCHDT'?7N.E S SWITCHDT=$$NOW^XLFDT N DGFDA,DGFILERR S DGFDA(46.4,EXPRTIEN_",",.04)=SWITCHDT D FILE^DIE(,"DGFDA","DGFILERR")
 .. Q:RECDATE>SWITCHDT                                                              ; Record's audit date is after send switch date, use this record
 .. S RECDATE=0 F  Q:$G(RECDATE)  S REC=$O(^DIA(FILENUM,REC)) Q:'REC  D  Q:'REC     ; Find next audit record
 ... S RECDATA=$G(@AUDGREF@(FILENUM,REC,0)),RECDATE=$P(RECDATA,"^",2)
 ... I SWITCHDT?7N.E,(RECDATE<SWITCHDT) S RECDATE="" Q                              ; Check audit date, quit and move to next record if before send switch date
 ... S REC=$O(^DIA(FILENUM,REC),-1)                                                 ; Found audit date>send switch date, set REC=previous record ($O will start with this record)
 . F  S REC=$O(@AUDGREF@(FILENUM,REC)) Q:'REC!$G(DGAUDSTOP)!'$G(DGAUDSHUT)!$G(DGABORT)!(REC>LASTDIA)  D
 .. S DGAUDSHUT=$$GET1^DIQ(46.5,1,.02,"I")                ; Check send switch. NEWed in DGAUDIT
 .. S CNTREC=CNTREC+($$FMAUD(FILENUM,REC)>0)
 .. K DIC S DIC="^DGAUDIT1(",X=FILENUM D ^DIC
 .. K DIE,DR,DA S DIE=46.4,DA=+Y,DR=".02///"_REC_";.03///"_$TR($G(@AUDGREF@(FILENUM,REC,0)),U,"%") D ^DIE
 .. I $$PENDING>(DGAUDMAX/4) D EXPORT3^DGAUDIT(.DGABORT)  ; If queue is more than 25% full, clear it out by sending all queued records
 .. S:$$FROZEN^DGAUDIT(70) DGABORT=1   ; Queue should be empty now - if queue remains more than 70% full, there's a problem.
 . I DGDEBUGON D
 .. D DBEMAIL("NEWAUDEX^DGAUDIT1")
 .. S DGDEBUGON=0
 .. D EN^XPAR("SYS","DG VAS DEBUGGING FLAG",1,DGDEBUGON)  ; Turn debug mode off. ; Changed XPAR names from VSRA to VAS 3/17/21
 . I $$PENDING>+$G(DGBATSIZE) D EXPORT3^DGAUDIT(.DGABORT) ; Clear out queue by sending all records for file FILENUM from ^DIA
 . S:$$FROZEN^DGAUDIT(70) DGABORT=1   ; Queue should be empty now - if queue remains more than 70% full, there's a problem.
 L -^DGAUDIT1(0)
 Q
 ;
FMAUD(FILENUM,AUDIEN) ; Send the data for a given AUDIT (#1.1) record
 N AUDARR,JSON,C,DA,DATETIME,DIA,DIC,DIQ,DR,ERR,FILEDATA,N,X,DGVARR,DGVDATA,DGVDFN,DGVDUZ,DGVREF,DGVMSG,DGVOFFN,DGVINST,DGAUDSTANUM,DGMVI,DGCTRL,DCCI
 S:'$G(DGAUDMAX) DGAUDMAX=$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES")
 Q:$$PENDING'<DGAUDMAX
 S DIA=FILENUM ; This is a special variable used for accessing AUDIT entries
 S DIC="^DIA(DIA,",DA=AUDIEN,DIQ="DGVDATA"
 ; Get the fields for which we want both Internal and External values
 S DIQ(0)="IEN",DR=".02;.04;4.1"
 D EN^DIQ1
 I '$D(DGVDATA) Q -1
 ;
 S DGVREF=$NA(@$Q(DGVDATA),2)
 S DIQ(0)="N" ; DICMX allows the lookup on Field 2.14 without <UNDEFINED>
 S DR=".01;.03;.05;.06;1;1.1;2;2.1;2.2;2.9;3;3.1;3.2;4.2"
 D EN^DIQ1
 F DCCI=0:1:31 S DGCTRL=$G(DGCTRL)_$c(DCCI)  ; Build string of non-printable control characters
 F DCCI=127:1:159 S DGCTRL=$G(DGCTRL)_$c(DCCI)
 ;
 ; If the AUDIT File can't identify the Patient,
 ; Then see if the Field being changed is the .01 Field and has an Old Value but a blank New Value
 ; and the Field Type is a Pointer to the PATIENT File (#2) or the PATIENT/IHS File (#9000001),
 ; and if so, then set the Patient value to the DFN from the OLD VALUE field.
 ; If we still don't have a Patient, then Quit.
 ; 
 I $G(@DGVREF@(2.9))="",$G(@DGVREF@(.03))=".01",$G(@DGVREF@(2.2))["P2'"!($G(@DGVREF@(2.2))["P9000001'"),$G(@DGVREF@(3))="<deleted>" S @DGVREF@(2.9)=$G(@DGVREF@(2.1))
 I $G(@DGVREF@(2.9))="" Q -2
 I $$ANON($G(@DGVREF@(.04,"I"))) Q 0
 S DGVARR=$NA(AUDARR("data","HEADER"))
 S DGVDFN=$G(@DGVREF@(2.9))
 ; These are the additional fields that we want to send with each record to the Audit Solution
 S DATETIME=$G(@DGVREF@(.02,"I"))
 I DATETIME'="" D
 . S @DGVARR@("DateTime")=$$FMTHL7^XLFDT(DATETIME)
 . ;S @DGVARR@("Week")=$SYSTEM.SQL.WEEK(+$$FMTH^XLFDT(DATETIME))
 . ;S @DGVARR@("Year")=$SYSTEM.SQL.YEAR(+$$FMTH^XLFDT(DATETIME))
 . S @DGVARR@("Week")=$$WEEK^DGAUDIT1($P(DATETIME,"."))
 . S @DGVARR@("Year")=+$$FMTE^XLFDT(DATETIME,7)
 S @DGVARR@("RequestType")=$S($G(@DGVREF@(.05))="Added Record":"CREATE",$G(@DGVREF@(.03))=.01&($G(@DGVREF@(3))="<deleted>"):"DELETE",1:"UPDATE")
 S @DGVARR@("SchemaType")="FMAUDIT"
 S DGVARR=$NA(AUDARR("data","HEADER","Patient"))
 S @DGVARR@("DFN")=$TR(DGVDFN,DGCTRL)
 S DGMVI=$$GETICN^MPIF001(DGVDFN),DGMVI=$S(DGMVI>0:DGMVI,1:"")
 S @DGVARR@("MVI")=$TR(DGMVI,DGCTRL)
 S @DGVARR@("PatientName")=$TR($$GET1^DIQ(2,DGVDFN,.01),DGCTRL)
 S @DGVARR@("SSN")=$TR($$GET1^DIQ(2,DGVDFN,.09),DGCTRL)
 S @DGVARR@("INITPLUS4")=$TR($$GET1^DIQ(2,DGVDFN,.0905),DGCTRL)
 S @DGVARR@("DOB")=$TR($$FMTHL7^XLFDT($$GET1^DIQ(2,DGVDFN,.03,"I")),DGCTRL)
 ;
 S DGVARR=$NA(AUDARR("data","HEADER","User"))
 S (DGVDUZ,@DGVARR@("DUZ"))=$TR($G(@DGVREF@(.04,"I")),DGCTRL)
 S @DGVARR@("UID")=$TR($$GET1^DIQ(200,$G(@DGVREF@(.04,"I")),205.4),DGCTRL)
 S @DGVARR@("UserName")=$TR($G(@DGVREF@(.04,"E")),DGCTRL)
 S @DGVARR@("Title")=$TR($$GET1^DIQ(200,$G(@DGVREF@(.04,"I")),8),DGCTRL)
 ;
 S DGVARR=$NA(AUDARR("data","HEADER","Location"))
 S:DGVDUZ'="" DGVINST=$O(^VA(200,DGVDUZ,2,"AX1",1,"")) ; Get User's Default Division
 S:$G(DGVINST)="" DGVINST=$$GET1^DIQ(8989.3,1,217,"I") ; Default Institution
 S DGVOFFN=$TR($$GET1^DIQ(4,DGVINST,100),DGCTRL) ; Official VA Name
 S @DGVARR@("Site")=$S(DGVOFFN'="":$TR(DGVOFFN,DGCTRL),1:$TR($$GET1^DIQ(8989.3,1,217),DGCTRL)) ; External value of the Default Institution
 S @DGVARR@("StationNumber")=$TR($$GET1^DIQ(4,DGVINST,99),DGCTRL) ; Station Number for the Default Institution
 ;
 S DGVARR=$NA(AUDARR("data","SCHEMA"))
 S @DGVARR@("FILE NUMBER")=FILENUM
 D FILE^DID(FILENUM,,"NAME","FILEDATA")
 S @DGVARR@("FILE NAME")=$G(FILEDATA("NAME"),"null")
 ; These are fields supplied by the AUDIT Data Dictionary (#1.1) that we have chosen to send.
 S @DGVARR@("RECORD ADDED")=$TR($G(@DGVREF@(.05),"null"),DGCTRL)
 S @DGVARR@("ACCESSED")=$TR($G(@DGVREF@(.06),"null"),DGCTRL)
 S @DGVARR@("FIELD NAME")=$TR($G(@DGVREF@(1.1),"null"),DGCTRL)
 S @DGVARR@("OLD VALUE")=$TR($G(@DGVREF@(2),"null"),DGCTRL)
 S @DGVARR@("NEW VALUE")=$TR($G(@DGVREF@(3),"null"),DGCTRL)
 S @DGVARR@("MENU OPTION USED")=$TR($G(@DGVREF@(4.1,"E"),"null"),DGCTRL)
 S @DGVARR@("PROTOCOL or OPTION USED")=$TR($G(@DGVREF@(4.2),"null"),DGCTRL)
 ;
 D PAYLOAD(.JSON,.AUDARR,DGVARR,FILENUM,AUDIEN)
 Q 1
 ;
 ;
PAYLOAD(DATA,HDRDATA,DGVARR,FILENUM,AUDIEN) ; Take ARRAY and send it the Audit Solution
 Q:'$$GET1^DIQ(46.5,1,.02,"I")  ; Audit flag blank/0=do not add to queue, 1=add to queue, 2=add to queue
 N DA,DO,DIC,X,Y,DGAUDECNT,LOCKED,DGFDA,DGNOWDTM,DGJSONID,JSONERR,DGAUDIEN,DGAUDJSON,TMPJSON,DGFMERR
 ;
 S DGNOWDTM=$$NOW^XLFDT
 S DGJSONID=+$G(FILENUM)_"."_+$G(AUDIEN)_"."_DGNOWDTM
 S DGAUDECNT="+1,"
 S DGVARR=$NA(HDRDATA("id"))
 S @DGVARR=DGJSONID  ;DGNOWDTM_"."_$$HL7TFM^XLFDT($G(HDRDATA("data","HEADER","DateTime")))   ; Record ID - File 46.3 IEN_"."_FMDATETIME
 ;
 N DGSTATION,DGSITENAM,DGSITEIEN
 S DGVARR=$NA(HDRDATA("station"))
 S DGSTATION=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S @DGVARR=DGSTATION
 S DGVARR=$NA(HDRDATA("site"))
 S DGSITEIEN=$$FIND1^DIC(4,,"X",DGSTATION,"D")
 S DGSITENAM=$$GET1^DIQ(4,DGSITEIEN,.01)
 S @DGVARR=DGSITENAM
 ;
 D ENCODE^XLFJSON($NA(@DGVARR,0),"DGAUDJSON","JSONERR")
 I '$G(JSONERR) D DECODE^XLFJSON("DGAUDJSON","TMPJSON","JSONERR")
 ;
 S DGFDA(46.3,DGAUDECNT,.01)=DGNOWDTM
 S DGFDA(46.3,DGAUDECNT,.02)="UPDATE"
 S DGFDA(46.3,DGAUDECNT,.03)=$$HL7TFM^XLFDT($G(HDRDATA("data","HEADER","DateTime")))
 S DGFDA(46.3,DGAUDECNT,.04)=$G(HDRDATA("data","HEADER","Patient","DFN"))
 S DGFDA(46.3,DGAUDECNT,.05)=$G(HDRDATA("data","HEADER","User","DUZ"))
 S DGFDA(46.3,DGAUDECNT,.06)=$G(HDRDATA("data","SCHEMA","MENU OPTION USED"))
 S DGFDA(46.3,DGAUDECNT,.07)=$G(HDRDATA("data","SCHEMA","FILE NUMBER"))
 S DGFDA(46.3,DGAUDECNT,.08)=$G(HDRDATA("data","HEADER","Location","StationNumber"))
 S DGFDA(46.3,DGAUDECNT,1)=DGAUDJSON(1)
 ;
 I ($L($G(DGFDA(46.3,DGAUDECNT,1)))<30)!$G(JSONERR(0)) D  Q
 . M DGFDA(46.3,DGAUDECNT,1)=HDRDATA
 . I $G(JSONERR(0)) S JSONERR=0 F  S JSONERR=$O(JSONERR(JSONERR)) Q:'JSONERR  S DGFDA(46.3,DGAUDECNT_",",1,"JSON ERROR",.999+JSONERR)=$G(JSONERR(JSONERR))
 . D BADJSON^DGAUDIT2(0,+$G(DGAUDKPX),.DGFDA)
 D UPDATE^DIE("S","DGFDA","DGAUDIEN","DGFMERR") S DGAUDIEN=$G(DGAUDIEN(1))
 I 'DGAUDIEN!'$L($G(^DGAUDIT(+DGAUDIEN,1))) D
 . M DGFDA(46.3,DGAUDECNT,1)=HDRDATA
 . I $D(DGFMERR("DIERR",1,"TEXT")) S DGFDA(46.3,DGAUDECNT,1,"JSON ERROR",1.999)="FileMan Filer Error: "_$G(DGFMERR("DIERR",1,"TEXT",1))
 . D BADJSON^DGAUDIT2(+$G(DGAUDIEN),+$G(DGAUDKPX),.DGFDA)
 Q
 ;
PATREL(FILENUM) ; Return 1 if this is a patient-related File
 Q $D(^DD(2,0,"PT",FILENUM))>0!($D(^DD(9000001,0,"PT",FILENUM))>0)
 ;
DBEMAIL(TAG) ; send email if debugging turned on
 N DGVOFFN,DGVDUZ,DGSUBJ,DGMSG,DGXMTO,DGGLO,DGGLB,DGXMINSTR,DGVINST,DGSITE,DGAUDSTANUM,DGNOW,DGEMAIL  ; JPN ADDED 03/31/21
 N DGSQ,DGSUB,DGVAR,Y,%,DGINST
 S DGNOW=$$FMTE^XLFDT($$NOW^XLFDT)
 S DGVDUZ=$G(DUZ)
 S:DGVDUZ'="" DGVINST=$O(^VA(200,DGVDUZ,2,"AX1",1,"")) ; Get User's Default Division
 S DGAUDSTANUM=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 D F4^XUAF4(DGAUDSTANUM,.DGINST)
 S DGSITE=$G(DGINST("VA NAME"))
 S DGSUBJ=TAG_" sent from "_$G(DGSITE)_" - "_$G(DGAUDSTANUM)
 S DGSUBJ=$E(DGSUBJ,1,65)
 S DGMSG(2)=""
 S DGMSG(3)=" Name: "_$G(DGSITE)
 S DGMSG(4)=" Station#: "_+$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S DGMSG(5)=" Domain: "_$G(^XMB("NETNAME"))
 S DGMSG(6)=" Date/Time: "_DGNOW
 S DGMSG(7)=" By: "_$P($G(^VA(200,DUZ,0)),U,1)
 S DGMSG(8)=""
 S DGMSG(9)=""
 S DGSQ=9
 S %="" F  S %=$O(@%) Q:%=""  S DGSQ=$G(DGSQ)+1,DGMSG(DGSQ)=%_"="_$G(@%)
 ;Copy mesage to OIT team?
 S DGXMTO(DUZ)=""
 S DGEMAIL=$$GET^XPAR("ALL","DG VAS MONITOR GROUP")           ;JPN ADDED 3/31/21
 S DGXMTO("G."_DGEMAIL)=""                                    ;JPN ADDED 3/31/21
 S DGXMINSTR("FROM")="noreply.domain.ext"
 ;
 D SENDMSG^XMXAPI(DUZ,DGSUBJ,"DGMSG",.DGXMTO,.DGXMINSTR)
 Q:'$D(^TMP("XMERR",$J))    ; no email problems
 ;
 D MES^XPDUTL("MailMan reported a problem trying to send the notification message.")
 D MES^XPDUTL(" ")
 S (DGGLO,DGGLB)="^TMP(""XMERR"","_$J
 S DGGLO=DGGLO_")"
 F  S DGGLO=$Q(@DGGLO) Q:DGGLO'[DGGLB  D MES^XPDUTL(" "_DGGLO_" = "_$G(@DGGLO))
 D MES^XPDUTL(" ")
 Q
 ;
ANON(DGDUZ) ; Check to see if the user fits the definition of an anoymous user
 ; Currently checking users with user types below
 N RTN,UNAME
 S RTN=0,UNAME=$$GET1^DIQ(200,DGDUZ,.01)
 I DGDUZ="" Q 1
 I $$ACTIVE^XUSAP(DGDUZ) D
 . ;I $SYSTEM.SQL.UPPER(UNAME)["ANONYMOUS" S RTN=1
 . I $$UP^XLFSTR(UNAME)["ANONYMOUS" S RTN=1
 . I $$USERTYPE^XUSAP(DGDUZ,"CONNECTOR PROXY") S RTN=1
 . I $$USERTYPE^XUSAP(DGDUZ,"APPLICATION PROXY") S RTN=1
 Q RTN
 ;
WEEK(FMDATE) ; Accept Fileman Date, Return Week
 N DAYOFYR,YRBEGDOW,YRBEG,WEEK
 S WEEK=""
 Q:'$G(FMDATE) ""
 S FMDATE=$P(FMDATE,".") Q:'(FMDATE?7N) ""
 S YRBEG=$E(FMDATE,1,3)_"0101"
 S YRBEGDOW=$$DOW^XLFDT(YRBEG,1)
 S DAYOFYR=$$FMDIFF^XLFDT(FMDATE,$$FMADD^XLFDT(YRBEG+(6-YRBEGDOW)))  ; Partial Week at beginning of year - add 1 to week below
 S WEEK=(DAYOFYR/7)+1 S WEEK=$S($P(WEEK,".",2):WEEK\1+1,1:WEEK)
 I (WEEK>53)!(WEEK<1) S WEEK=""
 Q WEEK
 ;
ESCAPE(INPUT) ; Escape XML characters from INPUT
 N ESCHAR,ESCAPED,CHAR,CHARARY,POS
 S INPUT=$G(INPUT),ESCAPED=""
 F CHAR="':&apos;","&:&amp;","<:&lt;",">:&gt;" S CHARARY($P(CHAR,":"))=$P(CHAR,":",2)
 F POS=1:1:$L(INPUT) S CHAR=$E(INPUT,POS) D
 .I $D(CHARARY(CHAR)) S ESCAPED=$G(ESCAPED)_CHARARY(CHAR) Q
 .S ESCAPED=$G(ESCAPED)_CHAR
 Q ESCAPED
 ;
GETTEXT(ERRARRAY) ;
 ; @DESC Gets the error text from the array
 ;
 ; @ERRARRAY Error array stores error in format defined by web service product.
 ;
 ; @RETURNS Error info as a single string
 ;
 NEW DGAUD
 ;
 ; Loop through the text subscript of error array and concatenate
 SET DGAUD("errorText")=""
 SET DGAUD("I")=""
 FOR  SET DGAUD("I")=$ORDER(ERRARRAY("text",DGAUD("I"))) QUIT:DGAUD("I")=""  DO
 . SET DGAUD("errorText")=DGAUD("errorText")_ERRARRAY("text",DGAUD("I"))
 . QUIT
 ;
 QUIT DGAUD("errorText")
 ;
ERRSPMSG(DGRESPERR,DGRESPETXT) ; 
 ; Input : DGRESPERR (Required) - response error from Post call
 ; Return: response code/txt (ex: DGERR(400) from Init)_response code/msg (ex: ADDRVAL###)
 N DGERRCODE,DGEMSG
 S DGERRCODE=DGRESPERR.code
 DO ERR2ARR^XOBWLIB(.DGRESPERR,.DGRESPETXT)
 ; Example:
 ;  S DGRESPETXT("errorType")="HTTP"
 ;  S DGRESPETXT("statusLine")="HTTP/1.1 504 Gateway Timeout"
 ;  S DGRESPETXT("text")=1
 ;  S DGRESPETXT("text",1)={"message":"Unable to parse data. Not JSON format"}
 S DGEMSG=$G(DGRESPETXT("text",1))
 I DGEMSG="" S DGEMSG=DGRESPETXT("statusLine")
 S DGERR(DGERRCODE)=DGERRCODE_$S($L(DGEMSG)>1:DGEMSG,1:" VAS Service Error.")
 Q DGERR(DGERRCODE)
 ;
PENDING() ; Return number of entries in queue
 N DGQIEN,DGQCNT
 S DGQCNT=0
 S DGQCNT=$P(^DGAUDIT(0),U,4)
 ;I ($G(DGQCNT)'>0),$O(^DGAUDIT(0)) S (DGQIEN,DGQCNT)=0 F  S DGQIEN=$O(^DGAUDIT(DGQIEN)) Q:'DGQIEN
 S (DGQIEN,DGQCNT)=0 F DGQCNT=0:1 S DGQIEN=$O(^DGAUDIT(DGQIEN)) Q:'DGQIEN
 Q DGQCNT
 ;
GENERR(DGAUDERR,DGALTSUB) ; General Error, DGAUDERR specific text
 N DGSRVID,DGSSLPORT,DGAUDNUM,DGAUDER2,DGAUDDATA
 S DGAUDER2=1
 S DGSRVID=$$FIND1^DIC(18.12,,"B","DG VAS WEB SERVER")
 S DGAUDER2(DGAUDER2)="Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT),DGAUDER2=DGAUDER2+1
  ; If SSL enabled PORT=$$GET1^DIQ(18.12,SRVID,3.03)
 S DGSSLPORT=$$GET1^DIQ(18.12,DGSRVID,3.03)
 I $G(DGSRVID) D
 . S DGAUDER2(DGAUDER2)="Error from DG VAS WEB SERVER: "_$$GET1^DIQ(18.12,DGSRVID,.04)_" on port: "_$S($G(DGSSLPORT):DGSSLPORT,1:$$GET1^DIQ(18.12,DGSRVID,.03))
 . S DGAUDER2=DGAUDER2+1
 . S DGAUDER2(DGAUDER2)="",DGAUDER2=DGAUDER2+1
 S DGAUDERR=0 F  S DGAUDERR=$O(DGAUDERR(DGAUDERR)) Q:'DGAUDERR  S DGAUDER2(DGAUDER2)=DGAUDERR(DGAUDERR),DGAUDER2=DGAUDER2+1
 D FILE^DID(46.3,,"ENTRIES","DGAUDDATA")
 S DGAUDNUM=$G(DGAUDDATA("ENTRIES"))
 S DGAUDER2(DGAUDER2)="",DGAUDER2=DGAUDER2+1
 S DGAUDER2(DGAUDER2)="The ^DGAUDIT global contains "_DGAUDNUM_" entr"_$S(DGAUDNUM=1:"y",1:"ies")_".",DGAUDER2=DGAUDER2+1
 S DGAUDER2(DGAUDER2)="The maximum number of entries in the queue is "_$$GET^XPAR("ALL","DG VAS MAX QUEUE ENTRIES")_".",DGAUDER2=DGAUDER2+1
 S DGAUDER2(DGAUDER2)="",DGAUDER2=DGAUDER2+1
 D SNDMSG^DGAUDIT(.DGAUDER2,,$G(DGALTSUB)) K DGAUDERR,DGAUDER2
 Q
