SDES2PROVSEARCH ;ALB/JAS,JHC,LAB - Get Provider based on Search String ;JULY 9, 2026
 ;;5.3;Scheduling;**890,909,951**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVPRV^PXAPI is supported by IA #2349
 ; Reference to $$ACTIVE^XUSER is supported by IA #2343
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 Q
 ;
PROVIDERSEARCH(JSONRETURN,SDCONTEXT,SDINPUT) ; rpc = SDES2 SEARCH PROVIDERS
 ; The SDCONTEXT array is controlled by the Acheron application and its fields are
 ; needed for the storage of the required auditing information.
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDINPUT("SEARCHSTRING") = The string to be used to search for active providers.
 ;
 ; OUTPUT - SDRETURN
 ;   List of a providers' details from the NEW PERSON (#200) file that meets the search criteria.
 ;
 N USERLIST,SDERRORS,SDRETURN,SEARCHSTRING,PROVIDERETURN,PROVIDERLIST
 ;
 ; Validate SDCONTEXT
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Provider",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 ; Validate SDINPUT
 S SEARCHSTRING=$G(SDINPUT("SEARCHSTRING"))
 S SEARCHSTRING=$TR(SEARCHSTRING,$C(13)_$C(10)_$C(9),"")
 D VALIDATEINPUT(.SDERRORS,SEARCHSTRING)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Provider",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 D NEWPROVLIST(SEARCHSTRING,.PROVIDERLIST)
 D BUILDRETURN(.PROVIDERLIST,.PROVIDERETURN)
 D BUILDJSON^SDES2JSON(.JSONRETURN,.PROVIDERETURN)
 Q
 ;
VALIDATEINPUT(ERRORLIST,SEARCHSTRING) ; validate incoming parameters
 ; input - ERRORLIST = passed in by reference, represents the errors that could be generated when validating the searchstring
 ;         SEARCHSTRING = represents the name or partial name of the provider
 I ($L(SEARCHSTRING)<3)!($L(SEARCHSTRING)>35) D ERRLOG^SDES2JSON(.ERRORLIST,230)
 Q
 ;
NEWPROVLIST(SEARCHSTRING,PROVIDERLIST) ;Loop through "B" cross reference for providers
 N USERDUZ,PROVIDERNAME,STRINGLENGTH,DATE
 S USERDUZ=""
 S DATE=$P(DT,".")
 S STRINGLENGTH=$L(SEARCHSTRING)
 S PROVIDERNAME=$O(^VA(200,"B",SEARCHSTRING),-1)
 I $E(PROVIDERNAME,1,STRINGLENGTH)=SEARCHSTRING D
 . S PROVIDERNAME=$O(^VA(200,"B",PROVIDERNAME),-1)
 F  S PROVIDERNAME=$O(^VA(200,"B",PROVIDERNAME)) Q:PROVIDERNAME=""!($E(PROVIDERNAME,1,STRINGLENGTH)'=SEARCHSTRING)  D
 . S USERDUZ=""
 . F  S USERDUZ=$O(^VA(200,"B",PROVIDERNAME,USERDUZ)) Q:USERDUZ=""  D
 . . I $$ACTIVPRV^PXAPI(USERDUZ,DATE)&($$ACTIVE^XUSER(USERDUZ)) S PROVIDERLIST(USERDUZ)=""
 Q
 ;
BUILDRETURN(PROVIDERLIST,PROVIDERETURN) ;Build return array with provider data
 ; input - PROVIDERLIST = array of active providers
 ;         PROVIDERETURN = passed by reference, represents the array of providers and associated data that will be returned to the client
 ; output - PROVIDERETURN = provider array and their associated data to be sent back to the client
 ;
 N PROVIDERDATA,IEN,IENS,INFO,RECORDNUMBER,IE
 S (RECORDNUMBER,IEN)=0
 F  S IEN=$O(PROVIDERLIST(IEN)) Q:'IEN  D GETS^DIQ(200,IEN_",",".01;.131:.138;.151;8;53.5;205.1","IE","INFO") D
 . S RECORDNUMBER=RECORDNUMBER+1
 . S PROVIDERETURN("Provider",RECORDNUMBER,"IEN")=IEN
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Name")=INFO(200,IEN_",",.01,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Homephone")=INFO(200,IEN_",",.131,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Officephone")=INFO(200,IEN_",",.132,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Phone3")=INFO(200,IEN_",",.133,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Phone4")=INFO(200,IEN_",",.134,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"CommercialPhone")=INFO(200,IEN_",",.135,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Fax")=INFO(200,IEN_",",.136,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"VoicePager")=INFO(200,IEN_",",.137,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"DigitalPager")=INFO(200,IEN_",",.138,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Email")=INFO(200,IEN_",",.151,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Title")=INFO(200,IEN_",",8,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"ProviderClass")=INFO(200,IEN_",",53.5,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"ProviderSecID")=INFO(200,IEN_",",205.1,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"PersonClass",1)=""
 . S PROVIDERETURN("Provider",RECORDNUMBER,"UserClass",1)=""
 . S IENS=0 F  S IENS=$O(^VA(200,IEN,"USC1",IENS)) Q:'IENS  D
 . . S PROVIDERETURN("Provider",RECORDNUMBER,"PersonClass",IENS)=$$GET1^DIQ(200.05,IENS_","_IEN_",",.01)
 . S IENS=0 F  S IENS=$O(^VA(200,IEN,"USC3",IENS)) Q:'IENS  D
 . . S PROVIDERETURN("Provider",RECORDNUMBER,"UserClass",IENS)=$$GET1^DIQ(200.07,IENS_","_IEN_",",.01)
 . K INFO,IE
 I '$D(PROVIDERETURN("Provider")) S PROVIDERETURN("Provider",1)=""
 Q
 ;
