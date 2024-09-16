PSO7P753 ;WILM/BDB - Post-Install for PSO patch 743 ;12-JAN-2024
 ;;7.0;OUTPATIENT PHARMACY;**753**;DEC 1997;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; -- entry point
 ; set header for the menu protocol
 N FDA,PRIEN,PRNAME
 D BMES^XPDUTL("-------------")
 D MES^XPDUTL("Setting the header for the Order Selection Menu protocol. ")
 S PRNAME="PSO LM SELECT MENU" D
 .S PRIEN=+$$FIND1^DIC(101,,"X",PRNAME,"B")
 .I PRIEN S FDA(101,PRIEN_",",26)="D A^PSOORUT3,SHOW^VALM S:$G(PSOACT)[""E"" XQORM(""#"")=$O(^ORD(101,""B"",""PSO LM EDIT SELECT ORDER"",0))_""^1:22"""
 .Q
 I $D(FDA) D FILE^DIE("E","FDA")
 D BMES^XPDUTL(" Done.")
