SDESGETREGA ;ALB/LAB - SD*5.3*799 Get registration info JSON format ; Sep 28, 2021@08:40
 ;;5.3;SCHEDULING;**799**;AUG 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to ^DPT(         In ICRs #7030,7029,1476,10035
 ;
 Q
 ;
GETREGA(SDECY,DFN) ;return basic reg info/demographics for given patient in JSON format
 ;Input Parmater:
 ;   DFN - Patient ID - Pointer to PATIENT file
 ;Returns:
 ; json formated output (need to add)
 NEW POP,SDINFO,SDDFN,SDPATARR,SDDEMO,PRACE,PRACEN,PETH,PETHN,SDMHP,SDPCP,GAF,GAFR,SDZIP
 S POP=0
 D VALIDATE D:POP BUILDER Q:POP
 D GETREG
 D BUILDER
 Q
 ;
VALIDATE ;validate input Parmater
 I +DFN=0 S POP=1 D ERRLOG^SDESJSON(.SDINFO,1) Q
 I '$D(^DPT(DFN,0)) S POP=1 D ERRLOG^SDESJSON(.SDINFO,2)
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDINFO,.SDECY,.JSONERR)
 Q
 ;
ASSIGNVALS ;assign values to be used to build output
 ; assign data values
 ;
 S SDDFN=DFN_","
 D GETS^DIQ(2,SDDFN,".1;.116;.1219;.1151;.1152;.1153;.1154;.1155;.1156;.1173;.1223","E","SDPATARR")
 D PDEMO^SDECU3(.SDDEMO,DFN)
 D RACELST^SDECU2(DFN,.PRACE,.PRACEN)
 D ETH^SDECU2(DFN,.PETH,.PETHN)   ;get ethnicity
 S SDMHP=$$START^SCMCMHTC(DFN) ;Return Mental Health Provider
 S SDPCP=$$OUTPTPR^SDUTL3(DFN) ;Return Primary Care Provider
 S GAF=$$NEWGAF^SDUTL2(DFN)
 S GAFR=""
 S:GAF="" GAF=-1
 S $P(GAFR,"|",1)=$S(+GAF:"New GAF Required",1:"No new GAF required")
 Q
 ;
