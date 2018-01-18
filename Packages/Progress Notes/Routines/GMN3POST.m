GMN3POST ;ISC-SLC/MJC;POST INIT FOR CWAD ENHANCEMENT;;12-13-94 5:06pm
 ;;2.5;Progress Notes;**34**;Jan 08, 1993
 ;Kills and then re-indexes "AJ4" x-ref for CWD indicator addendums
 W !!,"...I'll go ahead and reindex the new ""AJ4"" x-ref for you..."
 K ^GMR(121,"AJ4") S DIK="^GMR(121,",DIK(1)="3^AJ4" D ENALL^DIK
 W !!,"OK. I'm done."
 Q
