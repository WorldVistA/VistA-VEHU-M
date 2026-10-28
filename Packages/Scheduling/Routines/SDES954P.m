SDES954P ;ALB/JDJ - SD*5.3*954 Post Init Routine ; Aug 31, 2026
 ;;5.3;SCHEDULING;**954**;AUG 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
POST ; Post-Installation Entry Point
 ;
 D NEWRPCS
 Q
 ;
NEWRPCS ; Post-Installation Process for adding new RPCs to SDESRPC context
 N ADDERROR,ERRORS,OPTIONIEN,RPCNAME,RPCTEXT
 ;
 ; Retrieve IEN for SDESRPC Option
 ;
 S OPTIONIEN=$O(^DIC(19,"B","SDESRPC",0))
 I 'OPTIONIEN D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** There has been an issue identifying the SDESRPC Option.")
 . D MES^XPDUTL("      This patch may need to be re-installed at a later time.")
 ;
 ;;; Update OPTION (#19) file
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL(">>> Updating the SDESRPC option.")
 D MES^XPDUTL("")
 ;
 ; Attempt to add new RPC(s) to SDESRPC option
 ;
 S (ADDERROR,ERRORS)=0
 F RPCTEXT=1:1 S RPCNAME=$P($T(ADD+RPCTEXT),";;",2) Q:RPCNAME="QUIT"  D
 . D ADDRPC(.ADDERROR,OPTIONIEN,RPCNAME)
 . I ADDERROR S ERRORS=1
 ;
 I ERRORS D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("        *** The issues referenced above need to be addressed. ***")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL(">>> Updates to the SDESRPC have completed successfully. <<<")
 Q
 ;
ADDRPC(ADDERROR,OPTIONIEN,RPCNAME) ;Add RPC(s) to the SDESRPC Option
 N FDA,FDAERR,RPCIEN
 S ADDERROR=0
 ;
 ; Verify that the RPC is valid
 ;
 I '$D(^XWB(8994,"B",RPCNAME)) D  Q
 . S ADDERROR=1
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** RPC "_RPCNAME_" does not exist in file #8994 and cannot be added")
 . D MES^XPDUTL("      to the SDESRPC Option.")
 ;
 S RPCIEN=$O(^XWB(8994,"B",RPCNAME,0))
 I 'RPCIEN D  Q
 . S ADDERROR=1
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** There has been an issue identifying the "_RPCNAME_" RPC.")
 . D MES^XPDUTL("      This patch may need to be re-installed at a later time.")
 ;
 ; Attempt to register the RPC to the SDESRPC context
 ;
 I $D(^DIC(19,OPTIONIEN,"RPC","B",RPCIEN)) D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** RPC "_RPCNAME_" is already registered to SDESRPC.")
 ;
 S ADDERROR=0
 S FDA(19.05,"+1,"_OPTIONIEN_",",.01)=RPCIEN
 D UPDATE^DIE(,"FDA",,"FDAERR") K FDA
 ;
 I $D(FDAERR) D  Q
 . S ADDERROR=1
 . D MES^XPDUTL("")
 . D MES^XPDUTL("** There was an issue adding RPC "_RPCNAME_" to the")
 . D MES^XPDUTL("     SDESRPC context. It may need to be added manually.")
 . D MES^XPDUTL("     Additional Error Text: "_$G(FDAERR("DIERR",1,"PARAM","IENS")))
 . D MES^XPDUTL("       "_$G(FDAERR("DIERR",1,"TEXT",1))_".")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL(">> RPC "_RPCNAME_" has been successfully registered to SDESRPC.")
 Q
 ;
ADD ; codes to added to SDESRPC context - ;;rpc name
 ;;SDES2 GET PATIENT REG 2
 ;;QUIT
 ;
