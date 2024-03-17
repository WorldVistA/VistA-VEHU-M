SDES2EPT ;ALB/LAB,ANU - SDES2 GET PATIENT'S ExtendedProfile APPT INFO ; DEC 14,2023
 ;;5.3;Scheduling;**861,867**;Aug 13, 1993;Build 8
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to INP^DGPMV10 supported by ICR #7035
 ; Reference to ELIG^VADPT supported by ICR #10061
 ; Reference to Patient File supported by ICR #7019
 ; #10035 - ^DPT( references       (Supported)
 ;
 ; RPC: SDES2 GET PATIENT EPT
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = 36 character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action on the calling application.
 ; SDCONTEXT("USER NAME") = The name of the user taking action on the calling application.
 ; SDCONTEXT("PATIENT DFN") = The DFN of the patient taking action on the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the patient taking action on the calling application.
 ; SDINPUT("PATIENT DFN") = Patient to pull data for
 ;
 Q
 ;
GETPTIN(JSONRETURN,SDCONTEXT,SDINPUT) ; Get Patient's ExtendedProfile Appt Info
 N SDAPPTDT,SDDFN,SDERRORS,SDRETURN,VALRET
 ;
 ; Validate SDCONTEXT
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("ExtendedProfile",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ; Checking DFN separately, since it's required for this RPC
 D VALFILEIEN^SDES2VALUTIL(.VALRET,.SDERRORS,2,$G(SDINPUT("PATIENT DFN")),1,0,1,2)
 I 'VALRET,$D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("ExtendedProfile",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 S SDDFN=SDINPUT("PATIENT DFN")
 ;
 ;
 ; Retrieve Patient's ExtendedProfile Appt Info
 ;
 D GETPTINA(.SDRETURN,SDDFN)
 ;
 ; Build JSON return
 ;
 I '$D(SDRETURN) S SDRETURN("ExtendedProfile",1)=""
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
GETPTINA(SDRETURN,SDDFN) ;
 N SDCOUNT,SDRESULT,PATIENTDATA,SDPOS,SDPOSN,SDCMBTV,SDCMBTVED,SDPOW,SDSW,DFN,VASV
 N SDSTAT,SDST,SDSTA,SDLADMT,SDA,VAEL
 S SDCOUNT=1
 S DFN=SDDFN
 ; .323 - Period of Service
 D ELIG^VADPT,SVC^VADPT
 S SDRETURN("ExtendedProfile",SDCOUNT,"Period of Service IEN")=$P(VAEL(2),U,1)
 S SDRETURN("ExtendedProfile",SDCOUNT,"Period of Service Name")=$P(VAEL(2),U,2)
 ;
 D GETS^DIQ(2,SDDFN,".01;.135;.525;.322013","IE","PATIENTDATA")
 S SDRETURN("ExtendedProfile",SDCOUNT,"DFN")=SDDFN
 S SDRETURN("ExtendedProfile",SDCOUNT,"Name")=$G(PATIENTDATA(2,SDDFN_",",.01,"E"))
 ; COMBAT VETERAN
 I $G(VASV(5)) D
 . S SDCMBTV="Yes"
 . S SDCMBTVED=$P($G(VASV(5,2)),U,2)
 I '$G(VASV(5)) D
 . S SDCMBTV="No"
 . S SDCMBTVED="N/A"
 S SDRETURN("ExtendedProfile",SDCOUNT,"Combat Veteran")=$G(SDCMBTV)
 ;867
 I SDCMBTV="No" S SDRETURN("ExtendedProfile",SDCOUNT,"Combat Veteran End Date")=$G(SDCMBTVED)
 I SDCMBTV'="No" S SDRETURN("ExtendedProfile",SDCOUNT,"Combat Veteran End Date")=$$FMTISO^SDAMUTDT($$CONVDATE^SDESCOMPPEN($G(SDCMBTVED)))
 ;
 ; PRISONER OF WAR - VADPT is not handling Unknown value
 I $G(PATIENTDATA(2,SDDFN_",",.525,"I"))="Y" S SDPOW="Yes"
 I $G(PATIENTDATA(2,SDDFN_",",.525,"I"))="N" S SDPOW="No"
 I $G(PATIENTDATA(2,SDDFN_",",.525,"I"))="U" S SDPOW="Unknown"
 S SDRETURN("ExtendedProfile",SDCOUNT,"Prisoner of War")=$G(SDPOW)
 ;
 ; PAGER NUMBER
 S SDRETURN("ExtendedProfile",SDCOUNT,"Pager Number")=$G(PATIENTDATA(2,SDDFN_",",.135,"I"))
 ; SW ASIA CONDITIONS
 I $G(PATIENTDATA(2,SDDFN_",",.322013,"I"))="Y" S SDSW="Yes"
 I $G(PATIENTDATA(2,SDDFN_",",.322013,"I"))="N" S SDSW="No"
 I $G(PATIENTDATA(2,SDDFN_",",.322013,"I"))="U" S SDSW="Unknown"
 S SDRETURN("ExtendedProfile",SDCOUNT,"SW Asia Conditions")=$G(SDSW)
 ; STATUS, LAST ADMIT/LODGER DATE
 S (SDLADMT,SDSTAT,SDST,SDSTA,SDA)=""
 S SDRETURN("ExtendedProfile",SDCOUNT,"Status")=$G(SDSTAT)
 S SDRETURN("ExtendedProfile",SDCOUNT,"Last Admit/Lodger Date")=$G(SDLADMT)
 I '$D(^DGPM("C",SDDFN)) S SDSTAT="NO INPT./LOD. ACT." Q
 ;
 S VAIP("D")="L",VAIP("L")="" D INP^DGPMV10
 S SDA=$S("^3^5^"[("^"_+DGPMVI(2)_"^"):0,1:+DGPMVI(2)),SDST=$S('SDA:"IN",1:"")_"ACTIVE ",SDSTA=$S("^4^5^"[("^"_+DGPMVI(2)_"^"):"LODGER",1:"INPATIENT")
 S SDSTAT="" S SDSTAT=SDST_SDSTA
 S SDLADMT="" S SDLADMT=$P($G(DGPMVI(13,1)),"^",2)
 S SDRETURN("ExtendedProfile",SDCOUNT,"Status")=$G(SDSTAT)
 ;867
 ;S SDRETURN("ExtendedProfile",SDCOUNT,"Last Admit/Lodger Date")=$G(SDLADMT)
 S SDRETURN("ExtendedProfile",SDCOUNT,"Last Admit/Lodger Date")=$$FMTISO^SDAMUTDT($$CONVDATE^SDESCOMPPEN($G(SDLADMT)))
 K DGPMVI,VAIP
 Q
