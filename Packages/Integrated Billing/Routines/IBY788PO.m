IBY788PO ;YMG/EDE - IB*2.0*788 POST INSTALL;FEB 16 2024
 ;;2.0;Integrated Billing;**788**;21-MAR-94;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*788")
 D NEWCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*788")
 Q
 ;
NEWCANC ; add new cancellation reason to file 350.3
 N FDA,IBCNNM
 D MES^XPDUTL("     -> Adding new Cancellation Reason to file 350.3...")
 S IBCNNM="PACT103"
 I $$FIND1^DIC(350.3,,"X",IBCNNM,"B")>0 D MES^XPDUTL("        Already exists.") Q  ; already exists
 S FDA(350.3,"+1,",.01)=IBCNNM  ; name
 S FDA(350.3,"+1,",.02)="PACT"  ; abbreviation
 S FDA(350.3,"+1,",.03)=3       ; limit
 S FDA(350.3,"+1,",.04)=1       ; can cancel UC
 S FDA(350.3,"+1,",.05)=2       ; UC visit processing
 S FDA(350.3,"+1,",.07)=2       ; MH visit processing
 S FDA(350.3,"+1,",.08)=1       ; Can cancel MH Visit
 D UPDATE^DIE("","FDA")
 D MES^XPDUTL("        Done.")
 Q
