SDESCLNSEARCH ;ALB/MGD,BWF - CLINIC NAME SEARCH AND LIMITED DATA RETURN ;JUL 7, 2023
 ;;5.3;Scheduling;**824,851,861**;Aug 13, 1993;Build 17
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVPRV^PXAPI is supported by IA #2349
 ;
 ; RPC = SDES SEARCH CLINIC ATTRIBUTES
SEARCHCLIN(JSONRETURN,SEARCHSTRING,STATION,DATE) ;Search for clinics and provide return of matches and limited date in JSON STRING
 ; INPUT
 ;  SEARCHSTRING (Req) = free text string that represents the recall clinic name that will be searched
 ;  STATION (Opt) = Station Number: If present, the search would be limited to matching clinics at the given institution.
 ;    If absent, the search would take place across all divisions/institutions. Example values: 534, 534GB
 ;  DATE (Opt) = Date in ISO 8601 format to use for Clinic Status verification. If not passed in, default to DT.
 ; OUTPUT - JSONRETURN
 ; List of Recall Clinics from the RECALL REMINDERS (#403.5) file with the following data.
 ; Field List:
 ; 1. Clinic IEN
 ; 2. Clinic name
 ; 3. Patient friendly name
 ; 4. Default provider IEN
 ; 5. Default Provider name
 ; 6. Default Provider SECID
 ; 7. Stop code IEN
 ; 8. Stop code NAME
 ; 9. Stop code AMIS
 ; 10. Credit stop code IEN
 ; 11. Credit stop code name
 ; 12. Credit stop code AMIS
 ; 13. Status (Active or Inactive) If not passed in, default to DT
 ; 14. Non-count (Y or N)
 ;
 N CLINICLIST,ERROREXISTS,ERRORLIST,CLINICLIST
 K JSONRETURN
 S SEARCHSTRING=$G(SEARCHSTRING),STATION=$G(STATION),DATE=$G(DATE)
 S ERROREXISTS=0
 S ERROREXISTS=$$VALIDATEINPUT(.ERRORLIST,SEARCHSTRING,STATION,.DATE)
 I ERROREXISTS S ERRORLIST("Clinic",1)="" D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.ERRORLIST) Q
 D GETCLINICLIST(SEARCHSTRING,STATION,DATE,.CLINICLIST)
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.CLINICLIST)
 Q
 ;
VALIDATEINPUT(ERRORLIST,SEARCHSTRING,STATION,DATE) ; validate incoming parameters
 ; input - ERRORLIST = passed in by reference, represents the errors that could be generated when validating the searchstring
 ; SEARCHSTRING = represents the name or partial name of the Recall Clinic
 ; STATION = Station Number
 ; returns 0 or 1
 ; 0 = no validation errors
 ; 1 = validation errors
 N NOMATCHFOUND,INACTIVEONDATE
 S (NOMATCHFOUND,INACTIVEONDATE)=0
 S SEARCHSTRING=$TR(SEARCHSTRING,$C(13)_$C(10)_$C(9),"")
 I ($L(SEARCHSTRING)<2)!($L(SEARCHSTRING)>30) D  Q 1
 . D ERRLOG^SDESJSON(.ERRORLIST,473)
 I STATION'="",(($L(STATION)<3)!($L(STATION)>7)) D  Q 1
 . D ERRLOG^SDESJSON(.ERRORLIST,197)
 I STATION'="" D  Q:NOMATCHFOUND 1
 . D FIND^DIC(4,,"@;99","X",STATION,,"D",,,"RESULTS")
 . I '$D(RESULTS("DILIST",2)) D
 . . S NOMATCHFOUND=1
 . . D ERRLOG^SDESJSON(.ERRORLIST,197)
 I DATE="" S DATE=DT
 I DATE'="",DATE'?7N S DATE=$$ISOTFM^SDAMUTDT(DATE,"")
 I DATE=-1 D ERRLOG^SDESJSON(.ERRORLIST,244) Q 1
 Q 0
 ;
GETCLINICLIST(SEARCHSTRING,STATION,DATE,CLINICLIST) ; pull matching recall clinics using the first input parameter passed in by the RPC
 ; Input - SEARCHSTRING = string that represents the name of the recall clinic
 ;         STATION = Station Number
 ;         DATE = Fileman Date to use for Clinic Status verification
 ; CLINICLIST = passed in by reference; represents the array that will be returned as output
 ; Output - CLINICLIST = list of recall clinic names, clinic IENs and the associated recall reminder IENs.
 N CLINCNT,RESULTS,SUB3
 K CLINICLIST
 S (SUB3,CLINCNT)=0
 D FIND^DIC(44,,"@;.01",,SEARCHSTRING,,"B^C",,,"RESULTS")
 F  S SUB3=$O(RESULTS("DILIST",2,SUB3)) Q:SUB3=""  D
 . S CLINICIEN=$G(RESULTS("DILIST",2,SUB3))
 . I STATION'="" Q:$$WRONGDIVISION(CLINICIEN,STATION)
 . Q:$$INACTIVE^SDESUTIL(CLINICIEN,DATE)
 . S CLINCNT=CLINCNT+1
 . I CLINICIEN D BUILDRETURN(CLINICIEN,CLINCNT,.CLINICLIST)
 I CLINCNT=0 S CLINICLIST("Clinic",1)=""
 Q
 ;
