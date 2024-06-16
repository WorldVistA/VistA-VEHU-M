PXRMP86I ;SLC/PKR - Inits for PXRM*2.0*86 ;01/19/2024
 ;;2.0;CLINICAL REMINDERS;**86**;Feb 04, 2005;Build 9
 Q
 ;====================================================
PRE ;These are the pre-installation actions
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*86")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*86")
 Q
 ;
 ;====================================================
POST ;These are the post-installation actions
 D DUPFIX^PXRMDLGBREPAIR
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*86")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*86")
 D SENDIM^PXRMMSG("PXRM*2.0*86")
 Q
 ;
