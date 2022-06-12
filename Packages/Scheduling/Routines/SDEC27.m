SDEC27 ;ALB/SAT,WTC - VISTA SCHEDULING RPCS ;Feb 12, 2020@15:22
 ;;5.3;Scheduling;**627,694**;Aug 13, 1993;Build 61
 ;
 ;  ICR
 ;  ---
 ;   7030 - #2 (appointment record)
 ;  10061 - DEM^VADPT
 ;
 Q
 ;
PATAPPTD(SDECY,DFN) ;Return the Patient appointment display
 ;PATAPPTD(SDECY,DFN)  external parameter tag is in SDEC
 ;Return recordset of patient appointments used in listing
 ;a patient's appointments and generating patient letters.
 ;RETURN:
 ; Global Array in which each array entry contains patient appointment data separated by ^:
 ; 1. Name
 ; 2. DOB
 ; 3. Sex
 ; 4. HRN
 ; 5. ApptDate
 ; 6. Clinic
 ; 7. TypeStatus
 ; 8. RESOURCEID
 ; 9. APPT_MADE_BY
 ;10. DATE_APPT_MADE
 ;11. NOTE
 ;12. STREET
 ;13. CITY
 ;14. STATE
 ;15. ZIP
 ;16. HOMEPHONE
 ;17. EESTAT - Patient Status  N=NEW  E=ESTABLISHED
 ;
 N SDECI,SDECIEN,SDECNOD,SDECNAM,SDECDOB,SDECHRN,SDECSEX,SDECCNID,SDECCNOD,SDECMADE,SDECCLRK,SDECNOT,SDECQ
 N EESTAT,SDECSTRT,SDECDPT
 N SDECSTRE,SDECCITY,SDECST,SDECZIP,SDECPHON
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S SDECI=0
 S ^TMP("SDEC",$J,SDECI)="T00030Name^D00020DOB^T00030Sex^T00030HRN^D00030ApptDate^T00030Clinic^T00030TypeStatus"
 S ^TMP("SDEC",$J,SDECI)=^(SDECI)_"^I00010RESOURCEID^T00030APPT_MADE_BY^D00020DATE_APPT_MADE^T00250NOTE^T00030STREET^T00030CITY^T00030STATE^T00030ZIP^T00030HOMEPHONE^T00030EESTAT"_$C(30)
 ;Get patient info
 ;
 I '+DFN S ^TMP("SDEC",$J,1)=$C(31) Q
 I '$D(^DPT(+DFN,0)) S ^TMP("SDEC",$J,1)=$C(31) Q
 S SDECNOD=$$PATINFO(DFN)
 S SDECNAM=$P(SDECNOD,U) ;NAME
 S SDECSEX=$P(SDECNOD,U,2) ;SEX
 S SDECDOB=$P(SDECNOD,U,3) ;DOB
 S SDECHRN=$P(SDECNOD,U,4) ;Health Record Number for location DUZ(2)
 S SDECSTRE=$P(SDECNOD,U,5) ;Street
 S SDECCITY=$P(SDECNOD,U,6) ;City
 S SDECST=$P(SDECNOD,U,7) ;State
 S SDECZIP=$P(SDECNOD,U,8) ;zip
 S SDECPHON=$P(SDECNOD,U,9) ;homephone
 ;
 ;Organize ^DPT(DFN,"S," nodes
 ; into SDECDPT(CLINIC,DATE)
 ;
 I $D(^DPT(DFN,"S")) S SDECDT=0 F  S SDECDT=$O(^DPT(DFN,"S",SDECDT)) Q:'+SDECDT  D
 . S SDECNOD=$G(^DPT(DFN,"S",SDECDT,0))
 . S SDECCID=$P(SDECNOD,U)
 . Q:'+SDECCID
 . Q:'$D(^SC(SDECCID,0))
 . S SDECDPT(SDECCID,SDECDT)=SDECNOD
 ;
 ;$O Through ^SDEC("CPAT",
 S SDECIEN=0
 I $D(^SDEC(409.84,"CPAT",DFN)) F  S SDECIEN=$O(^SDEC(409.84,"CPAT",DFN,SDECIEN)) Q:'SDECIEN  D
 . N SDECNOD,SDECAPT,SDECCID,SDECCNOD,SDECCLN,SDEC44,SDECDNOD,SDECSTAT,SDEC,SDECTYPE,SDECLIN
 . S SDECNOD=$G(^SDEC(409.84,SDECIEN,0))
 . Q:SDECNOD=""
 . Q:$P(SDECNOD,U,12)]""  ;CANCELLED
 . S Y=$P(SDECNOD,U)
 . Q:'+Y
 .;
 .;  Change date/time conversion so midnight is handled properly.  wtc 694 5/17/18
 .;
 . S SDECAPT=$$FMTONET^SDECDATE(Y,"Y") ;
 . ;X ^DD("DD") S Y=$TR(Y,"@"," ")
 . ;S SDECAPT=Y ;Appointment date time
 . S SDECCLRK=$P(SDECNOD,U,8) ;Appointment made by
 . S:+SDECCLRK SDECCLRK=$G(^VA(200,SDECCLRK,0)),SDECCLRK=$P(SDECCLRK,U)
 . S Y=$P(SDECNOD,U,9) ;Date Appointment Made
 . S SDECMADE=$$FMTONET^SDECDATE(Y,"Y") ;
 . ;I +Y X ^DD("DD") S Y=$TR(Y,"@"," ")
 . ;S SDECMADE=Y
 . ;NOTE
 . S SDECNOT=""
 . I $D(^SDEC(409.84,SDECIEN,1,0)) S SDECNOT="",SDECQ=0 F  S SDECQ=$O(^SDEC(409.84,SDECIEN,1,SDECQ)) Q:'+SDECQ  D
 . . S SDECLIN=$G(^SDEC(409.84,SDECIEN,1,SDECQ,0))
 . . S:(SDECLIN'="")&($E(SDECLIN,$L(SDECLIN)-1,$L(SDECLIN))'=" ") SDECLIN=SDECLIN_" "
 . . S SDECNOT=SDECNOT_SDECLIN
 . ;Resource
 . S SDECCID=$P(SDECNOD,U,7) ;IEN of SDEC RESOURCE
 . Q:'+SDECCID
 . Q:'$D(^SDEC(409.831,SDECCID,0))
 . S SDECCNOD=$G(^SDEC(409.831,SDECCID,0)) ;SDEC RESOURCE node
 . Q:SDECCNOD=""
 . S SDECCLN=$P(SDECCNOD,U) ;Text name of SDEC Resource
 . S SDEC44=$P(SDECCNOD,U,4) ;File 44 pointer
 . ;If appt entry in ^DPT(PAT,"S" exists for this clinic, get the TYPE/STATUS info from
 . ;the SDECDPT array and delete the SDECDPT node
 . S SDECTYPE=""
 . I +SDEC44,$D(SDECDPT(SDEC44,$P(SDECNOD,U))) D  ;SDECNOD is the SDEC APPOINTMENT node
 . . S SDECDNOD=SDECDPT(SDEC44,$P(SDECNOD,U)) ;SDECDNOD is a copy of the ^DPT(PAT,"S" node
 . . S SDECTYPE=$$STATUS(DFN,$P(SDECNOD,U),SDECDNOD)
 . . K SDECDPT(SDEC44,$P(SDECNOD,U))
 . S EESTAT=$$GET1^DIQ(409.84,SDECIEN_",",.23,"E")
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=SDECNAM_"^"_SDECDOB_"^"_SDECSEX_"^"_SDECHRN_"^"_SDECAPT_"^"_SDECCLN_"^"_SDECTYPE_"^"_SDECCID_"^"_SDECCLRK_"^"_SDECMADE_"^"_SDECNOT_"^"_SDECSTRE_"^"_SDECCITY_"^"_SDECST_"^"_SDECZIP_"^"_SDECPHON_"^"_EESTAT_$C(30)
 . Q
 ;
 ;Go through remaining SDECDPT( entries
 I $D(SDECDPT) S SDEC44=0 D
 . F  S SDEC44=$O(SDECDPT(SDEC44)) Q:'+SDEC44  S SDECDT=0 D
 . . F  S SDECDT=$O(SDECDPT(SDEC44,SDECDT)) Q:'+SDECDT  D
 . . . S SDECDNOD=SDECDPT(SDEC44,SDECDT)
 . . . S Y=SDECDT
 . . . Q:'+Y
 . . . ;
 . . . ;  Change date/time conversion so midnight is handled properly.  wtc 694 5/17/18
 . . . ;
 . . . S SDECAPT=$$FMTONET^SDECDATE(Y,"Y") ;
 . . . ;X ^DD("DD") S Y=$TR(Y,"@"," ")
 . . . ;S SDECAPT=Y
 . . . S SDECTYPE=$$STATUS(DFN,SDECDT,SDECDNOD) ;IHS/OIT/HMW 20050208 Added
 . . . S SDECCLN=$P($G(^SC(SDEC44,0)),U)
 . . . S SDECCLRK=$P(SDECDNOD,U,18)
 . . . S:+SDECCLRK SDECCLRK=$G(^VA(200,SDECCLRK,0)),SDECCLRK=$P(SDECCLRK,U)
 . . . S Y=$P(SDECDNOD,U,19)
 . . . S SDECMADE=$$FMTONET^SDECDATE(Y,"Y") ;
 . . . ;I +Y X ^DD("DD") S Y=$TR(Y,"@"," ")
 . . . ;S SDECMADE=Y
 . . . S SDECNOT=""
 . . . S SDECI=SDECI+1
 . . . S ^TMP("SDEC",$J,SDECI)=SDECNAM_"^"_SDECDOB_"^"_SDECSEX_"^"_SDECHRN_"^"_SDECAPT_"^"_SDECCLN_"^"_SDECTYPE_"^"_"^"_SDECCLRK_"^"_SDECMADE_"^"_SDECNOT_"^"_SDECSTRE_"^"_SDECCITY_"^"_SDECST_"^"_SDECZIP_"^"_SDECPHON_"^"_$C(30)
 . . . K SDECDPT(SDEC44,SDECDT)
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
STATUS(PAT,DATE,NODE) ; returns appt status
 NEW TYP
 S TYP=$$APPTYP^SDECU2(PAT,DATE)    ;sched vs. walkin
 I $P(NODE,U,2)["C" Q TYP_" - CANCELLED"
 I $P(NODE,U,2)'="NT",$P(NODE,U,2)["N" Q TYP_" - NO SHOW"
 I $$CO^SDECU2(PAT,+NODE,DATE) Q TYP_" - CHECKED OUT"
 I $$CI^SDECU2(PAT,+NODE,DATE) Q TYP_" - CHECKED IN"
 Q TYP
 ;
ERROR ;
 D ERR("VISTA Error")
 Q
 ;
ERR(ERRNO) ;Error processing
 N SDECERR
 S:'$D(SDECI) SDECI=999
 S SDECERR=ERRNO
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="^^^^^^^^^^^^^^^"_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
PATINFO(DFN) ;EP
 ;Intrisic Function returns NAME^SEX^DOB^HRN^STREET^CITY^STATE^ZIP^PHONE for patient ien DFN
 ;DOB is in external format
 ;HRN depends on existence of DUZ(2)
 ;
 N SDECNOD,SDECNAM,SDECSEX,SDECDOB,SDECHRN,SDECSTRT,SDECCITY,SDECST,SDECZIP,SDECPHON
 S SDECNOD=^DPT(+DFN,0)
 S SDECNAM=$P(SDECNOD,U) ;NAME
 S SDECSEX=$P(SDECNOD,U,2)
 S SDECSEX=$S(SDECSEX="F":"FEMALE",SDECSEX="M":"MALE",1:"")
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 5/17/18
 ;
 S Y=$P(SDECNOD,U,3) ;I Y]""  X ^DD("DD") S Y=$TR(Y,"@"," ")
 I Y]"" S Y=$$FMTONET^SDECDATE(Y,"Y") ;
 S SDECDOB=Y ;DOB
 S SDECHRN=""
 I $D(DUZ(2)) I DUZ(2)>0 S SDECHRN=$P($G(^AUPNPAT(DFN,41,DUZ(2),0)),U,2) ;HRN
 ;
 S SDECNOD=$G(^DPT(+DFN,.11))
 S (SDECSTRT,SDECCITY,SDECST,SDECZIP)=""
 I SDECNOD]"" D
 . S SDECSTRT=$E($P(SDECNOD,U),1,50) ;STREET
 . S SDECCITY=$P(SDECNOD,U,4) ;CITY
 . S SDECST=$P(SDECNOD,U,5) ;STATE
 . I +SDECST,$D(^DIC(5,+SDECST,0)) S SDECST=$P(^DIC(5,+SDECST,0),U,2)
 . S SDECZIP=$P(SDECNOD,U,6) ;ZIP
 ;
 S SDECNOD=$G(^DPT(+DFN,.13)) ;PHONE
 S SDECPHON=$P(SDECNOD,U)
 ;
 Q SDECNAM_U_SDECSEX_U_SDECDOB_U_SDECHRN_U_SDECSTRT_U_SDECCITY_U_SDECST_U_SDECZIP_U_SDECPHON
 ;
CLINLET(SDECY,SDECCLST,SDECBEG,SDECEND,SDECWI) ;CLINIC LETTERS Appointment data
 ;CLINLET(SDECY,SDECCLST,SDECBEG,SDECEND,SDECWI)  external parameter tag is in SDEC
 ;Return recordset of patient appointments
 ;between dates SDECBEG and SDECEND for each clinic in SDECCLST.
 ;Used in listing a patient's appointments and generating patient letters.
 ;SDECCLST is a |-delimited list of SDEC RESOURCE iens.  (The last |-piece is null, so discard it.)
 ;SDECBEG and SDECEND are in external date form.
 ;SDECWI = return only appointments where the WALKIN field is yes
 ;RETURN:
 ; Global Array in which each array entry contains the following Clinic Letter data separated by ^:
 ; 1. Name
 ; 2. DOB
 ; 3. Sex
 ; 4. HRN
 ; 5. ApptDate
 ; 6. Clinic
 ; 7. TypeStatus
 ; 8. RESOURCEID
 ; 9. APPT_MADE_BY
 ;10. DATE_APPT_MADE
 ;11. NOTE
 ;12. STREET
 ;13. CITY
 ;14. STATE
 ;15. ZIP
 ;16. HOMEPHONE
 ;
 N SDECI,SDECNOD,SDECNAM,SDECDOB,SDECHRN,SDECSEX,SDECCID,SDECCNOD,SDECDT
 N SDECJ,SDECAID,DFN,SDECPNOD,SDECCLN,SDECCLRK,SDECMADE,SDECNOT,SDECLIN
 N SDECSTRT,%DT,X,Y
 N SDECSTRE,SDECCITY,SDECST,SDECZIP,SDECPHON
 S SDECY="^TMP(""SDEC"","_$J_")"
 K ^TMP("SDEC",$J)
 S SDECI=0
 S ^TMP("SDEC",$J,SDECI)="T00030Name^D00020DOB^T00030Sex^T00030HRN^D00030ApptDate^T00030Clinic^T00030TypeStatus"
 S ^TMP("SDEC",$J,SDECI)=^TMP("SDEC",$J,SDECI)_"^I00010RESOURCEID^T00030APPT_MADE_BY^D00020DATE_APPT_MADE^T00250NOTE^T00030STREET^T00030CITY^T00030STATE^T00030ZIP^T00030HOMEPHONE"_$C(30)
 ;
 ;Convert beginning and ending dates
 ;
 S X=SDECBEG,%DT="X" D ^%DT S SDECBEG=$P(Y,"."),SDECBEG=SDECBEG-1,SDECBEG=SDECBEG_".9999"
 I Y=-1 D ERR(SDECI,0,"Routine: SDEC27, Error: Invalid Date") Q
 S X=SDECEND,%DT="X" D ^%DT S SDECEND=$P(Y,"."),SDECEND=SDECEND_".9999"
 I Y=-1 D ERR(SDECI,0,"Routine: SDEC27, Error: Invalid Date") Q
 I SDECCLST="" D ERR(SDECI,0,"Routine: SDEC27, Error: Null clinic list") Q
 ;
 ;For each clinic in SDECCLST $O through ^SDEC(409.84,"ARSRC",ResourceIEN,FMDate,ApptIEN)
 ;
 F SDECJ=1:1:$L(SDECCLST,"|")-1 S SDECCID=$P(SDECCLST,"|",SDECJ) D
 . S SDECCLN=$G(^SDEC(409.831,SDECCID,0)) S SDECCLN=$P(SDECCLN,U) Q:SDECCLN=""
 . S SDECSTRT=SDECBEG F  S SDECSTRT=$O(^SDEC(409.84,"ARSRC",SDECCID,SDECSTRT)) Q:'+SDECSTRT  Q:SDECSTRT>SDECEND  D
 . . S SDECAID=0 F  S SDECAID=$O(^SDEC(409.84,"ARSRC",SDECCID,SDECSTRT,SDECAID)) Q:'+SDECAID  D
 . . . S SDECNOD=$G(^SDEC(409.84,SDECAID,0))
 . . . Q:SDECNOD=""
 . . . Q:$P(SDECNOD,U,12)]""  ;CANCELLED
 . . . I '$G(SDECWI),$P(SDECNOD,U,13)="y" Q  ;DO NOT ALLOW WALKIN
 . . . I $G(SDECWI),$P(SDECNOD,U,13)'="y" Q  ;ONLY ALLOW WALKIN
 . . . S Y=$P(SDECNOD,U)
 . . . Q:'+Y
 . . . ;
 . . . ;  Change date/time conversion so midnight is handled properly.  wtc 694 5/17/18
 . . . ;
 . . . S SDECAPT=$$FMTONET^SDECDATE(Y,"Y") ;
 . . . ;X ^DD("DD") S Y=$TR(Y,"@"," ")
 . . . ;S SDECAPT=Y ;Appointment date time
 . . . ;
 . . . ;NOTE
 . . . S SDECNOT=""
 . . . I $D(^SDEC(409.84,SDECAID,1,0)) S SDECQ=0 F  S SDECQ=$O(^SDEC(409.84,SDECAID,1,SDECQ)) Q:'+SDECQ  D
 . . . . S SDECLIN=$G(^SDEC(409.84,SDECAID,1,SDECQ,0))
 . . . . S:(SDECLIN'="")&($E(SDECLIN,$L(SDECLIN)-1,$L(SDECLIN))'=" ") SDECLIN=SDECLIN_" "
 . . . . S SDECNOT=SDECNOT_SDECLIN
 . . . ;
 . . . S DFN=$P(SDECNOD,U,5)
 . . . S SDECPNOD=$$PATINFO(DFN)
 . . . S SDECNAM=$P(SDECPNOD,U) ;NAME
 . . . S SDECSEX=$P(SDECPNOD,U,2) ;SEX
 . . . S SDECDOB=$P(SDECPNOD,U,3) ;DOB
 . . . S SDECHRN=$P(SDECPNOD,U,4) ;Health Record Number for location DUZ(2)
 . . . S SDECSTRE=$P(SDECPNOD,U,5) ;Street
 . . . S SDECCITY=$P(SDECPNOD,U,6) ;City
 . . . S SDECST=$P(SDECPNOD,U,7) ;State
 . . . S SDECZIP=$P(SDECPNOD,U,8) ;zip
 . . . S SDECPHON=$P(SDECPNOD,U,9) ;homephone
 . . . S SDECTYPE="" ;Type/status doesn't exist for SDEC APPT clinics and it's not needed for clinic letters
 . . . S SDECCLRK=$P(SDECNOD,U,8)
 . . . S:+SDECCLRK SDECCLRK=$G(^VA(200,SDECCLRK,0)),SDECCLRK=$P(SDECCLRK,U)
 . . . S Y=$P(SDECNOD,U,9)
  . . . ;
 . . . ;  Change date/time conversion so midnight is handled properly.  wtc 694 5/17/18
 . . . ;
 . . . S SDECMADE=$$FMTONET^SDECDATE(Y,"Y") ;
 . . . ;I +Y X ^DD("DD") S Y=$TR(Y,"@"," ")
 . . . ;S SDECMADE=Y
 . . . S SDECI=SDECI+1
 . . . S ^TMP("SDEC",$J,SDECI)=SDECNAM_"^"_SDECDOB_"^"_SDECSEX_"^"_SDECHRN_"^"_SDECAPT_"^"_SDECCLN_"^"_SDECTYPE_"^"_SDECCID_"^"_SDECCLRK_"^"_SDECMADE_"^"_SDECNOT_"^"_SDECSTRE_"^"_SDECCITY_"^"_SDECST_"^"_SDECZIP_"^"_SDECPHON_$C(30)
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
CLINLETW(SDECY,SDECCLST,SDECBEG,SDECEND) ;CLINIC LETTERS WALK-IN Appointment data for Walk-in Appointments only
 ;CLINLETW(SDECY,SDECCLST,SDECBEG,SDECEND)  external parameter tag is in SDEC
 ;Return recordset of patient walk-in appointments
 ;between dates SDECBEG and SDECEND for each clinic in SDECCLST.
 ;Used in listing a patient's walk-in appointments and generating patient letters.
 ;SDECCLST is a |-delimited list of SDEC RESOURCE iens.  (The last |-piece is null, so discard it.)
 ;SDECBEG and SDECEND are in external date form.
 ;RETURN:
 ; Global Array in which each array entry contains the following Clinic Letter data separated by ^:
 ; 1. Name
 ; 2. DOB
 ; 3. Sex
 ; 4. HRN
 ; 5. ApptDate
 ; 6. Clinic
 ; 7. TypeStatus
 ; 8. RESOURCEID
 ; 9. APPT_MADE_BY
 ;10. DATE_APPT_MADE
 ;11. NOTE
 ;12. STREET
 ;13. CITY
 ;14. STATE
 ;15. ZIP
 ;16. HOMEPHONE
 S:$G(U)="" U="^"
 D CLINLET(.SDECY,SDECCLST,SDECBEG,SDECEND,1)
 Q
