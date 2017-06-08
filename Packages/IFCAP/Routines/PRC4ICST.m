PRC4ICST ;SLC/STAFF-SITE TRACKING SEND UPDATE TO SERVER ;3/16/93  15:10
 ;;4.0;IFCAP;;9/23/93
 ;;1.0;Site Tracking Update;;Mar 12, 1993
 ;
PAC(PKG,VER) ; from package init (A5CSTBUL installs code to call this routine)
 ; Compatable with Fileman Version 18 or greater
 ; PKG = $T(IXF) of the INIT routine.
 ; VER is an array that is contained in DIFROM from the INIT routine
 ;
 N DATE,DIFROM,DOMAIN,NOW,PACKAGE,RUN,SERVER,SITE,START,XMDUZ,XMSUB,XMTEXT,XMY,Y K ^TMP("PRC4ICST",$J)
 ;
 ; Site tracking updates only occur if run in a VA production primary domain
 ; account and having a domain for FORUM
 I $G(^XMB("NAME"))'[".VA.GOV" Q
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 I $L($G(^XMB("NAME")),".")>3 Q
 S DOMAIN=$O(^DIC(4.2,"B","FORUM")) I DOMAIN'["FORUM." Q
 ;
 S SERVER="S.A5CSTS@"_DOMAIN
 S PACKAGE=$P($P(PKG,";",3),U)
 S SITE=$G(^XMB("NAME"))
 ;  modify this to pick up start of prc4inst
 S START=$G(VER("START")) I '$L(START) S START="Unknown"
 S NOW=$$HTFM^XLFDT($H)
 S RUN="Unknown" I START S RUN=$$FMDIFF^XLFDT(NOW,START,3)
 S START=$$FMTE^XLFDT(START)
 S DATE=NOW\1
 S NOW=$$FMTE^XLFDT(NOW)
 ;
 ; Message for server
 S ^TMP("PRC4ICST",$J,1,0)="PACKAGE INSTALL"
 S ^TMP("PRC4ICST",$J,2,0)="SITE: "_SITE
 S ^TMP("PRC4ICST",$J,3,0)="PACKAGE: "_PACKAGE
 S ^TMP("PRC4ICST",$J,4,0)="VERSION: "_VER
 S ^TMP("PRC4ICST",$J,5,0)="Start time: "_START
 S ^TMP("PRC4ICST",$J,6,0)="Completion time: "_NOW
 S ^TMP("PRC4ICST",$J,7,0)="Run time: "_RUN
 S ^TMP("PRC4ICST",$J,8,0)="DATE: "_DATE
 ;
 ; Data is sent to server on FORUM - S.A5CSTS
 S XMY(SERVER)="",XMDUZ=.5,XMTEXT="^TMP(""PRC4ICST"",$J,",XMSUB=PACKAGE_" VERSION "_VER_" INSTALLATION"
 D ^XMD
 K ^TMP("PRC4ICST",$J)
 Q
