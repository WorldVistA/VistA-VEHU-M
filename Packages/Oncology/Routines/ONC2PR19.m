ONC2PR19 ;HINES OIFO/RTK - Pre-Install Routine for Patch ONC*2.2*19 ;12/04/23
 ;;2.2;ONCOLOGY;**19**;Jul 31, 2013;Build 4
 ;
 K ^ONCO(160.16)  ;delete 160.16 and bring back in patch 19 build
 K ^ONCO(164)     ;delete 164 and bring back in patch 19 build
 K ^ONCO(164.46)  ;delete 164.46 and bring back in patch 19 build
 K ^ONCO(165.8)   ;delete 165.8 and bring back in patch 19 build
 K ^ONCO(165.9)   ;delete 165.9 and bring back in patch 19 build
 K ^ONCO(169.3)   ;delete 169.3 and bring back in patch 19 build
 ;
 D USERV ;update url (development or production)
 Q
 ;
USERV ;Update url to Production or Development server
 N ONCSYS
 S ONCSYS=$$PROD^XUPROD()
 S DA=$O(^XOB(18.12,"B","ONCO WEB SERVER",""))
 ;production url
 I ONCSYS D
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-prod-apim.reg.vaec.domain""" D ^DIE
 .W !,"Oncology Web Server is updated to Production url...",!
 ;preprod url
 I 'ONCSYS D
 .S DIE="^XOB(18.12,",DR=".04///^S X=""va-reg-preprod-apim.reg.vaec.domain""" D ^DIE
 .W !,"Oncology Web Server is updated to Development url...",!
 Q
