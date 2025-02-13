SDES2VALCRTCLIN1 ;ALB/MGD/BLB,BWF,BLB,TJB,JAS - CLINIC VALIDATION UTILITIES DRIVER ;NOV 05,2024
 ;;5.3;Scheduling;**853,857,860,871,885,890,893,895**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to $$CODEC^ICDEX is supported by IA #5747
 ; Reference to $$CODEN^ICDEX is supported by IA #5747
 ;
 ; RPC: SDES CREATE CLINIC2
 ;
 Q
 ;
VALCLINIC(SDERRORS,SDCLINIC,SDFILEDATA) ; Validate Clinic Input Array
 N VRES
 ; Validate required variables first
 D VALALLOWNOSHOW^SDES2VAL44(.SDERRORS,$G(SDCLINIC("ALLOWABLE CONSECUTIVE NO-SHOWS")),.SDFILEDATA)
 D VALDIRPATSCHED^SDES2VAL44(.SDERRORS,$G(SDCLINIC("DIRECT PATIENT SCHEDULING")),.SDFILEDATA)
 D VALPRIMAMIS^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALNAME^SDES2VAL44(.SDERRORS,$G(SDCLINIC("NAME")),.SDFILEDATA)
 D VALDISPAPPT^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALINCPERHOUR^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALDIV^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALCHECKIN^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALAPPTLENGTH^SDES2VAL44(.SDERRORS,$G(SDCLINIC("LENGTH OF APPOINTMENT")),"",$G(SDCLINIC("DISPLAY INCREMENTS PER HOUR")),.SDFILEDATA)
 D VALMAXFUTBOOK^SDES2VAL44(.SDERRORS,$G(SDCLINIC("MAX DAYS FUTURE BOOKING")),.SDFILEDATA)
 D VALMEETATFACIL^SDES2VAL44(.SDERRORS,$G(SDCLINIC("MEETS AT FACILITY")),.SDFILEDATA)
 D VALNONCOUNT^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALOVBDAYMAX^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALPRECHECKIN^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALPROFILE^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALSERVICE^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 D VALVETSLFCAN^SDES2VAL44A(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 ;
 ; Quit if any errors in Required input parameters
 Q:$D(SDERRORS)
 ;
 ; Validate optional variables second - Values that will be altered by the validation will have SDCLINIC passed by reference
 ; =================================
 I $G(SDCLINIC("ABBREVIATION"))'="" D VALABBR^SDES2VAL44(.SDERRORS,SDCLINIC("ABBREVIATION"),.SDFILEDATA)
 I $G(SDCLINIC("ADMIN INPATIENT MEDS"))'="" D VALINPATMED^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("APPOINTMENT CANCELLATION LETTER"))'="" D VALAPTCANLET^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("ASK CHECK IN/OUT"))'="" D VALINOUTTIME^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("CLINIC CANCELLATION LETTER"))'="" D VALCANLET^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("CREDIT AMIS"))'="" D VALCREDITAMIS^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("PRIMARY AMIS"))'="",$G(SDCLINIC("CREDIT AMIS"))'="" D CONDAMISCHECK^SDES2VAL44(.SDERRORS,SDCLINIC("PRIMARY AMIS"),SDCLINIC("CREDIT AMIS"))
 I $G(SDCLINIC("DEFAULT APPOINTMENT TYPE"))'="" D VALAPPTTYPE^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("DEFAULT TO PC PRACTITIONER"))'="" D VALDEFAULTTOPRAC^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $D(SDCLINIC("DIAGNOSIS")) D VALDIAG(.SDERRORS,.SDCLINIC,.SDFILEDATA) ; Call Create only Validator
 D VALSTARTHOUR^SDES2VAL44(.SDERRORS,$G(SDCLINIC("HOUR CLINIC DISPLAY BEGINS")),.SDFILEDATA)
 I $G(SDCLINIC("NO-SHOW LETTER"))'="" D VALNOSHOWLET^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("PATIENT FRIENDLY NAME"))'="" D VALPATFNAME^SDES2VAL44(.SDERRORS,SDCLINIC("PATIENT FRIENDLY NAME"),.SDFILEDATA)
 I $G(SDCLINIC("PBSPID"))'="" D VALPBSPID^SDES2VAL44(.SDERRORS,SDCLINIC("PBSPID"),.SDFILEDATA)
 I $G(SDCLINIC("PHYSICAL LOCATION"))'="" D VALLOCATION^SDES2VAL44(.SDERRORS,SDCLINIC("PHYSICAL LOCATION"),.SDFILEDATA)
 I $G(SDCLINIC("PRE-APPOINTMENT LETTER"))'="" D VALPREAPTLET^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("PRINCIPAL CLINIC"))'="" D VALPRINCLINIC^SDES2VAL44(.SDERRORS,SDCLINIC("PRINCIPAL CLINIC"),.SDFILEDATA)
 I $G(SDCLINIC("PROHIBIT ACCESS TO CLINIC"))'="" D VALNOACCESS^SDES2VAL44(.SDERRORS,SDCLINIC("PROHIBIT ACCESS TO CLINIC"),.SDFILEDATA)
 I $D(SDCLINIC("PRIVILEGED USER")),$G(SDCLINIC("PROHIBIT ACCESS TO CLINIC"))="Y" D VALPRIVUSERS(.SDERRORS,.SDCLINIC,.SDFILEDATA) ; Call Create only Validator
 I $D(SDCLINIC("PROVIDER")) D VALPROVIDERS(.SDERRORS,.SDCLINIC,.SDFILEDATA) ; Call Create only Validator
 I $G(SDCLINIC("REQUIRE X-RAY"))'="" D VALXRAY^SDES2VAL44(.SDERRORS,SDCLINIC("REQUIRE X-RAY"),.SDFILEDATA)
 I $G(SDCLINIC("SCHEDULE ON HOLIDAYS"))'="" D VALSCHEDHOLIDAY^SDES2VAL44(.SDERRORS,SDCLINIC("SCHEDULE ON HOLIDAYS"),.SDFILEDATA)
 I $D(SDCLINIC("SPECIAL INSTRUCTIONS")) D VALSPECINSTRUCT(.SDERRORS,.SDCLINIC,.SDFILEDATA) ; Call Create only Validator
 I $D(SDCLINIC("SUBSPECIALTY")) D VALSUBSPEC^SDES2VAL44A(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("TELEPHONE"))'="" D VALPHONE^SDES2VAL44(.SDERRORS,SDCLINIC("TELEPHONE"),.SDFILEDATA)
 I $G(SDCLINIC("TELEPHONE EXTENSION"))'="" D VALPHONEEXT^SDES2VAL44(.SDERRORS,SDCLINIC("TELEPHONE EXTENSION"),.SDFILEDATA)
 I $G(SDCLINIC("VARIABLE APPOINTMENT LENGTH"))'="" D VALVARAPTLENGTH^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 I $G(SDCLINIC("WORKLOAD VALIDATION"))'="" D VALWORKLOAD^SDES2VAL44(.SDERRORS,.SDCLINIC,.SDFILEDATA)
 Q
 ;
 ; Validation for optional variables unique to Create Clinic
 ; =========================================================
 ;
