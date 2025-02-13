MAGVIM09 ;WOIFO/DAC,MAT,JSJ,RRM,BT,JSL - Utilities for RPC calls for DICOM file processing ; Oct 04, 2022@19:19:13
 ;;3.0;IMAGING;**118,138,332,345,357**;Mar 19, 2002;Build 29
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
 ; +++++  Get a record from a WORK ITEM file (#2006.941) by IEN 
 ; 
 ; Input parameters
 ; ================
 ; ID = IEN in the file
 ; STARTCNT = starting line in OUT array
 ; 
 ; Return Values
 ; =============
 ;   OUT(STARTCNT)="WorkItemHeader"_delimited "`" fields values
 ;   OUT(STARTCNT+1..n)=Message
 ;   OUT(n+1..m)=Tags`TagName`TagValue
 ;
GETWI(OUT,ID,STOPTAG,SRV) ; Return Work Item record in OUT array
 ; OUT      - array that holds the result
 ; ID       - IEN of the Work Item 
 ; STOPTAG  - The last tag of a record to be returned (optional)
 N FILE,IENS,MAGOUT,ERR,FLD,CNT,TAGS,I,AFLD,DATA
 N SSEP,OSEP,STOP,TAGNAME,TAGVALUE
 S SSEP=$$STATSEP^MAGVIM01,OSEP=$$OUTSEP^MAGVIM01
 S FILE=2006.941
 S IENS=ID_","
 D GETS^DIQ(FILE,ID_",","*","IE","MAGOUT","ERR")
 I $D(ERR) S OUT="-1"_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q 
 ; Type of the return field values - internal, external, date
 S AFLD(.01)="D"  ; CREATED DATE/TIME
 S AFLD(1)="E"    ; TYPE
 S AFLD(2)="E"    ; SUBTYPE
 S AFLD(3)="E"    ; STATUS
 S AFLD(4)="I"    ; LOCATION
 S AFLD(5)="E"    ; PRIORITY
 S AFLD(8)="IE"   ; CREATING USER
 S AFLD(9)="D"    ; LAST UPDATED DATE/TIME
 S AFLD(10)="IE"  ; LAST UPDATING USER
 S AFLD(14)="E"   ; CREATING APPLICATION
 S AFLD(15)="E"   ; LAST UPDATING APPLICATION
 S AFLD(16)="E"   ; SC TRANSACTION ID
 ;
 ;Convert Institution IEN to Station Number
 I $G(MAGOUT(FILE,IENS,4,"I")) D
 . S MAGOUT(FILE,IENS,4,"I")=$$STA^XUAF4(MAGOUT(FILE,IENS,4,"I")) ;IA #2171 Get station number for an IEN
 . Q
 ;
 S CNT=OUT(0)+1
 S FLD=0
 S OUT(CNT)="WorkItemHeader"_SSEP_ID
 F  S FLD=$O(MAGOUT(FILE,IENS,FLD)) Q:FLD=""  D
 . Q:FLD=13  ; Word-processing field
 . I AFLD(FLD)["D" S OUT(CNT)=OUT(CNT)_OSEP_$$FMTE^XLFDT(MAGOUT(FILE,IENS,FLD,"I"),5)  ; Date fields
 . I AFLD(FLD)["I" S OUT(CNT)=OUT(CNT)_OSEP_MAGOUT(FILE,IENS,FLD,"I")
 . I AFLD(FLD)["E" S OUT(CNT)=OUT(CNT)_OSEP_MAGOUT(FILE,IENS,FLD,"E")
 . Q
 ; Get Message
 S I=0 F  S I=$O(MAGOUT(FILE,IENS,13,I)) Q:I'>0  D
 . S CNT=CNT+1,OUT(CNT)="Message"_SSEP_MAGOUT(FILE,IENS,13,I)
 . Q
 ; Get Tags
 S TAGS=2006.94111,I="",STOP=0
 I $G(SRV)'="" S CNT=CNT+1,OUT(CNT)="Tag"_SSEP_"Service"_OSEP_SRV
 S I=0
 F  S I=$O(^MAGV(2006.941,ID,4,I)) Q:I=""  D  Q:STOP=1
 . S DATA=$G(^MAGV(2006.941,ID,4,I,0))
 . S TAGNAME=$P(DATA,U,1),TAGVALUE=$P(DATA,U,2)
 . S CNT=CNT+1,OUT(CNT)="Tag"_SSEP_TAGNAME_OSEP_TAGVALUE
 . I $G(STOPTAG)'="",STOPTAG=TAGNAME S STOP=1
 S OUT(0)=CNT
 Q
 ;
 ;P332 IMSTATUS moved from MAGVIM01 because routine size was exceeded
 ; RPC: MAGV IMPORT STATUS from MAGVIM01
IMSTATUS(OUT,UIDS) ; Get import status
 N SSEP,STUDYLIST,SOPLIST,STUDYOUT,SOPOUT,I,CNT,STUDYUID,SERUID,SOPUID,ISEP,SOPIEN,SERIEN,STUDIEN,FOUNDUID
 N ONFILESOP
 S SSEP=$$OUTSEP^MAGVIM01,ISEP=$$INPUTSEP^MAGVIM01,I=0,CNT=0 ;P332 add routine to calls
 I '$D(UIDS) S OUT(1)=-6_SSEP_"No UIDs provided" Q
 F  S I=$O(UIDS(I)) Q:I=""  D
 . S CNT=I,FOUNDUID="",ONFILESOP=0
 . S STUDYUID=$P(UIDS(I),ISEP,1),SERUID=$P(UIDS(I),ISEP,2),SOPUID=$P(UIDS(I),ISEP,3)
 . I $G(STUDYUID)="" S OUT(I+1)=-1_SSEP_"No study UID provided" Q
 . I $G(SERUID)="" S OUT(I+1)=-2_SSEP_"No series UID provided" Q
 . I $G(SOPUID)="" S OUT(I+1)=-3_SSEP_"No SOP UID provided" Q
 . S OUT(I+1)=-1_SSEP_UIDS(I)_SSEP_"not on file"
 . S STUDYLIST(1)=1,STUDYLIST(2)=STUDYUID
 . S SOPLIST(1)=1,SOPLIST(2)=SOPUID
 . ; Check ^MAG(2005) for import study status 
 . D CHECKUID^MAGDRPCA(.STUDYOUT,.STUDYLIST,"STUDY")
 . I STUDYOUT(2)'="",(+STUDYOUT(2))'<0 D
 . . D CHECKUID^MAGDRPCA(.SOPOUT,.SOPLIST,"SOP")
 . . I SOPOUT(2)'="",(+SOPOUT(2))'<0 D  S CNT=I
 . . . S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . . . S ONFILESOP=1
 . . . Q
 . . Q
 . I $G(STUDYOUT(2))="",$G(ONFILESOP)<1 D SOPCHECK(.UIDS,I) Q:$G(ONFILESOP)
 . S SOPOUT=""
 . ; Check SOP original and UID
 . I ('$D(^MAGV(2005.64,"B",SOPUID)))&('$D(^MAGV(2005.66,"B",SOPUID))) D SOPCHECK(.UIDS,I) Q
 . S SOPIEN=$O(^MAGV(2005.64,"B",SOPUID,""),-1)
 . ;if null try dup(replaced) UID
 . I SOPIEN="" S SOPIEN=$$DUPUID(.UIDS,I,SOPUID,3)  ;P332 Check for replacement
 . Q:SOPIEN=""
 . I $G(^MAGV(2005.64,SOPIEN,11))'="A" Q
 . ; Check Series original and UID
 . I ('$D(^MAGV(2005.63,"B",SERUID)))&('$D(^MAGV(2005.66,"B",SERUID))) D  Q:$G(FOUNDUID)=""
 . . I $G(SOPIEN)'="" S FOUNDUID=$$RECHKFLE(.UIDS,I,SOPUID,2)
 . S SERIEN=$O(^MAGV(2005.63,"B",$S($G(FOUNDUID)'="":FOUNDUID,1:SERUID),""),-1)
 . ;if null try dup(replaced) UID
 . I SERIEN="" S SERIEN=$$DUPUID(.UIDS,I,SERUID,2)  ;P332 Check for replacement
 . Q:SERIEN=""
 . I $G(^MAGV(2005.63,SERIEN,9))'="A" Q
 . ; Check Study original and UID
 . I ('$D(^MAGV(2005.62,"B",STUDYUID)))&('$D(^MAGV(2005.66,"B",STUDYUID))) D  Q:$G(FOUNDUID)=""
 . . I $G(SERIEN)'="" S FOUNDUID=$$RECHKFLE(.UIDS,I,SERUID,1)
 . S STUDIEN=$O(^MAGV(2005.62,"B",$S($G(FOUNDUID)'="":FOUNDUID,1:STUDYUID),""),-1)
 . ;if null try dup(replaced) UID
 . I STUDIEN="" S STUDIEN=$$DUPUID(.UIDS,I,STUDYUID,1)  ;P332 Check for replacement
 . Q:STUDIEN=""
 . I $P($G(^MAGV(2005.62,STUDIEN,5)),U,2)'="A" Q
 . S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . I SOPIEN'="" S ONFILESOP=1
 . Q
 ;
 S OUT(1)=0_SSEP_CNT
 Q
 ;
SOPCHECK(UIDS,I) ;
 N MAG2005IEN,MAGPARENTIEN
 S SOPUID=$P(UIDS(I),ISEP,3)
 I $D(^MAG(2005,"P",SOPUID)) D
 . D CHECKUID^MAGDRPCA(.SOPOUT,.SOPLIST,"SOP")
 . I SOPOUT(2)'="",(+SOPOUT(2))'<0 D
 . . D CHECKUID^MAGDRPCA(.STUDYOUT,.STUDYLIST,"STUDY")
 . . I SOPOUT(2)'="",(+SOPOUT(2))'<0 S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . . S ONFILESOP=1
 Q
 ;
RECHKFLE(UIDS,I,UID,TYPE) ;
 N FILE,NEWUID
 I TYPE=1 S FILE=2005.63
 I TYPE=2 S FILE=2005.64
 I $D(^MAGV(FILE,"B",UID)) D
 . S IEN=$O(^MAGV(FILE,"B",UID,""))
 . S IEN=$P(^MAGV(FILE,IEN,6),"^")
 . I TYPE=1 D
 . . S NEWUID=$P($G(^MAGV(2005.62,IEN,0)),"^")
 . . ;S $P(UIDS(I),ISEP,TYPE)=NEWUID
 . I TYPE=2 D
 . . S NEWUID=$P($G(^MAGV(2005.63,IEN,0)),"^")
 . . ;S $P(UIDS(I),ISEP,TYPE)=NEWUID
 Q $G(NEWUID)  ;SF prevent UNDEF errors 
 ;
 ;Set replaced UID in UIDS array if found in 2005.66 duplicate file
DUPUID(UIDS,I,UID,TYPE)  ;P332 added sub
 ; UIDS - Array of UIDs
 ; I    - Current array element of UIDS being processed
 ; UID  - Original UID of TYPE being checked for duplicate
 ; TYPE - UID type - 1-STUDY, 2-SERIES, 3-SOP
 I UID=""!(TYPE="") Q ""
 NEW IEN,FILE,REC0,RPLFND,RPLIEN
 S FILE=$P("2005.62,2005.63,2005.64",",",TYPE)
 S (IEN,RPLIEN,RPLFND)=""
 ;loop dup index from latest and quit if a match is found
 F  S RPLIEN=$O(^MAGV(2005.66,"B",UID,RPLIEN),-1) Q:(RPLIEN="")!RPLFND  D
 . S REC0=$G(^MAGV(2005.66,RPLIEN,0))
 . I TYPE'=$P(REC0,U,5) Q   ;UID type mismatch
 . I UID'=$P(REC0,U) Q      ;UID doesn't match orig in dup record
 . ;verify dup UID is in file index and UID matches original UID in FILE
 . S IEN=$O(^MAGV(FILE,"B",$P(REC0,U,2),""),-1)  ;get IEN from file with replaced UID
 . I IEN="" Q                                    ;replaced UID not in FILE index
 . I UID'=$P($G(^MAGV(FILE,IEN,0)),"^",2) Q      ;original UID does not match
 . S $P(UIDS(I),ISEP,TYPE)=$P(REC0,U,2)          ;set replacement UID
 . S RPLFND=1                                    ;quit loop
 Q IEN  ;return FILE IEN for replaced UID (or null if not found)
 ;
 ; RPC: MAGV FIND WORK ITEM  (Calling from FIND^MAGVIM01)
FIND(OUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,STOPTAG,MAXROWS,TAGS,LASTIEN,ORDER,DTFROM,DTTO) ; Find records with given attributes - return ID
 ;PLACEID is FILE #4's STATION NUMBER
 N IEN,IEN2,J,TAGMATCH,SSEP,ISEP,TAG,WICOUNT,FLD
 N VALUE,FLDS,AFLD,NOMATCH,IENS,MAGOUT,LOCIEN,SRV
 N TAGITM,PATNAME,GLB,FLTITM,RET
 S SSEP=$$STATSEP^MAGVIM01,ISEP=$$INPUTSEP^MAGVIM01
 S:'$G(DTFROM) DTFROM=0
 S:'$G(DTTO) DTTO=9999999
 ;
 I $G(MAXROWS)'="",'(MAXROWS?1N.N) S OUT=-2_SSEP_"Invalid MAXROWS parameter provided" Q
 ;
 I $G(PLACEID)'="" D  Q:$G(OUT)<0
 . S LOCIEN=$$IEN^XUAF4(PLACEID) ;IA #2171 Get Institution IEN for a station number
 . I LOCIEN="" S OUT=-2_SSEP_"Invalid PLACEID parameter provided"
 . Q
 ;
 S OUT(0)=0
 ; AFLD(FLD,"IE") = compare the external or internal value of the field
 S FLDS=""
 I $G(TYPE)'="" S FLDS=FLDS_"1;",AFLD(1)=TYPE,AFLD(1,"IE")="E"
 I $G(SUBTYPE)'="" S FLDS=FLDS_"2;",AFLD(2)=SUBTYPE,AFLD(2,"IE")="E"
 I $G(STATUS)'="" S FLDS=FLDS_"3;",AFLD(3)=STATUS,AFLD(3,"IE")="E"
 I $G(LOCIEN)'="" S FLDS=FLDS_"4;",AFLD(4)=LOCIEN,AFLD(4,"IE")="I"
 I $G(PRIORITY)'="" S FLDS=FLDS_"5;",AFLD(5)=PRIORITY,AFLD(5,"IE")="E"
 ;
 K FLTITM S RET=$$GFLTITM^MAGVIM01(.FLTITM,.TAGS) ;filter Source, Service, Modality, and Procedure 
 I RET S GLB="FLTITM"
 I 'RET S GLB="^MAGV(2006.941)"
 ;
 K ERR
 S:'$G(ORDER) ORDER=1
 I '$G(LASTIEN) D
 . I ORDER=1 S LASTIEN=0
 . I ORDER=-1 S LASTIEN=9999999
 S IEN=LASTIEN,WICOUNT=1
 ;
 F  S IEN=$O(@GLB@(IEN),ORDER) Q:(+IEN=0)!$D(ERR)!(($G(MAXROWS)'="")&(WICOUNT>$G(MAXROWS)))  D
 . Q:'$$DTINRNG^MAGVIM01(IEN,DTFROM,DTTO)
 . S IENS=IEN_"," K ERR,MAGOUT
 . D GETS^DIQ(2006.941,IENS,FLDS,"IE","MAGOUT","ERR")
 . I $D(ERR) K OUT S OUT(0)=-1_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q  ; Set Error and quit
 . S FLD="",NOMATCH=0
 . F  S FLD=$O(AFLD(FLD)) Q:FLD=""!NOMATCH  D
 . . S:AFLD(FLD)'=MAGOUT("2006.941",IENS,FLD,AFLD(FLD,"IE")) NOMATCH=1
 . . Q
 . Q:NOMATCH  ; get next one if no match
 . ; Tag matching
 . S SRV=$$SRV^MAGVIM01(IEN),J=0,TAGMATCH=1
 . F  S J=$O(TAGS(J)) Q:(J="")!'TAGMATCH  D
 . . S TAG=$P(TAGS(J),ISEP,1),VALUE=$P(TAGS(J),ISEP,2)
 . . I TAG="Procedure",VALUE="[No Procedure]",'$D(^MAGV(2006.941,"H",TAG,IEN)) Q
 . . I TAG="Modality",VALUE="[No Modality]",'$D(^MAGV(2006.941,"H",TAG,IEN)) Q
 . . I TAG="Service",VALUE'="" D  Q
 . . . I VALUE="[No Service]",SRV="" Q
 . . . I SRV'=VALUE S TAGMATCH=0
 . . I TAG="PatientName",VALUE'="",'$D(^MAGV(2006.941,"H",TAG,IEN)) S TAGMATCH=0 Q
 . . I TAG="PatientName",VALUE'="",$D(^MAGV(2006.941,"H",TAG,IEN)) D  Q
 . . . S TAGITM=$O(^MAGV(2006.941,"H",TAG,IEN,"")) I TAGITM="" S TAGMATCH=0 Q
 . . . S PATNAME=$P($G(^MAGV(2006.941,IEN,4,TAGITM,0)),U,2) I PATNAME="" S TAGMATCH=0 Q
 . . . I '$F($$UPCASE(PATNAME),$$UPCASE(VALUE)) S TAGMATCH=0 Q
 . . I VALUE'="",$L(VALUE)<31,'$D(^MAGV(2006.941,"HH",TAG,VALUE,IEN)) S TAGMATCH=0 Q
 . . I VALUE'="",$L(VALUE)<31,$D(^MAGV(2006.941,"HH",TAG,VALUE,IEN)) Q
 . . S IEN2=$O(^MAGV(2006.941,"H",TAG,IEN,""))
 . . I $P($G(^MAGV(2006.941,IEN,4,IEN2,0)),U,2)'=VALUE S TAGMATCH=0
 . . Q
 . I 'TAGMATCH Q
 . ; Add work item header to output array
 . D GETWI^MAGVIM09(.OUT,IEN,"",SRV)  ; Get Work Item Record
 . I +OUT(0)<0 S ERR=""  ; Check for error and set ERR to quit from the loop
 . S WICOUNT=WICOUNT+1
 . S LASTIEN=IEN
 . Q
 ;Save the last IEN processed, used to retrieve more rows
 I IEN,'$D(ERR) S OUT(0)=OUT(0)_SSEP_LASTIEN
 Q
 ;
UPDWI(ID,FDA,MSGUPD) ; Update work item
 ; Return 0|Error`Message error
 ; 
 ; ID - IEN of Work Item
 ; FDA - VA FileMan FDA array
 ; MSGUPD - Message array
 N ERR,SSEP
 S SSEP=$$STATSEP^MAGVIM01
 ;
 D VALIDATE^MAGVIM06(.FDA,.ERR)
 I $D(ERR("DIERR",1,"TEXT",1)) Q -4_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 ;
 K ERR
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR("DIERR",1,"TEXT",1)) Q -3_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 ;
 ; Update Message field
 K ERR
 I $D(MSGUPD) D WP^DIE(2006.941,ID_",",13,"K","MSGUPD","ERR")
 I $D(ERR("DIERR",1,"TEXT",1)) Q -5_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 ;
 Q 0_SSEP_"Work item "_ID_" updated"
 ;
UPCASE(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
