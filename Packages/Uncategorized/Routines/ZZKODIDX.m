ZZKODIDX ;ASM/SRG -- Re-index file after global imports
 ;;1.0;ZZ KODAK IMPORT;;Sep 01, 2011;Build 4
 Q
ENV ; Environment check routine - kill cross-references before import
 G IDX2
 Q
 ;
IDX
 S DIK="^GMR(120.5," F DA=30233:1:30247 D IX^DIK   ; Vitals
 S DIK="^GMR(120.8," F DA=1004:1:1006 D IX^DIK   ; Allergies
 S DIK="^TIU(8925," F DA=11771:1:11775 D IX^DIK  ; Documents
 S DIK="^AUPNVSIT(",DA=11888 D IX^DIK ; Visits
 Q
 ;
IDX2
 S DIK="^GMR(120.5," F DA=30233:1:30247 D IX2^DIK   ; Vitals
 S DIK="^GMR(120.8," F DA=1004:1:1006 D IX2^DIK   ; Allergies
 S DIK="^TIU(8925," F DA=11771:1:11775 D IX2^DIK  ; Documents
 S DIK="^AUPNVSIT(",DA=11888 D IX2^DIK ; Visits
 Q
 
