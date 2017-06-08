ZZPANIDX ;ASM/SRG -- Re-index file after global imports
 ;;1.0;ZZ PANORAMA IMPORT;;Sep 01, 2011;Build 3
 Q
ENV ; Environment check routine - kill cross-references before import
 G IDX2
 Q
 ;
IDX
 S DIK="^GMR(120.5," F DA=30217:1:30232 D IX^DIK ; Vitals
 S DIK="^TIU(8925," F DA=11768:1:11770 D IX^DIK  ; Documents
 Q
 ;
IDX2
 S DIK="^GMR(120.5," F DA=30217:1:30232 D IX2^DIK ; Vitals
 S DIK="^TIU(8925," F DA=11768:1:11770 D IX2^DIK  ; Documents
 Q
 