VALDIAG(SDERRORS,SDCLINIC,SDFDATA) ;
 N SDDIAGCODE,SDDIAGIEN,SDDEFDIAGCNT,SDNEWDIAGIEN
 S SDDEFDIAGCNT=0
 S SDDIAGCODE="" F  S SDDIAGCODE=$O(SDCLINIC("DIAGNOSIS",SDDIAGCODE)) Q:SDDIAGCODE=""  D
 .I $G(SDCLINIC("DIAGNOSIS",SDDIAGCODE))="@" D ERRLOG^SDES2JSON(.SDERRORS,459,"DIAGNOSIS: "_SDDIAGCODE)
 .S SDDIAGIEN=$$CODEN^ICDEX(SDDIAGCODE,80)
 .I +SDDIAGIEN=-1 D ERRLOG^SDES2JSON(.SDERRORS,85,SDDIAGCODE)
 .I $D(SDCLINIC("DIAGNOSIS",SDDIAGCODE,"DEFAULT")) S SDDEFDIAGCNT=SDDEFDIAGCNT+1
 I SDDEFDIAGCNT>1 D ERRLOG^SDES2JSON(.SDERRORS,490) Q
 M SDFDATA("DIAGNOSIS")=SDCLINIC("DIAGNOSIS")
 Q
 ;
