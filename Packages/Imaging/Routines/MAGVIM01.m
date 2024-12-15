MAGVIM01 ;WOIFO/DAC/NST/JSJ/BT - Utilities for RPC calls for DICOM file processing ; Nov 05, 2020@07:26:32
 ;;3.0;IMAGING;**118,138,221,250,283,332,357**;Mar 19, 2002;Build 29
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
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and result separator ie. -3``No record IEN
 Q "`"
INPUTSEP() ; Name value separator for input data ie. NAME`TESTPATIENT
 Q "`"
 ; RPC: MAGV GET WORKLISTS
GETLIST(OUT) ; Returns all worklist names and statuses
 N IEN,OSEP,SSEP,FILE,WORKLIST,I
 S IEN=0,I=0,OSEP=$$OUTSEP,SSEP=$$STATSEP,FILE=2006.9412
 F  S IEN=$O(^MAGV(FILE,IEN)) Q:+IEN=0  D
 . S I=I+1,WORKLIST=$G(^MAGV(FILE,IEN,0))
 . S OUT(I+1)=$P(WORKLIST,U,1)_OSEP_$P(WORKLIST,U,2)
 I I>0 S OUT(1)=0_SSEP_I
 Q
 ; RPC: MAGV CREATE WORK ITEM
CRTITEM(OUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,MSGTAGS,CRTUSR,CRTAPP,UPDSRV) ; Creates an entry in the work item file and the work history file
 N FDA,FDA2,ERR,ERR2,SMIEN,ISEP,SSEP,MSG,APPIEN,LOCIEN,I,CRTDAT,SRV,MDL,PROC,SRC,TAGN,TAGV,TAGIDX
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 S CRTDAT=$$NOW^XLFDT ; CREATED DATE/TIME
 S UPDSRV=$G(UPDSRV,0) ;Set Service based on modality and procedure
 K OUT
 I $G(TYPE)="" S OUT=-6_SSEP_"No work item TYPE provided" Q
 I $G(SUBTYPE)="" S OUT=-7_SSEP_"No work item SUBTYPE provided" Q
 I $G(STATUS)="" S OUT=-8_SSEP_"No work item STATUS provided" Q
 I $G(PLACEID)="" S OUT=-9_SSEP_"No work item LOCATION provided" Q
 I $G(PRIORITY)="" S OUT=-10_SSEP_"No work item PRIORITY provided" Q
 I ($G(CRTUSR)="")&($G(CRTAPP)="") S OUT=-11_SSEP_"No work item USER/APPLICATION provided" Q
 ; P250 DAC - Removed P142 LOCATION screen
 ; P283 DAC - This function will now only accepts Station Numbers as inputs. Will convert to Institution IEN before filing.
 S LOCIEN=$$IEN^XUAF4(PLACEID) ; If it wasn't a LOCATION IEN, it should be a STATION NUMBER
 I '$G(LOCIEN) S OUT=-11_SSEP_"Invalid LOCATION provided" Q  ; If it was a LOCATION IEN or a STATION NUMBER
 S FDA(2006.941,"+1,",.01)=CRTDAT
 S FDA(2006.941,"+1,",1)=TYPE
 S FDA(2006.941,"+1,",2)=SUBTYPE
 S FDA(2006.941,"+1,",3)=STATUS
 S FDA(2006.941,"+1,",5)=PRIORITY
 S FDA(2006.941,"+1,",9)=CRTDAT
 S:$G(CRTUSR)'="" (FDA(2006.941,"+1,",8),FDA(2006.941,"+1,",10))="`"_CRTUSR  ; user DUZ is passed
 I $G(CRTAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,CRTAPP,1)  ; Get application IEN
 . S (FDA(2006.941,"+1,",14),FDA(2006.941,"+1,",15))=CRTAPP
 . Q
 ; Add message text and tag names and values
 F I=1:1 Q:'$D(MSGTAGS(I))  D
 . S TAGN=$P(MSGTAGS(I),ISEP,1)
 . S TAGV=$P(MSGTAGS(I),ISEP,2)
 . S TAGIDX=I+1
 . I $E(TAGN,1,3)="MSG" S MSG(TAGIDX)=TAGV Q
 . S FDA(2006.94111,"+"_TAGIDX_",+1,",.01)=TAGN  ; TAG NAME
 . S FDA(2006.94111,"+"_TAGIDX_",+1,",1)=TAGV    ; TAG VALUE
 . I UPDSRV,TAGN="Modality" S MDL=TAGV Q
 . I UPDSRV,TAGN="Procedure" S PROC=TAGV Q
 . I UPDSRV,TAGN="Source" S SRC=TAGV Q
 . Q
 ; Update Service based on Modality and Procedure
 S ERR=""
 I UPDSRV,$G(MDL)'="" D
 . S SRV=$$GETSRV^MAGVIM12(MDL,$G(PROC))
 . I $P(SRV,U,1)="-1" S ERR=SRV Q
 . Q
 I ERR'="" S OUT="-1"_SSEP_$P(ERR,U,2) Q
 K ERR
 D VALIDATE^MAGVIM06(.FDA,.ERR)
 ; Quit on validation error
 I $D(ERR) S OUT="-4"_SSEP_$G(ERR) Q
 ; Set Work Item
 K ERR
 L +^MAGV(2006.941,0):5 I $T D
 . D UPDATE^DIE("E","FDA","SMIEN","ERR")
 . S FDA2(2006.941,SMIEN(1)_",",4)=LOCIEN
 . D FILE^DIE("I","FDA2","ERR2") ; P250 DAC - Update LOCATION separately with the internal value
 . I '$D(ERR) S ERR=$G(ERR2) ; P250 DAC - If there was no error on the first UPDATE set the ERR to the 2nd update
 . D
 . . I $D(ERR("DIERR",1,"TEXT",1)) S OUT="-1"_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q
 . . ; File message as word processing field
 . . K ERR
 . . I $D(MSG) D  Q:$D(ERR)  ; Quit if error during saving
 . . . D WP^DIE(2006.941,SMIEN(1)_",",13,"K","MSG","ERR")
 . . . I $D(ERR) S OUT="-3"_SSEP_$G(ERR("DIERR",1,"TEXT",1))
 . . . Q
 . . ; Return ID of new entry
 . . S OUT=0_SSEP_SMIEN(1)
 . . Q
 . L -^MAGV(2006.941,0)
 E  D
 . S OUT=-5_SSEP_"Unable to lock MAG WORK ITEM file."
 . Q
 Q
 ;
 ; RPC: MAGV UPDATE WORK ITEM
