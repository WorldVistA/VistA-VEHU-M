SDES2CLNSEARCH ;ALB/MGD,BWF - CLINIC NAME SEARCH AND LIMITED DATA RETURN ;NOV 20, 2023
 ;;5.3;Scheduling;**870,871**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVPRV^PXAPI is supported by IA #2349
 ;
 ; Copy of SDESCLNSEARCH for SDES2 Namespace
 ; RPC = SDES2 SEARCH CLINIC ATTRIBUTES
SEARCHCLIN(SDRETURN,SDCONTEXT,SDCLINIC) ;Search for clinics and provide return of matches and limited date in JSON STRING
 ; The SDCONTEXT array is controlled by the Acheron application and its fields are
 ; needed for the storage of the required auditing information.
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; The SDCLINIC array contains the following array elements:
 ;  SDCLINIC("SEARCHSTRING") (Req) = free text string that represents the recall clinic name that will be searched
 ;  SDCLINIC("STATION") (Opt) = Station Number: If present, the search would be limited to matching clinics at the given institution.
 ;    If absent, the search would take place across all divisions/institutions. Example values: 534, 534GB
 ;  SDCLINIC("DATETIME") (Opt) = Date in ISO 8601 format to use for Clinic Status verification. If not passed in, defaults to DT.
 ;  SDCLINIC("RETURNACTIVE") (Opt) = Boolean to return Active or Inactive clinics.
 ;     1:Returns active and inactive clinics, 0:Returns only active clinics,  Defaults to 0 if not passed in
 ;
 ; OUTPUT - SDRETURN
 ; List of Recall Clinics from the RECALL REMINDERS (#403.5) file with the following data.
 ; Field List:
 ; 1. Clinic IEN
 ; 2. Clinic name
 ; 3. Patient friendly name
 ; 4. Default provider IEN
 ; 5. Default Provider name
 ; 6. Default Provider SECID
 ; 7. Stop code IEN
 ; 8. Stop code Name
 ; 9. Stop code AMIS
 ; 10. Credit stop code IEN
 ; 11. Credit stop code Name
 ; 12. Credit stop code AMIS
 ; 13. Status (Active or Inactive) If not passed in, default to DT
 ; 14. Non-count (Y or N)
 ;
 N SDLINICLIST,SDERRORS,SDCLINICLIST,SDJSONERRORS
 N SDSEARCHSTRING,SDSTATION,SDDATE,SDDATETIME,SDRETURNACTIVE
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) S SDJSONERRORS("CreateClinic",1)="" M SDJSONERRORS=SDERRORS D BUILDJSON^SDES2JSON(.SDRETURN,.SDJSONERRORS) Q
 ;
 D VALCLINIC(.SDERRORS,.SDCLINIC,.SDVALIDDATA)
 I $D(SDERRORS) S SDJSONERRORS("CreateClinic",1)="" M SDJSONERRORS=SDERRORS D BUILDJSON^SDES2JSON(.SDRETURN,.SDJSONERRORS) Q
 ;
 D GETCLINICLIST(.SDVALIDDATA,.SDCLINICLIST)
 D BUILDJSON^SDESBUILDJSON(.SDRETURN,.SDCLINICLIST)
 Q
 ;
VALCLINIC(SDERRORS,SDCLINIC,SDVALIDDATA) ; validate incoming clinic parameters
 ; Input - SDERRORS = passed in by reference, represents the errors that could be generated when validating the search string
 ; SDSEARCHSTRING = represents the name or partial name of the Recall Clinic
 ; SDSTATION = Station Number
 ; SDDATETIME (Opt) = Date in ISO 8601 format to use for Clinic Status verification. If not passed in, default to DT.
 ; SDRETURNACTIVE ? Boolean: 1:Return active and inactive clinics, 0:Return only active clinics
 ;
 ; Returns 0 or 1
 ; 0 = no validation errors
 ; 1 = validation errors
 ;
 S SDSEARCHSTRING=$G(SDCLINIC("SEARCHSTRING"))
 S SDSEARCHSTRING=$TR(SDSEARCHSTRING,$C(13)_$C(10)_$C(9),"")
 I ($L(SDSEARCHSTRING)<2)!($L(SDSEARCHSTRING)>30) D ERRLOG^SDESJSON(.SDERRORS,$S(SDSEARCHSTRING="":231,1:473))
 S SDVALIDDATA("SEARCHSTRING")=SDSEARCHSTRING
 ;
 S SDSTATION=$G(SDCLINIC("STATION"))
 S SDDATETIME=$G(SDCLINIC("DATETIME"))
 I SDSTATION'="" D VALSTATIONNUM^SDES2VAL4(.SDERRORS,SDSTATION,SDDATETIME)
 S SDVALIDDATA("STATION")=SDSTATION
 ;
 I SDDATETIME="" S SDDATETIME=DT
 I SDDATETIME'="",SDDATETIME'?7N D
 .S SDDATETIME=$$ISOTFM^SDAMUTDT(SDDATETIME,"")
 .I SDDATETIME=-1 D ERRLOG^SDESJSON(.SDERRORS,244)
 S SDVALIDDATA("DATETIME")=SDDATETIME
 ;
 S SDRETURNACTIVE=$G(SDCLINIC("RETURNACTIVE"))
 I SDRETURNACTIVE="" S SDRETURNACTIVE=0
 D VALBOOLEAN^SDES2UTIL1(.SDERRORS,SDRETURNACTIVE,0,"SDCLINIC(""RETURNACTIVE"")")
 S SDVALIDDATA("RETURNACTIVE")=SDRETURNACTIVE
 Q
 ;
