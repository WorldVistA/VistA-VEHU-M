PXRMP88I ;SLC/PKR - Inits for PXRM*2.0*88 ;05/31/2024
 ;;2.0;CLINICAL REMINDERS;**88**;Feb 04, 2005;Build 13
 Q
 ;====================================================
PRE ;These are the pre-installation actions
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*88")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*88")
 Q
 ;
 ;====================================================
POST ;These are the post-installation actions
 D DUPFIX^PXRMDLGBREPAIR
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*88")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*88")
 D SENDIM^PXRMMSG("PXRM*2.0*88")
 Q
 ;
