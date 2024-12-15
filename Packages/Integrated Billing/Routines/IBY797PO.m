IBY797PO ;YMG/EDE - IB*2.0*797 POST INSTALL;FEB 16 2024
 ;;2.0;Integrated Billing;**797**;21-MAR-94;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*797")
 D NEWCANC
 D UPDCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*797")
 Q
 ;
NEWCANC ; add new cancellation reason to file 350.3
 N FDA,IBCNNM
 D MES^XPDUTL("     -> Adding new Cancellation Reason to file 350.3...")
 S IBCNNM="INCORRECT CLINIC/STOP CODE"
 I $$FIND1^DIC(350.3,,"X",IBCNNM,"B")>0 D MES^XPDUTL("        Already exists.") Q  ; already exists
 S FDA(350.3,"+1,",.01)=IBCNNM  ; name
 S FDA(350.3,"+1,",.02)="ICS"  ; abbreviation
 S FDA(350.3,"+1,",.03)=3       ; limit
 S FDA(350.3,"+1,",.07)=1       ; MH visit processing
 S FDA(350.3,"+1,",.08)=1       ; Can cancel MH Visit
 D UPDATE^DIE("","FDA")
 D MES^XPDUTL("        Done.")
 Q
 ;
UPDCANC ; update fields .09 and .1 in file 350.3
 N FDA,IBCNNM,IBDATA,IBEFDT,IBENDT,IBIEN,IENS,Z
 D MES^XPDUTL("     -> initializing EFFECTIVE DATE and END DATE fields in file 350.3...")
 F Z=1:1 S IBDATA=$T(REASDAT+Z),IBCNNM=$P(IBDATA,";",3) Q:IBCNNM="END"  D
 .S IBEFDT=$P(IBDATA,";",4),IBENDT=$P(IBDATA,";",5)
 .S IBIEN=$O(^IBE(350.3,"B",IBCNNM,""))
 .I 'IBIEN D BMES^XPDUTL("       >>  Unable to update the Charge Remove Reason "_IBCNNM_".") Q
 .S IENS=IBIEN_","
 .S FDA(350.3,IENS,.09)=IBEFDT
 .I IBENDT>0 S FDA(350.3,IENS,.1)=IBENDT
 .D FILE^DIE("","FDA") K FDA
 .Q
 D MES^XPDUTL("        Done.")
 Q
 ;
REASDAT ; Cancellation reasons (350.3) to update
 ;;AI/AN VERIFIED;3220105
 ;;CLELAND-DOLE;3230627;3271231
 ;;COMPACT;3230117
 ;;HANNON ACT;3220919;3250918
 ;;MEDAL OF HONOR;3161216
 ;;PACT103;3240305
 ;;PANDEMIC RESPONSE;3200301;3210930
 ;;UC - CHANGE IN ELIGIBILITY;3190606
 ;;UC - DUPLICATE VISIT;3190606
 ;;UC - ENTERED IN ERROR;3190606
 ;;UC - PG6 REVIEWED;3190606
 ;;UC - SEQUENCE UPDATE;3190606
 ;;WORLD WAR II;3230325
 ;;END
 Q
