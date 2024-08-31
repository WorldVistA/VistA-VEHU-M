SDES2GETVISIT ;ALB/JAS,TJB - SDES2 VISTA SCHEDULING API for Visit Retrieval and Checkin functions ;Jun 17, 2024
 ;;5.3;Scheduling;**878,881**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Based off of SDECAPI4 & SDECAPI with portions of code pulled from SDECU2 & SDECV
 ;
 Q
 ;
GETVISIT(SDOUTPUT,SDINPUT) ;Private Entry Point
 ; >> All date/time variables must be in FileMan internal format
 ; Special Incoming Variables:
 ;  SDINPUT("FORCE ADD")   = 1    ; no matter what, create new visit (Optional)
 ;  SDINPUT("NEVER ADD")   = 1    ; never add visit, just try to find one or more (Optional)
 ;  SDINPUT("ANCILLARY")   = 1    ; for ancillary packages to create noon visit if no match found (Optional)
 ;  SDINPUT("SHOW VISITS") = 1    ; this will display visits if more than one match
 ; Incoming Variables used in Matching: REQUIRED
 ;  SDINPUT("PAT")         = patient IEN (file 2 or 9000001)
 ;  SDINPUT("VISIT DATE")  = visit date & time (same as check-in date & time)
 ;  SDINPUT ("SITE")       = location of encounter IEN (file 4 or 9999999.06)
 ;  SDINPUT("VISIT TYPE")  = internal value for field .03 in Visit file
 ;  SDINPUT("SRV CAT")     = internal value for service category
 ;  SDINPUT("TIME RANGE")  = #    ; range in minutes for matching on visit time; REQUIRED unless FORCE ADD set
 ;                                ; zero=exact matches only; -1=don't match on time
 ; These are used to match if sent (Optional)
 ;  SDINPUT("PROVIDER")    = IEN for provider to match from file 200
 ;  SDINPUT("CLINIC CODE") = IEN of clinic stop code (file 40.7)
 ;  SDINPUT("HOS LOC")     = IEN of hospital location (file 44, field .22 in VISIT file)
 ; Incoming Variables used in creating appt and visit
 ;  SDINPUT("APPT DATE")   = appt date & time (Required for scheduled appts and walk-ins; check-in will be performed)
 ;  SDINPUT("USR")         = user IEN in file 200; REQUIRED
 ;  SDINPUT("OPT")         = name for Option Used To Create field, for check-in only (Optional)
 ;  SDINPUT("OI")          = reason for appointment; for walk-ins (Optional)
 ; Incoming PCC variables for adding additional info to visit (Optional)
 ;  SDINPUT("SDTPB")       = Third Party Billed (#.04)
 ;  SDINPUT("SDPVL")       = Parent Visit Link (#.12)
 ;  SDINPUT("SDAPPT")      = WalkIn/Appt (#.16)
 ;  SDINPUT("SDEVM")       = Evaluation and Management Code (#.17)
 ;  SDINPUT("SDCODT")      = Check Out Date & Time (#.18)
 ;  SDINPUT("SDLS")        = Level of Service -PCC Form  (#.19).
 ;  SDINPUT("SDVELG")      = Eligibility (#.21)
 ;  SDINPUT("SDPROT")      = Protocol (#.25).
 ;  SDINPUT("SDOPT")       = Option Used To Create (#.24)
 ;  SDINPUT("SDOLOC")      = Outside Location (#2101)
 ; Outgoing Array:
 ;  SDOUTPUT(0) always set; if = 0 none found and may have error message in 2nd piece
 ;                          if = 1 and SDOUTPUT(visit ien)="ADD" new visit just created
 ;                          if = 1 and SDOUTPUT(visit ien)=#; # is time difference in minutes
 ;                          if >1, multiple SDOUTPUT(visit ien) entries exist
 N SDARRAY K SDOUTPUT
 M SDARRAY=SDINPUT    ;preserve incoming array
 I '$$HAVEREQ(.SDOUTPUT,.SDARRAY) Q    ;check required fields
 I '$G(SDARRAY("SDOPT")) D
 . I $G(SDARRAY("OPT"))]"",SDARRAY("OPT")?.N,$D(^DIC(19,SDARRAY("OPT"))) S SDARRAY("SDOPT")=SDARRAY("OPT") Q
 . I $G(SDARRAY("OPT"))]"",$E(SDARRAY("OPT"),1,1)="`" S SDARRAY("SDOPT")=$TR(SDARRAY("OPT"),"`") Q
 . I $G(SDARRAY("OPT"))]"",SDARRAY("OPT")'?.N S SDARRAY("SDOPT")=$O(^DIC(19,"B",SDARRAY("OPT"),0)) Q
 . I $G(SDARRAY("SDOPT"))]"",$E(SDARRAY("SDOPT"),1,1)="`" S SDARRAY("SDOPT")=$TR(SDARRAY("SDOPT"),"`") Q
 . I $G(SDARRAY("SDOPT"))]"",SDARRAY("SDOPT")'?.N S SDARRAY("SDOPT")=$O(^DIC(19,"B",SDARRAY("SDOPT"),0)) Q
 I $G(SDARRAY("FORCE ADD")) D ADDVIST(.SDOUTPUT,.SDARRAY) Q
 ; attempt to find matching visits; return SDOUTPUT array
 I '$G(SDARRAY("FORCE ADD")) D MATCH(.SDOUTPUT,.SDARRAY)
 ; if no appointment date/time sent, just create visit and quit
 I '$G(SDARRAY("APPT DATE")) D ADDVIST(.SDOUTPUT,.SDARRAY) Q
 ; if one matching visit found, continue to check-in
 I SDOUTPUT(0)=1 S SDARRAY("VIEN")=$O(SDOUTPUT(0))
 ; if patient already has appt at this time, call Check-in then quit
 N IEN,ERR,VISIT
 S IEN=$$SCIEN(SDARRAY("PAT"),SDARRAY("HOS LOC"),SDARRAY("APPT DATE"))  ;find appt
 I IEN D  Q
 . ; set variables used by checkin call
 . S SDARRAY("CDT")=SDARRAY("VISIT DATE")
 . S SDARRAY("CC")=$G(SDARRAY("CLINIC CODE"))
 . S SDARRAY("PRV")=$G(SDARRAY("PROVIDER"))
 . S SDARRAY("CLN")=$G(SDARRAY("HOS LOC"))
 . S SDARRAY("ADT")=$G(SDARRAY("APPT DATE"))
 . S ERR=$$CHECKIN(.SDARRAY)      ;check in
 . ; reset SDOUTPUT only if truly added one.
 . I 'ERR S VISIT=$$GETVST(SDARRAY("PAT"),SDARRAY("APPT DATE")) I VISIT,'$G(SDARRAY("VIEN")) S:SDOUTPUT(0)=0 SDOUTPUT(0)=1 S SDOUTPUT(VISIT)="ADD" Q
 . I ERR S SDOUTPUT(0)=0_U_$P(ERR,U,2)
 ; else call walk-in (which calls make appt, checkin and create visit)
 D WALKIN(.SDOUTPUT,.SDARRAY)
 Q
 ;
MATCH(SDOUT,SDINPUT) ; find matching visits based on input array
 S SDOUT(0)=0
 N END,DATE,VIEN,STOP,DIFF,MATCH
 S MATCH=0
 D TIME(SDINPUT("TIME RANGE"),SDINPUT("VISIT DATE"),.DATE,.END)
 F  S DATE=$O(^AUPNVSIT("AA",SDINPUT("PAT"),DATE)) Q:'DATE  Q:(DATE>END)  D
 . S VIEN=0
 . F  S VIEN=$O(^AUPNVSIT("AA",SDINPUT("PAT"),DATE,VIEN)) Q:'VIEN  D
 . . I $$GET1^DIQ(9000010,VIEN,.11)="DELETED" Q                     ;check for delete flag just in case xref not killed
 . . I SDINPUT("SITE")'=$$GET1^DIQ(9000010,VIEN,.06,"I") Q          ;no match on loc of enc
 . . I SDINPUT("VISIT TYPE")'=$$GET1^DIQ(9000010,VIEN,.03,"I") Q    ;no match on visit type
 . . ; get observation and day surgery visits
 . . I SDINPUT("SRV CAT")["CENRT" Q  ;don't look at HIM excluded visits
 . . I $$GET1^DIQ(90000010,VIEN,.07,"I")["CENRT" Q  ;don't look at HIM excluded visits
 . . I SDINPUT("SRV CAT")=$$GET1^DIQ(9000010,VIEN,.07,"I") S MATCH=1       ;no match on service category
 . . I SDINPUT("SRV CAT")="A",$G(SDINPUT("ANCILLARY")),$$GET1^DIQ(9000010,VIEN,.07,"I")="O" S MATCH=1  ;match if observation
 . . I SDINPUT("SRV CAT")="A",$G(SDINPUT("ANCILLARY")),$$GET1^DIQ(9000010,VIEN,.07,"I")="D" S MATCH=1
 . . I '$G(MATCH) Q
 . . I SDINPUT("TIME RANGE")>-1 S STOP=0 D  Q:STOP                  ;check time range
 . . . S DIFF=$$TIMEDIF(SDINPUT("VISIT DATE"),VIEN)                 ;find difference in minutes
 . . . I $$ABS^XLFMTH(DIFF)>SDINPUT("TIME RANGE") S STOP=1
 . . I '$$PRVMTCH(.SDINPUT,VIEN) Q   ; if provider sent and didn't match, skip
 . . ; if called by ancillary, falls through and sets visit into array
 . . ; otherwise, check if app wants to match on clinic code or hosp location
 . . I '$G(SDINPUT("ANCILLARY")) S STOP=0 D  Q:STOP
 . . . I $G(SDINPUT("HOS LOC")),'$G(SDINPUT("CLINIC CODE")) S SDINPUT("CLINIC CODE")=$$GET1^DIQ(44,SDINPUT("HOS LOC"),8,"I")
 . . . I $G(SDINPUT("CLINIC CODE")),SDINPUT("CLINIC CODE")'=$$GET1^DIQ(9000010,VIEN,.08,"I") S STOP=1 Q  ;no match on clinic code
 . . . ; if both have appt date and visit was triage clinic, is a match
 . . . ; create visit on same day no matter what
 . . . I $G(SDINPUT("HOS LOC")),(SDINPUT("HOS LOC")'=$$GET1^DIQ(9000010,VIEN,.22,"I")) S STOP=1 Q  ;no match on hospital location
 . . . ; if same clinic & same provider but not triage, make new visit
 . . . I $G(SDINPUT("APPT DATE")),$$GET1^DIQ(9000010,VIEN,.26,"I"),'$$TRIAGE(VIEN) S STOP=1 Q
 . . ; must be good match, increment counter and set array node
 . . S SDOUT(0)=SDOUT(0)+1
 . . S SDOUT(VIEN)=$$TIMEDIF(SDINPUT("VISIT DATE"),VIEN)
 Q
 ;
PRVMTCH(SDINPUT,VIEN) ; do visits match on provider?
 N PRVS,IEN
 I '$G(SDINPUT("PROVIDER")) Q 1     ; if no provider sent, assume okay
 ; if visit is triage clinic & new encounter is not ancillary, skip provider match
 I $$TRIAGE(VIEN),'$G(SDINPUT("ANCILLARY")) Q 1
 ; find all v provider entries for visit
 S IEN=0 F  S IEN=$O(^AUPNVPRV("AD",VIEN,IEN)) Q:'IEN  D
 . S PRVS($$GET1^DIQ(9000010.06,IEN_",",.01,"I"))=""
 ; if incoming provider in list, this is match
 I $D(PRVS(SDINPUT("PROVIDER"))) Q 1
 ; otherwise, no match
 Q 0
 ;
TIMEDIF(VDTTM,VIEN) ; return time diff between incoming time and current visit
 Q $$FMDIFF^XLFDT(VDTTM,+$G(^AUPNVSIT(VIEN,0)),2)\60
 ;
ADDVIST(SDOUTPUT,SDARRAY)  ;
 N %DT,SDVISITIN,SUB,X,Y
 S SUB="SD" F  S SUB=$O(SDARRAY(SUB)) Q:SUB=""  Q:$E(SUB,1,2)'="SD"  S SDVISITIN(SUB)=SDARRAY(SUB)
 S SDVISITIN("AUPNTALK")="",SDVISITIN("SDANE")=""      ;keep it silent
 S SDVISITIN("SDLOC")=$G(SDARRAY("SITE"))              ;facility
 S SDVISITIN("SDPAT")=$G(SDARRAY("PAT"))               ;patient
 S SDVISITIN("SDTYPE")=$G(SDARRAY("VISIT TYPE"))       ;visit type
 S SDVISITIN("SDCAT")=$G(SDARRAY("SRV CAT"))           ;srv cat
 S SDVISITIN("SDDATE")=$G(SDARRAY("VISIT DATE"))       ;chkin dt
 I $G(SDARRAY("CLINIC CODE")) S SDVISITIN("SDCLN")="`"_SDARRAY("CLINIC CODE")      ;clinic code ien w/`
 S SDVISITIN("SDHL")=$G(SDARRAY("HOS LOC"))            ;clinic name
 S SDVISITIN("SDAPDT")=$G(SDARRAY("APPT DATE"))        ;appt date
 S SDVISITIN("SDUSR")=$G(SDARRAY("USR"))
 S SDVISITIN("SDADD")=1                                ;force add
 ; create visit
 N SDVISITOUT
 D EN1^SDES2CRTVISIT(.SDVISITOUT,.SDVISITIN)
 ; if no visit created,error quit
 I '$G(SDVISITOUT("SDVSIT")) D  Q
 . S SDOUTPUT(0)="0^Error Creating Visit"
 ; set new visit info in out array
 S SDOUTPUT(SDVISITOUT("SDVSIT"))="ADD",SDOUTPUT(0)=1
 K SDVISITIN,SDVISITOUT
 Q
 ;
WALKIN(SDOUT,SDWALKIN) ;Create walkin appt which is checked in and visit created
 N ERR,VISIT
 S SDOUT(0)=0    ;initialize outgoing count
 S SDWALKIN("CLN")=$G(SDWALKIN("HOS LOC"))
 S SDWALKIN("TYP")=4   ;4=walkin
 S SDWALKIN("ADT")=$G(SDWALKIN("APPT DATE"))
 I '$D(SDWALKIN("LEN")) S SDWALKIN("LEN")=$$GET1^DIQ(44,SDWALKIN("CLN"),1912)
 ; make walkin appt
 S ERR=$$MAKE(.SDWALKIN) I ERR S $P(SDOUT(0),U,2)=$P(ERR,U,2) Q
 ; set variables used by checkin call
 S SDWALKIN("CDT")=SDWALKIN("VISIT DATE")
 S SDWALKIN("CC")=$G(SDWALKIN("CLINIC CODE"))
 S SDWALKIN("PRV")=$G(SDWALKIN("PROVIDER"))
 ; check in appt and create visit
 S ERR=$$CHECKIN(.SDWALKIN)
 ; update out array based on result
 ; reset SDOUTPUT(0) only if added new visit
 I 'ERR S VISIT=$$GETVST(SDWALKIN("PAT"),SDWALKIN("APPT DATE")) I VISIT,'$G(SDARRAY("VIEN")) S:SDOUT(0)=0 SDOUT(0)=1 S SDOUT(VISIT)="ADD"   ;visit added
 I ERR S $P(SDOUT(0),U,2)=$P(ERR,U,2)          ;error
 Q
 ;
HAVEREQ(SDOUT,SDINPUT) ; check required fields
 I '$G(SDINPUT("FORCE ADD")),'$D(SDINPUT("TIME RANGE")) S SDOUT(0)="0^Missing Time Range" Q 0
 I '$D(SDINPUT("PAT")) S SDOUT(0)="0^Missing Patient IEN" Q 0
 I '$D(SDINPUT("VISIT DATE")) S SDOUT(0)="0^Missing Visit Date" Q 0
 I '$D(SDINPUT("SITE")) S SDOUT(0)="0^Missing Facility/Site" Q 0
 I '$D(SDINPUT("VISIT TYPE")) S SDOUT(0)="0^Missing Visit Type" Q 0
 I '$D(SDINPUT("SRV CAT")) S SDOUT(0)="0^Missing Service Category" Q 0
 I '$D(SDINPUT("USR")) S SDOUT(0)="0^Missing User IEN" Q 0
 I $G(SDINPUT("HOS LOC")),'$G(SDINPUT("CLINIC CODE")) S SDINPUT("CLINIC CODE")=$$GET1^DIQ(44,SDINPUT("HOS LOC"),8,"I")
 ; convert service category
 I $G(SDINPUT("APPT DATE")),$G(SDINPUT("HOS LOC")) S SDINPUT("SRV CAT")=$$SERCAT(SDINPUT("HOS LOC"),SDINPUT("PAT"))
 Q 1
 ;
TIME(RANGE,VISIT,DATE,END) ; set DATE and END based on TIME RANGE setting in minutes
 N TMDIF,SW
 S TMDIF=$S(RANGE<1:0,1:RANGE)
 S DATE=$$FMADD^XLFDT(VISIT,,,-TMDIF)
 S END=$$FMADD^XLFDT(VISIT,,,TMDIF)
 I (DATE\1)<(END\1) S SW=(END\1),END=(DATE\1)_".9999",DATE=SW
 S DATE=(9999999-(DATE\1)_"."_$P(DATE,".",2))-.0001
 S END=9999999-(END\1)_"."_$P(END,".",2)
 I RANGE=-1 S END=(END\1)_".9999",DATE=(DATE\1)   ;no time range used
 Q
 ;
TRIAGE(VST) ; returns 1 if visit's hosp loc is triage type
 N HSPLOC
 S HSPLOC=$$GET1^DIQ(9000010,VST,.22,"I") I 'HSPLOC Q 0
 Q +$$GET1^DIQ(9009017.2,HSPLOC,.16,"I")
 ;
MAKE(SDAPPTIN) ;Call to store appt made
 ;
 ; Make call using: S ERR=$$MAKE^SDES2GETVISIT(.ARRAY)
 ;
 ; Input Array -
 ; SDAPPTIN("PAT") = ien of patient in file 2
 ; SDAPPTIN("CLN") = ien of clinic in file 44
 ; SDAPPTIN("TYP") = 3 for scheduled appts, 4 for walkins
 ; SDAPPTIN("ADT") = appointment date and time
 ; SDAPPTIN("LEN") = appointment length in minutes (5-240)
 ; SDAPPTIN("OI")  = reason for appt - up to 150 characters
 ; SDAPPTIN("USR") = user who made appt
 ;
 ; Output: error status and message
 ;   = 0 or null:  everything okay
 ;   = 1^message:  error and reason
 ;
 N SDERROR
 I '$D(^DPT(+$G(SDAPPTIN("PAT")),0)) Q 1_U_"Patient not on file: "_$G(SDAPPTIN("PAT"))
 I '$D(^SC(+$G(SDAPPTIN("CLN")),0)) Q 1_U_"Clinic not on file: "_$G(SDAPPTIN("CLN"))
 I ($G(SDAPPTIN("TYP"))<3)!($G(SDAPPTIN("TYP"))>4) Q 1_U_"Appt Type error: "_$G(SDAPPTIN("TYP"))
 I $G(SDAPPTIN("ADT"))'?7N1"."1N.N Q 1_U_"Appt Date/Time error: "_$G(SDAPPTIN("ADT")) ;PWC  allow any time combination of numbers #694
 I ($G(SDAPPTIN("LEN"))<5)!($G(SDAPPTIN("LEN"))>240) Q 1_U_"Appt Length error: "_$G(SDAPPTIN("LEN"))
 I '$D(^VA(200,+$G(SDAPPTIN("USR")),0)) Q 1_U_"User Who Made Appt Error: "_$G(SDAPPTIN("USR"))
 I $D(^DPT(SDAPPTIN("PAT"),"S",SDAPPTIN("ADT"),0)),$$GET1^DIQ(2.98,SDAPPTIN("ADT")_","_SDAPPTIN("PAT")_",",3,"I")'="C" Q 1_U_"Patient "_SDAPPTIN("PAT")_" already has appt at "_SDAPPTIN("ADT")
 ;
 N DIC,DA,Y,X,DD,DO,DLAYGO
 I $D(^DPT(SDAPPTIN("PAT"),"S",SDAPPTIN("ADT"),0)),$$GET1^DIQ(2.98,SDAPPTIN("ADT")_","_SDAPPTIN("PAT")_",",3,"I")="C" D
 . ; "un-cancel" existing appt in file 2
 . N SDAPPTFDA,SDAPPTIENS,SDAPPTERR
 . S SDAPPTIENS=SDAPPTIN("ADT")_","_SDAPPTIN("PAT")_","
 . S SDAPPTFDA(2.98,SDAPPTIENS,".01")=SDAPPTIN("CLN")
 . S SDAPPTFDA(2.98,SDAPPTIENS,"3")=""
 . S SDAPPTFDA(2.98,SDAPPTIENS,"9")=SDAPPTIN("TYP")
 . S SDAPPTFDA(2.98,SDAPPTIENS,"9.5")=9
 . S SDAPPTFDA(2.98,SDAPPTIENS,"14")=""
 . S SDAPPTFDA(2.98,SDAPPTIENS,"15")=""
 . S SDAPPTFDA(2.98,SDAPPTIENS,"16")=""
 . S SDAPPTFDA(2.98,SDAPPTIENS,"19")=""
 . S SDAPPTFDA(2.98,SDAPPTIENS,"20")=$$NOW^XLFDT
 . D FILE^DIE("","SDAPPTFDA","SDAPPTERR")
 . N SDAPPTTMP S SDAPPTTMP=$G(SDAPPTERR)
 E  D  I $G(SDERROR(1)) Q 1_U_"FileMan add to DPT error: Patient="_SDAPPTIN("PAT")_" Appt="_SDAPPTIN("ADT")
 . ; add appt to file 2
 . ; call to silent server call
 . N SDAPPTFDA,SDAPPTIENS,SDAPPTERR
 . S SDAPPTIENS="?+2,"_SDAPPTIN("PAT")_","
 . S SDAPPTIENS(2)=SDAPPTIN("ADT")
 . S SDAPPTFDA(2.98,SDAPPTIENS,.01)=SDAPPTIN("CLN")
 . S SDAPPTFDA(2.98,SDAPPTIENS,"9")=SDAPPTIN("TYP")
 . S SDAPPTFDA(2.98,SDAPPTIENS,"9.5")=9
 . S SDAPPTFDA(2.98,SDAPPTIENS,"20")=$$NOW^XLFDT
 . D UPDATE^DIE("","SDAPPTFDA","SDAPPTIENS","SDERROR(1)")
 ;
 ; add appt to file 44
 K DIC,DA,X,Y,DLAYGO,DD,DO
 I '$D(^SC(SDAPPTIN("CLN"),"S",0)) S ^SC(SDAPPTIN("CLN"),"S",0)="^44.001DA^^"
 I '$D(^SC(SDAPPTIN("CLN"),"S",SDAPPTIN("ADT"),0)) D  I Y<1 Q 1_U_"Error adding date to file 44: Clinic="_SDAPPTIN("CLN")_" Date="_SDAPPTIN("ADT")
 . S DIC="^SC("_SDAPPTIN("CLN")_",""S"",",DA(1)=SDAPPTIN("CLN"),(X,DINUM)=SDAPPTIN("ADT")
 . S DIC("P")="44.001DA",DIC(0)="L",DLAYGO=44.001
 . S Y=1 I '$D(@(DIC_X_")")) D FILE^DICN
 ;
 K DIC,DA,X,Y,DLAYGO,DD,DO,DINUM
 S DIC="^SC("_SDAPPTIN("CLN")_",""S"","_SDAPPTIN("ADT")_",1,"
 S DA(2)=SDAPPTIN("CLN"),DA(1)=SDAPPTIN("ADT"),X=SDAPPTIN("PAT")
 S DIC("DR")="1///"_SDAPPTIN("LEN")_";3///"_$E($G(SDAPPTIN("OI")),1,150)_";7///"_SDAPPTIN("USR")_";8///"_$$NOW^XLFDT
 S DIC("P")="44.003PA",DIC(0)="L",DLAYGO=44.003
 D FILE^DICN
 ;
 ; call event driver
 N DFN,SDT,SDCL,SDDA,SDMODE
 S DFN=SDAPPTIN("PAT"),SDT=SDAPPTIN("ADT"),SDCL=SDAPPTIN("CLN"),SDMODE=2
 S SDDA=$$SCIEN(SDAPPTIN("PAT"),SDAPPTIN("CLN"),SDAPPTIN("ADT"))
 D MAKE^SDAMEVT(DFN,SDT,SDCL,SDDA,SDMODE)
 Q 0
 ;
CHECKIN(SDAPPTIN) ;Call to add checkin info to appt
 ;
 ; Input array -
 ;  SDAPPTIN("PAT") = ien of patient in file 2
 ;  SDAPPTIN("CLN") = ien of clinic in file 44
 ;  SDAPPTIN("ADT") = appt date/time
 ;  SDAPPTIN("CDT") = checkin date/time
 ;  SDAPPTIN("USR") = checkin user
 ;  SDAPPTIN("OPT") = option used to create visit (optional)
 ;  SDAPPTIN("VIEN") = visit IEN (sent if new visit is NOT to be created)
 ;
 ; variables to create visit under event driver
 ;  SDAPPTIN("CC")  = clinic code for creating visit - optional
 ;  SDAPPTIN("PRV") = visit provider - pointer to file 200
 ;
 ; Output value = 0 (successful)
 ;              = 1^error message
 ;
 I '$D(^DPT(+$G(SDAPPTIN("PAT")),0)) Q 1_U_"Patient not on file: "_$G(SDAPPTIN("PAT"))
 I '$D(^SC(+$G(SDAPPTIN("CLN")),0)) Q 1_U_"Clinic not on file: "_$G(SDAPPTIN("CLN"))
 I $G(SDAPPTIN("ADT"))'?7N1"."1N.N Q 1_U_"Appt Date/Time error: "_$G(SDAPPTIN("ADT"))
 I $G(SDAPPTIN("CDT"))'?7N1"."1N.N Q 1_U_"Checkin Date/Time error: "_$G(SDAPPTIN("CDT"))
 I '$D(^VA(200,+$G(SDAPPTIN("USR")),0)) Q 1_U_"User Who Made Appt Error: "_$G(SDAPPTIN("USR"))
 ;
 ; find ien for appt in file 44
 N IEN,DIE,DA,DR,SDVSTN
 S IEN=$$SCIEN(SDAPPTIN("PAT"),SDAPPTIN("CLN"),SDAPPTIN("ADT"))
 I 'IEN Q 1_U_"Error trying to find appointment for checkin: Patient="_SDAPPTIN("PAT")_" Clinic="_SDAPPTIN("CLN")_" Appt="_SDAPPTIN("ADT")
 ;
 ; remember before status
 N SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL
 S DFN=SDAPPTIN("PAT"),SDT=SDAPPTIN("ADT"),SDCL=SDAPPTIN("CLN"),SDMODE=2,SDDA=IEN
 S SDCIHDL=$$HANDLE^SDAMEVT(1),SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL)
 ;
 ; set checkin
 N SDFDA
 S SDFDA(44.003,IEN_","_SDAPPTIN("ADT")_","_SDAPPTIN("CLN")_",",305)=$$NOW^XLFDT()
 S SDFDA(44.003,IEN_","_SDAPPTIN("ADT")_","_SDAPPTIN("CLN")_",",309)=SDAPPTIN("CDT")
 D FILE^DIE("","SDFDA")
 K SDFDA
 ; Updating 302 separately because of trigger on field 309 uses logged-in DUZ
 S SDFDA(44.003,IEN_","_SDAPPTIN("ADT")_","_SDAPPTIN("CLN")_",",302)=SDAPPTIN("USR")
 D FILE^DIE("","SDFDA")
 ;
 ; set after status
 S SDDA=$$SCIEN(SDAPPTIN("PAT"),SDAPPTIN("CLN"),SDAPPTIN("ADT"))
 S SDCIHDL=$$HANDLE^SDAMEVT(1),SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL)
 ;
 Q 0
 ;
SERCAT(CLINIC,PAT) ;Returns service category for visit
 N CLNCAT
 I $$GET1^DIQ(2,PAT_",",.1)]"" Q "I"               ;in hospital if inpt
 S CLNCAT=$$GET1^DIQ(9009017.2,CLINIC,.12,"I")     ;clinic's service category
 Q $S(CLNCAT]"":CLNCAT,1:"A")
 ;
SCIEN(PAT,CLINIC,DATE) ;Returns ien for appt in ^SC
 N APPTIEN,VALIDIEN
 S APPTIEN=0 F  S APPTIEN=$O(^SC(CLINIC,"S",DATE,1,APPTIEN)) Q:'APPTIEN  Q:$G(VALIDIEN)  D
 . Q:$$GET1^DIQ(44.003,APPTIEN_","_DATE_","_CLINIC,310,"I")="C"  ;cancelled
 . I $$GET1^DIQ(44.003,APPTIEN_","_DATE_","_CLINIC,.01,"I")=PAT S VALIDIEN=APPTIEN
 Q $G(VALIDIEN)
 ;
GETVST(PAT,DATE) ;Returns visit ien for appt date and patient
 I ('PAT)!('DATE) Q 0
 N OUTPTENC
 S OUTPTENC=$$GET1^DIQ(2.98,DATE_","_PAT_",",21,"I")
 I 'OUTPTENC Q 0                                      ;outpt encounter ptr
 ;
 I $$GET1^DIQ(409.68,OUTPTENC_",",.02,"I")'=PAT Q 0   ;patient ptr
 Q $$GET1^DIQ(409.68,OUTPTENC_",",.05,"I")            ;visit ptr
 ;
