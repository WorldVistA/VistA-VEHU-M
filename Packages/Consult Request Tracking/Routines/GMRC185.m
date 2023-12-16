GMRC185 ;WTC/ALB - LOAD DATA FOR CERNER IFCS; Jul 11, 2023@11:56:21
 ;;3.0;CONSULT/REQUEST TRACKING;**185**;DEC 27, 1997;Build 16
 ;
 ;  Use of ^XTMP supported by ICR #10103
 ;  Use of PROD^XUPROD supported by ICR #4440
 ;
 Q  ;
 ;
LOAD ;
 ;
 ;  Load Cerner patient acount numbers into REQUEST/CONSULTATION file (#123) Patient Account Number field (#502)
 ;  Load Ordering physician ID, last name, first name, middle name into Ordering Physician field (#507) in file #123
 ;  Load Cerner placer field 1 into Cerner Placer Field 1 field (#508) in file #123
 ;
 QUIT
 N I,DATA,ORDRNUM,PLACRSTN,FILLRSTN,ACCTNUM,VAMCLIST,PLACRIEN,FILLRIEN,GMRCDA,IDX,LOADED,NOTFOUND,TYPE,OBR16,UNIQUEID,OBR19,SUB,X,FILEPATH,HOSTFILE,DIR,ENV,Y ;
 ;
 K ^TMP($J),^TMP("GMRC185",$J) ;
 K ^XTMP("GMRC185") S ^XTMP("GMRC185",0)=$$FMADD^XLFDT(DT,7)_U_DT ;  ICR #10103
 ;
 S (IDX,LOADED,NOTFOUND)=0 ;
 D VAMCLIST(.VAMCLIST) ;
 ;
 ;  Open data file.
 ;
 I $$PROD^XUPROD()=1 S FILEPATH="/srv/vista/patches/SOFTWARE/" ;  ICR #4440
 E  D  Q:$D(DIRUT)  ;
 . K DIR,DIRUT S DIR(0)="S^D:DEVELOPMENT;T:IST TEST;P:PRE-PROD",DIR("A")="Installation environment" D ^DIR Q:$D(DIRUT)  S ENV=Y ;
 . S FILEPATH=$S(ENV="P":"/srv/vista/patches/SOFTWARE/",1:"/home/sftp/patches/") ;
 ;
 ;S FILEPATH=$S($$PROD^XUPROD()=1:"/srv/vista/patches/SOFTWARE/",1:"/home/sftp/patches/") ;  ICR #4440
 S HOSTFILE="gmrc_3_185.dat" ;
 D OPEN^%ZISH(,FILEPATH,HOSTFILE,"R") I POP S XPDABORT=1,XPDQUIT=1 D BMES^XPDUTL("Cannot open host file "_HOSTFILE_" on "_FILEPATH) Q  ;
 ;
 ;  Read and process data records.
 ;
 S ^TMP("GMRC185",$J,"NOT FOUND")=0,^TMP("GMRC185",$J,"LOADED")=0 ;
 F I=1:1 U IO Q:$$STATUS^%ZISH  R DATA:1 Q:DATA=""  D PROCESS(DATA) ;
 D CLOSE^%ZISH ;
 ;
 ;  Send mail message
 ;
 S NOTFOUND=^TMP("GMRC185",$J,"NOT FOUND"),LOADED=^TMP("GMRC185",$J,"LOADED") ;
 ;
 I $D(^TMP($J,"MATCHED")) D  ;
 . ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="===============================================================================" ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)=LOADED_" CONSULT"_$S(LOADED'=1:"S",1:"")_" UPDATED.",IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="" ;
 . ;S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="TYPE    UNIQUE ID        ACCOUNT NUMBER",IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="------  ---------------  --------------" ;
 . ;S GMRCDA=0 ;
 . ;F  S GMRCDA=$O(^TMP($J,"MATCHED",GMRCDA)) Q:'GMRCDA  S X=^(GMRCDA),UNIQUEID=$$GET1^DIQ(123,GMRCDA,80),IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)=$P(X,U,1)_"  "_UNIQUEID_$J("",15-$L(UNIQUEID))_"  "_$P(X,U,5) ;
 ;
 I $D(^TMP($J,"UNMATCHED")) D  ;
 . ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="===============================================================================" ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)=NOTFOUND_" ORDER"_$S(NOTFOUND'=1:"S",1:"")_" NOT FOUND.",IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="" ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="ORDER NUMBER             SITE            ACCOUNT NUMBER",IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="-----------------------  -----------     --------------" ;
 . F I=1:1:NOTFOUND S X=^TMP($J,"UNMATCHED",I),TYPE=$P(X,U,1),ORDRNUM=$P(X,U,2),PLACRSTN=$P(X,U,3),FILLRSTN=$P(X,U,4),ACCTNUM=$P(X,U,5),OBR16=$P(X,U,6,9),OBR19=$P(X,U,10),OBR20=$P(X,U,11),OBR27=$P(X,U,12) D  ;
 .. I TYPE="PLACER" S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)=ORDRNUM_$J("",25-$L(ORDRNUM))_TYPE_": "_PLACRSTN_$J("",8-$L(PLACRSTN))_ACCTNUM,IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="" Q  ;
 .. Q:TYPE'="FILLER"  ;
 .. S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)=ORDRNUM_$J("",25-$L(ORDRNUM))_TYPE_": "_FILLRSTN_$J("",8-$L(FILLRSTN))_ACCTNUM_$J("",20-$L(ACCTNUM)) ;
 .. I OBR16'="" S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="     ORDERING PHYSICIAN: "_OBR16 ;
 .. I OBR19'="" S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="     CERNER PLACER FIELD 1: "_OBR19 ;
 .. I OBR20'="" S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="   OPT IN FOR FINAL STATUS: "_OBR20 ;
 .. I OBR27'="" S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="       PERFORMED DATE/TIME: "_OBR27 ;
 .. S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="" Q  ;
 ;
 I IDX=0 D  ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="===============================================================================" ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="No matching records for station "_$P($$SITE^VASITE(),U,3) ;
 . S IDX=IDX+1,^TMP("GMRC185",$J,IDX,0)="===============================================================================" ;
 ;
 N XMY,XMDUZ,XMSUB,XMTEXT ;
 S XMY(DUZ)="",XMY("G.OR CACS")="" ;
 S XMSUB="GMRC*3.0*185 LOAD REPORT ("_$$FMTE^XLFDT(DT)_")",XMTEXT="^TMP(""GMRC185"",$J)" ;
 D SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY) ;
 ;
 K ^TMP($J),^TMP("GMRC185",$J) Q  ;
 ;
