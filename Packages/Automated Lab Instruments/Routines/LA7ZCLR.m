LA7CLR ;DALISC/JRR - Process Incoming Univ Interface Messages  ; Compiled 09/30/97 03:33PM for M/WNT
 ;;5.2;LAB MESSAGING;**17,23**;Feb 29, 1996
 ; THIS MESSAGE WILL PURGE ENTRIES IN 62.49 
 ;
PURGE ;purge messages previous to today
 S LA7DAT=0
 F  S LA7DAT=$O(^LAHM(62.49,"AD",LA7DAT)) Q:'LA7DAT  D
 . S LA7DAT(0)=$G(^XTMP("LA7"_LA7DAT,0),0) ; Set flag if "problem" messages for this date are purgeable --> have been removed from XTMP.
 . S DA=0
 . F  S DA=$O(^LAHM(62.49,"AD",LA7DAT,DA)) Q:'DA  D
 . . I LA7DAT(0),$P(^LAHM(62.49,DA,0),"^",3)'="X" Q  ; Don't purge if problem message and still in XTMP global.
 . . S DIK="^LAHM(62.49," D ^DIK
 S $P(^LAHM(62.49,0),"^",3)=0
 K DA,DIK,LA7DAT
 QUIT  ;quit PURGE subroutine
 ;
Z ;LA7UIIN ;DALISC/JRR - Process Incoming Univ Interface Messages
