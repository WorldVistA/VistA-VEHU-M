PRCAP389 ;EDE/YMG - PRCA*4.5*389 POST INSTALL; 07/28/21
 ;;4.5;Accounts Receivable;**389**;Mar 20, 1995;Build 36
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*389")
 ; Update audit log comments in file 340.5
 D UPDCMNT
 ;
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*389")
 Q
 ;
UPDCMNT ; Update audit log comments and 36 months review flag (fields 340.54/4 and 340.5/1.06) in file 340.5
 N AIEN,APPR36,CMNT,CMNTPTR,FDA,IENS,RPIEN,RPPLEN
 D BMES^XPDUTL(" >>  Updating audit log comments and 36 months review flag in file 340.5...")
 S RPIEN=0 F  S RPIEN=$O(^RCRP(340.5,RPIEN)) Q:'RPIEN  D
 .S APPR36=0
 .S RPPLEN=$P(^RCRP(340.5,RPIEN,0),U,5)
 .S AIEN=0 F  S AIEN=$O(^RCRP(340.5,RPIEN,4,AIEN)) Q:'AIEN  D
 ..S CMNT=$P(^RCRP(340.5,RPIEN,4,AIEN,0),U,4) I CMNT="" Q
 ..I CMNT="SM" S APPR36=1
 ..S CMNTPTR=+$O(^RCRP(340.501,"B",CMNT,"")) I CMNTPTR'>0 Q
 ..S IENS=AIEN_","_RPIEN_",",FDA(340.54,IENS,5)=CMNTPTR D FILE^DIE("","FDA")
 ..Q
 .; set field 340.5/1.06, if necessary
 .I RPPLEN>36 S IENS=RPIEN_"," I $$GET1^DIQ(340.5,IENS,1.06,"I")="" S FDA(340.5,IENS,1.06)=APPR36 D FILE^DIE("","FDA")
 .Q
 D MES^XPDUTL("Done.")
 Q
