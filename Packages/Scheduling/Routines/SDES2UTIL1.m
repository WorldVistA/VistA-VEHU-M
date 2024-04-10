SDES2UTIL1 ;ALB/MGD/TJB/MGD,TJB - SDES2 UTILITIES Continued ;FEB 08, 2024
 ;;5.3;Scheduling;**870,861,873**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
VALBOOLEAN(SDERRORS,SDBOOLEAN,SDREQUIRED,SDERRORTEXT) ;
 ; SDERRORS = Array to hold any logged errors
 ; SDBOOLEAN = Boolean input array element to validate
 ; SDREQUIRED = 1:Required, 0:Optional, Defaults to 0
 ; SDERRORTEXT = Additional text to append to error message. This is normally the name of the input parameter element.
 ;
 I SDREQUIRED=0,SDBOOLEAN="" Q
 S SDREQUIRED=$S($G(SDREQUIRED)="":0,1:$G(SDREQUIRED))
 I SDREQUIRED=1,SDBOOLEAN="" D ERRLOG^SDESJSON(.SDERRORS,519,SDERRORTEXT)
 I SDBOOLEAN'="1",SDBOOLEAN'="0" D ERRLOG^SDESJSON(.SDERRORS,518,SDERRORTEXT)
 Q
 ;
GETRES(SDCL,INACT)  ; Extrinsic function to return resource for clinic - SDEC RESOURCE (409.831)
 ; SDCL = Clinic IEN from File 44
 ; INACT = If not null, skip check to see if resource is inactive
 ; Return value is the associated resource or the empty string
 ;
 ; SDHLN - Name of the Clinic from File 44
 ; SDI - Resource IEN from file 409.831
 ; SDRESTYP - RESOURCE TYPE, Field .012 from File 409.831
 N SDHLN,SDI,SDRESTYP,SDRES,SDRES1
 S (SDRES,SDRES1)=""
 S SDHLN=$$GET1^DIQ(44,SDCL_",",.01,"E")
 Q:SDHLN="" ""
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI=""  D  Q:SDRES'=""
 .S SDRESTYP=$$GET1^DIQ(409.831,SDI_",",.012,"I")
 .I '$G(INACT) Q:$$GET1^DIQ(409.831,SDI_",",.02)="YES"
 .S:SDRES1="" SDRES1=SDI
 .Q:$P(SDRESTYP,";",2)'="SC("
 .S SDRES=SDI
 I SDRES="",SDRES1'="" S SDRES=SDRES1
 Q SDRES
 ;
GETGAF(DFN) ;
 N GAF,GAFR
 S GAF=$$NEWGAF^SDUTL2(DFN)
 S GAFR=""
 S:GAF="" GAF=-1
 S $P(GAFR,"|",1)=$S(+GAF:"New GAF Required",1:"No new GAF required")
 Q GAFR
 ;
ETHNLIST(ETHNICITY,DFN) ;get ethnicity list
 ;INPUT:
 ;  DFN = Patient ID pointer to PATIENT file
 ;RETURN:
 ;   PETH   - Patient Ethnicity list separated by pipe |
 ;               Pointer to ETHNICITY file 10.2
 ;   PETHN  - Patient Ethnicity names separated by pipe |
 N SDI,SDID,PETH,PETHN
 S (PETH,PETHN)=""
 S SDI=0 F  S SDI=$O(^DPT(DFN,.06,SDI)) Q:SDI'>0  D
 .S SDID=$P($G(^DPT(DFN,.06,SDI,0)),U,1)
 .S PETH=$S(PETH'="":PETH_"|",1:"")_SDID
 .S PETHN=$S(PETHN'="":PETHN_"|",1:"")_$P($G(^DIC(10.2,SDID,0)),U,1)
 S ETHNICITY("NAMES")=PETHN
 S ETHNICITY("IENS")=PETH
 Q
RACELIST(RACELST,DFN) ;get list of race information for given patient
 ;INPUT:
 ;  DFN = Patient ID pointer to PATIENT file
 ;RETURN:
 ;   RACEIEN  - Patient race list separated by pipe |
 ;               Pointer to RACE file 10
 ;   RACENAM  - Patient race names separated by pipe |
 N SDI,SDID,RACEIEN,RACENAM
 S (RACEIEN,RACENAM)=""
 S SDI=0 F  S SDI=$O(^DPT(DFN,.02,SDI)) Q:SDI'>0  D
 .S SDID=$P($G(^DPT(DFN,.02,SDI,0)),U,1)
 .S RACEIEN=$S(RACEIEN'="":RACEIEN_"|",1:"")_SDID
 .S RACENAM=$S(RACENAM'="":RACENAM_"|",1:"")_$P($G(^DIC(10,SDID,0)),U,1)
 S RACELST("NAMES")=RACENAM
 S RACELST("IENS")=RACEIEN
 Q
 ;
HRN(DFN) ;Health Record Number
 N X
 S X=$G(^AUPNPAT(DFN,41,+$G(DUZ(2)),0))
 Q $S($P(X,U,3):"",1:$P(X,U,2))
 ;
FLAGS(DFN,FNUM) ;get PRF flags
 ;INPUT:
 ; DFN  - Patient ID
 ; FNUM - PRF Flag file ID  26.15=PRF NATIONAL FLAG  26.11=PRF LOCAL FLAG
 ;RETURN:
 ;  Each | piece contains the following ;; pieces:
 ;   1. PRFAID   - PRF Assignment ID pointer to PRF ASSIGNMENT file (#26.13)
 ;   2. PRFSTAT  - PRF Assignment Status 0=INACTIVE 1=ACTIVE
 ;   3. PRFLID   - PRF Local Flag ID pointer to PRF LOCAL FLAG file (#26.11)
 ;   4. PRFLNAME - PRF Local Flag name
 ;   5. PRFLSTAT - PRF Local Flag status  0=INACTIVE 1=ACTIVE
 ;
 N PRFAID,PRFID,PRFLST,RET,STAT
 S RET=""
 S DFN=$G(DFN)
 Q:DFN="" ""
 Q:'$D(^DPT(DFN,0)) ""
 S FNUM=$G(FNUM)
 Q:(FNUM'=26.15)&(FNUM'=26.11) ""
 D FLST(.PRFLIST,FNUM)
 S PRFID="" F  S PRFID=$O(PRFLIST(PRFID)) Q:PRFID=""  D
 .S PRFAID="" F  S PRFAID=$O(^DGPF(26.13,"AFLAG",PRFID,DFN,PRFAID)) Q:PRFAID=""  D
 ..S STAT="" S STAT=$$GET1^DIQ(26.13,PRFAID_",",.03,"I") Q:STAT'=1
 ..S RET=RET_$S(RET'="":"|",1:"")_PRFAID_";;"_STAT_";;"_+PRFID_";;"_$P(PRFLIST(PRFID),U,1)_";;"_$P(PRFLIST(PRFID),U,2)
 Q RET
FLST(PRFLIST,FNUM)  ;build flag list
 N PRFID,PRFN
 K PRFLIST
 S PRFN="" F  S PRFN=$O(^DGPF(FNUM,"B",PRFN)) Q:PRFN=""  D
 .S PRFID="" F  S PRFID=$O(^DGPF(FNUM,"B",PRFN,PRFID)) Q:PRFID=""  D
 ..S PRFLIST(PRFID_";DGPF("_FNUM_",")=$$GET1^DIQ(FNUM,PRFID_",",.01)_U_$$GET1^DIQ(FNUM,PRFID_",",.02,"I")
 Q
 ;