GETCLINICLIST(SDVALIDDATA,SDCLINICLIST) ; pull matching recall clinics using the first input parameter passed in by the RPC
 ; Input - SEARCHSTRING = string that represents the name of the recall clinic
 ; SDSTATION = Station Number
 ; SDDATETIME = Date/Time in FileMan format to use for Clinic Status verification
 ; SDRETURNACTIVE ? Boolean: 1:Return active and inactive clinics, 0:Return only active clinics
 ; SDCLINICLIST = passed in by reference; represents the array that will be returned as output
 ; Output - SDCLINICLIST = list of recall clinic names, clinic IENs and the associated recall reminder IENs.
 N SDCLINCNT,SDRESULTS,SUB3,SDCNT,SDINDX,SDNAMEINDX
 S SDSEARCHSTRING=SDVALIDDATA("SEARCHSTRING")
 S SDSTATION=SDVALIDDATA("STATION")
 S SDDATETIME=SDVALIDDATA("DATETIME")
 S SDRETURNACTIVE=SDVALIDDATA("RETURNACTIVE")
 K SDCLINICLIST,SDRESULTS
 S SDNAMEINDX=0,SDCNT=0
 ; Loop through B x-ref
 F  S SDNAMEINDX=$O(^SC("B",SDNAMEINDX)) Q:SDNAMEINDX=""  D
 .Q:SDNAMEINDX'[SDSEARCHSTRING
 .S SDINDX=$O(^SC("B",SDNAMEINDX,""))
 .Q:'$D(^SC(SDINDX,0))
 .S SDCNT=SDCNT+1
 .S SDRESULTS(SDINDX)=""
 ; Loop through C x-ref
 S SDNAMEINDX=0
 F  S SDNAMEINDX=$O(^SC("C",SDNAMEINDX)) Q:SDNAMEINDX=""  D
 .Q:SDNAMEINDX'[SDSEARCHSTRING
 .S SDINDX=0
 .F  S SDINDX=$O(^SC("C",SDNAMEINDX,SDINDX)) Q:'SDINDX  D
 ..Q:'$D(^SC(SDINDX,0))
 ..S SDCNT=SDCNT+1
 ..S SDRESULTS(SDINDX)=""
 ; Process Matching Clinics
 S SDINDX=0,SDCLINCNT=0
 F  S SDINDX=$O(SDRESULTS(SDINDX)) Q:SDINDX=""  D
 .I SDRETURNACTIVE=0,SDSTATION'="" Q:$$WRONGDIVISION(SDINDX,SDSTATION)
 .I SDRETURNACTIVE=0 Q:$$INACTIVE^SDES2UTIL(SDINDX,SDDATETIME)
 .S SDCLINCNT=SDCLINCNT+1
 .I SDINDX D BUILDRETURN(SDINDX,SDCLINCNT,.SDCLINICLIST,.SDDATETIME)
 I SDCLINCNT=0 S SDCLINICLIST("Clinic",1)=""
 Q
 ;
