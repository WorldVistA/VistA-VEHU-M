SDES2DISPRECALL ;ALB/BWF,JAS - DISPOSITION RECALL REQUEST; NOV 25, 2024
 ;;5.3;Scheduling;**866,895**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ;
 ; RPC: SDES2 DISPOSITION RECALL REQ
 ;
 ; SDCONTEXT INPUT
 ;
 ;S SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ;S SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ;S SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;S SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ;S SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ;
 ; INPUT FORMAT
 ;
 ;S SDINPUT("RECALL IEN")=RECALL IEN                           REQUIRED
 ;S SDINPUT("DELETE REASON")=DELETE REASON From 403.56, 203    OPTIONAL
 ;      Can be the number or name
 ;      '1' FOR FAILURE TO RESPOND
 ;      '2' FOR MOVED
 ;      '3' FOR DECEASED
 ;      '4' FOR DOESN'T WANT VA SERVICES
 ;      '5' FOR RECEIVED CARE AT ANOTHER VA
 ;      '6' FOR OTHER
 ;      '7' FOR APPT SCHEDULED
 ;      '8' FOR VET SELF-CANCEL
 ;
 ;S SDINPUT("COMMENT")=FREE TEXT (1-80)                        OPTIONAL
 ;
DISPRECALL(JSONRETURN,SDCONTEXT,SDINPUT) ; add a disposition and delete an entry from the RECALL REMINDERS file (403.5)
 N ERRORS,FILEDATA,NOKEY,PROVIDER,NOKEY,RECALLRETURN,DELUSER
 ; validate context
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("PtCSchReqDisposition",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 S DELUSER=$S($G(SDCONTEXT("USER DUZ"))'="":SDCONTEXT("USER DUZ"),1:DUZ)
 M FILEDATA=SDINPUT
 ; validate SDINPUT
 D VALIDATE(.ERRORS,.SDINPUT,.FILEDATA)
 I $D(ERRORS) S ERRORS("PtCSchReqDisposition",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 ; edit the comment and eas fields in 403.5
 D EDIT(.FILEDATA,$G(SDCONTEXT("ACHERON AUDIT ID")))
 S PROVIDER=$$GET1^DIQ(403.5,$G(SDINPUT("RECALL IEN")),4,"I")
 S NOKEY=$$KEY($G(SDINPUT("RECALL IEN")),PROVIDER,DELUSER)
 I NOKEY D  Q    ;cannot move/delete if security key isn't present
 .D ERRLOG^SDES2JSON(.ERRORS,NOKEY)
 .S ERRORS("PtCSchReqDisposition",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS)
 ; delete 403.5 entry
 D DELETE(.ERRORS,.FILEDATA)
 I $D(ERRORS) S ERRORS("PtCSchReqDisposition",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 S RECALLRETURN("PtCSchReqDisposition","IEN")=$G(SDINPUT("RECALL IEN"))
 D BUILDJSON^SDES2JSON(.JSONRETURN,.RECALLRETURN)
 Q
 ;
VALIDATE(ERRORS,SDINPUT,FILEDATA) ;
 N VALRETURN
 D VALFILEIEN^SDES2VALUTIL(.VALRETURN,.ERRORS,403.5,$G(SDINPUT("RECALL IEN")),1,,16,17)
 ; validate disposition (optional)
 D VALFIELD^SDES2VALUTIL(.VALRETURN,.ERRORS,403.56,203,$G(SDINPUT("DELETE REASON")),,,,535)
 I VALRETURN S FILEDATA("DELETE REASON")=$G(VALRETURN(403.56,203,"I"))
 ;validate comment
 D VALFIELD^SDES2VALUTIL(.VALRETURN,.ERRORS,403.5,2.5,$G(SDINPUT("COMMENT")),,,,443)
 Q
 ;
EDIT(FILEDATA,EAS) ;
 ;replace existing comment and EAS tracking number before calling move/delete
 N LASTNOTE,SDFDA
 S LASTNOTE=$$GET1^DIQ(403.5,$G(FILEDATA("RECALL IEN"))_",",2.5,"E")
 S SDFDA(403.5,$G(FILEDATA("RECALL IEN"))_",",2.5)=$$CTRL^XMXUTIL1($G(FILEDATA("COMMENT")))
 S SDFDA(403.5,$G(FILEDATA("RECALL IEN"))_",",100)=$G(EAS)
 D FILE^DIE("","SDFDA")
 K SDFDA
 ; 403.57 COMMENT AUDIT multiple
 N LASTLENGTH,NEWLENGTH,NEWNOTE
 S LASTLENGTH=$L(LASTNOTE),NEWLENGTH=$L($G(FILEDATA("COMMENT")))
 S NEWNOTE=$E($G(FILEDATA("COMMENT")),(LASTLENGTH+1),NEWLENGTH)
 S:$E(NEWNOTE,1,1)=" " NEWNOTE=$E(NEWNOTE,2,$L(NEWNOTE))
 S CAFDA(403.57,"+1,"_$G(FILEDATA("RECALL IEN"))_",",.01)=$$NOW^XLFDT
 S CAFDA(403.57,"+1,"_$G(FILEDATA("RECALL IEN"))_",",1)=DELUSER
 S CAFDA(403.57,"+1,"_$G(FILEDATA("RECALL IEN"))_",",2)=NEWNOTE
 D UPDATE^DIE("","CAFDA") K CAFDA
 Q
 ;
DELETE(ERRORS,FILEDATA) ;delete and move entry to RECALL REMINDERS REMOVED file (403.56)
 N SDFDA,SDMSG,SDRRFTR
 S SDRRFTR=$G(FILEDATA("DELETE REASON"))
 S SDFDA(403.5,$G(FILEDATA("RECALL IEN"))_",",.01)="@"
 D FILE^DIE("","SDFDA","SDMSG")
 I $D(SDMSG) D ERRLOG^SDESJSON(.ERRORS,136,"for IEN "_$G(SDINPUT("RECALL IEN")))
 Q
 ;
KEY(RECALLIEN,RRPROVIEN,DELUSER) ;check that user has the correct SECURITY KEY
 ;INPUT:
 ; RECALLIEN - ien of the entry in RECALL REMINDERS file (403.5)
 ; RRPROVIEN - ien of the entry in the RECALL REMINDERS PROVIDERS file 403.54
 ; DELUSER   - user ien dispositioning the request
 ;RETURN
 ;  0=User has the correct SECURITY KEY
 ;  "-1^<text>" = User does not have the correct SECURITY KEY
 N KEY,RET,VALUE
 S RET=135
 I RRPROVIEN="" S RET=0
 I RRPROVIEN'="" D
 .S KEY=$$GET1^DIQ(409.54,RRPROVIEN,6,"I")
 .I KEY="" S RET=0 Q
 .S VALUE=$$LKUP^XPDKEY(KEY) N KY D OWNSKEY^XUSRB(.KY,VALUE,DELUSER)
 .I $G(KY(0))'=0 S RET=0
 Q RET