GETREG ;
 S SDINFO("Patient","DataFileNumber")=DFN
 D ASSIGNVALS ;assign all values needed to build SDINFO array
 ;
 ;person identification information
 ;
 S SDINFO("Patient","Name")=SDDEMO("NAME")
 S SDINFO("Patient","SocialSecurityNumber")=SDDEMO("SSN")
 S SDINFO("Patient","DateOfBirth")=SDDEMO("DOB")
 S SDINFO("Patient","Race")=$G(PRACE)
 S SDINFO("Patient","RaceName")=$G(PRACEN)
 S SDINFO("Patient","Ethnicity")=$G(PETH)
 S SDINFO("Patient","EthnicityName")=$G(PETHN)
 S SDINFO("Patient","Sex")=SDDEMO("GENDER")
 S SDINFO("Patient","Security")=$$PTSEC^SDECUTL(DFN)
 S SDINFO("Patient","Marital")=SDDEMO("PMARITAL")
 S SDINFO("Patient","Religion")=SDDEMO("PRELIGION")
 ;
 ;health information
 ;
 S SDINFO("Patient","PrimaryCareProvider")=$P(SDPCP,"^",2)
 S SDINFO("Patient","ServiceConnected")=SDDEMO("SVCCONN")
 S SDINFO("Patient","ServiceConnectedPercentage")=SDDEMO("SVCCONNP")
 S SDINFO("Patient","Ward")=$G(SDPATARR(2,SDDFN,.1,"E"))
 S SDINFO("Patient","HealthRecordNumber")=SDDEMO("HRN")
  ;
 ;flags
 ;
 S SDINFO("Patient","FugitiveFlag")=SDDEMO("PF_FFF")
 S SDINFO("Patient","VeteranCatastrophicallyDisabled")=SDDEMO("PF_VCD")
 S SDINFO("Patient","NationalFlag")=SDDEMO("PFNATIONAL")
 S SDINFO("Patient","LocalFlag")=SDDEMO("PFLOCAL")
 S SDINFO("Patient","EnrollmentSubgroup")=SDDEMO("SUBGRP")
 S SDINFO("Patient","Category8GFlag")=(SDDEMO("PRIGRP")="GROUP 8")&(SDDEMO("SUBGRP")="g")
 S SDINFO("Patient","SimilarPatients")=SDDEMO("SIMILAR")
 S SDINFO("Patient","PriorityGroup")=SDDEMO("PRIGRP")
 S SDINFO("Patient","GAFRequired")=$G(GAFR)
 ;
 ;contact information
 ;
 S SDINFO("Patient","Cell")=SDDEMO("PCELL")
 S SDINFO("Patient","Email")=SDDEMO("PEMAIL")
 S SDINFO("Patient","HomePhone")=SDDEMO("HPHONE")
 S SDINFO("Patient","OfficePhone")=SDDEMO("OPHONE")
 ;
 ;mail address information
 ;
 S SDINFO("Patient","MailStreet1")=SDDEMO("PADDRES1")
 S SDINFO("Patient","MailStreet2")=SDDEMO("PADDRES2")
 S SDINFO("Patient","MailStreet3")=SDDEMO("PADDRES3")
 S SDINFO("Patient","MailCity")=SDDEMO("PCITY")
 S SDINFO("Patient","MailState")=SDDEMO("PSTATE")
 S SDINFO("Patient","MailCounty")=SDDEMO("PCOUNTY")
 S SDINFO("Patient","MailCountry")=SDDEMO("PCOUNTRY")
 S SDINFO("Patient","MailCountryName")=$G(SDPATARR(2,SDDFN,.1173,"E"))
 S SDZIP=SDDEMO("PZIP+4")
 S:SDZIP="" SDZIP=$G(SDPATARR(2,SDDFN,.116,"E"))
 S SDINFO("Patient","MailZip")=SDZIP
 S SDINFO("Patient","AddressIndicator")=SDDEMO("BADADD")
 ;
 ;Residential Address Info
 ;
 S SDINFO("Patient","MentalHealthProvider")=$P(SDMHP,"^",2)
 S SDINFO("Patient","ResidentialAddress1")=$G(SDPATARR(2,SDDFN,.1151,"E"))
 S SDINFO("Patient","ResidentialAddress2")=$G(SDPATARR(2,SDDFN,.1152,"E"))
 S SDINFO("Patient","ResidentialAddress3")=$G(SDPATARR(2,SDDFN,.1153,"E"))
 S SDINFO("Patient","ResidentialCity")=$G(SDPATARR(2,SDDFN,.1154,"E"))
 S SDINFO("Patient","ResidentialState")=$G(SDPATARR(2,SDDFN,.1155,"E"))
 S SDINFO("Patient","ResidentialZip")=$G(SDPATARR(2,SDDFN,.1156,"E"))
 ;
 ;Temp Adress information
 ;
 S SDINFO("Patient","TempAddress1")=SDDEMO("PTADDRESS1")
 S SDINFO("Patient","TempAddress2")=SDDEMO("PTADDRESS2")
 S SDINFO("Patient","TempAddress3")=SDDEMO("PTADDRESS3")
 S SDINFO("Patient","TempCity")=SDDEMO("PTCITY")
 S SDINFO("Patient","TempState")=SDDEMO("PTSTATE")
 S SDINFO("Patient","TempZip")=SDDEMO("PTZIP")
 S SDINFO("Patient","TempZip4")=SDDEMO("PTZIP+4")
 S SDINFO("Patient","TempCountry")=SDDEMO("PTCOUNTRY")
 S SDINFO("Patient","TempCountryName")=$G(SDPATARR(2,SDDFN,.1223,"E"))
 S SDINFO("Patient","TempCounty")=SDDEMO("PTCOUNTY")
 S SDINFO("Patient","TempAddressStart")=SDDEMO("PTSTART")
 S SDINFO("Patient","TempAddressEnd")=SDDEMO("PTEND")
 S SDINFO("Patient","TempPhone")=$G(SDPATARR(2,SDDFN,.1219,"E"))
 ;
 ;Primary Next Of Kin Information
 ;
 S SDINFO("Patient","PrimaryNextOfKin")=SDDEMO("NOK")
 S SDINFO("Patient","PrimaryNextOfKinPhone")=SDDEMO("KPHONE")
 S SDINFO("Patient","PrimaryNextOfKinAddress")=SDDEMO("KSTREET")
 S SDINFO("Patient","PrimaryNextOfKinCity")=SDDEMO("KCITY")
 S SDINFO("Patient","PrimaryNextOfKinState")=SDDEMO("KSTATE")
 S SDINFO("Patient","PrimaryNextOfKinZip")=SDDEMO("KZIP")
 S SDINFO("Patient","PrimaryNextOfKinStreet2")=SDDEMO("KSTREET2")
 S SDINFO("Patient","PrimaryyNextOfKinStreet3")=SDDEMO("KSTREET3")
 ;
 ;Secondary Next of Kin Information
 ;
 S SDINFO("Patient","SecondaryNextOfKin")=SDDEMO("NOK2")
 S SDINFO("Patient","SecondaryNextOfKinName")=SDDEMO("K2NAME")
 S SDINFO("Patient","SecondaryNextOfKinRelationship")=SDDEMO("K2REL")
 S SDINFO("Patient","SecondaryNextOfKinPhone")=SDDEMO("K2PHONE")
 S SDINFO("Patient","SecondaryNextOfKinStreet")=SDDEMO("K2STREET")
 S SDINFO("Patient","SecondaryNextOfKinStreet2")=SDDEMO("K2STREET2")
 S SDINFO("Patient","SecondaryNextOfKinStreet3")=SDDEMO("K2STREET3")
 S SDINFO("Patient","SecondaryNextOfKinCity")=SDDEMO("K2CITY")
 S SDINFO("Patient","SecondaryNextOfKinState")=SDDEMO("K2STATE")
 S SDINFO("Patient","SecondaryNextOfKinZip")=SDDEMO("K2ZIP")
 Q
 ;
