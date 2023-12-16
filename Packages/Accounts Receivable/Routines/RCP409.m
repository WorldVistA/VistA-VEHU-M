RCP409 ;AITC/DOM - Patch PRCA*4.5*371 Post Installation Processing ;20 Feb 2020 14:00:00
 ;;4.5;Accounts Receivable;**409**;Feb 20, 2020;Build 17
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 D REMDES                                       ; Remove Data exceptions
 D RECPTYPE                                     ; Add two new receipt types
 D BMES^XPDUTL("PRCA*4.5*409 post-installation finished "_$$HTE^XLFDT($H))
 Q
 ;
REMDES ; Removes Data Exceptions for all ERAs that have been removed from the worklist
 ; and have data exceptions
 N ERA,RREASON,RUSER,Z
 D MES^XPDUTL(">> Removing EOB Data Exceptions for ERAs that have been removed from the worklist...")
 ;
 S ERA=0
 F  D  Q:'ERA
 . S ERA=$O(^RCY(344.4,ERA))
 . Q:'ERA
 . Q:$P(^RCY(344.4,ERA,0),"^",14)'=4            ; ERA has not been removed from the worklist
 . S Z=$G(^RCY(344.4,ERA,6))                    ; Get removed from worklist data
 . S RUSER=$P(Z,"^",1)                          ; User who removed the ERA from the worklist
 . S RREASON=$P(Z,"^",1)                        ; Reason the ERA was removed from the worklist
 . Q:RREASON=""
 . S:$L(RREASON)<5 RREASON=RREASON_".   "       ; Make sure the reason is at least 3 characters long
 . D REMEXC^RCDPEX31(ERA,RREASON,1)             ; Remove any data exceptions
 Q
 ;
RECPTYPE ; Add new receipt type OGC-CHK and remove OGC-EFT from IOC sites
 N ERROR,RCFDA,RCIEN,RCIENS,RCJ
 ; I '$D(^RC(341.1,"B","OGC-EFT")) D  ; Check if already added
 ; . D BMES^XPDUTL("Adding new entry to AR Event Type file.")
 ; . S RCFDA(341.1,"+1,",.01)="OGC-EFT"
 ; . S RCFDA(341.1,"+1,",.02)=18
 ; . S RCFDA(341.1,"+1,",.06)=1
 ; . D UPDATE^DIE(,"RCFDA")
 ;
 I $D(^RC(341.1,"B","OGC-EFT")) D  ; Check if exists
 . D BMES^XPDUTL("Removing entry OGC-EFT from AR Event Type file.")
 . S RCIEN=$O(^RC(341.1,"B","OGC-EFT",0))
 . I RCIEN D  ;
 . . S RCFDA(341.1,RCIEN_",",.01)="@"
 . . D FILE^DIE("","RCFDA")
 ;
 I '$D(^RC(341.1,"B","OGC-CHK")) D  ; Check if already added
 . K RCFDA,RCIENS
 . D BMES^XPDUTL("Adding new entry OGC-CHK to AR Event Type file.")
 . S RCIENS(1)=19
 . S RCFDA(341.1,"+1,",.01)="OGC-CHK"
 . S RCFDA(341.1,"+1,",.02)=19
 . S RCFDA(341.1,"+1,",.06)=1
 . D UPDATE^DIE(,"RCFDA","RCIENS")
 ;
 ; Check integrity of the 341.1 file.
 S ERROR=0
 D VERIFY^PRCABJ
 I ERROR D  ;
 .  D BMES^XPDUTL("**Error in AR EVENT TYPE file**")
 .  S RCJ=""
 .  F  S RCJ=$O(ERROR(RCJ)) Q:'RCJ  D  ;
 . . D BMES^XPDUTL(ERROR(RCJ))
 I 'ERROR D  ;
 . D BMES^XPDUTL("AR EVENT TYPE file verified.")
 Q
 ;
