MAGVCLN ;WOIFO/DAC - File 2005.6X Duplicate Removal Utility ; Feb 22, 2022@21:12:01
 ;;3.0;IMAGING;**278**;Mar 19, 2002;Build 138
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
ID ; Identify Duplicates and Unattached Records
 N MAGQUIT,DELETE,LINE,MAGSCR,MAGQUE,MAGTEXT,MAGLICNT
 S DELETE=0,$P(LINE,"-",30)="-"
 D MSG^MAGVCLN1(DELETE,.MAGQUIT) Q:$G(MAGQUIT)
 D DEVICE^MAGVCLN1(DELETE,.MAGQUIT,.MAGQUE,.MAGSCR) Q:$G(MAGQUIT)
 I $G(MAGQUE) D CONT Q
 W !!,"Identifying Duplicates...",!,LINE
 D IDDEL(DELETE)
 D CONT
 Q
DELETE ; Change Status of Duplicates and Unattached Records to INACCESSIBLE
 N MAGQ,DELETE,LINE,MAGSCR,MAGQUE,MAGTEXT,MAGLICNT
 S DELETE=1,$P(LINE,"-",30)="-"
 D MSG^MAGVCLN1(DELETE,.MAGQUIT) Q:$G(MAGQUIT)
 D DEVICE^MAGVCLN1(DELETE,.MAGQUIT,.MAGQUE,.MAGSCR) Q:$G(MAGQUIT)
 I $G(MAGQUE) D CONT Q
 W !!,"Resolving Duplicates...",!,LINE
 D IDDEL(DELETE)
 D CONT
 Q
