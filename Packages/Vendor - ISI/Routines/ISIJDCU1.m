ISIJDCU1 ; ISI/MLS - ISIJ Dictation System Utilities ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**102,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to DBS^RAERR in ICR #7401
 ;
 Q
 ;
 ; RPC = ISIJ RAD RPT DETAIL
 ;       Provides report details for dictation
 ;
 ; 4/1/2020 -- Entry point also called via subroutine call from ISIJRPT
 ;             to support ISI Rad Dictation "Version 2"; change key = DICTV2
 ;
 ;
 ; Input paramters:
 ; OUT = output array
 ; RACASE = DFN^RADTI^RACNI
 ;          Where DFN is Patient DFN ; RADTI is Inverse exam date and RACNI is Case Num.
 ; DICTV2 = If positive, is both a Line Count initiator, AND a flag for alternate processing logic
 ;
 ; Output array:
 ; OUT(0) = 0 no results; n results; <0 error [-#^details^line tag^E]
 ; OUT(1) = Accession Num ^ Rpt IEN ^ Rpt Status ^ Rpt Status [internal] ^ Rpt Verify Date ^ Reported Date ^ Verifying Physician ^ Ver Phys DNF ^ Prim DX Code ^ Prim DX code [internal]
 ; OUT(n++) = "*RPT"           [start report txt indicator]
 ; OUT(n++) = ...report text
 ; OUT(n++) = "*END_RPT"       [end report txt indicator]
 ; OUT(n++) = "*IMP"           [start of Impression text indicator]
 ; OUT(n++) = ...impression text
 ; OUT(n++) = "*END_IMP"       [end report txt indicator]
 ; OUT(n++) = "*ACL"           [start additional clin hist txt indicator]
 ; OUT(n++) = ...clin hist txt
 ; OUT(n++) = "*END_ACL"       [end additional clin hist txt inicator] 
 ; OUT(n++) = "*OCN"           [start other case # list]
 ; OUT(n++) = ...other case #'s
 ; OUT(n++) = "*END_OCN"       [end other case # list]
 ; OUT(n++) = "*SECDX"
 ; Secondary DX Code ^ DX code [internal]
 ; OUT(n++) = "*END_SECDX"
 ; 
RPTSTAT(OUT,RACASE,DICTV2) ;
 S DICTV2=$G(DICTV2,0) ; jhc--"dictation V2" has different needs; minor changes ID'd by this variable
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJDCU1"
 N CNT,DFN,RADTI,RACNI,IENS7003,IENS7002,DIERR,RADTE,RABUF,RAMSG
 N RACN,ACCNUM,RPTIEN,IENS74,RPTSTAT,RPTSTATI,VERDT,RPTDT,VERPHYS,VERPHYSI
 N PRIMDXCD,PRIMDXI,ZFLD,SECDX
 S U="^" K OUT S (OUT(0),CNT)=0
 I DICTV2 S CNT=DICTV2  ; dict V2 mod
 Q:RACASE=""
 S DFN=$P(RACASE,U) Q:DFN=""
 S RADTI=$P(RACASE,U,2) Q:RADTI=""
 S RACNI=$P(RACASE,U,3) Q:RACNI=""
 ;
 ;Get IENs
 S IENS7003=$$EXAMIENS^RAMAGU04(RACASE)
 S IENS7002=$P(IENS7003,",",2,4)
 ;
 S RADTE=$$GET1^DIQ(70.02,IENS7002,.01,"I",,"RAMSG")
 I $G(DIERR) S OUT(0)=$$DBS^RAERR("RAMSG",-9,70.02,IENS7002) Q
 ;
 ;--- Get the report IEN
 K RABUF,RAMSG
 S ZFLD=".01;13;13.1*;17"
 I $$VFIELD^DILFD(70.03,31) S ZFLD=ZFLD_";31" ;check to see if running MAG*49
 D GETS^DIQ(70.03,IENS7003,ZFLD,"IE","RABUF","RAMSG")
 I $G(DIERR) S OUT(0)=$$DBS^RAERR("RAMSG",-9,70.03,IENS7003) Q
 S RACN=$G(RABUF(70.03,IENS7003,.01,"I"))
 S PRIMDXCD=$G(RABUF(70.03,IENS7003,13,"E"))
 S PRIMDXI=$G(RABUF(70.03,IENS7003,13,"I"))
 S RPTIEN=$G(RABUF(70.03,IENS7003,17,"I"))
 I RPTIEN'>0 S OUT(0)="0" Q  ; No report yet
 S ACCNUM=$G(RABUF(70.03,IENS7003,31,"I")) ;long acccession #
 ;
 ; if long accession # not used, construct short 
 S:ACCNUM="" ACCNUM=$$ACCNUM^RAMAGU04(RADTE,RACN,"S") ;
 ;
 ; save Secondary DX codes for later processing
 M SECDX(70.14)=RABUF(70.14)
 ;
 ;--- Get the Report details
 K RABUF,RAMSG
 S IENS74=(RPTIEN)_","
 D GETS^DIQ(74,IENS74,"4.5*;5;7;8;9;200;300;400","IE","RABUF","RAMSG")  ; was missing ;8
 I $G(DIERR) S OUT(0)=$$DBS^RAERR("RAMSG",-9,74,IENS74) Q
 S RPTSTAT=$G(RABUF(74,IENS74,5,"E"))
 S RPTSTATI=$G(RABUF(74,IENS74,5,"I"))
 S VERDT=$G(RABUF(74,IENS74,7,"E"))
 S RPTDT=$G(RABUF(74,IENS74,8,"E"))
 S VERPHYS=$G(RABUF(74,IENS74,9,"E"))
 S VERPHYSI=$G(RABUF(74,IENS74,9,"I"))
 ;
 ; assemble detail string
 ; DICTV2-Begin
 I +$G(DICTV2) D  G RPTSTATZ
 . N SECDX2,HIT
 . ; get: REPORT TEXT (200), IMPRESSION TEXT (300)
 . D WP("RABUF(74,"""_IENS74_""",200)","REPORT",.HIT)
 . I HIT S OUT(CNT)="*REPORT_END"  ; * this overwrites node from the subrtn
 . D WP("RABUF(74,"""_IENS74_""",300)","IMPRESSION",.HIT)
 . I HIT S OUT(CNT)="*IMPRESSION_END"  ; * this overwrites node from the subrtn
 . ; get 13.1 SECONDARY DX CODES;  * only supporting one sec dx code in dictv2
 . S SECDX2=""
 . S X=$O(SECDX(70.14,0)) I X]"" S SECDX2=SECDX(70.14,X,.01,"I")
 . S X=PRIMDXI_U_SECDX2
 . I $L(X)>1 D  ; only report if either value exists
 . . S CNT=CNT+1,OUT(CNT)="*DXCODE"
 . . S CNT=CNT+1,OUT(CNT)=PRIMDXI_U_SECDX2
 . . S CNT=CNT+1,OUT(CNT)="*DXCODE_END"
 . I '(DICTV2<CNT) S CNT=0  ; no rpt data found
 ; DICTV2-End
 S CNT=CNT+1
 S OUT(CNT)=ACCNUM_U_RPTIEN_U_RPTSTAT_U_RPTSTATI_U_VERDT_U_RPTDT_U_VERPHYS_U_VERPHYSI_U_PRIMDXCD_U_PRIMDXI
 ;
 ; get WP fields:  REPORT TEXT (200), IMPRESSION TEXT (300), ADDITIONAL CLINICAL HISTORY (400)
 D WP("RABUF(74,"""_IENS74_""",200)","RPT")
 D WP("RABUF(74,"""_IENS74_""",300)","IMP")
 D WP("RABUF(74,"""_IENS74_""",400)","ACL")
 ;
 ; get 4.5 OTHER CASE#  (multiple)
 D OCASE("RABUF(74.05)","OCN")
 ;
 ; get 13.1 SECONDARY DX CODES  (multiple)
 D SECDX("SECDX(70.14)","SECDX")
 ;
RPTSTATZ ;
 S OUT(0)=CNT ;success
 Q
 ;
 ; process word processor fields
WP(NODE,CROSS,HIT) ;
 S HIT=1
 S X=0 I '$O(@NODE@(X))  S HIT=0 Q
 S CNT=CNT+1 S OUT(CNT)="*"_CROSS
 S X=0 F  S X=$O(@NODE@(X)) Q:'X  D
 . S CNT=CNT+1
 . S OUT(CNT)=@NODE@(X)
 S CNT=CNT+1 S OUT(CNT)="*END_"_CROSS
 Q
 ;
 ; Process Other Cases (4.5) muliple 
OCASE(NODE,CROSS) ;
 S X=0 I '$O(@NODE@(X)) Q
 S CNT=CNT+1 S OUT(CNT)="*"_CROSS
 S X=0 F  S X=$O(@NODE@(X)) Q:X=""  D
 . S CNT=CNT+1
 . S OUT(CNT)=@NODE@(X,.01,"E")
 S CNT=CNT+1 S OUT(CNT)="*END_"_CROSS
 Q
 ;
 ; Process Secondary DX Code (13.1) muliple
SECDX(NODE,CROSS) ;
 S X=0 I '$O(@NODE@(X)) Q
 S CNT=CNT+1 S OUT(CNT)="*"_CROSS
 S X=0 F  S X=$O(@NODE@(X)) Q:X=""  D
 . S CNT=CNT+1
 . S OUT(CNT)=@NODE@(X,.01,"E")_U_@NODE@(X,.01,"I")
 S CNT=CNT+1 S OUT(CNT)="*END_"_CROSS
 Q
 ;
ERR ;
 S OUT(0)="-1^VISTA ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
