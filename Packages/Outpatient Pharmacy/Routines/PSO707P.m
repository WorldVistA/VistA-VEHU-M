PSO707P ;ORLFO/FJF/WC - post install ; Mar 20, 2023@12:57:56
 ;;7.0;OUTPATIENT PHARMACY;**707**;DEC 1997;Build 18
 ;
 ; External calls:
 ;
 ; Description       ICR     Notes
 ; -----------       ------  -------
 ; Reference to NEW PERSON (#200) file (reads) in #10060
 ; Reference to OPTION (#19) file (reads) in #2246
 ; Reference to FIND1^DIC in #2051
 ; Reference to CREATE^XUSAP in #4677
 ; Reference to UPDATE^DIE in #2053
 ; Reference to BMES^XPDUTL in #10141
 ;
 ; Post Install routine for patch PSO*7.0*707
 ;
POST ; Update Proxy user with CRMS secondary menu option context
 ;
 N FDA,ERR,OIEN,IEN,PSOA
 S PSOA=$$CREATE^XUSAP("PSOVCC,APPLICATION PROXY","","PSO WEB CHART")
 ; USER found:
 I +PSOA'<0 D
 . S IEN=$$FIND1^DIC(200,,"M","PSOVCC,APPLICATION PROXY")
 . S OIEN=$$FIND1^DIC(19,,"M","PSO WEB CHART")
 . I $D(^VA(200,IEN,203,"B",OIEN)) Q  ; check for existence, Quit if found
 . S FDA(200.03,"+1,"_IEN_",",.01)=OIEN  ; add if needed
 . D UPDATE^DIE("","FDA",,"ERR")
 . I '$D(ERR) D BMES^XPDUTL("Proxy user updated successfully.") Q
 . I $D(ERR) D
 . . D BMES^XPDUTL("***********************")
 . . D BMES^XPDUTL("Proxy user not updated.")
 . . D BMES^XPDUTL("***********************")
 ; User not found:
 I +PSOA<0 D
 . D BMES^XPDUTL("*************************************")
 . D BMES^XPDUTL("APPLICATION PROXY USER not created.")
 . D BMES^XPDUTL("Please contact the Service Desk.")
 . D BMES^XPDUTL("*************************************")
 Q
