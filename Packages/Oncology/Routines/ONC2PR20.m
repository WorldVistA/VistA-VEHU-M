ONC2PR20 ;HINES OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*20 ;05/01/24
 ;;2.2;ONCOLOGY;**20**;Jul 31, 2013;Build 5
 ;
 ; ICRs:
 ; #1157  XPDMENU
 ; #10141 XPDUTL
 ; #10060 FILE 200 fields
 Q
START ;start pre-init changes
 K ^ONCO(160.16)  ;delete 160.16 and bring back in patch 20 build
 K ^ONCO(164.33)  ;delete 164.33 and bring back in patch 20 build
 K ^ONCO(164.44)  ;delete 164.44 and bring back in patch 20 build
 K ^ONCO(165.8)  ;delete 165.8 and bring back in patch 20 build
 K ^ONCO(165.9)  ;delete 165.9 and bring back in patch 20 build
 D CASEFIND
 D INITIALS
 D ABSTATUS
 D GEOCODE
 D REMOPT1,REMOPT2,REMOPT3
 D USERV
 Q
 ;
GEOCODE ;fix NEW ENGLAND AND NEW JERSEY entry in File #165.2
 ;FILE 165.2 - GEOCODES
 Q:+$$PATCH^XPDUTL("ONC*2.2*20")  ;already done
 N ONCDA,ONCIEN,ONCIEN1,ONCIENS
 S (ONCDA,ONCIEN,ONCIEN1)=0
 D BMES^XPDUTL("Fixing the 'New England and New Jersey' entry in GEOCODES file (#165.2)")
 F  S ONCDA=$O(^ONCO(165.2,ONCDA)) Q:'ONCDA!(ONCIEN>0)  D
 .I $P(^ONCO(165.2,ONCDA,0),U,1)="New England and New Jersey" S ONCIEN=ONCDA
 I ONCIEN'>0 D  Q
 .D BMES^XPDUTL("Cannot find the entry in FILE #165.2.")
 .D BMES^XPDUTL("Please log a ticket.")
 K ONCFDA,ONCMSG
 S ONCIENS=ONCIEN_","
 S ONCFDA(165.2,ONCIENS,1.1)="US" ;edit USPS STATE CODE 
 D FILE^DIE(,"ONCFDA","ONCMSG")
 S ONCDA=0
 F  S ONCDA=$O(^ONCO(165.2,ONCIEN,1,ONCDA)) Q:'ONCDA!(ONCIEN1>0)  D
 .I $P(^ONCO(165.2,ONCIEN,1,ONCDA,0),U,1)="NEW JERSEY" S ONCIEN1=ONCDA
 K ONCIENS,ONCFDA,ONCMSG
 S ONCIENS=ONCIEN1_","_ONCIEN_","
 S ONCFDA(165.21,ONCIENS,.01)="@" ;delete XREF field value 
 D FILE^DIE(,"ONCFDA","ONCMSG")
 D BMES^XPDUTL("GEOCODES FILE (#165.2) entry changed.")
 Q
REMOPT1 ;Remove ONCO UTIL-DELETE PATIENT option from it's menu
 Q:+$$PATCH^XPDUTL("ONC*2.2*20")  ;already done
 N ONCY
 S ONCY=$$DELETE^XPDMENU("ONCO UTIL MENU","ONCO UTIL-DELETE PATIENT")
 I ONCY'=1 D  Q
 .D BMES^XPDUTL("Could not remove the 'ONCO UTIL-DELETE PATIENT' option from it's menu.")
 .D BMES^XPDUTL("Please log a ticket.")
 Q
REMOPT2 ;Remove ONCO RQRS EXTRACT option from it's menu
 Q:+$$PATCH^XPDUTL("ONC*2.2*20")  ;already done
 N ONCY
 S ONCY=$$DELETE^XPDMENU("ONCO UTIL MENU","ONCO RQRS EXTRACT")
 I ONCY'=1 D  Q
 .D BMES^XPDUTL("Could not remove the 'ONCO RQRS EXTRACT' option from it's menu.")
 .D BMES^XPDUTL("Please log a ticket.")
 Q
REMOPT3 ;Remove ONCO FOLL-PAT FOLLOWUP REPORT option from it's menu
 Q:+$$PATCH^XPDUTL("ONC*2.2*20")  ;already done
 N ONCY
 S ONCY=$$DELETE^XPDMENU("ONCO FOLL PROCEDURE MENU","ONCO FOLL-PAT FOLLOWUP REPORT")
 I ONCY'=1 D  Q
 .D BMES^XPDUTL("Could not remove the 'ONCO FOLL-PAT FOLLOWUP REPORT' option from it's menu.")
 .D BMES^XPDUTL("Please log a ticket.")
 Q
