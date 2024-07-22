RCP436 ;AITC/CJE - Patch PRCA*4.5*436 Post Installation Processing ;20 Feb 2020 14:00:00
 ;;4.5;Accounts Receivable;**436**;Feb 20, 2020;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 D RECPTYPE                                     ; Add OGC-EFT receipt type
 D BMES^XPDUTL("PRCA*4.5*436 post-installation finished "_$$HTE^XLFDT($H))
 Q
 ;
RECPTYPE ; Add new receipt type OGC-CHK and remove OGC-EFT from IOC sites
 N ERROR,RCFDA,RCIEN,RCIENS,RCJ
 ;
 I '$D(^RC(341.1,"B","OGC-EFT")) D  ; Check if already added
 . S RCIENS(1)=18
 . D BMES^XPDUTL("Adding new entry 'OGC-EFT' to AR Event Type file.")
 . S RCFDA(341.1,"+1,",.01)="OGC-EFT"
 . S RCFDA(341.1,"+1,",.02)=18
 . S RCFDA(341.1,"+1,",.06)=1
 . D UPDATE^DIE(,"RCFDA","RCIENS")
 ;
 ; Check integrity of the 341.1 file.
 S ERROR=0
 D VERIFY^PRCABJ
 I ERROR D  ;
 .  D BMES^XPDUTL("**Error verifying AR reference files**")
 .  S RCJ=""
 .  F  S RCJ=$O(ERROR(RCJ)) Q:'RCJ  D  ;
 . . D BMES^XPDUTL(ERROR(RCJ))
 I 'ERROR D  ;
 . D BMES^XPDUTL("AR reference files verified.")
 Q
