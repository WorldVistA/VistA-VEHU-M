RAIPS203 ;HISC/GJC  - post install routine ; May 19, 2023@11:16:25
 ;;5.0;Radiology/Nuclear Medicine;**203**;Mar 16, 1998;Build 1
 ;
 ; Tag^Routine        File       IA          Type
 ;-----------------------------------------------
 ; $$FIND1^DIC()                 2051        (S)
 ; MES^XPDUTL()                  10141       (S)
 ; FILE^DIE()                    2053        (S)
 ;
EN ;rename nat'l hold reason
 ;From: MYHEALTHYVET CONTACT
 ;  To: MYHEALTHEVET CONTACT
 N RAIEN,RANEW,RAOLD S RAOLD="MYHEALTHYVET CONTACT"
 S RANEW="MYHEALTHEVET CONTACT"
 S RAIEN=$$FIND1^DIC(75.2,,"B",RAOLD)
 I RAIEN=0 D  Q
 .N RATXT S RATXT(1)="The record '"_RAOLD_"' was not found."
 .S RATXT(2)="Contact the national radiology development team."
 .D MES^XPDUTL(.RATXT)
 .Q
 N RAFDA,RAIENS S RAIENS=RAIEN_","
 S RAFDA(75.2,RAIENS,.01)=RANEW
 D FILE^DIE("E","RAFDA")
 ;
 I ($$FIND1^DIC(75.2,,"B",RANEW))'=RAIEN D  ;failed...
 .N RATXT S RATXT(1)="The record '"_RAOLD_"' was not updated to '"_RANEW_"'."
 .S RATXT(2)="Contact the national radiology development team."
 .D MES^XPDUTL(.RATXT)
 .Q
 E  D  ;success...
 .N RATXT S RATXT="The record '"_RAOLD_"' was updated to '"_RANEW_"'."
 .D MES^XPDUTL(RATXT)
 .Q
 Q
 ;
