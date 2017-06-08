A2APSTU ;WASH/PEH - SITE TRACKING UPDATE ;8/9/01  07:20
 ;;1.0;;;
ALL ;
 W !,"This utility will check the install file (9.7) for the patches"
 W !,"installed at your site.  This information will be used to update the site"
 W !,"tracking file on FORUM."
 W !!,"The data collected is determined by the data in your Build and Install",!,"files and will only contain data since the last time you ran the ",!,"Purge data option."
 W !!,"This routine should only be used in your production account."
 W !!,"The data collected will be sent to FORUM automatically via MailMan."
 ;
 K DIC,DIR
 I $G(^XMB("NETNAME"))'[".VA.GOV" D BMES^XPDUTL("This routine should only be used in a VA primary domain") Q
 X ^%ZOSF("UCI") S %=^%ZOSF("PROD") S:%'["," Y=$P(Y,",") I Y'=% D BMES^XPDUTL("This routine must be run in a production account.") Q
 S DIR(0)="YAM",DIR("A")="Proceed to collect data for site tracking? ",DIR("B")="YES" D ^DIR K DIR Q:Y'=1
 S ZTRTN="TASK^A2ASTU",ZTDESC="SITE TRACKING PATCH UPDATE",ZTIO="",ZTSAVE("DUZ")="" D ^%ZTLOAD W !!,"Job started in background" Q
TASK ;get data then send message
 N PD0,PD1,DIC,DIR,LCD,LCP,SERVER,SITE,PFL,PFL1,PNUM,XMDUZ,XMSUB,XMTEXT,XPD,XPD0,XPD1,XPDTEXT,XPDV,XPZ,X,Y
 S SITE=^XMB("NETNAME"),LCD=$P(^XPD(9.6,0),"^",5) S:'LCD LCD=0
 S PD0=0 F  S PD0=$O(^XPD(9.6,PD0)) Q:'PD0  S PD1=$G(^(PD0,0)) D
 .Q:$P(PD1,"^",5)'="y"  ;not tracked nationally
 .S PNUM=$P(PD1,"^",1),PFL=0,PFL1="" F  S PFL=$O(^XPD(9.7,"B",PNUM,PFL)) Q:'PFL  S:$D(^XPD(9.7,PFL,1)) PFL1=PFL
 .Q:PFL1=""!(PFL1<0)  ;Patch has been loaded but not installed
 .S XPD0=^XPD(9.7,PFL1,0),XPD1=$G(^(1))
 .Q:'$P(XPD0,U,2)  ;No link to PACKAGE file from Install
 .S XPD=$P($G(^DIC(9.4,+$P(XPD0,U,2),0)),U),XPDV=$$VER^XPDUTL($P(XPD0,U))
 .Q:XPD=""  ;PACKAGE file entry missing
 .;XPZ(1)=start, XPZ(2)=completion date/time, XPZ(3)=run time
 .S XPZ(1)=$P(XPD1,U),XPZ(2)=$P(XPD1,U,3)
 .Q:XPZ(2)<LCD  ;Last complied date
 .S XPZ(3)=$$FMDIFF^XLFDT(XPZ(2),XPZ(1),3),XPZ(1)=$$FMTE^XLFDT(XPZ(1)) ;,XPZ(2)=$$FMTE^XLFDT(XPZ(2))
 .D FORUM H 1 Q
 S $P(^XPD(9.6,0),"^",5)=DT Q
 ;
FORUM ;send to Server on FORUM
 S XMY("S.A5CSTS@FORUM.VA.GOV")=""
 ;Message for server
 S XPDTEXT(1,0)="PACKAGE INSTALL"
 S XPDTEXT(2,0)="SITE: "_SITE
 S XPDTEXT(3,0)="PACKAGE: "_XPD
 S XPDTEXT(4,0)="VERSION: "_XPDV
 S XPDTEXT(5,0)="Start time: "_XPZ(1)
 S XPDTEXT(6,0)="Completion time: "_XPZ(2)
 S XPDTEXT(7,0)="Run time: "_XPZ(3)
 S XPDTEXT(8,0)="DATE: "_$P(XPZ(2),".",1)
 S XPDTEXT(9,0)="Installed by: "_$P($G(^VA(200,+$P(XPD0,U,11),0)),U)
 S XPDTEXT(10,0)="Install Name: "_$P(XPD0,U)
 S XPDTEXT(11,0)="Distribution Date: "_$P(XPD1,U,4)
 S XPDTEXT(12,0)="Previously installed"
 S XMDUZ=$S($D(DUZ):DUZ,1:.5),XMTEXT="XPDTEXT(",XMSUB=$P(XPD0,U)_" INSTALLATION"
 D ^XMD
 ;W ! F III=3:1:11 W !,XPDTEXT(III,0)
 Q
 ;
