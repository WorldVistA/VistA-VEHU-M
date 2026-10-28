SDES2GETREGS2 ;ALB/JDJ - SDES2 GET PATIENT REG 2 registration info JSON format ; Aug 25, 2026
 ;;5.3;SCHEDULING;**954**;AUG 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to PATIENT fields in ICRs: #1476, #7019, #7029, #7030, #10035
 ; Reference to SCHEDULED ADMISSION in ICR #4425
 ; Reference to DUZ^XUP is supported by IA #7487
 ;;
 Q
 ;
GETPATINFO(JSON,SDCONTEXT,SDPARAM) ;return basic reg info/demographics for given patient in JSON format
 ;Input Parameter:
 ; SDPARAM("PATIENT IEN") - Patient ID - Pointer to PATIENT file
 ;Returns:
 ; JSON formatted output
 N RETURN,SDINFO,SDDFN,SDPATARR,SDDEMO,PRACE,PRACEN,PETH,PETHN,SDMHP,SDPCP,GAF,GAFR,SDZIP,SDDOD,ERRORS
 ; Next line to address leaks from other APIs
 N PRFLIST,VA,YSZ,Z0
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S RETURN("patient")="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D VALIDATE(.ERRORS,.SDPARAM)
 I $D(ERRORS) S RETURN("patient")="" M RETURN=ERRORS D BUILDJSON^SDES2JSON(.JSON,.RETURN) Q
 D GETDEMOGR(.RETURN,.SDCONTEXT,.SDPARAM)
 D BUILDJSON^SDES2JSON(.JSON,.RETURN)
 Q
 ;
VALIDATE(ERRORS,SDPARAM) ;validate input Parameter
 D VALPATDFN^SDES2VAL2(.ERRORS,$G(SDPARAM("PATIENT IEN")),1,0)
 Q
 ;
GETPREREGTIM(DFN) ;
 N PREREGTIMIEN,PREREGTIM
 S PREREGTIM=""
 S PREREGTIMIEN=$O(^DGS(41.41,"B",DFN,"A"),-1)
 I PREREGTIMIEN'="" D
 . S PREREGTIM=$$FMTISO^SDAMUTDT($$GET1^DIQ(41.41,PREREGTIMIEN_",",1,"I"))
 Q PREREGTIM
 ;
