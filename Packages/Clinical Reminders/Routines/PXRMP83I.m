PXRMP83I ;ISP/AGP - PATCH 83 INSTALLATION ;10/06/2022
 ;;2.0;CLINICAL REMINDERS;**83**;Feb 04, 2005;Build 14
 ;
POST ;Post-init
 ;Install Exchange File entries.
 D RENAME
 ;Enable options and protocols
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*83")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*83")
 Q
 ;
PRE ;Pre-init
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*83")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*83")
 Q
 ;
RENAME ;
 D MES^XPDUTL("Renaming LGBTQ general findings")
 D RENAME^PXRMUTIL(801.46,"LGBTQ NO ANSWER","SO NO ANSWER")
 D RENAME^PXRMUTIL(801.46,"LGBTQ DESCRIPTION","SO DESCRIPTION")
 D RENAME^PXRMUTIL(801.46,"LGBTQ OTHER","SO OTHER")
 D RENAME^PXRMUTIL(801.46,"LGBTQ UNKNOWN","SO UNKNOWN")
 D RENAME^PXRMUTIL(801.46,"LGBTQ QUEER","SO QUEER")
 D RENAME^PXRMUTIL(801.46,"LGBTQ BISEXUAL","SO BISEXUAL")
 D RENAME^PXRMUTIL(801.46,"LGBTQ STRAIGHT","SO STRAIGHT")
 D RENAME^PXRMUTIL(801.46,"LGBTQ HOMOSEXUAL","SO HOMOSEXUAL")
 D RENAME^PXRMUTIL(801.46,"LGBTQ SEXUAL ORIENTATION RECORD ID","SO SEXUAL ORIENTATION RECORD ID")
 D MES^XPDUTL("   Done")
 Q
 ;