UPDITEM(OUT,ID,EXPSTAT,NEWSTAT,MESSAGE,UPDUSR,UPDAPP) ; Update work item status and create an entry in the work history file
 N FDA,SSEP,ISEP,MSGUPD,APPIEN
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 I '$D(^MAGV(2006.941,ID)) S OUT="-6"_SSEP_"Work item "_ID_" not found" Q
 I $G(EXPSTAT)="" S OUT=-7_SSEP_"No work item expected status provided" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT=-8_SSEP_"No updated by user/application provided" Q
 L +^MAGV(2006.941,ID):1999999
 S RSTAT=$$GET1^DIQ(2006.941,ID,"STATUS")
 I EXPSTAT'=RSTAT S OUT=-9_SSEP_"Work item "_ID_" has a status of "_RSTAT_", not the expected status of "_EXPSTAT L -^MAGV(2006.941,ID) Q
 I NEWSTAT'="" S FDA(2006.941,ID_",",3)=NEWSTAT
 ;
 F I=1:1 Q:'$D(MESSAGE(I))  D
 . I $E($P(MESSAGE(I),ISEP,1),1,3)="MSG" S MSGUPD(I+1)=$P(MESSAGE(I),ISEP,2)
 . Q
 ;
 S FDA(2006.941,ID_",",9)=$$NOW^XLFDT  ; LAST UPDATED DATE/TIME
 S:$G(UPDUSR)'="" FDA(2006.941,ID_",",10)="`"_UPDUSR  ; LAST UPDATING USER - User DUZ
 I $G(UPDAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,UPDAPP,1)  ; Get application IEN or create a new one
 . S FDA(2006.941,ID_",",15)=UPDAPP      ; LAST UPDATING APP
 . Q
 ;
 S OUT=$$UPDWI^MAGVIM09(ID,.FDA,.MSGUPD)  ; Update Work Item ID with FDA data, MSGUPD message
 L -^MAGV(2006.941,ID)
 Q
 ;
 ; RPC: MAGV FIND WORK ITEM