PROCESS(DATA) ;
 ;
 N ORDRNUM,PLACRSTN,FILLRSTN,ACCTNUM,OBR16,OBR19,FILLRIEN,PLACRIEN,GMRCDA,TYPE,NOTFOUND,OBR20,OBR27 ;
 ;
 F  Q:$E(DATA,1)'=" "  S DATA=$E(DATA,2,$L(DATA)) ;
 F  Q:$E(DATA,$L(DATA))'=" "  S DATA=$E(DATA,1,$L(DATA)-1) ;
 ;
 ;  Extract order number, placer and filler stations, account number, ordering provider (OBR16) and ordering description (OBR19).
 ;
 S ORDRNUM=$P(DATA,U,1),PLACRSTN=$P(DATA,U,2),FILLRSTN=$P(DATA,U,3),ACCTNUM=$P(DATA,U,4),OBR16=$P(DATA,U,5,8),OBR19=$P(DATA,U,9),OBR20=$P(DATA,U,10),OBR27=$P(DATA,U,11) ;
 Q:PLACRSTN=""  Q:PLACRSTN="N/A"  Q:FILLRSTN=""  Q:FILLRSTN="N/A"  ;
 S FILLRIEN=$$IEN^XUAF4(FILLRSTN),PLACRIEN=$$IEN^XUAF4(PLACRSTN) ;
 ;
 Q:'FILLRIEN  Q:'PLACRIEN  ; Skip if stations not in file #4
 ;
 I '$D(VAMCLIST(FILLRIEN)),'$D(VAMCLIST(PLACRIEN)) Q  ;  Skip processing if this VistA is neither placer nor filler.
 ;
 ;  Look up consult for the remote order number.  If site is filler, remote order number is the placer's order number.  If site is placer, remote order number is the filler's order number.
 ;
 I $D(VAMCLIST(PLACRIEN)) S GMRCDA=$O(^GMR(123,"AIFC",FILLRIEN,ORDRNUM,0)),TYPE="PLACER" ;
 I $D(VAMCLIST(FILLRIEN)) S GMRCDA=$O(^GMR(123,"AIFC",PLACRIEN,ORDRNUM,0)),TYPE="FILLER" ;
 ;
 ;  Update field #502.  Update fields #507 and #508 if site is filler.  Create list of updated consults.
 ;
 I GMRCDA D  Q  ;
 . ; 
 . ;  Save data for back out
 . ;
 . S $P(^XTMP("GMRC185",GMRCDA,"CERNER"),U,3)=$P($G(^GMR(123,GMRCDA,"CERNER")),U,3) ;
 . S $P(^XTMP("GMRC185",GMRCDA,"CERNER"),U,11)=$P($G(^GMR(123,GMRCDA,"CERNER")),U,11) ;
 . S $P(^XTMP("GMRC185",GMRCDA,"CERNER"),U,12)=$P($G(^GMR(123,GMRCDA,"CERNER")),U,12) ;
 . S ^XTMP("GMRC185",GMRCDA,"CERNER1")=$G(^GMR(123,GMRCDA,"CERNER1")),^XTMP("GMRC185",GMRCDA,"CERNER2")=$G(^GMR(123,GMRCDA,"CERNER2")) ;
 . ;
 . ;  Update consult file (#123)
 . ;
 . S $P(^GMR(123,GMRCDA,"CERNER"),U,3)=ACCTNUM,$P(^("CERNER"),U,11)=OBR20,$P(^("CERNER"),U,12)=OBR27 ;
 . S ^GMR(123,GMRCDA,"CERNER1")=OBR16,^("CERNER2")=OBR19 ;
 . S ^TMP("GMRC185",$J,"LOADED")=^TMP("GMRC185",$J,"LOADED")+1 ;
 . ;
 . ;  Save data for mail message
 . ;
 . S ^TMP($J,"MATCHED",GMRCDA)=TYPE_U_ORDRNUM_U_PLACRSTN_U_FILLRSTN_U_ACCTNUM_U_OBR16_U_OBR19_U_OBR20_U_OBR27 ;
 ;
 ;  Store list of orders that couldn't be matched to the Consult file.
 ;
 S NOTFOUND=^TMP("GMRC185",$J,"NOT FOUND")+1,^("NOT FOUND")=NOTFOUND,^TMP($J,"UNMATCHED",NOTFOUND)=TYPE_U_ORDRNUM_U_PLACRSTN_U_FILLRSTN_U_ACCTNUM_U_OBR16_U_OBR19_U_OBR20_U_OBR27 ;
 Q  ;
 ;
VAMCLIST(RTNLIST) ; from EHMUTILS
 ;
 ;  Returns list of VAMCs associated with a VistA instance.  e.g., RTNLIST(ien)=Station Number.
 ;
 N SITEIEN S SITEIEN=$P($$SITE^VASITE(),U,1) ;
 S RTNLIST(SITEIEN)=$P($$SITE^VASITE(),U,3) ;
 ;
 N SUBSITE S SUBSITE=0 F  S SUBSITE=$O(^DIC(4,"AC",2,SITEIEN,SUBSITE)) Q:'SUBSITE  D  ;
 . Q:$$GET1^DIQ(4,SUBSITE,101,"I")=1  ;
 . I $$GET1^DIQ(4,SUBSITE,13)="VAMC" S RTNLIST(SUBSITE)=$$GET1^DIQ(4,SUBSITE,99) Q  ;
 . I $$GET1^DIQ(4,SUBSITE,99)="358" S RTNLIST(SUBSITE)="358" Q  ;  Manila is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="402" S RTNLIST(SUBSITE)="402" Q  ;  Togus, ME is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="405" S RTNLIST(SUBSITE)="405" Q  ;  White River Junction, VT is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="436GH" S RTNLIST(SUBSITE)="436GH" Q  ;  Billings, MT is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="437" S RTNLIST(SUBSITE)="437" Q  ;  Fargo, ND is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="438" S RTNLIST(SUBSITE)="438" Q  ;  Sioux Falls, SD is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="442" S RTNLIST(SUBSITE)="442" Q  ;  Cheyenne, WY is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="459" S RTNLIST(SUBSITE)="459" Q  ;  Honolulu, HI is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="460" S RTNLIST(SUBSITE)="460" Q  ;  Wilmington, DE is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="463" S RTNLIST(SUBSITE)="463" Q  ;  Anchorage AK is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="636A5" S RTNLIST(SUBSITE)="636A5" Q  ;  Lincoln NE is a division but not a VAMC
 . I $$GET1^DIQ(4,SUBSITE,99)="756" S RTNLIST(SUBSITE)="756" Q  ;  El Paso, TX is a division but not a VAMC
 ;
 ;  VAMCs that are not parents of themselves but are VistA sites and, therefore, divisions
 ;
 I $$GET1^DIQ(4,SITEIEN,99)="436" S RTNLIST(SITEIEN)="436" Q  ;  Fort Harrison, MT
 I $$GET1^DIQ(4,SITEIEN,99)="512" S RTNLIST(SITEIEN)="512" Q  ;  Baltimore, MD
 I $$GET1^DIQ(4,SITEIEN,99)="520" S RTNLIST(SITEIEN)="520" Q  ;  Biolxi, MS
 I $$GET1^DIQ(4,SITEIEN,99)="537" S RTNLIST(SITEIEN)="537" Q  ;  Chicago, IL
 I $$GET1^DIQ(4,SITEIEN,99)="561" S RTNLIST(SITEIEN)="561" Q  ;  East Orange, NJ
 I $$GET1^DIQ(4,SITEIEN,99)="562" S RTNLIST(SITEIEN)="562" Q  ;  Erie, PA
 I $$GET1^DIQ(4,SITEIEN,99)="646" S RTNLIST(SITEIEN)="646" Q  ;  Pittsburg, PA
 I $$GET1^DIQ(4,SITEIEN,99)="652" S RTNLIST(SITEIEN)="652" Q  ;  Richmond, VA
 I $$GET1^DIQ(4,SITEIEN,99)="657" S RTNLIST(SITEIEN)="657" Q  ;  St. Louis, MO
 I $$GET1^DIQ(4,SITEIEN,99)="688" S RTNLIST(SITEIEN)="688" Q  ;  Washington, DC
 ;
 Q  ;
 ;
BACKOUT ;
 ;
 ;  Back out changes made to file #123.
 ;
 N GMRCDA ;
 ;
 I '$D(^XTMP("GMRC185")) W !!,"No data on file to be restored.",! Q  ;
 ;
 ;  Scan saved data and restore original values to consult file (#123).
 ;
 S GMRCDA=0 F  S GMRCDA=$O(^XTMP("GMRC185",GMRCDA)) Q:'GMRCDA  D  ;
 . S $P(^GMR(123,GMRCDA,"CERNER"),U,3)=$P(^XTMP("GMRC185",GMRCDA,"CERNER"),U,3) ;
 . S $P(^GMR(123,GMRCDA,"CERNER"),U,11)=$P(^XTMP("GMRC185",GMRCDA,"CERNER"),U,11) ;
 . S $P(^GMR(123,GMRCDA,"CERNER"),U,12)=$P(^XTMP("GMRC185",GMRCDA,"CERNER"),U,12) ;
 . S ^GMR(123,GMRCDA,"CERNER1")=$G(^XTMP("GMRC185",GMRCDA,"CERNER1")),^GMR(123,GMRCDA,"CERNER2")=$G(^XTMP("GMRC185",GMRCDA,"CERNER2")) ;
 . W "." ;
 ;
 W !!,"Data restored.",! K ^XTMP("GMRC185") ;
 Q  ;