BUILDRETURN(SDCLINICIEN,SDCLINCNT,SDCLINICLIST,SDDATETIME) ;Build return array with recall reminder clinic data
 ; input - SDCLINICIEN = IEN of clinic in #44
 ; SDCLINICLIST = passed by reference, represents the array of recall clinics and associated data that will be returned to the client
 ; output - SDCLINICLIST = recall clinic array and their associated data to be sent back to the client
 ;
 N STATUS,SDFIELDS,SDDATA,SDPRVCNT,SDCLINPROVIDER,SDPROVIDERID,SDPROVIDERNAME,SDDEFAULTPROV,SDPROVIDERSECID
 S SDFIELDS=".01;1;2;2.1;8;16;50.01;60;200;2502;2503"
 D GETS^DIQ(44,SDCLINICIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDCLINICLIST("Clinic",SDCLINCNT,"Abbreviation")=$G(SDDATA(44,SDCLINICIEN_",",1,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"Type")=$G(SDDATA(44,SDCLINICIEN_",",2,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"TypeExtension")=$G(SDDATA(44,SDCLINICIEN_",",2.1,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"ClinicIEN")=SDCLINICIEN
 S SDCLINICLIST("Clinic",SDCLINCNT,"ClinicName")=$G(SDDATA(44,SDCLINICIEN_",",.01,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"PatientFriendlyName")=$G(SDDATA(44,SDCLINICIEN_",",60,"E"))
 ; initialize default provider fields to null to ensure they are always defined (in the event no default provider is found)
 S SDCLINICLIST("Clinic",SDCLINCNT,"DefaultProviderIEN")=""
 S SDCLINICLIST("Clinic",SDCLINCNT,"DefaultProviderName")=""
 S SDCLINICLIST("Clinic",SDCLINCNT,"DefaultProviderSecID")=""
 S SDCLINICLIST("Clinic",SDCLINCNT,"StopCodeIEN")=$G(SDDATA(44,SDCLINICIEN_",",8,"I"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"StopCodeName")=$G(SDDATA(44,SDCLINICIEN_",",8,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"StopCodeAMIS")=$$GET1^DIQ(40.7,$G(SDDATA(44,SDCLINICIEN_",",8,"I")),1,"I")
 S SDCLINICLIST("Clinic",SDCLINCNT,"OccasionOfServiceClinic")=$G(SDDATA(44,SDCLINICIEN_",",50.01,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"CreditStopCodeIEN")=$G(SDDATA(44,SDCLINICIEN_",",2503,"I"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"CreditStopCodeName")=$G(SDDATA(44,SDCLINICIEN_",",2503,"E"))
 S SDCLINICLIST("Clinic",SDCLINCNT,"CreditStopCodeAMIS")=$$GET1^DIQ(40.7,$G(SDDATA(44,SDCLINICIEN_",",2503,"I")),1,"I")
 S SDCLINICLIST("Clinic",SDCLINCNT,"NonCountClinic")=$G(SDDATA(44,SDCLINICIEN_",",2502,"E"))
 S STATUS=$$INACTIVE^SDESUTIL(SDCLINICIEN,SDDATETIME),STATUS=$S(STATUS=1:"Inactive",1:"Active")
 S SDCLINICLIST("Clinic",SDCLINCNT,"ClinicStatus")=STATUS
 S SDCLINICLIST("Clinic",SDCLINCNT,"PbspID")=$G(SDDATA(44,SDCLINICIEN_",",200,"E"))
 S SDPRVCNT=0
 S SDCLINPROVIDER=0 F  S SDCLINPROVIDER=$O(^SC(SDCLINICIEN,"PR",SDCLINPROVIDER)) Q:'SDCLINPROVIDER  D
 .S SDPROVIDERID=$$GET1^DIQ(44.1,SDCLINPROVIDER_","_SDCLINICIEN_",",.01,"I")
 .S SDPROVIDERNAME=$$GET1^DIQ(200,SDPROVIDERID,.01,"E")
 .S SDPROVIDERSECID=$$GET1^DIQ(200,SDPROVIDERID,205.1,"I")
 .S SDDEFAULTPROV=$$GET1^DIQ(44.1,SDCLINPROVIDER_","_SDCLINICIEN_",",.02,"I")
 .I SDDEFAULTPROV D  Q
 ..S SDCLINICLIST("Clinic",SDCLINCNT,"DefaultProviderIEN")=SDPROVIDERID
 ..S SDCLINICLIST("Clinic",SDCLINCNT,"DefaultProviderName")=$$GET1^DIQ(200,SDPROVIDERID,.01,"E")
 ..S SDCLINICLIST("Clinic",SDCLINCNT,"DefaultProviderSecID")=SDPROVIDERSECID
 .S SDPRVCNT=SDPRVCNT+1
 .S SDCLINICLIST("Clinic",SDCLINCNT,"Providers",SDPRVCNT,"Name")=SDPROVIDERNAME
 .S SDCLINICLIST("Clinic",SDCLINCNT,"Providers",SDPRVCNT,"ID")=SDPROVIDERID
 .S SDCLINICLIST("Clinic",SDCLINCNT,"Providers",SDPRVCNT,"SecID")=SDPROVIDERSECID
 ; set empty object if no records are found
 I '$D(SDCLINICLIST("Clinic",SDCLINCNT,"Providers")) S SDCLINICLIST("Clinic",SDCLINCNT,"Providers",1)=""
 Q
 ;
WRONGDIVISION(SDCLINICIEN,STATION) ;
 ; Screen out Clinics that don't match passed in Station Number
 N SDDIVISION,SDINSTIEN,STATIONID
 S SDDIVISION=$$GET1^DIQ(44,SDCLINICIEN,3.5,"I")
 S SDINSTIEN=$$GET1^DIQ(40.8,SDDIVISION,.07,"I")
 S STATIONID=$$GET1^DIQ(4,SDINSTIEN,99,"I")
 I STATIONID'[STATION Q 1
 Q 0