VALPRIVUSERS(ERRORS,PRIVUSERS,SDFDATA) ;
 N SDPUSER
 S SDPUSER=0 F  S SDPUSER=$O(PRIVUSERS("PRIVILEGED USER",SDPUSER)) Q:'SDPUSER  D
 .I PRIVUSERS("PRIVILEGED USER",SDPUSER)="@" D ERRLOG^SDES2JSON(.SDERRORS,459,"Privileged User: "_SDPUSER) Q
 .D VALUSERDUZ^SDES2VAL200(.ERRORS,SDPUSER)
 M SDFDATA("PRIVILEGED USER")=PRIVUSERS("PRIVILEGED USER")
 Q
 ;
VALPROVIDERS(ERRORS,SDCLINIC,SDFDATA) ;
 N SDPROVIEN,SDPROVERRORS,SDDEFCNT
 S (SDPROVIEN,SDDEFCNT)=0 F  S SDPROVIEN=$O(SDCLINIC("PROVIDER",SDPROVIEN)) Q:'SDPROVIEN  D
 .I $G(SDCLINIC("PROVIDER",SDPROVIEN))="@" D ERRLOG^SDES2JSON(.SDERRORS,459,"Provider: "_SDPROVIEN) Q
 .D VALPROVIDER^SDES2VAL200(.ERRORS,SDPROVIEN)
 .I $D(SDCLINIC("PROVIDER",SDPROVIEN,"DEFAULT")) S SDDEFCNT=SDDEFCNT+1
 I SDDEFCNT>1 D ERRLOG^SDES2JSON(.ERRORS,488)
 M SDFDATA("PROVIDER")=SDCLINIC("PROVIDER")
 Q
 ;
VALSPECINSTRUCT(SDERRORS,SDSPECINST,SDFDATA) ;
 ; SDSPECINST("SPECIAL INSTRUCTIONS",SDINSTRUCT)=IEN|@
 ; SDSPECINST("SPECIAL INSTRUCTIONS",SDINSTRUCT)=
 N SDINSTRUCT,SDINSDATA,SDINSIEN,SDINSTEXT
 S SDINSTRUCT=0 F  S SDINSTRUCT=$O(SDSPECINST("SPECIAL INSTRUCTIONS",SDINSTRUCT)) Q:'SDINSTRUCT  D
 .S SDINSDATA=$G(SDSPECINST("SPECIAL INSTRUCTIONS",SDINSTRUCT))
 .S SDINSIEN=$P(SDINSDATA,"|")
 .S SDINSTEXT=$P(SDINSDATA,"|",2)
 .I SDINSTEXT="" Q
 .I SDINSTEXT="@" D ERRLOG^SDES2JSON(.SDERRORS,459,"SPECIAL INSTRUCTIONS")
 .I $L(SDINSTEXT)<1!($L(SDINSTEXT)>80) D ERRLOG^SDES2JSON(.SDERRORS,52,"Special instructions must be 1-80 characters in length.")
 Q:$D(SDERRORS)
 M SDFDATA("SPECIAL INSTRUCTIONS")=SDSPECINST("SPECIAL INSTRUCTIONS")
 Q
