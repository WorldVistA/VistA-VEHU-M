DVBAUDXPD1  ;ALB/CP - KIDS Utilities;JAN 23, 2012 ; 9/20/13 2:58pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified         
 ;     $$GET1^DIQ      ; IA #2056
 ;           ^XMD      ; IA #10070
 ;      $$HTE^XLFDT    ; IA #10103
 ;        MES^XPDUTL   ; IA #10141
 ;
 Q
 ;
INSTALLD(XMY) ;Send E-Mail Notification of KIDS installation
 ; - assumes only called from a KIDS post-install.
 ; XMY    : Addressee array to receive the install message
 ;
 ; External variable maintained by the KIDS build:
 ;  XPDNM : the name of the build KIDS is now installing.
 ;
 N DIFROM
 N DVBSITE S DVBSITE=$$GET1^DIQ(8989.3,1,.01,"E")
 N XMSUB S XMSUB=XPDNM_" installed at "_DVBSITE
 N XMDUZ S XMDUZ=DUZ
 S XMY(XMDUZ)=""
 N DVBI S DVBI=0
 N XMTEXT S XMTEXT="DVBTXT(",DVBI=DVBI+1
 N DVBTXT
 S DVBI=DVBI+1,DVBTXT(DVBI)=" "
 S DVBI=DVBI+1,DVBTXT(DVBI)=XPDNM_" installed at "_$G(^XMB("NAME"))
 S DVBI=DVBI+1,DVBTXT(DVBI)=" "
 S DVBI=DVBI+1,DVBTXT(DVBI)="Installation complete: "_$$HTE^XLFDT($H)
 S DVBI=DVBI+1,DVBTXT(DVBI)="Site:  "_DVBSITE
 S DVBI=DVBI+1,DVBTXT(DVBI)="By:    "_$$GET1^DIQ(200,DUZ,.01,"E")
 S DVBI=DVBI+1,DVBTXT(DVBI)="Phone: "_$$GET1^DIQ(200,DUZ,.132,"E") ; office
 ;
 ; Send E-Mail message
 D ^XMD
 ;
 ; Send feedback to installation device and INSTALL file entry
 I $D(XMZ) D
 . D MES^XPDUTL("AMIE Installation notification message #"_XMZ_" sent.")
 . K XMZ
 E  D
 . D MES^XPDUTL("AMIE Installation notification failed: "_XMMG)
 . K XMMG
 Q
