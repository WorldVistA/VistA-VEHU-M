IBY721PO ;YMG/EDE - IB*2.0*721 POST INSTALL;JUN 23 2023
 ;;2.0;Integrated Billing;**721**;21-MAR-94;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*721")
 D NEWATYPE
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*721")
 Q
 ;
NEWATYPE ; add new IB action types to file 350.1
 N FDA,FDAIEN,IBATYPE,IBCHRG,IBIEN,IBNAME,IBSRV,IENS,Z
 D MES^XPDUTL("     -> Adding new IB action types to file 350.1...")
 S IBCHRG=$$FIND1^DIC(430.2,,"X","CC OPT","B")
 S IBSRV=$$GET1^DIQ(350.9,1,1.14,"I")
 F IBNAME="CC MH (OPT) NEW","CC MH (OPT) UPDATE","CC MH (OPT) CANCEL" D
 .D MES^XPDUTL("        Adding "_IBNAME_"...")
 .S IBATYPE=+$$FIND1^DIC(350.1,,"X",IBNAME,"B"),IENS=$S(IBATYPE>0:IBATYPE_",",1:"+1,")
 .S FDA(350.1,IENS,.01)=IBNAME  ; name
 .S FDA(350.1,IENS,.02)=$S(IBNAME["UPDATE":"UPD CCMH",IBNAME["CANCEL":"CAN CCMH",1:"N CCMH")  ; abbreviation
 .S FDA(350.1,IENS,.03)=IBCHRG  ; charge category
 .S FDA(350.1,IENS,.04)=IBSRV  ; service
 .S FDA(350.1,IENS,.05)=$S(IBNAME["UPDATE":3,IBNAME["CANCEL":2,1:1)  ; sequence #
 .I IBNAME["NEW" D
 ..S FDA(350.1,IENS,.08)="CC MH OPT"  ; user lookup name
 ..S FDA(350.1,IENS,.1)=1  ; place on hold
 ..S FDA(350.1,IENS,.11)=4  ; billing group
 ..S FDA(350.1,IENS,20)="S IBDESC=""CC MH OPT COPAY"""
 ..Q
 .S FDA(350.1,IENS,.12)=0  ; inactive?
 .I 'IBATYPE D
 ..D UPDATE^DIE("","FDA","FDAIEN")
 ..I +$G(FDAIEN(1))>0 S IBIEN($S(IBNAME["UPDATE":"U",IBNAME["CANCEL":"C",1:"N"))=FDAIEN(1)
 ..K FDAIEN
 ..Q
 .I IBATYPE D
 ..D FILE^DIE("","FDA")
 ..S IBIEN($S(IBNAME["UPDATE":"U",IBNAME["CANCEL":"C",1:"N"))=IBATYPE
 ..Q
 .K FDA
 .D MES^XPDUTL("        Ok.")
 .Q
 F Z="U","C","N" D
 .S IENS=IBIEN(Z)_","
 .S FDA(350.1,IENS,.06)=IBIEN("C")  ; cancellation action type
 .S FDA(350.1,IENS,.07)=IBIEN("U")  ; update action type
 .S FDA(350.1,IENS,.09)=IBIEN("N")  ; new action type
 .D FILE^DIE("","FDA")
 .K FDA
 .Q
 D MES^XPDUTL("      Done.")
 Q
