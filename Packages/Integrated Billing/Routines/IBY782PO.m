IBY782PO ;YMG/EDE - IB*2.0*782 POST INSTALL;DEC 21 2023
 ;;2.0;Integrated Billing;**782**;21-MAR-94;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*782")
 D UPDCANC
 D UPDOPT
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*782")
 Q
UPDCANC ; update cancellation reason in file 350.3
 N FDA,IBREAS,IENS
 D MES^XPDUTL("     -> Updating Cancellation Reason in file 350.3...")
 S IBREAS=+$$FIND1^DIC(350.3,,"X","INDIAN ATTESTATION","B")
 I IBREAS>0 D
 .S IENS=IBREAS_","
 .S FDA(350.3,IENS,.01)="AI/AN VERIFIED"
 .S FDA(350.3,IENS,.02)="AI/AN"
 .D FILE^DIE("","FDA")
 .Q
 D MES^XPDUTL("        Done.")
 Q
 ;
UPDOPT ; Update IB INDIAN EXEMPTION REPORT option synonym
 N FDA,IENS,MIEN,OIEN
 D MES^XPDUTL("     -> Updating option synonym in file 19...")
 S MIEN=+$$LKOPT^XPDMENU("IB OUTPUT PATIENT REPORT MENU")
 I MIEN D
 .S IENS=","_MIEN_","
 .S OIEN=+$$FIND1^DIC(19.01,IENS,"X","IB INDIAN EXEMPTION REPORT","B")
 .I OIEN S IENS=OIEN_IENS,FDA(19.01,IENS,2)="AIAN" D FILE^DIE("","FDA")
 .Q
 D MES^XPDUTL("        Done.")
 Q
