EVETU1 ;SLC/GPM - Utility procedures for Health eVet namespace ; 2/24/04 1:15pm
 ;;1.0;HEALTH EVET;**1,2**;Nov 05, 2002
 ;
VER(EVVER,EVPATCH) ;returns the current version number and patch number
 ;for the application
 ;S EVVER="1.0"
 ;S EVPATCH="1 TEST v14"
 N NUM,VER,PAT,EVFLAG
 S NUM="A",EVFLAG=0
 F  S NUM=$O(^XPD(9.7,NUM),-1) Q:NUM<1!(EVFLAG)  D
 . I $P($G(^XPD(9.7,NUM,0)),"^")'["EVET" Q
 . S VER=$P(^XPD(9.7,NUM,0),"^",1),EVFLAG=1
 . S EVPATCH=$P($G(^XPD(9.7,NUM,2)),"*",3)
 . I EVPATCH="" S EVPATCH=$P(VER,"*",3)
 . S EVVER=$$GET1^DIQ(9.4,$P(^XPD(9.7,NUM,0),"^",2),13)
 . I EVVER<1 S EVVER=$P(VER,"*",2)
 Q
 ;
SITEPRMS(EVIP,EVPORT,EVTSITE,EVSITEN) ;system common values stored in
 ;file 2276.999. Record key = "SYS"
 ; EVIP - IP address of server
 ; EVPORT - Port to use when contacting server
 ; EVTSITE - Y/N value identifying system as test (Y) or production (N)
 ; EVSITEN - site value for test ie 99996 (sample)
 N REC,EVKEY
 S EVKEY="SYS"
 K ^TMP("DIERR",$J) K ^TMP("DILIST",$J)
 D FIND^DIC(2276.999,"","@;.02;.03;.04I;.05;","ABP",EVKEY,"B","","","")
 I ($D(^TMP("DIERR",$J))'=0)!($P(^TMP("DILIST",$J,0),"^",1)=0) S EVPORT="",EVIP="",EVTSITE="",EVSITEN="" Q
 S REC=^TMP("DILIST",$J,1,0)
 S EVIP=$P(REC,"^",2)
 S EVPORT=$P(REC,"^",3)
 S EVTSITE=$P(REC,"^",4)
 S EVSITEN=$P(REC,"^",5)
 Q
REGLST ; called from EVET PRINT REGISTER
 ; print all contained in the  Health eVet register
 N FLDS,BY
 W !!?27,"HEALTH eVET REGISTER LIST",!!
 S DIC=2275,(FLDS)="[EVET REGLST]",BY="VETERAN"
 K %ZIS
 D EN1^DIP
 K DIC
 Q
 ;
XMLDATE(EVETX) ; convert fm date to yyyy-mm-ddThh:mm
 ;modified to always have 2 digit month, day, hr, min & add seconds
 N X,Y
 S EVETX=$TR($$FMTE^XLFDT(EVETX,7),"/","-")
 S EVETX=$TR(EVETX,"@","T")
 ;add leading zero to month
 S Y=$P(EVETX,"T",1),X=$P(Y,"-",2)
 I $L(X)=1 D
 . S $P(Y,"-",2)="0"_X
 . S $P(EVETX,"T",1)=Y
 . Q
 ;add leading zero to day
 S Y=$P(EVETX,"T",1),X=$P(Y,"-",3)
 I $L(X)=1 D
 . S $P(Y,"-",3)="0"_X
 . S $P(EVETX,"T",1)=Y
 . Q
 ;add zeroes to time elements
 S X=$P(EVETX,"T",2)
 I $L(X)>0 D
 . I $L($P(X,":",1))=1 S $P(X,":",1)="0"_$P(X,":",1)
 . I $L($P(X,":",2))=1 S $P(X,":",2)="0"_$P(X,":",2)
 . I $L($P(X,":",2))=0 S $P(X,":",2)="00"
 . I $L($P(X,":",3))=1 S $P(X,":",3)="0"_$P(X,":",3)
 . I $L($P(X,":",3))=0 S $P(X,":",3)="00"
 . S $P(EVETX,"T",2)=X
 . Q
 Q EVETX
 ;
CONVDT(DT) ;converts date from "4/16/2002 8:50:35AM" format to yyyy-mm-ddT01:01:01
 N MM,DD,YY,HH,MN,SS,DAT,AP,TIM
 I DT="" Q ""
 S DAT=$P(DT," ",1),TIM=$P(DT," ",2)
 S MM=$P(DAT,"/",1),DD=$P(DAT,"/",2),YY=$P(DAT,"/",3)
 S HH=$P(TIM,":",1),MN=$P(TIM,":",2),SS=$E($P(TIM,":",3),1,2),AP=$E($P(TIM,":",3),3,4)
 S:HH="" HH="01"
 S:MN="" MN="00"
 S:SS="" SS="00"
 S HH="0"_HH,HH=$E(HH,$L(HH)-1,$L(HH))
 S MN="0"_MN,MN=$E(MN,$L(MN)-1,$L(MN))
 S DD="0"_DD,DD=$E(DD,$L(DD)-1,$L(DD))
 S MM="0"_MM,MM=$E(MM,$L(MM)-1,$L(MM))
 S:AP="PM" HH=HH+12
 S DAT=YY_"-"_MM_"-"_DD_"T"_HH_":"_MN_":"_SS
 Q DAT
REGCHK ; check to see if outstanding responses from Health eVet exist
 ; this procedure called from option - EVET CHECK FOR ACTIVATION RESPONSES
 N EVIDFN,EV2275DA,EVCURMSG,EVETZ,EVETNM,EVIDFN,EVETICN,EVUSRNM,EVPASSWD,EVEMAIL,EVCURMSG,EVRESP,EVACTIV
 W !!,"*** Checking for received messages. ***"
 S EV2275DA=0 F  S EV2275DA=$O(^EVET(2275,EV2275DA)) Q:EV2275DA<1  Q:EV2275DA="B"  D
 . K EVETZ
 . D GETS^DIQ(2275,EV2275DA_",",".01;.03:.06;1;2","EI","EVETZ","")
 . I $G(EVETZ(2275,EV2275DA_",",.03,"I"))="Y" Q
 . S EVETNM=EVETZ(2275,EV2275DA_",",.01,"E")
 . S EVIDFN=EVETZ(2275,EV2275DA_",",.01,"I")
 . S EVETICN=$$GETICN^MPIF001(EVIDFN)
 . S EVUSRNM=EVETZ(2275,EV2275DA_",",.04,"E")
 . S EVPASSWD=EVETZ(2275,EV2275DA_",",.05,"E")
 . S EVEMAIL=EVETZ(2275,EV2275DA_",",.06,"E")
 . S EVCURMSG=$G(EVETZ(2275,EV2275DA_",",1,"E"))
 . S EVRESP=EVETZ(2275,EV2275DA_",",2,"E")
 . W !!?5,"Health eVet response to transmission of the"
 . W !?5,"Veteran's registration information >>> "_EVRESP,!
 . S EVACTIV="N"
 . I (EVRESP'["Ok")&(EVCURMSG'="") W !,?5,"Error: ",EVCURMSG D USRERR^EVETR1
 . I EVRESP["Ok" D USRINFO^EVETR1 S EVACTIV="Y"
 . D RESET(EV2275DA,EVACTIV,EVRESP)
 I '$D(EVRESP) W !,"No pending Health eVet responses exist at this time."
 Q
 ;
RESET(EV2275DA,EVACTIV,EVRESP) ; reset activation status to inactive
 ; file reason for not being activated
 ; when Health eVet does not respond or receives an exception to 
 ; VistA transmission of Veteran registration information
 N FDA
 L +^EVET(2275,EV2275DA):0 ;lock file entry
 S FDA(1,2275,EV2275DA_",",.03)=EVACTIV  ; file active status
 I EVRESP'="" S FDA(1,2275,EV2275DA_",",1)=EVRESP ;file not active reason
 D FILE^DIE("","FDA(1)","")
 L -^EVET(2275,EV2275DA)
 Q
EVETDEL ;Removes entries in ^EVET(2276) > 7 days old
 N EDT,NDX,CHKDT
 S EDT="",NDX=""
 S CHKDT=$P($$NOW^XLFDT(),".",1)-7
 D EDLOOP
 Q
EDLOOP S EDT=$O(^EVET(2276,"C",EDT)) Q:EDT=""  Q:EDT>CHKDT  D EDL1 K ^EVET(2276,"C",EDT) G EDLOOP
EDL1 S NDX=$O(^EVET(2276,"C",EDT,NDX)) Q:NDX=""  D EDL2 G EDL1
EDL2 K ^EVET(2276,"B",NDX)
 K ^EVET(2276,NDX,0)
 Q
PWDFMT(PWD) ;check password for correct format
 ;at least 8 characters long
 ;first character alpha
 ;contains at least one numeric
 ;contains at least one $#!^%?~-_
 ;failure returns nil as password
 N I,NOK,OOK,BADCHAR
 I $L(PWD)<8 S PWD="" Q
 I $E(PWD)'?1A S PWD="" Q
 S NOK=0,OOK=0,BADCHAR=0
 F I=1:1:$L(PWD) D
 . I $E(PWD,I)?1A Q
 . I $E(PWD,I)?1N S NOK=1 Q
 . I "$#!^%?~-_"[$E(PWD,I) S OOK=1 Q
 . S BADCHAR=1
 . Q
 ;erase password if error found
 I (NOK=0)!(OOK=0)!(BADCHAR=1) S PWD=""
 Q
IDFMT(ID) ;check user id for correct format
 ;6 to 12 characters long
 ;first char alpha
 ;alpha & numeric only
 N I,BADCHAR
 I $L(ID)<6 S ID="" Q
 I $L(ID)>12 S ID="" Q
 I $E(ID)'?1A S ID="" Q
 S BADCHAR=0
 F I=1:1:$L(ID) D
 . I $E(ID,I)?1A Q
 . I $E(ID,I)?1N Q
 . S BADCHAR=1
 . Q
 I BADCHAR=1 S ID=""
 Q
 ;
ALERT(MSG) ; Send messages for important events
 N TEXT,XMDUN,XMDUZ,XMTEXT,XMROU,XMSTRIP,XMSUB,XMY,XMZ,XMDF,EVERR,SITE
 S XMDF="",(XMDUN,XMDUZ)="Health eVet Package"
 S XMY("G.EVET HEALTH EVET ALERTS")=""
 S SITE=+$$SITE^VASITE
 S SITE=$$GET1^DIQ(4,SITE_",",.01)
 S EVERR=""
 I $D(^TMP("EVET_XML_PARSE",$J,0,"ERROR","result")) S EVERR=^("result")
 I $D(^TMP("EVET_XML_PARSE",$J,1,"ERROR","result")) S EVERR=^("result")
 I $D(^TMP("EVET_XML_PARSE",$J,2,"ERROR","result")) S EVERR=^("result")
 I EVERR="" S EVERR="Error not captured."
 ;
 ; Message - Download failure
 ; Called from error trap in EVETLID
 I MSG="DOWNLOAD" D
 .S XMSUB=SITE_" Health eVet download failure"
 .S XMTEXT="TEXT("
 .S TEXT(1)="The download for Health eVet failed."
 .S TEXT(2)="Non recoverable error.  Download process halted."
 .S TEXT(3)="Please check Error Processing."
 .S TEXT(4)=" "
 .S TEXT(5)="Veteran: "_$S($G(EVDFN)>0:$P(^DPT(EVDFN,0),"^"),1:"?")
 .S TEXT(6)="Request: "_$S($G(EVREQ)'="":EVREQ,1:"?")
 ;
 ; Message - Extract failure
 ; Called from extract error trap in EVETU1
 I MSG="EXTRACT"
 .S XMSUB=SITE_" Health eVet extract failure"
 .S XMTEXT="TEXT("
 .S TEXT(1)="An extract for Health eVet failed."
 .S TEXT(2)="Data was not successfully extracted from "_$G(EVREQI)
 .S TEXT(3)="Please check Error Processing."
 .S TEXT(4)=" "
 .S TEXT(5)="Veteran: "_$S($G(EVDFN)>0:$P(^DPT(EVDFN,0),"^"),1:"?")
 .S TEXT(6)="Request: "_$S($G(EVREQ)'="":EVREQ,1:"?")
 ;
 ; Message - Transmission Failure
 ; Called from check response code in EVETLID1
 I MSG="TRANSMIT" D
 .S XMSUB=SITE_" Health eVet transmission failure"
 .S XMTEXT="TEXT("
 .S TEXT(1)="A transmission for Health eVet failed."
 .S TEXT(2)="Extracted data was not successfully transmitted."
 .S TEXT(3)=EVERR
 .S TEXT(4)=" "
 .S TEXT(5)="Veteran: "_$S($G(EVDFN)>0:$P(^DPT(EVDFN,0),"^"),1:"?")
 .S TEXT(6)="Request: "_$S($G(EVREQ)'="":EVREQ,1:"?")
 ;
 ; Message - Request Query Failure
 ; Called from check response code in EVETLID
 I MSG="REQUEST" D
 .S XMSUB=SITE_" Health eVet request query failure"
 .S XMTEXT="TEXT("
 .S TEXT(1)="The query for requests from Health eVet failed."
 .S TEXT(2)="No requests were processed."
 .S TEXT(3)=EVERR
 ;
 ; Message - Registration Failure
 ; Called from check response code in EVETLIR
 I MSG="REGISTER" D
 .S XMSUB=SITE_" Health eVet registration failure"
 .S XMTEXT="TEXT("
 .S TEXT(1)="The registration for Health eVet failed."
 .S TEXT(2)="Registration was not successful."
 .S TEXT(3)=EVERR
 .S TEXT(4)=" "
 .S TEXT(5)="Veteran: "_$S($G(EVDFN)>0:$P(^DPT(EVDFN,0),"^"),1:"?")
 ;
 ;
 I $D(XMSUB) D ^XMD
 Q
CHKBLOCK(EVDFN,BLKFLAG) ;check to see if dfn is blocked for download. if so
 ;return 1 response. Not blocked returns 0.
 I EVDFN<1 S BLKFLAG=1 Q
 N EVIEN
 S BLKFLAG=0,EVIEN=""
 S EVIEN=$O(^EVET(2275,"B",EVDFN,EVIEN))
 I EVIEN<1 S BLKFLAG=1 Q  ;Block if not a patient on this system
 S BLKFLAG=$P($G(^EVET(2275,EVIEN,0)),"^",9)="Y"
 Q
GMT() ; Get current date time in GMT
 N EVTZ,EVH,EVM,EVDAT
 S EVTZ=$$TZ^XLFDT() ; Gets time differane ( -0600)
 S EVH=$E(EVTZ,2,3)
 S EVM=$E(EVTZ,4,5)
 I $E(EVTZ,1)="+" D
 . ;IF GMT IS behind current time zone take off time
 . S EVH="-"_EVH
 . S EVM="-"_EVM
 . Q
 S EVDAT=$$XMLDATE^EVETU1($$FMADD^XLFDT($$NOW^XLFDT(),0,EVH,EVM))
 Q EVDAT
 ;
ETRAP ; Error trap for Extracts
 D ^%ZTERR
 D ALERT("EXTRACT")
 Q
