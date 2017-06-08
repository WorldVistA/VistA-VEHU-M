GMN1POST ;ISC-SLC/MJC;POST INIT FOR BATCH PRT PATCH;12-27-94 2:07pm
 ;;2.5;Progress Notes;**31**;Jan 08, 1993
 ;Kills and then re-indexes "AH" x-ref
 W !!,"...I'll go ahead and reindex the new ""AH"" x-ref for you..."
 W !!,"...While I'm at it let me also reindex the existing ""H"""
 W " x-ref as well..."
 K ^GMR(121,"AH"),^GMR(121,"H")
 S DIK="^GMR(121,",DIK(1)="3^AH^H" D ENALL^DIK K DIK
 W !!,"OK. I'm done."
 Q