BUILDRETURN(CLINICIEN,CLINCNT,CLINICLIST) ;Build return array with recall reminder clinic data
 ; input - CLINICIEN = IEN of clinic in #44
 ; CLINICLIST = passed by reference, represents the array of recall clinics and associated data that will be returned to the client
 ; output - CLINICLIST = recall clinic array and their associated data to be sent back to the client
 ;
 N STATUS,SDFIELDS,SDDATA,PRVCNT,CLINPROVIDER,PROVIDERID,PROVIDERNAME,DEFAULTPROVIDER,PROVIDERSECID
 S SDFIELDS=".01;1;8;16;60;2502;2503"
 D GETS^DIQ(44,CLINICIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S CLINICLIST("Clinic",CLINCNT,"Abbreviation")=$G(SDDATA(44,CLINICIEN_",",1,"E"))
 S CLINICLIST("Clinic",CLINCNT,"ClinicIEN")=CLINICIEN
 S CLINICLIST("Clinic",CLINCNT,"ClinicName")=$G(SDDATA(44,CLINICIEN_",",.01,"E"))
 S CLINICLIST("Clinic",CLINCNT,"PatientFriendlyName")=$G(SDDATA(44,CLINICIEN_",",60,"E"))
 ; initialize default provider fields to null to ensure they are always defined (in the event no default provider is found)
 S CLINICLIST("Clinic",CLINCNT,"DefaultProviderIEN")=""
 S CLINICLIST("Clinic",CLINCNT,"DefaultProviderName")=""
 S CLINICLIST("Clinic",CLINCNT,"DefaultProviderSecID")=""
 S CLINICLIST("Clinic",CLINCNT,"StopCodeIEN")=$G(SDDATA(44,CLINICIEN_",",8,"I"))
 S CLINICLIST("Clinic",CLINCNT,"StopCodeName")=$G(SDDATA(44,CLINICIEN_",",8,"E"))
 S CLINICLIST("Clinic",CLINCNT,"StopCodeAMIS")=$$GET1^DIQ(40.7,$G(SDDATA(44,CLINICIEN_",",8,"I")),1,"I")
 S CLINICLIST("Clinic",CLINCNT,"CreditStopCodeIEN")=$G(SDDATA(44,CLINICIEN_",",2503,"I"))
 S CLINICLIST("Clinic",CLINCNT,"CreditStopCodeName")=$G(SDDATA(44,CLINICIEN_",",2503,"E"))
 S CLINICLIST("Clinic",CLINCNT,"CreditStopCodeAMIS")=$$GET1^DIQ(40.7,$G(SDDATA(44,CLINICIEN_",",2503,"I")),1,"I")
 S CLINICLIST("Clinic",CLINCNT,"NonCountClinic")=$G(SDDATA(44,CLINICIEN_",",2502,"E"))
 S STATUS=$$INACTIVE^SDESUTIL(CLINICIEN,DATE),STATUS=$S(STATUS=1:"Inactive",1:"Active")
 S CLINICLIST("Clinic",CLINCNT,"ClinicStatus")=STATUS
 S PRVCNT=0
 S CLINPROVIDER=0 F  S CLINPROVIDER=$O(^SC(CLINICIEN,"PR",CLINPROVIDER)) Q:'CLINPROVIDER  D
 .S PROVIDERID=$$GET1^DIQ(44.1,CLINPROVIDER_","_CLINICIEN_",",.01,"I")
 .S PROVIDERNAME=$$GET1^DIQ(200,PROVIDERID,.01,"E")
 .S PROVIDERSECID=$$GET1^DIQ(200,PROVIDERID,205.1,"I")
 .S DEFAULTPROVIDER=$$GET1^DIQ(44.1,CLINPROVIDER_","_CLINICIEN_",",.02,"I")
 .I DEFAULTPROVIDER D  Q
 ..S CLINICLIST("Clinic",CLINCNT,"DefaultProviderIEN")=PROVIDERID
 ..S CLINICLIST("Clinic",CLINCNT,"DefaultProviderName")=$$GET1^DIQ(200,PROVIDERID,.01,"E")
 ..S CLINICLIST("Clinic",CLINCNT,"DefaultProviderSecID")=PROVIDERSECID
 .S PRVCNT=PRVCNT+1
 .S CLINICLIST("Clinic",CLINCNT,"Providers",PRVCNT,"Name")=PROVIDERNAME
 .S CLINICLIST("Clinic",CLINCNT,"Providers",PRVCNT,"ID")=PROVIDERID
 .S CLINICLIST("Clinic",CLINCNT,"Providers",PRVCNT,"SecID")=PROVIDERSECID
 ; set empty object if no records are found
 I '$D(CLINICLIST("Clinic",CLINCNT,"Providers")) S CLINICLIST("Clinic",CLINCNT,"Providers",1)=""
 Q
 ;
WRONGDIVISION(CLINICIEN,STATION) ;
 ; Screen out Clinics that don't match passed in Station Number
 N DIVISION,INSTIEN,STATIONID
 S DIVISION=$$GET1^DIQ(44,CLINICIEN,3.5,"I")
 S INSTIEN=$$GET1^DIQ(40.8,DIVISION,.07,"I")
 S STATIONID=$$GET1^DIQ(4,INSTIEN,99,"I")
 I STATIONID'[STATION Q 1
 Q 0