FIND(OUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,STOPTAG,MAXROWS,TAGS,LASTIEN,ORDER,DTFROM,DTTO) ; Find records with given attributes - return ID
 ;PLACEID is FILE #4's STATION NUMBER
 D FIND^MAGVIM09(.OUT,.TYPE,.SUBTYPE,.STATUS,.PLACEID,.PRIORITY,.STOPTAG,.MAXROWS,.TAGS,.LASTIEN,.ORDER,.DTFROM,.DTTO)  ;P357 routine size exceeded - Moved to MAGVIM09
 Q
 ;
DTINRNG(IEN,DTFROM,DTTO) ;
 N DAT S DAT=+$P($P($G(^MAGV(2006.941,IEN,0)),U),".")
 Q (DAT'<DTFROM)&(DAT'>DTTO)
 ;
GFLTITM(FLTITM,TAGS) ;This to improve loading performance
 N TAGITM,TAG,TAGVAL,VALUE,IEN,IEN2,FILTER,FLTITM2,NOFILTER,DAT
 ;
 K FILTER
 S TAGITM=0
 F  S TAGITM=$O(TAGS(TAGITM)) Q:TAGITM=""  D
 . S TAG=$P(TAGS(TAGITM),ISEP,1),VALUE=$P(TAGS(TAGITM),ISEP,2)
 . I TAG'="Procedure"&(TAG'="Modality")&(TAG'="Source")&(TAG'="Service")&(TAG'="PatientName") Q
 . I TAG'="",VALUE'="",VALUE'="[No Procedure]",VALUE'="[No Modality]",VALUE'="[No Service]" S FILTER(TAG)=VALUE
 ;
 Q:'$D(FILTER) 0  ;no filter on service, source, procedure, modality 
 ;
 K FLTITM,FLTITM2
 S TAG="Procedure"
 S VALUE=$G(FILTER(TAG))
 I VALUE'="",VALUE'="[No Procedure]",$L(VALUE)<31 M FLTITM=^MAGV(2006.941,"HH",TAG,VALUE) Q:'$D(FLTITM) 1  ;can't find such procedure
 I VALUE'="",VALUE'="[No Procedure]",$L(VALUE)>30 D  Q:'$D(FLTITM) 1  ;can't find such procedure
 . S IEN=0
 . F  S IEN=$O(^MAGV(2006.941,"H",TAG,IEN)) Q:'IEN  D
 . . S IEN2=$O(^MAGV(2006.941,"H",TAG,IEN,""))
 . . S TAGVAL=$P($G(^MAGV(2006.941,IEN,4,IEN2,0)),U,2)
 . . ;S DAT=$P($G(^MAGV(2006.941,IEN,0)),U)
 . . I TAGVAL=VALUE S FLTITM(IEN)="" ;,FLTITM2(DAT,IEN)=""
 ;
 K FLTITM3,FLTITM4
 S TAG="Modality",VALUE=$G(FILTER(TAG))
 I VALUE'="",VALUE'="[No Modality]" D  Q:'$D(FLTITM) 1  ;can't find such modality
 . S NOFILTER='$D(FLTITM)
 . I NOFILTER M FLTITM=^MAGV(2006.941,"HH",TAG,VALUE) Q
 . I 'NOFILTER D
 . . S IEN=0
 . . F  S IEN=$O(FLTITM(IEN)) Q:'IEN  D
 . . . ;S DAT=$P($G(^MAGV(2006.941,IEN,0)),U)
 . . . I $D(^MAGV(2006.941,"HH",TAG,VALUE,IEN)) S FLTITM3(IEN)="" ;,FLTITM4(DAT,IEN)=""
 . . K FLTITM,FLTITM2 M FLTITM=FLTITM3 ;,FLTITM2=FLTITM4
 ;
 K FLTITM3,FLTITM4
 S TAG="Source",VALUE=$G(FILTER(TAG))
 S NOFILTER='$D(FLTITM)
 I VALUE'="",NOFILTER D  Q:'$D(FLTITM) 1  ;can't find such Source
 . I $L(VALUE)<31 M FLTITM=^MAGV(2006.941,"HH",TAG,VALUE) Q
 . I $L(VALUE)>30 D
 . . S IEN=0
 . . F  S IEN=$O(^MAGV(2006.941,"H",TAG,IEN)) Q:'IEN  D
 . . . S IEN2=$O(^MAGV(2006.941,"H",TAG,IEN,""))
 . . . S TAGVAL=$P($G(^MAGV(2006.941,IEN,4,IEN2,0)),U,2)
 . . . ;S DAT=$P($G(^MAGV(2006.941,IEN,0)),U)
 . . . I TAGVAL=VALUE S FLTITM3(IEN)="" ;,FLTITM4(DAT,IEN)=""
 . . K FLTITM,FLTITM2 M FLTITM=FLTITM3 ;,FLTITM2=FLTITM4
 ; 
 I VALUE'="",'NOFILTER D  Q:'$D(FLTITM) 1  ;can't find such source
 . I $L(VALUE)<31 D
 . . S IEN=0
 . . F  S IEN=$O(FLTITM(IEN)) Q:'IEN  D
 . . . ;S DAT=$P($G(^MAGV(2006.941,IEN,0)),U)
 . . . I $D(^MAGV(2006.941,"HH",TAG,VALUE,IEN)) S FLTITM3(IEN)="" ;,FLTITM4(DAT,IEN)=""
 . I $L(VALUE)>30 D
 . . S IEN=0
 . . F  S IEN=$O(FLTITM(IEN)) Q:'IEN  D
 . . . S IEN2=$O(^MAGV(2006.941,"H",TAG,IEN,""))
 . . . S TAGVAL=$P($G(^MAGV(2006.941,IEN,4,IEN2,0)),U,2)
 . . . ;S DAT=$P($G(^MAGV(2006.941,IEN,0)),U)
 . . . I TAGVAL=VALUE S FLTITM3(IEN)="" ;,FLTITM4(DAT,IEN)=""
 . K FLTITM,FLTITM2 M FLTITM=FLTITM3 ;,FLTITM2=FLTITM4
 ;
 K FLTITM3,FLTITM4
 S TAG="Service",VALUE=$G(FILTER(TAG))
 I VALUE'="",VALUE'="[No Service]",'$D(FLTITM) Q 0  ;Service is a calculated field, can't use "HH" index
 I VALUE'="",VALUE'="[No Service]",$D(FLTITM) D
 . S IEN=0
 . F  S IEN=$O(FLTITM(IEN)) Q:'IEN  D
 . . ;S DAT=$P($G(^MAGV(2006.941,IEN,0)),U)
 . . I $$SRV(IEN)=VALUE S FLTITM3(IEN)="" ;,FLTITM4(DAT,IEN)=""
 . K FLTITM,FLTITM2 M FLTITM=FLTITM3 ;,FLTITM2=FLTITM4
 ;
 S TAG="PatientName",VALUE=$G(FILTER(TAG))
 I VALUE'="",'$D(FLTITM) Q 0  ;can't use index, patientname can be filtered using partial
 ;
 Q 1  ;use the filtered items for further processing
 ;
SRV(IEN) ;return Service
 N MTGIDX,MOD,MODS,PTGIDX,PROC,SRV
 N CM S CM=","
 S MTGIDX=0,MODS=""
 F  S MTGIDX=$O(^MAGV(2006.941,"H","Modality",IEN,MTGIDX)) Q:'MTGIDX  D
 . S MOD=$P(^MAGV(2006.941,IEN,4,MTGIDX,0),U,2)
 . I (CM_MODS_CM)'[(CM_MOD_CM) S MODS=MODS_MOD_","
 I MODS'="" S MODS=$E(MODS,1,$L(MODS)-1)
 I MODS="" Q ""
 ; 
 S PTGIDX=$O(^MAGV(2006.941,"H","Procedure",IEN,""))
 I 'PTGIDX Q $$DESCR($$GETS^MAGVIM12(MODS,""))
 S PROC=$P(^MAGV(2006.941,IEN,4,PTGIDX,0),U,2)
 I PROC="" Q $$DESCR($$GETS^MAGVIM12(MODS,""))
 ;
 Q $$DESCR($$GETS^MAGVIM12(MODS,PROC))
 ;
DESCR(SRV) ;
 I SRV="RAD" Q "Radiology"
 I SRV="CON" Q "Consult"
 I SRV="LAB" Q "Lab"
 Q ""
 ;
 ; RPC: MAGV GET WORK ITEM
GETITEM(OUT,ID,EXPSTAT,NEWSTAT,UPDUSR,UPDAPP) ; Find work item with matching ID and return tags
 N I,J,SSEP,RSTAT,FDA,APPIEN
 S SSEP=$$STATSEP
 K OUT
 I $G(ID)="" S OUT(0)=-1_SSEP_"No work item ID" Q
 I $G(EXPSTAT)="" S OUT(0)=-2_SSEP_"No expected status" Q
 I $G(NEWSTAT)="" S OUT(0)=-3_SSEP_"No new status" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT(0)=-4_SSEP_"No updated by user/application" Q
 I '$D(^MAGV(2006.941,ID)) S OUT(0)=-5_SSEP_"No work item with matching ID" Q
 S RSTAT=$$GET1^DIQ(2006.941,ID,"STATUS")
 I EXPSTAT'=RSTAT S OUT(0)=-6_SSEP_"Work item "_ID_" has a status of "_RSTAT_", not the expected status of "_EXPSTAT L -^MAGV(2006.941,ID) Q
 L +^MAGV(2006.941,ID):1999999
 S OUT(0)=0
 I NEWSTAT'=EXPSTAT D UPUSRAPP(.OUT,ID,NEWSTAT,UPDUSR,UPDAPP) ; Update user, app, updated time fields
 I +OUT(0)=0 D
 . S OUT(0)=0
 . D GETWI^MAGVIM09(.OUT,ID)  ; Get Work Item Record
 . Q 
 L -^MAGV(2006.941,ID)
 Q
 ; RPC: MAGV DELETE WORK ITEM
DELWITEM(OUT,ID) ; Delete Work Item
 N FDA,SSEP
 S SSEP=$$STATSEP
 I '$D(^MAGV(2006.941,ID)) S OUT=-1_SSEP_"Work item "_ID_" not found." Q
 S FDA(2006.941,ID_",",.01)="@"
 L +^MAGV(2006.941,0):5 I $T D
 . ;--- Do not decrement FileMan highest entry value during delete.
 . N MAXIEN S MAXIEN=$P(^MAGV(2006.941,0),U,3)
 . D FILE^DIE("","FDA")
 . S:$P(^MAGV(2006.941,0),U,3)<MAXIEN $P(^MAGV(2006.941,0),U,3)=MAXIEN
 . S OUT=0_SSEP_"Work item "_ID_" deleted."
 . L -^MAGV(2006.941,0)
 . Q
 E  D
 . S OUT=-2_SSEP_"Work item "_ID_" is locked."
 . Q
 Q
 ; RPC: MAGV ADD WORK ITEM TAGS
ADDTAG(OUT,ID,EXPSTAT,UPDUSR,UPDAPP,TAG) ; Add tags to work item
 N FDA1,FDA2,ERR1,ERR4,STATMATCH,STATUS,SSEP,ISEP,I,APPIEN,MSGUPD
 S SSEP=$$STATSEP,ISEP=$$INPUTSEP
 I $G(ID)="" S OUT=-9_SSEP_"No work item ID" Q
 I '$D(^MAGV(2006.941,ID)) S OUT=-5_SSEP_"No work item with matching ID" Q
 I '$D(EXPSTAT) S OUT=-6_SSEP_"No status provided" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT=-7_SSEP_"No updated by user/application" Q
 I $G(TAG(1))="" S OUT=-8_SSEP_"No tag" Q
 S STATUS=$$GET1^DIQ(2006.941,ID,"STATUS")
 S STATMATCH=0
 F I=1:1  Q:$P(EXPSTAT,ISEP,I)=""  Q:STATMATCH  D
 . I $P(EXPSTAT,ISEP,I)=STATUS S STATMATCH=1
 . Q
 I STATMATCH=0 S OUT=-9_SSEP_"work item does not have expected status" Q
 L +^MAGV(2006.941,ID):1999999
 F I=1:1  Q:'$D(TAG(I))  D
 . S FDA1(2006.94111,"+"_I_","_ID_",",.01)=$P(TAG(I),ISEP,1)  ; TAG NAME
 . S FDA1(2006.94111,"+"_I_","_ID_",",1)=$P(TAG(I),ISEP,2)    ; TAG VALUE
 . Q
 D VALIDATE^MAGVIM06(.FDA1,.ERR4)
 I $D(ERR4) S OUT="-11"_SSEP_$G(ERR4) L -^MAGV(2006.941,ID) Q  ; Unlock/quit
 D UPDATE^DIE("","FDA1","","ERR1")
 I $D(ERR1("DIERR",1,"TEXT",1)) S OUT="-10"_SSEP_$G(ERR1("DIERR",1,"TEXT",1)) L -^MAGV(2006.941,ID) Q  ; Unlock/quit
 ; Set Work Item
 S FDA2(2006.941,ID_",",9)=$$NOW^XLFDT
 S:$G(UPDUSR)'="" FDA2(2006.941,ID_",",10)="`"_UPDUSR  ; LAST UPDATING USER - User DUZ is passed
 I $G(UPDAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,UPDAPP,1)  ; Get application IEN or create a new one first
 . S FDA2(2006.941,ID_",",15)=UPDAPP      ; LAST UPDATING APP
 . Q
 S OUT=$$UPDWI^MAGVIM09(ID,.FDA2,.MSGUPD)  ; Update Work Item ID with FDA data, MSGUPD message
 L -^MAGV(2006.941,ID)
 Q
 ; RPC: MAGV GET NEXT WORK ITEM
GETNEXT(OUT,ETYPE,EXPSTAT,NEWSTAT,UPDUSR,UPDAPP,LOCATION) ; Find last update work item on worklist type provided
 N SSEP,ID,ETYPEIEN,ESTATIEN,ELOCIEN,UPDATEDT
 K OUT
 S SSEP=$$STATSEP
 I $G(ETYPE)="" S OUT(0)=-1_SSEP_"Work Item type not specified" Q
 I $G(EXPSTAT)="" S OUT(0)=-2_SSEP_"Work Item expected status not specified" Q
 I $G(NEWSTAT)="" S OUT(0)=-3_SSEP_"Work Item new status not specified" Q
 I ($G(UPDUSR)="")&($G(UPDAPP)="") S OUT(0)=-4_SSEP_"No updated by user/application provided" Q
 I $G(LOCATION)="" S OUT(0)=-5_SSEP_"Work Item Place ID not specified" Q
 ; 
 S ETYPEIEN=$O(^MAGV(2006.9412,"B",ETYPE,""))
 S ESTATIEN=$O(^MAGV(2006.9413,"B",EXPSTAT,""))
 S ELOCIEN=$$IEN^XUAF4(LOCATION) ; get Location IEN
 ;
 I ETYPEIEN'>0 S OUT(0)=-6_SSEP_"Work Item type IEN not found: "_ETYPE Q
 I ESTATIEN'>0 S OUT(0)=-7_SSEP_"Work Item expected status IEN not found: "_EXPSTAT Q 
 I ELOCIEN'>0 S OUT(0)=-8_SSEP_"Work Item Place ID not found: "_LOCATION Q
 ; 
 ;Get last updated record with matching parameters
 S UPDATEDT=$O(^MAGV(2006.941,"C",ETYPEIEN,ESTATIEN,ELOCIEN,""))
 I 'UPDATEDT S OUT(0)=0_SSEP_"No matching work item found" Q
 S ID=$O(^MAGV(2006.941,"C",ETYPEIEN,ESTATIEN,ELOCIEN,UPDATEDT,""))
 I 'ID S OUT(0)=0_SSEP_"No matching work item found" Q
 L +^MAGV(2006.941,ID):1999999
 S OUT(0)=0
 I NEWSTAT'=EXPSTAT D UPUSRAPP(.OUT,ID,NEWSTAT,UPDUSR,UPDAPP) ; Update user, app, updated time fields
 I +OUT(0)=0 D
 . S OUT(0)=0
 . D GETWI^MAGVIM09(.OUT,ID)  ; Get Work Item Record
 . Q 
 L -^MAGV(2006.941,ID)
 Q
 ; RPC: MAGV IMPORT STATUS
IMSTATUS(OUT,UIDS) ; Get import status
 D IMSTATUS^MAGVIM09(.OUT,.UIDS)  ;P332 routine size exceeded - Moved to MAGVIM09
 Q
UPUSRAPP(OUT,ID,NEWSTAT,UPDUSR,UPDAPP) ; Update user, app, updated time fields
 N FDA,APPIEN
 S FDA(2006.941,ID_",",3)=NEWSTAT
 S FDA(2006.941,ID_",",9)=$$NOW^XLFDT
 S:$G(UPDUSR)'="" FDA(2006.941,ID_",",10)="`"_UPDUSR  ; LAST UPDATING USER - User DUZ is passed
 I $G(UPDAPP)'="" D
 . S APPIEN=$$GETIEN^MAGVAF05(2006.9193,UPDAPP,1)  ; Get application IEN or create a new one first
 . S FDA(2006.941,ID_",",15)=UPDAPP      ; LAST UPDATING APPLICATION
 . Q
 S OUT(0)=$$UPDWI^MAGVIM09(ID,.FDA)  ; Update Work Item ID with FDA data and MSGUPD message
 Q
UPCASE(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