ABSTATUS ;Check ABSTRACT STATUS (#91) field for all 2023 cases and later.
 ;If value=3 (Complete), then change to 2 (Partial).
 ;FILE 165.5 - ONCOLOGY PRIMARY
 ;ADX x-ref on DATE DX (#3) field
 D BMES^XPDUTL("Checking ABSTATUS (#91) values in ONCOLOGY SITE PARAMETERS file (#165.2)")
 N ONCDATE,ONCIEN,ONCNODE,ONCFDA,ONCMSG,ONCIENS
 S ONCDATE=3221231.999999
 F  S ONCDATE=$O(^ONCO(165.5,"ADX",ONCDATE)) Q:'ONCDATE  D
 .S ONCIEN=0
 .F  S ONCIEN=$O(^ONCO(165.5,"ADX",ONCDATE,ONCIEN)) Q:'ONCIEN  D
 ..S ONCNODE=$G(^ONCO(165.5,ONCIEN,7))
 ..Q:$P(ONCNODE,U,2)'=3  ;quit if ABSTRACT STATUS (#91) is not "Complete"
 ..K ONCFDA,ONCMSG
 ..S ONCIENS=ONCIEN_","
 ..S ONCFDA(165.5,ONCIENS,91)=2 ;set to "Partial"
 ..D FILE^DIE(,"ONCFDA","ONCMSG")
 .. D BMES^XPDUTL("Changed ABSTRACT STATUS value for entry "_ONCIEN_".")
 Q
INITIALS ;Check if Oncology Registrar has initials in FILE 200
 ;FILE 165.5 - ONCOLOGY PRIMARY
 ;FILE 200   - NEW PERSON
 D BMES^XPDUTL("Checking if Oncology Registrar has INITIALS in the NEW PERSON file (#200)")
 N ONCDUZ,ONCIEN,ONCINITIALS,ONCNODE,ONCUSER,ONCWARNING
 S ONCIEN=0
 F  S ONCIEN=$O(^ONCO(165.5,ONCIEN)) Q:'ONCIEN  D
 .S ONCNODE=$G(^ONCO(165.5,ONCIEN,7))
 .S ONCDUZ=$P(ONCNODE,U,3) ;(#92) ABSTRACTED BY - pointer to FILE 200
 .Q:ONCDUZ=""  ;field can be null if the case is not "Completed"
 .S ONCINITIALS=$$GET1^DIQ(200,ONCDUZ_",",1,,,"ONCMSG")
 .Q:ONCINITIALS'=""  ;there are user initials
 .S ONCUSER=$$GET1^DIQ(200,ONCDUZ_",",.01,,,"ONCMSG")
 .S ONCWARNING=ONCUSER_" does not have INITIALS (#1) in the NEW PERSON (#200) file"
 .D BMES^XPDUTL(ONCWARNING)
 Q
CASEFIND ;Changes to CASEFINDING SOURCE (#166) file
 ;change DEFINITION (#1) value for codes 20, 24 and 26
 Q:+$$PATCH^XPDUTL("ONC*2.2*20")  ;already done
 N ONCIEN,ONCFDA,ONCMSG
 S ONCIEN=$O(^ONCO(166,"B",20,0))
 S ONCFDA(166,ONCIEN_",",1)="Pathology Department Review (surgical pathology reports, autopsies, or cytology reports)"
 D FILE^DIE(,"ONCFDA","ONCMSG")
 K ONCFDA,ONCMSG
 S ONCIEN=$O(^ONCO(166,"B",24,0))
 S ONCFDA(166,ONCIEN_",",1)="Laboratory Reports (other than pathology reports, code 20)"
 D FILE^DIE(,"ONCFDA","ONCMSG")
 K ONCFDA,ONCMSG
 S ONCIEN=$O(^ONCO(166,"B",26,0))
 S ONCFDA(166,ONCIEN_",",1)="Diagnostic Imaging/Radiology (other than radiation therapy, codes 23; includes nuclear medicine)"
 D FILE^DIE(,"ONCFDA","ONCMSG")
 K ONCFDA,ONCMSG
 S ONCIEN=$O(^ONCO(166,"B",28,0)) ;this change merely corrects a misspelling that existed
 S ONCFDA(166,ONCIEN_",",1)="Hospital Rehabilitation Service or Clinic"
 D FILE^DIE(,"ONCFDA","ONCMSG")
 Q
USERV ;Update url to Production or Development server
 N ONCSYS
 S ONCSYS=$$PROD^XUPROD()
 S DA=$O(^XOB(18.12,"B","ONCO WEB SERVER",""))
 ;production url
 I ONCSYS D
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-prod-apim.reg.vaec.domain""" D ^DIE
 .W !,"Oncology Web Server is updated to Production url...",!
 ;development url
 I 'ONCSYS D
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-preprod-apim.reg.vaec.domain""" D ^DIE
 .W !,"Oncology Web Server is updated to Development url...",!
 Q