IDDEL(DELETE,MAGPOST) ; Identify or Set Status of Duplicates and Unattached Records
 ; DELETE - Set STATUS to Inaccessible, move child records from duplicate to primary 
 ; MAGPOST - Run from Post-Install, send output as message to installer
 ;
 N FILE,MAGXTMP,LINE,MAGTEXT,MAGLICNT
 K ^TMP("MAGCLN",$J)
 S MAGXTMP="MAGVCLN"
 S $P(LINE,"-",50)="-"
 S MAGLICNT=1
 ;
 S ^XTMP(MAGXTMP,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^IMAGING CLEANUP LOG"
 I $G(MAGPOST) D MSGHDR^MAGVCLN1(.MAGLICNT,DELETE)
 ;
 ; Process duplicates
 F FILE=2005.6,2005.61,2005.62,2005.63,2005.64,2005.65 D DELETE2(FILE,DELETE)
 ;
 ; Process Invalid parent pointers
 S MAGTEXT=$S($G(DELETE):"Marking as INACCESSIBLE",1:"Identifying")_" Missing or Invalid Parent Links..."
 D OUTPUT^MAGVCLN1(MAGTEXT,3,,$G(MAGPOST)),OUTPUT^MAGVCLN1(LINE,1,0,$G(MAGPOST))
 F FILE=2005.61,2005.62,2005.63,2005.64,2005.65 D IDLINKS(FILE,DELETE)
 ;
 S MAGTEXT="** FINISHED **" D OUTPUT^MAGVCLN1(MAGTEXT,3,2,$G(MAGPOST))
 ;
 I $G(MAGPOST) D  Q
 . D TMPMSG^MAGVCLN1($G(DELETE))
 . K ^TMP("MAGVCLN",$J)
 ;
 I '$G(MAGSCR) W !,@IOF
 D ^%ZISC
 Q
 ;
IDLINKS(FILE,DELETE) ; Check 2005.6x files broken pointer to parent records
 N IEN,PIEN,PFILE,PRIEN,PATIEN,KEY,BKEY,MAGCNT
 S MAGTEXT="Searching File "_FILE D OUTPUT^MAGVCLN1(MAGTEXT,2,,$G(MAGPOST))
 S IEN=0,MAGCNT=0
 S BKEY="" F  S BKEY=$O(^MAGV(FILE,"B",BKEY)) Q:BKEY=""  D IDLINKS2(FILE,DELETE,BKEY,.MAGCNT)
 I '$G(MAGCNT) S MAGTEXT=FILE_" - No missing or invalid pointers identified." D OUTPUT^MAGVCLN1(MAGTEXT,1,0,$G(MAGPOST))
 Q
IDLINKS2(FILE,DELETE,BKEY,MAGCNT) ; Get IEN from "B" x-ref
 N IEN
 S IEN=0 F  S IEN=$O(^MAGV(FILE,"B",BKEY,IEN)) Q:'+IEN  D
 . S KEY=$P($G(^MAGV(FILE,IEN,0)),U,1)
 . S PIEN=$P($G(^MAGV(FILE,IEN,6)),U,1)
 . I FILE=2005.62 S PATIEN=$P($G(^MAGV(2005.62,IEN,6)),U,3)
 . S PFILE=FILE-.01
 . I $G(PIEN)="" D DELBP(FILE,KEY,IEN,2,DELETE) Q
 . I '$D(^MAGV(PFILE,PIEN,0)) D DELBP(FILE,KEY,IEN,3,DELETE,PIEN) Q
 . I FILE=2005.62,$G(PATIEN)="" D DELBP(FILE,KEY,IEN,4,DELETE) Q
 . I FILE=2005.62,$G(PATIEN)'="",'$D(^MAGV(2005.6,PATIEN,0)) D DELBP(FILE,KEY,IEN,5,DELETE,PATIEN) Q
 Q
DELETE2(FILE,DELETE) ; Check 2005.6x files for B x-ref for duplicate key values 
 N NAOFS,AOFS,DUPE,NEXTIEN,MAGCNT,PATCHK,PATDIFF,MAGCNT
 S KEY="",MAGCNT=0
 S MAGTEXT="Searching File "_FILE D OUTPUT^MAGVCLN1(MAGTEXT,2,0,$G(MAGPOST))
 F  S KEY=$O(^MAGV(FILE,"B",KEY)) Q:KEY=""  D
 . S (PATCHK,PATDIFF)=""
 . S AOFS="",NAOFS="",IEN="",DUPE=""
 . F  S IEN=$O(^MAGV(FILE,"B",KEY,IEN)) Q:IEN=""  D 
 . . S NEXTIEN=$O(^MAGV(FILE,"B",KEY,IEN))
 . . S:NEXTIEN DUPE=1 Q:NEXTIEN=""
 . . ; Check 2005.6,2005.61 duplicate - multifield keys
 . . I FILE=2005.6 S PATCHK=$$PATCHK(IEN,NEXTIEN) D  I 'PATCHK Q
 . . . I PATCHK=-1 S PATDIFF=1
 . . I FILE=2005.61,'$$PROCCHK(IEN,NEXTIEN) Q
 . . S AOF=$$AOF(FILE,IEN) D ADDAOF(IEN,AOF,.AOFS,.NAOFS)
 . . S AOF=$$AOF(FILE,NEXTIEN) D ADDAOF(NEXTIEN,AOF,.AOFS,.NAOFS)
 . I ($L(NAOFS,U)>1)!($L(AOFS,U)>1)!((AOFS'="")&(NAOFS'="")) D DELETE3(FILE,AOFS,NAOFS,DELETE,PATDIFF)
 . Q
 I '$G(MAGCNT) S MAGTEXT="   No duplicate records identified." D OUTPUT^MAGVCLN1(MAGTEXT,1,0,$G(MAGPOST))
 Q
 ;
DELETE3(FILE,AOFS,NAOFS,DELETE,PATDIFF) ; Inactivate records identified as duplicates
 ; If no AOFS mark INACCESSIBLE all but first NAOFS
 N DELIEN,ORIGNAOF,TOTNAOFS,TOTAOFS
 I AOFS="" D  Q
 . S ORIGNAOF=$P(NAOFS,U)
 . S TOTNAOFS=$L(NAOFS,U)
 . I TOTNAOFS>=2 F DELIEN=2:1:TOTNAOFS D
 . . I '$G(PATDIFF) D MOVESUBS(FILE,ORIGNAOF,$P(NAOFS,U,DELIEN),DELETE)
 . . D DELDUP(FILE,ORIGNAOF,$P(NAOFS,U,DELIEN),DELETE)
 . Q
 ; If AOF mark INACCESSIBLE all NAOFs and all but first AOF - link all children to 1st AOF record
 I $G(AOFS) D  Q
 . S ORIGAOF=$P(AOFS,U),TOTNAOFS=0
 . S TOTAOFS=$L(AOFS,U)
 . I $G(NAOFS) S TOTNAOFS=$L(NAOFS,U)
 . I TOTNAOFS F DELIEN=1:1:TOTNAOFS D
 . . I '$G(PATDIFF) D MOVESUBS(FILE,ORIGAOF,$P(NAOFS,U,DELIEN),DELETE)
 . . D DELDUP(FILE,ORIGAOF,$P(NAOFS,U,DELIEN),DELETE)
 . I TOTAOFS F DELIEN=2:1:TOTAOFS D
 . . I '$G(PATDIFF) D MOVESUBS(FILE,ORIGAOF,$P(AOFS,U,DELIEN),DELETE)
 . . D DELDUP(FILE,ORIGAOF,$P(AOFS,U,DELIEN),DELETE)
 . Q
 Q
DELDUP(FILE,ORIGIEN,DUPEIEN,DELETE) ; Mark Duplicates INACCESSIBLE
 N KEY,PROCKEY,STATUS,MAGPATID,PATIEN,PATNAME,FILEATT,FILERET,FILENAME,PATID
 I FILE=2005.6 S KEY=$$PATKEY(DUPEIEN)
 I FILE=2005.61 S KEY=$$PROCKEY(DUPEIEN)
 I FILE>=2005.62 S KEY=$P($G(^MAGV(FILE,DUPEIEN,0)),U)
 S STATUS=$$GET1^DIQ(FILE,DUPEIEN,"STATUS","I")
 Q:STATUS="I"
 S MAGCNT=$G(MAGCNT)+1
 S MAGTEXT="  DUPLICATE Records Found in "_FILE_": " D OUTPUT^MAGVCLN1(MAGTEXT,2,0,$G(MAGPOST))
 S PATID=$$PATMAGID^MAGVCLN1(FILE,ORIGIEN)
 S MAGTEXT="   Enterprise Patient ID: "_PATID D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 S FILEATT="NAME" D FILE^DID(FILE,,FILEATT,"FILERET") S FILENAME=$G(FILERET("NAME"))
 S MAGTEXT="   File Name: "_FILENAME_"   File Number: "_FILE D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 S MAGTEXT="   Key: "_KEY D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 S MAGTEXT="     File "_FILE_" Primary IEN: "_ORIGIEN D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 S MAGTEXT="     File "_FILE_" Duplicate IEN: "_DUPEIEN D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 I $G(FILE),$G(DUPEIEN),$D(^MAGV(FILE,DUPEIEN,0)) M ^XTMP("MAGVCLN",+$G(FILE),+$G(DUPEIEN))=^MAGV(FILE,DUPEIEN)
 I $G(DELETE) D
 . N INACTBIEN,INACTREAS,MAGFDA,IENS,INACTOUT
 . S MAGTEXT="   Setting STATUS to INACCESSIBLE..." D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . ;
 . ; Attempt to inactivate all child records
 . S INACTBIEN=$S($L($G(BADIEN)):BADIEN,1:"NULL")
 . S INACTREAS=$S(INACTBIEN="NULL":"Missing",1:"Inactive")_" Parent Reference"
 . D INACT^MAGVRS44(.INACTOUT,FILE,IEN,INACTBIEN,1,INACTREAS) ; Marks the entry indicated by file # and IEN as deleted (inactivated)
 . ;
 . ; Set status of problem record to inaccesible, to ensure duplicate records don't cause errors
 . S IENS=DUPEIEN_","
 . S MAGFDA(FILE,IENS,"STATUS")="I"
 . D FILE^DIE("","MAGFDA","ERR")
 . Q
 D AUDIT^MAGVCLN1(KEY,FILE,DUPEIEN,ORIGIEN,1,DELETE)
 Q
DELBP(FILE,KEY,IEN,REASON,DELETE,BADIEN) ; Report and/or inactivate (aka 'delete') records with broken pointers
 N FILEATT,FILRET,FILENAME,PFILE,PFILENAME
 Q:(($G(IEN)="")!($G(KEY)=""))
 S STATUS=$$GET1^DIQ(FILE,IEN,"STATUS","I")
 Q:STATUS="I"
 S MAGCNT=$G(MAGCNT)+1
 S MAGTEXT="  Identified "_$S($G(REASON)#2:"Invalid",1:"Missing")_" Parent File Pointer " D OUTPUT^MAGVCLN1(MAGTEXT,2,0,$G(MAGPOST))
 S FILEATT="NAME" D FILE^DID(FILE,,FILEATT,"FILERET") S FILENAME=$G(FILERET("NAME"))
 S MAGTEXT="   File Name: "_FILENAME_"   File Number: "_FILE_"   IEN: "_IEN D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 S MAGTEXT="   Key: "_KEY D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 S PFILE=FILE-.01 I PFILE>2005.6  S FILEATT="NAME" D FILE^DID(PFILE,,FILEATT,"FILERET") S PFILENAME=$G(FILERET("NAME"))
 S MAGTEXT="   Invalid Parent Pointer: "_$S($D(BADIEN):BADIEN,1:"NULL") D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 I $L($G(PFILENAME)) S MAGTEXT="  Points to: "_PFILENAME D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 I $G(FILE),$G(IEN),$D(^MAGV(FILE,IEN,0)) M ^XTMP("MAGVCLN",+$G(FILE),+$G(IEN))=^MAGV(FILE,IEN)
 I $G(DELETE) D
 . N IENS,MAGFDA,ERR,INACTREAS,INACTBIEN,INACTOUT
 . S MAGTEXT="   Setting STATUS to INACCESSIBLE..." D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . ;
 . ; Attempt to inactivate all child records
 . S INACTBIEN=$S($L($G(BADIEN)):BADIEN,1:"NULL")
 . S INACTREAS=$S(INACTBIEN="NULL":"Missing",1:"Inactive")_" Parent Reference"
 . D INACT^MAGVRS44(.INACTOUT,FILE,IEN,INACTBIEN,1,INACTREAS) ; Marks the entry indicated by file # and IEN as deleted (inactivated)
 . ;
 . ; Set status of problem record to inaccessible, to ensure data access methods don't produce errors
 . S IENS=IEN_","
 . S MAGFDA(FILE,IENS,"STATUS")="I"
 . D FILE^DIE("","MAGFDA","ERR")
 . Q
 D AUDIT^MAGVCLN1(KEY,FILE,IEN,"",REASON,DELETE,$G(BADIEN))
 Q
 ;
ADDAOF(IEN,AOF,AOFS,NAOFS)  ; Log AOF or NAOF
 ; If AOF add to AOF list
 I AOF D
 . N PC,REPEAT S REPEAT=0
 . F PC=1:1:$L(AOFS,U) Q:REPEAT  I $P(AOFS,U,PC)=IEN S REPEAT=1
 . Q:REPEAT
 . I $L(AOFS)>0 S AOFS=AOFS_U_IEN
 . I $L(AOFS)=0 S AOFS=IEN
 ; If not AOF add to not AOF list
 I 'AOF D
 . N PC,REPEAT S REPEAT=0
 . F PC=1:1:$L(NAOFS,U) Q:REPEAT  I $P(NAOFS,U,PC)=IEN S REPEAT=1
 . Q:REPEAT
 . I $L(NAOFS)>0 S NAOFS=NAOFS_U_IEN
 . I $L(NAOFS)=0 S NAOFS=IEN
 . Q
 Q
 ;
AOF(FILE,IEN) ; Determine if record has images on file
 N AOF
 I FILE=2005.6 S AOF=$P($G(^MAGV(2005.6,IEN,0)),U,4)
 I FILE=2005.61 S AOF=$P($G(^MAGV(2005.61,IEN,0)),U,6)
 I FILE=2005.62 S AOF=$P($G(^MAGV(2005.62,IEN,6)),U,2)
 I FILE=2005.63 S AOF=$P($G(^MAGV(2005.63,IEN,6)),U,2)
 I FILE=2005.64 S AOF=$P($G(^MAGV(2005.64,IEN,6)),U,2)
 I FILE=2005.65 S AOF=$P($G(^MAGV(2005.65,IEN,0)),U,2)
 Q AOF
PATKEY(IEN,PATFIL) ; Return 4-piece Patient Reference Key
 N PATREF,PATKEY,PID,AUTH,INST
 S PATREF=^MAGV(2005.6,IEN,0)
 S PID=$P(PATREF,U,1)
 S AUTH=$P(PATREF,U,2)
 S IDTYPE=$P(PATREF,U,3)
 S INST=$P(PATREF,U,8)
 S PATFIL=$P(PATREF,U,7)
 S PATKEY=PID_"/"_AUTH_"/"_IDTYPE_"/"_INST
 Q PATKEY
PROCKEY(IEN) ; Return 4-piece Procedure Reference Key
 N PROCREF,ACC,PROCT,AUTH,INST
 S PROCREF=^MAGV(2005.61,IEN,0)
 S ACC=$P(PROCREF,U,1)
 S PROCT=$P(PROCREF,U,3)
 S AUTH=$P(PROCREF,U,7)
 S INST=$P(PROCREF,U,8)
 S PROCKEY=ACC_"/"_PROCT_"/"_AUTH_"/"_INST
 Q PROCKEY
PATCHK(IEN,NEXTIEN) ; Patient Reference Duplicate Check
 ; Patient references have 4 key values
 N PATKEY1,PATKEY2,MATCH,IDTYPE,PATFIL1,PATFIL2
 S MATCH=0,PATFIL=""
 S PATKEY1=$$PATKEY(IEN,.PATFIL1)
 S PATKEY2=$$PATKEY(NEXTIEN,.PATFIL2)
 I PATKEY1=PATKEY2 S MATCH=1
 I MATCH,($P(PATKEY1,"/",3)="D"),$G(PATFIL1)'=$G(PATFIL2) S MATCH=-1  ; Different PATIENT (#2) file records
 Q MATCH
PROCCHK(IEN,NEXTIEN) ; Patient Reference Duplicate Check
 ; Procedure references have 4 key values
 N PROCKEY1,PROCKEY2,MATCH
 S MATCH=0
 S PROCKEY1=$$PROCKEY(IEN)
 S PROCKEY2=$$PROCKEY(NEXTIEN)
 I PROCKEY1=PROCKEY2 S MATCH=1
 Q MATCH
MOVESUBS(FILE,ORIGAOF,DELIEN,DELETE) ; Move subfile child records
 Q:DELIEN=""
 N MAGFDA,SFILE,FIELD,CHILD,REASON,ACTION,FILNAME,FILEATT,FIELDATT
 S FILEATT="NAME" D FILE^DID(FILE,,FILEATT,"FILERET") S CHILDFILE=$G(FILERET("NAME"))
 D FILE^DID(FILE-.01,,FILEATT,"FILRET") S PARENTFILE=$G(FILERET("NAME"))
 S REASON=6
 S ACTION=$S($G(DELETE):"MC",1:"MI")
 S SFILE=FILE+.01,CHILD=0
 F  S CHILD=$O(^MAGV(SFILE,"C",DELIEN,CHILD)) Q:'CHILD  D
 . N KEY,FLDNAME,CHILDFILE,PARENTFILE,FILERET,PATNAME,PATIEN,FIELDATT,STATUS
 . S STATUS=$$GET1^DIQ(SFILE,CHILD,"STATUS","I")
 . Q:STATUS="I"  ; Don't bother with Inaccessible children
 . S FILEATT="NAME" D FILE^DID(SFILE,,FILEATT,"FILERET") S CHILDFILE=$G(FILERET("NAME"))
 . K FILERET D FILE^DID(FILE,,FILEATT,"FILERET") S PARENTFILE=$G(FILERET("NAME"))
 . S KEY=$$GET1^DIQ(SFILE,CHILD_",",.01)
 . I SFILE=2005.61 S FIELD=.99
 . I SFILE'=2005.61 S FIELD=11
 . S FLDNAME=$P(^DD(SFILE,FIELD,0),"^")
 . S MAGTEXT=$S(ACTION="MC":"   Moving File "_SFILE_" Record's Pointer From Duplicate Parent to Primary Parent: ",1:"   Identified File "_SFILE_" Record Pointing to Duplicate Record in File "_FILE)
 . D OUTPUT^MAGVCLN1(MAGTEXT,1,0,$G(MAGPOST))
 . S PATNAME=$$PATNAME^MAGVCLN1(SFILE,+$G(CHILD))
 . S PATID=$$PATMAGID^MAGVCLN1(SFILE,+$G(CHILD))
 . I $L(PATNAME) S MAGTEXT="       Enterprise Patient ID: "_PATID D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="       File: "_$G(CHILDFILE)_"   IEN: "_CHILD D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT=$S($G(DELETE):"        Old",1:"        (Current)")_" Pointer to File "_FILE D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="              Duplicate IEN: "_DELIEN D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S FIELDATT="LABEL" D FIELD^DID(FILE,.01,"",FIELDATT,"FIELDRET")
 . I $L($G(FIELDRET("LABEL"))) S MAGTEXT="             "_FIELDRET("LABEL")_": "_$$GET1^DIQ(FILE,DELIEN,.01) D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="         "_$S($G(DELETE):"New",1:"(Prospective)")_" Pointer to File "_FILE D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="              Primary IEN: "_ORIGAOF D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . I $L($G(FIELDRET("LABEL"))) S MAGTEXT="              "_FIELDRET("LABEL")_": "_$$GET1^DIQ(FILE,ORIGAOF,.01) D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . ;
 . I $G(DELETE) D
 . . S MAGFDA(SFILE,CHILD_",",FIELD)=ORIGAOF
 . . D FILE^DIE("","MAGFDA","ERR") K MAGFDA
 . D AUDIT^MAGVCLN1(KEY,SFILE,CHILD,"",+$G(REASON),ACTION,,$G(ORIGAOF),DELIEN)
 . Q
 ;
 ; Move Study's patient reference
 I FILE=2005.6 S CHILD=0 F  S CHILD=$O(^MAGV(2005.62,"L",DELIEN,CHILD)) Q:'CHILD  D
 . N KEY,FLDNAME,FILE6,FILE62
 . S FLDNAME="PATIENT REFERENCE",FILE6="IMAGING PATIENT REFERENCE",FILE62="IMAGE STUDY"
 . S KEY=$$GET1^DIQ(2005.62,CHILD,.01)
 . S MAGTEXT="   "_$S(ACTION="MC":"Moving File 2005.62 Record's Pointer From Duplicate to Primary Record in File 2005.6",1:"Identified File 2005.62 Record Pointing to Duplicate Record in File 2005.6")
 . D OUTPUT^MAGVCLN1(MAGTEXT,2,0,$G(MAGPOST))
 . S PATNAME=$$PATNAME^MAGVCLN1(2005.62,CHILD)
 . S PATID=$$PATMAGID^MAGVCLN1(2005.62,+$G(CHILD))
 . S MAGTEXT="       Enterprise Patient ID: "_PATID D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="       File: "_FILE62_"   IEN: "_CHILD D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="        "_$S($G(DELETE):" Old",1:" (Current)")_" Pointer to File 2005.6" D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="              Duplicate IEN: "_DELIEN D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . K FIELDRET
 . S FIELDATT="LABEL" D FIELD^DID(2005.6,.01,"",FIELDATT,"FIELDRET") I $L($G(FIELDRET("LABEL"))) D
 . . S MAGTEXT="              "_FIELDRET("LABEL")_": "_$$GET1^DIQ(2005.6,DELIEN,.01) D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="        "_$S($G(DELETE):"New",1:" (Prospective)")_" Pointer to File 2005.6" D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . S MAGTEXT="              Primary IEN: "_ORIGAOF D OUTPUT^MAGVCLN1(MAGTEXT,0,0,$G(MAGPOST))
 . ;
 . I $L($G(FIELDRET("LABEL"))) D
 . . S MAGTEXT="               "_FIELDRET("LABEL")_": "_$$GET1^DIQ(2005.6,ORIGAOF,.01)
 . I $G(DELETE) D
 . . N MAGFDA S MAGFDA(2005.62,CHILD_",",13)=ORIGAOF
 . . D FILE^DIE("","MAGFDA","ERR")
 . D AUDIT^MAGVCLN1(KEY,2005.62,CHILD,"",REASON,ACTION,,$G(ORIGAOF),DELIEN)
 . Q
 Q
CONT ; Continue
 W ! K DIR("A") S DIR(0)="E" D ^DIR K DIR
 Q
 ;
QUE ; Queue Search and Resolve processes
 N CALLBACK,MENUIEN
 D CLEAR^MAGUERR(1)
 ;
 D IDDEL^MAGVCLN(0,1)  ; Log Identification of Problem Records
 H 60  ; Ensure Identification and Resolution are logged at distinct date/times
 D IDDEL^MAGVCLN(1,1)  ; Log Resolution of Problem Records
 ;
 Q