GETDEMOGR(SDINFO,SDCONTEXT,SDPARAM) ;
 N PATIENTLIST,SDDEMO,DFN,RACELIST,ETHNLIST,SDFN,FIELDS,PCE,SDPCE,SDPCEM,CAT8GROUPFLG,SDMHP,MHTC,SDPCP,SDSENSITIVE,SDSECURITY
 S DFN=SDPARAM("PATIENT IEN"),SDFN=DFN_","
 D SENSITIVE^SDES2UTIL(.SDSENSITIVE,DFN,DUZ)
 S SDSECURITY=SDSENSITIVE(1)_$S($G(SDSENSITIVE(2))'="":"|"_SDSENSITIVE(2),1:"")_$S($G(SDSENSITIVE(3))'="":"|"_SDSENSITIVE(3),1:"")
 D RACELIST^SDES2UTIL1(.RACELIST,DFN)
 D ETHNLIST^SDES2UTIL1(.ETHNLIST,DFN)   ;get ethnicity
 S FIELDS=".01;.02;.05;.08;.1;.105;.111;.112;.113;.114;.115;.116;.1112;.2203;.2207;.301;.302;.331;.332;"
 S FIELDS=FIELDS_".333;.334;.335;.336;.337;.338;.339;.351;.39;.1219;.1151;.1152;.1153;.1154;.1155;.1156;.1157;.11573;"
 S FIELDS=FIELDS_".1173;.1223;.2201;.33011;27.01;1100.01"
 D GETS^DIQ(2,SDFN,FIELDS,"IE","SDPATARR")
 ;patient enrollment
 S PCE=$G(SDPATARR(2,SDFN,27.01,"I"))
 D:+PCE GETS^DIQ(27.11,+PCE_",",".07;.12;50.01;50.02;50.03","IE","SDPCE","SDPCEM")
 S:+PCE CAT8GROUPFLG=(SDPCE(27.11,+PCE_",",.07,"E")="GROUP 8")&(SDPCE(27.11,+PCE_",",.12,"E")="g")
 S CAT8GROUPFLG=$S($G(CAT8GROUPFLG)'="":CAT8GROUPFLG,1:0)
 S SDMHP=$$START^SCMCMHTC(DFN) ;Return Mental Health Provider
 S SDPCP=$$OUTPTPR^SDUTL3(DFN) ;Return Primary Care Provider
 D ASSIGNADDR(.SDDEMO,DFN) ;assign values to build SDINFO array
 ;
 ;person identification information
 S SDINFO("patient","dataFileNumber")=DFN
 S SDINFO("patient","iCN")=$$GETPATICN^SDESINPUTVALUTL(DFN)
 S SDINFO("patient","name")=$G(SDPATARR(2,SDFN,.01,"E"))
 S SDINFO("patient","socialSecurityNumber")=$$LAST4SSN^SDESINPUTVALUTL(DFN)
 S SDINFO("patient","dateOfBirth")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDFN,.03,"I"))
 S SDINFO("patient","race","iEN")=$G(RACELIST("IENS"))
 S SDINFO("patient","race","name")=$G(RACELIST("NAMES"))
 S SDINFO("patient","ethnicity","iEN")=$G(ETHNLIST("IENS"))
 S SDINFO("patient","ethnicity","Name")=$G(ETHNLIST("NAMES"))
 S SDINFO("patient","sex")=$G(SDPATARR(2,SDFN,.02,"I"))
 S SDINFO("patient","security")=SDSECURITY
 S SDINFO("patient","marital")=$G(SDPATARR(2,SDFN,.05,"E"))
 S SDINFO("patient","religion")=$G(SDPATARR(2,SDFN,.08,"E"))
 S SDINFO("patient","timeStamp")=$$GETPREREGTIM(DFN)
 ;
 ;health information
 S SDINFO("patient","primaryCareProvider")=$P(SDPCP,"^",2)
 S SDINFO("patient","serviceConnected")=$G(SDPATARR(2,SDFN,.301,"E"))
 S SDINFO("patient","serviceConnectedPercentage")=$G(SDPATARR(2,SDFN,.302,"E"))
 S SDINFO("patient","ward")=$G(SDPATARR(2,SDFN,.1,"E"))
 S SDINFO("patient","healthRecordNumber")=$$HRN^SDES2UTIL1(DFN)
 S SDINFO("patient","mentalHealthProvider")=$P(SDMHP,"^",2)
 ;
 ;flags
 S SDINFO("patient","fugitiveFlag")=$G(SDPATARR(2,SDFN,1100.01,"I"))
 S SDINFO("patient","veteranCatastrophicallyDisabled")=$G(SDPATARR(2,SDFN,.39,"I"))
 S SDINFO("patient","nationalFlag")=$$FLAGS^SDES2UTIL1(DFN,26.15)
 S SDINFO("patient","localFlag")=$$FLAGS^SDES2UTIL1(DFN,26.11)
 S SDINFO("patient","enrollmentSubgroup")=$S(+PCE:SDPCE(27.11,+PCE_",",.12,"E"),1:"")
 S SDINFO("patient","category8GFlag")=CAT8GROUPFLG
 S SDINFO("patient","similarPatients")=$$SIM(DFN)
 S SDINFO("patient","priorityGroup")=$S(+PCE:SDPCE(27.11,+PCE_",",.07,"E"),1:"")
 S SDINFO("patient","gAFRequired")=$$GETGAF^SDES2UTIL1(DFN)
 ;
 ;contact information
 S SDINFO("patient","cell")=$S(SDDEMO("PCELL")["X":$P(SDDEMO("PCELL"),"X"),1:SDDEMO("PCELL"))
 S SDINFO("patient","cellExt")=$S(SDDEMO("PCELL")["X":$P(SDDEMO("PCELL"),"X",2),1:"")
 S SDINFO("patient","email")=SDDEMO("PEMAIL")
 S SDINFO("patient","homePhone")=$S(SDDEMO("HPHONE")["X":$P(SDDEMO("HPHONE"),"X"),1:SDDEMO("HPHONE"))
 S SDINFO("patient","officePhone")=$S(SDDEMO("OPHONE")["X":$P(SDDEMO("OPHONE"),"X"),1:SDDEMO("OPHONE"))
 S SDINFO("patient","homePhoneExt")=$S(SDDEMO("HPHONE")["X":$P(SDDEMO("HPHONE"),"X",2),1:"")
 S SDINFO("patient","officePhoneExt")=$S(SDDEMO("OPHONE")["X":$P(SDDEMO("OPHONE"),"X",2),1:"")
 ;
 ;mail address information
 S SDINFO("patient","mailingAddress","addressLine1")=SDDEMO("PADDRES1")
 S SDINFO("patient","mailingAddress","addressLine2")=SDDEMO("PADDRES2")
 S SDINFO("patient","mailingAddress","addressLine3")=SDDEMO("PADDRES3")
 S SDINFO("patient","mailingAddress","cityName")=SDDEMO("PCITY")
 S SDINFO("patient","mailingAddress","stateName")=SDDEMO("PSTATE")
 S SDINFO("patient","mailingAddress","countyName")=SDDEMO("PCOUNTY")
 S SDINFO("patient","mailingAddress","country")=SDDEMO("PCOUNTRYC")
 S SDINFO("patient","mailingAddress","countryName")=$$GET1^DIQ(779.004,SDDEMO("PCOUNTRY"),2,"E")
 I $L(SDDEMO("PZIP+4"))>8 S SDINFO("patient","mailingAddress","zipCode4")=$E(SDDEMO("PZIP+4"),*-3,*)
 E  S SDINFO("patient","mailingAddress","zipCode4")=""
 S SDINFO("patient","mailingAddress","zipCode5")=$E($G(SDPATARR(2,SDFN,.1112,"E")),1,5)
 S SDINFO("patient","addressIndicator")=SDDEMO("BADADD")
 ;
 ;Residential Address Info
 S SDINFO("patient","residentialAddress","addressLine1")=$G(SDPATARR(2,SDFN,.1151,"E"))
 S SDINFO("patient","residentialAddress","addressLine2")=$G(SDPATARR(2,SDFN,.1152,"E"))
 S SDINFO("patient","residentialAddress","addressLine3")=$G(SDPATARR(2,SDFN,.1153,"E"))
 S SDINFO("patient","residentialAddress","cityName")=$G(SDPATARR(2,SDFN,.1154,"E"))
 S SDINFO("patient","residentialAddress","stateName")=$G(SDPATARR(2,SDFN,.1155,"E"))
 S SDINFO("patient","residentialAddress","countyName")=$G(SDPATARR(2,SDFN,.1157,"E"))
 S SDINFO("patient","residentialAddress","countryCode")=$G(SDPATARR(2,SDFN,.11573,"E"))
 S SDINFO("patient","residentialAddress","countryName")=$$GET1^DIQ(779.004,$G(SDPATARR(2,SDFN,.11573,"I")),2,"E")
 I $L($G(SDPATARR(2,SDFN,.1156,"E")))>8 S SDINFO("patient","residentialAddress","zipCode4")=$E($G(SDPATARR(2,SDFN,.1156,"E")),*-3,*)
 E  S SDINFO("patient","residentialAddress","zipCode4")=""
 S SDINFO("patient","residentialAddress","zipCode5")=$E($G(SDPATARR(2,SDFN,.1156,"E")),1,5)
 ;
 ;Temp Address information
 S SDINFO("patient","temporaryAddress","addressLine1")=SDDEMO("PTADDRESS1")
 S SDINFO("patient","temporaryAddress","addressLine2")=SDDEMO("PTADDRESS2")
 S SDINFO("patient","temporaryAddress","addressLine3")=SDDEMO("PTADDRESS3")
 S SDINFO("patient","temporaryAddress","cityName")=SDDEMO("PTCITY")
 S SDINFO("patient","temporaryAddress","stateName")=SDDEMO("PTSTATE")
 S SDINFO("patient","temporaryAddress","zipCode5")=$E(SDDEMO("PTZIP"),1,5)
 I $L(SDDEMO("PTZIP+4"))>8 S SDINFO("patient","temporaryAddress","zipCode4")=$E(SDDEMO("PTZIP+4"),*-3,*)
 E  S SDINFO("patient","temporaryAddress","zipCode4")=""
 S SDINFO("patient","temporaryAddress","countryCode")=SDDEMO("PTCOUNTRYC")
 S SDINFO("patient","temporaryAddress","countryName")=$$GET1^DIQ(779.004,SDDEMO("PTCOUNTRY"),2,"E")
 S SDINFO("patient","temporaryAddress","countyName")=SDDEMO("PTCOUNTY")
 S SDINFO("patient","temporaryAddressActive")=$S($G(SDDEMO("PTACTIVE"))="Y":1,1:0)
 S SDINFO("patient","temporaryAddressStart")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDFN,.1217,"I"))
 S SDINFO("patient","temporaryAddressEnd")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDFN,.1218,"I"))
 S SDINFO("patient","temporaryPhone")=$G(SDPATARR(2,SDFN,.1219,"E"))
 ;
 ;Primary Next Of Kin Information
 S SDINFO("patient","primaryNextOfKin","name")=SDDEMO("NOK")
 S SDINFO("patient","primaryNextOfKin","relationship")=SDDEMO("KREL")
 S SDINFO("patient","primaryNextOfKin","phone")=SDDEMO("KPHONE")
 S SDINFO("patient","primaryNextOfKin","address","addressLine1")=SDDEMO("KSTREET")
 S SDINFO("patient","primaryNextOfKin","address","addressLine2")=SDDEMO("KSTREET2")
 S SDINFO("patient","primaryNextOfKin","address","addressLine3")=SDDEMO("KSTREET3")
 S SDINFO("patient","primaryNextOfKin","address","cityName")=SDDEMO("KCITY")
 S SDINFO("patient","primaryNextOfKin","address","stateName")=SDDEMO("KSTATE")
 S SDINFO("patient","primaryNextOfKin","address","zipCode5")=$E(SDDEMO("KZIP"),1,5)
 I $L($G(SDPATARR(2,SDFN,.2207,"E")))>8 S SDINFO("patient","primaryNextOfKin","address","zipCode4")=$E($G(SDPATARR(2,SDFN,.2207,"E")),*-3,*)
 E  S SDINFO("patient","primaryNextOfKin","address","zipCode4")=""
 ;
 ;Secondary Next of Kin Information
 S SDINFO("patient","secondaryNextOfKin","name")=SDDEMO("K2NAME")
 S SDINFO("patient","secondaryNextOfKin","relationship")=SDDEMO("K2REL")
 S SDINFO("patient","secondaryNextOfKin","phone")=SDDEMO("K2PHONE")
 S SDINFO("patient","secondaryNextOfKin","address","addressLine1")=SDDEMO("K2STREET")
 S SDINFO("patient","secondaryNextOfKin","address","addressLine2")=SDDEMO("K2STREET2")
 S SDINFO("patient","secondaryNextOfKin","address","addressLine3")=SDDEMO("K2STREET3")
 S SDINFO("patient","secondaryNextOfKin","address","cityName")=SDDEMO("K2CITY")
 S SDINFO("patient","secondaryNextOfKin","address","stateName")=SDDEMO("K2STATE")
 S SDINFO("patient","secondaryNextOfKin","address","zipCode5")=$E(SDDEMO("K2ZIP"),1,5)
 I $L($G(SDPATARR(2,SDFN,.2203,"E")))>8 S SDINFO("patient","secondaryNextOfKin","address","zipCode4")=$E($G(SDPATARR(2,SDFN,.2203,"E")),*-3,*)
 E  S SDINFO("patient","secondaryNextOfKin","address","zipCode4")=""
 ;
 ; Emergency Contact
 S SDINFO("patient","emergencyContact","name")=$G(SDPATARR(2,SDFN,.331,"E"))
 S SDINFO("patient","emergencyContact","relationship")=$G(SDPATARR(2,SDFN,.332,"E"))
 S SDINFO("patient","emergencyContact","phone")=$G(SDPATARR(2,SDFN,.339,"E"))
 S SDINFO("patient","emergencyContact","workPhone")=$G(SDPATARR(2,SDFN,.33011,"E"))
 S SDINFO("patient","emergencyContact","address","addressLine1")=$G(SDPATARR(2,SDFN,.333,"E"))
 S SDINFO("patient","emergencyContact","address","addressLine2")=$G(SDPATARR(2,SDFN,.334,"E"))
 S SDINFO("patient","emergencyContact","address","addressLine3")=$G(SDPATARR(2,SDFN,.335,"E"))
 S SDINFO("patient","emergencyContact","address","cityName")=$G(SDPATARR(2,SDFN,.336,"E"))
 S SDINFO("patient","emergencyContact","address","stateName")=$G(SDPATARR(2,SDFN,.337,"E"))
 S SDINFO("patient","emergencyContact","address","zipCode5")=$E($G(SDPATARR(2,SDFN,.338,"E")),1,5)
 I $L($G(SDPATARR(2,SDFN,.2201,"E")))>8 S SDINFO("patient","emergencyContact","address","zipCode4")=$E($G(SDPATARR(2,SDFN,.2201,"E")),*-3,*)
 E  S SDINFO("patient","emergencyContact","address","zipCode4")=""
 D GETELIGIBILITY^SDESPATSEARCH(.PATIENTLIST,DFN,1)
 M SDINFO("patient")=PATIENTLIST("patient",1)
 ; Date Of Death
 S SDDOD=$$FMTISO^SDAMUTDT($G(SDPATARR(2,SDFN,.351,"I"))),SDDOD=$E(SDDOD,1,10)
 S SDINFO("patient","dateOfDeath")=SDDOD
 Q
 ;
SIM(DFN)  ;get similar patient data
 N MI,MSG,NOD,PATS,RET,SIM
 S (MSG,PATS,SIM)=""
 D GUIBS5A^DPTLK6(.RET,DFN)
 S MI=1 F  S MI=$O(RET(MI)) Q:MI=""  D
 .S NOD=RET(MI)
 .I $P(NOD,U,1)=0 S MSG=MSG_$S(MSG'="":" ",1:"")_$P(NOD,U,2)
 .I $P(NOD,U,1)=1 S PATS=PATS_$S(PATS'="":";;",1:"")_$TR($P(NOD,U,2,4),U,"~")_"~"_$E($P(NOD,U,5),6,$L($P(NOD,U,5))) S:(MSG'="")&($E(MSG,$L(MSG))'=".") MSG=MSG_"."
 S SIM=MSG_"|"_PATS
 Q SIM
 ;
ASSIGNADDR(RET,DFN) ;build array for output
 N SDD,SDI,SDM,Z0
 N PCE,PCOUNTY,PTCOUNTY,PSTATE
 Q:'+$G(DFN)
 Q:'$D(^DPT(DFN,0))
 ;
 ;collect demographics
 K RET
 S (PCOUNTY,PTCOUNTY,RET("PCOUNTY"),RET("PTCOUNTY"))=""
 ;
 ;get addresses
 K SDD,SDM D GETS^DIQ(2,DFN_",",".111:.135;.211:.2207","IE","SDD","SDM")
 S RET("PADDRES1")=$G(SDD(2,DFN_",",.111,"E"))
 S RET("PADDRES2")=$G(SDD(2,DFN_",",.112,"E"))
 S RET("PADDRES3")=$G(SDD(2,DFN_",",.113,"E"))
 S RET("PZIP+4")=$G(SDD(2,DFN_",",.1112,"E"))
 S RET("PCITY")=$G(SDD(2,DFN_",",.114,"E"))
 S PSTATE=$G(SDD(2,DFN_",",.115,"I"))
 S RET("PSTATE")=$G(SDD(2,DFN_",",.115,"E"))
 I PSTATE'="" D
 .S PCOUNTY=$G(SDD(2,DFN_",",.117,"I"))
 .S:PCOUNTY'="" RET("PCOUNTY")=$P($G(^DIC(5,PSTATE,1,PCOUNTY,0)),U,1)
 S RET("PCOUNTRY")=$G(SDD(2,DFN_",",.1173,"I"))
 S RET("PCOUNTRYC")=$G(SDD(2,DFN_",",.1173,"E"))
 I RET("PCOUNTRY")'="",'+RET("PCOUNTRY") S RET("PCOUNTRY")=$O(^HL(779.004,"B",RET("PCOUNTRY"),0))
 S RET("BADADD")=$S(+$G(SDD(2,DFN_",",.121,"I")):1,1:0)
 S RET("PTACTIVE")=$G(SDD(2,DFN_",",.12105,"I"))
 S RET("PTADDRESS1")=$G(SDD(2,DFN_",",.1211,"E"))
 S RET("PTADDRESS2")=$G(SDD(2,DFN_",",.1212,"E"))
 S RET("PTADDRESS3")=$G(SDD(2,DFN_",",.1213,"E"))
 S RET("PTCITY")=$G(SDD(2,DFN_",",.1214,"E"))
 N PTSTATE S PTSTATE=$G(SDD(2,DFN_",",.1215,"I"))
 S RET("PTSTATE")=$G(SDD(2,DFN_",",.1215,"E"))
 S RET("PTZIP")=$G(SDD(2,DFN_",",.1216,"E"))
 S RET("PTZIP+4")=$G(SDD(2,DFN_",",.12112,"E"))
 S RET("PTCOUNTRY")=$G(SDD(2,DFN_",",.1223,"I"))
 S RET("PTCOUNTRYC")=$G(SDD(2,DFN_",",.1223,"E"))
 I PTSTATE'="" D
 .S PTCOUNTY=$G(SDD(2,DFN_",",.12111,"I"))
 .S:PTCOUNTY'="" RET("PTCOUNTY")=$P($G(^DIC(5,PTSTATE,1,PTCOUNTY,0)),U,1)
 S RET("PTSTART")=$G(SDD(2,DFN_",",.1217,"E"))
 S RET("PTEND")=$G(SDD(2,DFN_",",.1218,"E"))
 ;
 ;get phones
 S RET("HPHONE")=$G(SDD(2,DFN_",",.131,"E"))
 S RET("OPHONE")=$G(SDD(2,DFN_",",.132,"E"))
 S RET("PTPHONE")=$G(SDD(2,DFN_",",.1219,"E"))
 S RET("PCELL")=$G(SDD(2,DFN_",",.134,"E"))
 S RET("PPAGER")=$G(SDD(2,DFN_",",.135,"E"))
 S RET("PEMAIL")=$G(SDD(2,DFN_",",.133,"E"))
 ;
 ;next of kin data:
 S RET("NOK")=$G(SDD(2,DFN_",",.211,"I"))
 S RET("KNAME")=$G(SDD(2,DFN_",",.211,"E"))
 S RET("KREL")=$G(SDD(2,DFN_",",.212,"E"))
 S RET("KPHONE")=$G(SDD(2,DFN_",",.219,"E"))
 S RET("KSTREET")=$G(SDD(2,DFN_",",.213,"E"))
 S RET("KSTREET2")=$G(SDD(2,DFN_",",.214,"E"))
 S RET("KSTREET3")=$G(SDD(2,DFN_",",.215,"E"))
 S RET("KCITY")=$G(SDD(2,DFN_",",.216,"E"))
 S RET("KSTATE")=$G(SDD(2,DFN_",",.217,"E"))
 S RET("KZIP")=$G(SDD(2,DFN_",",.218,"E"))
 ;
 S RET("NOK2")=$G(SDD(2,DFN_",",.2191,"I"))
 S RET("K2NAME")=$G(SDD(2,DFN_",",.2191,"E"))
 S RET("K2REL")=$G(SDD(2,DFN_",",.2192,"E"))
 S RET("K2PHONE")=$G(SDD(2,DFN_",",.2199,"E"))
 S RET("K2STREET")=$G(SDD(2,DFN_",",.2193,"E"))
 S RET("K2STREET2")=$G(SDD(2,DFN_",",.2194,"E"))
 S RET("K2STREET3")=$G(SDD(2,DFN_",",.2195,"E"))
 S RET("K2CITY")=$G(SDD(2,DFN_",",.2196,"E"))
 S RET("K2STATE")=$G(SDD(2,DFN_",",.2197,"E"))
 S RET("K2ZIP")=$G(SDD(2,DFN_",",.2198,"E"))
 ;
 Q
 ;
