XOBVSYSI ;ID/MJK/ALB - VistaLink Interface Implementation ; 4/27/26 3:41pm
 ;;1.6;VistALink;**9**;May 08, 2009;Build 19
 ;Per VHA directive 2004-038, this routine should not be modified.
 ; Case sensitive, 3+ characters
 ; ICR 10104 - ^XLFSTR
 ; ICR 2051 - FIND^DIC
 ; ICR 2171 - XUAF4
 ; ICR 2541 - KSP^XUPARAM
 ; ICR 7616 - INIT^XUTLS AND GKSPTLSCN^XUTLS
 ; ICR 1052 - XUSCLEAN
 ; ICR 10097 - GENTENV^%ZOSSV
 ; ICR 4153 - MXMLUTL
 ; ICR 4440 - PROD^XUPROD
 ; ICR 2343 - $$NAME^XUSER
CALLBACK(CB) ; -- init callbacks implementation
 SET CB("STARTELEMENT")="ELEST^XOBVSYSI"
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;             RPC Server: Request Message XML SAX Parser Callbacks         
 ; ------------------------------------------------------------------------
ELEST(ELE,ATR) ; -- element start event handler
 IF ELE="VistaLink" DO  QUIT
 . SET XOBDATA("MODE")=$GET(ATR("mode"),"single call")
 ;
 IF ELE="Request" DO  QUIT
 . SET XOBDATA("XOB SYSTEM","TYPE")=$GET(ATR("type"),"unknown")
 . SET XOBDATA("XOB SYSTEM","ENV")=$$LOW^XLFSTR($GET(ATR("environment"),"j2se"))
 ;
 QUIT
 ;
READER(XOBUF,XOBDATA) ; -- proprietary format reader implementation
 QUIT
 ;
REQHDLR(XOBDATA) ; -- request handler implementation
 NEW TYPE,XOBVR
 SET TYPE=$GET(XOBDATA("XOB SYSTEM","TYPE"),"unknown")
 ;
 ; -- initialize socket partition request
 IF TYPE="initializeSocket" DO INIT(.TYPE) GOTO REQHDLRQ
 ; -- set stop flag to close socket request
 IF TYPE="closeSocket" DO CLOSE(.TYPE) GOTO REQHDLRQ
 ;
 ; -- cleanup partition request 
 IF TYPE="cleanupPartition" DO CLEANUP(.TYPE) GOTO REQHDLRQ
 ;
 ; --  heartbeat request 
 IF TYPE="heartbeat" DO HB(.TYPE) GOTO REQHDLRQ
 ;
 ; --  system info request 
 IF TYPE="systemInfo" DO SYSINFO(.TYPE) GOTO REQHDLRQ
 ;
 ; -- upgrade to TLS encryption -- XOBV*1.6*9
 IF TYPE="upgradeToTLS" D TLSU(.TYPE) GOTO REQHDLRQ
 ; -- failure if processing get here
 DO RESPONSE(.TYPE,"failure")
 ;
REQHDLRQ ;
 QUIT
 ;
ENV ; -- set env variable
 SET XOBSYS("ENV")=$GET(XOBDATA("XOB SYSTEM","ENV"))
 QUIT
 ;
PSTANUM ; -- set primary station number
 SET XOBSYS("PRIMARY STATION#")=$$TRUNCCH($$STA^XUAF4($$KSP^XUPARAM("INST")))
 ; note: AAC 200M is truncated to 200
 QUIT
 ;
INIT(TYPE) ; -- handle initialize request
 KILL XOBSYS
 S XOBVRTN1=0
 DO ENV
 DO PSTANUM
 ;
 IF "^j2se^j2ee^.net^"[(U_XOBSYS("ENV")_U) DO
 . DO RESPONSE(.TYPE,"success",$$RATE()_$$JOB()_$$RASTO()_$$TLS(.RTN))  ;ADD $$TLS for XOBV*1.6*9
 ELSE  DO
 . DO RESPONSE(.TYPE,"failure")
 QUIT
 ;
CLOSE(TYPE) ; -- handle close socket request
 SET XOBSTOP=1
 DO RESPONSE(.TYPE,"success")
 K XOBVRTN1,XOBVRTN,XOBVARRAY
 QUIT
 ;
CLEANUP(TYPE) ; -- handle cleanup partition request
 ; -- unlock any pending locks
 LOCK
 ;
 ; -- clean ^TMP, ^UTILITY, ^XUTL
 DO XUTL^XUSCLEAN
 ;
 ; -- restore DUZ to connector user
 KILL DUZ
 MERGE DUZ=XOBSYS("DUZ")
 ;
 ; -- clean symbol table
 DO KILL^XOBVLL
 ;
 DO RESPONSE(.TYPE,"success")
 QUIT
 ;
DUZSV(DUZ) ; -- save initial DUZ info for session
 IF $GET(XOBSYS("ENV"))="j2ee" DO
 . KILL XOBSYS("DUZ")
 . MERGE XOBSYS("DUZ")=DUZ
 QUIT
 ;
HB(TYPE) ; -- handle heartbeat request
 DO ENV
 DO RESPONSE(.TYPE,"success",$$RATE())
 QUIT
 ;
RATE() ; -- set up rate attribute for response
 NEW XOBRATE
 ; -- get J2EE timeout value for app serv environment
 IF $GET(XOBSYS("ENV"))="j2ee" DO
 . SET XOBRATE=$$GETASTO^XOBVLIB()
 ELSE  DO
 . SET XOBRATE=$$GETRATE^XOBVLIB()
 QUIT " rate="""_XOBRATE_""""
 ;
JOB() ; -- set up $JOB attribute for response
 QUIT " mJob="""_$JOB_""""
 ;
RASTO() ; -- set up ReAuthenticated Session TimeOut
 QUIT " reAuthSessionTimeout="""_$$GETRASTO^XOBVLIB()_""""
 ;
RESPONSE(TYPE,STATUS,ATTRS) ; -- build xml response
 ; -- initialize
 DO PRE^XOBVSKT
 DO WRITE^XOBVSKT($$VLHDR^XOBVLIB(4))
 DO WRITE^XOBVSKT("<Response type="""_$GET(TYPE)_""" status="""_$GET(STATUS)_""""_$GET(ATTRS,"")_" />")
 DO WRITE^XOBVSKT($$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 DO POST^XOBVSKT
 QUIT
 ;
SYSINFO(TYPE) ; -- build system info response
 NEW XOBINFO,XOBELE,XOBDEFLT,XOBINTRO,XOBI,XOBVT,XOBVRTN
 ;
 ; -- set up default value
 SET XOBDEFLT="unknown"
 ;
 ; -- get system info array
 DO GETSINFO(.XOBINFO)
 ;
 ; -- build <SystemInfo> element
 S XOBVT=$$TLS()
 SET XOBELE="<SystemInfo"
 SET XOBELE=XOBELE_" vistalinkVersion="""_$GET(XOBINFO("version"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" vistalinkBuild="""_$GET(XOBINFO("build"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" appServerTimeout="""_$GET(XOBINFO("appServerTimeout"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" reAuthSessionTimeout="""_$GET(XOBINFO("reAuthSessionTimeout"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" uci="""_$GET(XOBINFO("uci"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" vol="""_$GET(XOBINFO("vol"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" boxVolume="""_$GET(XOBINFO("boxVolume"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" mVersion="""_$GET(XOBINFO("mVersion"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" operatingSystem="""_$GET(XOBINFO("operatingSystem"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" domainName="""_$GET(XOBINFO("domainName"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" vistaProduction="""_$GET(XOBINFO("vistaProduction"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" defaultInstitution="""_$GET(XOBINFO("defaultInstitution"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_" cpName="""_$GET(XOBINFO("cpName"),XOBDEFLT)_""""
 SET XOBELE=XOBELE_XOBVT
 SET XOBELE=XOBELE_" />"
 ;
 SET XOBINTRO=$GET(XOBINFO("introductoryText"))
 ;
 ; -- build and send complete message
 DO PRE^XOBVSKT
 DO WRITE^XOBVSKT($$VLHDR^XOBVLIB(4))
 DO WRITE^XOBVSKT("<Response type="""_$GET(TYPE)_""" status=""success"" >")
 DO WRITE^XOBVSKT(XOBELE)
 FOR XOBI=1:1  QUIT:'$DATA(XOBINFO("introductoryText",XOBI))  DO
 . DO WRITE^XOBVSKT(XOBINFO("introductoryText",XOBI))
 DO WRITE^XOBVSKT("</Response>")
 DO WRITE^XOBVSKT($$ENVFTR^XOBVLIB())
 DO POST^XOBVSKT
 ;
 QUIT
 ;
GETSINFO(XOBINFO) ; -- gather system info into array
 NEW X,Y
 ;
 ; -- get version
 SET XOBINFO("version")=$PIECE($TEXT(XOBVSYSI+1),";",3)
 ;
 ; -- get build number
 SET XOBINFO("build")=$PIECE($TEXT(XOBVSYSI+1),";",7)
 ;
 ; -- get application server connection timeout
 SET XOBINFO("appServerTimeout")=$$GETASTO^XOBVLIB()
 ;
 ; -- get reauthentication session timeout
 SET XOBINFO("reAuthSessionTimeout")=$$GETRASTO^XOBVLIB()
 ;
 ; -- get basic M environment information
 SET Y=""
 DO GETENV^%ZOSV
 ;
 ; -- get uci
 SET XOBINFO("uci")=$PIECE(Y,U,1)
 ;
 ; -- get vol
 SET XOBINFO("vol")=$PIECE(Y,U,2)
 ;
 ; -- get box volume
 SET XOBINFO("boxVolume")=$PIECE(Y,U,4)
 ;
 ; -- get M version (full name)
 SET XOBINFO("mVersion")=$$SYMENC^MXMLUTL($$VERSION^%ZOSV(1))
 ;
 ; -- get operating system
 SET XOBINFO("operatingSystem")=$$SYMENC^MXMLUTL($$SYSOS^XOBVLIB(XOBOS))
 ;
 ; -- get domain name
 SET XOBINFO("domainName")=$$SYMENC^MXMLUTL($$KSP^XUPARAM("WHERE"))
 ;
 ; -- production or test
 SET XOBINFO("vistaProduction")=$S($$PROD^XUPROD(0):"true",1:"false")
 ;
 ; -- default institution
 SET XOBINFO("defaultInstitution")=$$SYMENC^MXMLUTL($$STA^XUAF4($$KSP^XUPARAM("INST"))_"/"_$$NAME^XUAF4($$KSP^XUPARAM("INST")))
 ;
 ; -- get intro text
 D GETINTRO^XOBSCAV2("XOBINFO(""introductoryText"")",1)
 ;
 ; -- get c/p username
 SET XOBINFO("cpName")=$$NAME^XUSER(DUZ)
 ;
 QUIT
 ;
RPC(XOBY) ;
 NEW XOBX,XOBLINE,XOBARR
 D GETSINFO(.XOBARR)
 SET XOBLINE=0
 S XOBX="" F  S XOBX=$O(XOBARR(XOBX)) Q:XOBX']""  D
 . SET XOBLINE=XOBLINE+1
 . SET XOBY(XOBLINE)=XOBX_"~"_XOBARR(XOBX)
 QUIT
 ;
TRUNCCH(XOBSTR) ; truncate before first non-numeric char
 NEW XOBI,XOBSTOP,XOBSTR1
 SET XOBSTOP=0,XOBSTR1=""
 FOR XOBI=1:1:$L(XOBSTR) QUIT:XOBSTOP  DO
 . IF "0123456789"'[$E(XOBSTR,XOBI) SET XOBSTOP=1 QUIT
 . SET XOBSTR1=XOBSTR1_$E(XOBSTR,XOBI)
 QUIT XOBSTR1
TLS(RTN) ;TLS Contingency check XOBV*1.6*9
 N XOBVNAME,XOBVTLS
 S (XOBVRTN,XOBVRTN1)=0
 S RTN=""
 S XOBVTLS=$T(GKSPTLSCN^XUTLS)
 I $L($G(XOBVTLS)) D
 . S XOBVRTN=$$GKSPTLSCN^XUTLS() S XOBVRTN1=+XOBVRTN
 . S RTN=" encryptionSupported="""_XOBVRTN1_""""
 Q RTN
TLSU(TYPE) ; TLS use check XOBV*1.6*9
 ;extra piecing was required to send back the exact responses needed without quotes.
 N XOBV1,XOBVR
 S XOBV1=$P($$INIT^XUTLS("USE",$P),""":",2)_"""" ;this gets (::/TLS="tls_encrypt_server")"
 S XOBV1=$P(XOBV1,"""",2)
 S XOBVR="1^"_XOBPORT_":"_XOBV1_""""
 I $G(XOBVR) D RESPONSE(.TYPE,"success"," result="""_XOBVR_"")
 D USE^%ZISUTL(XOBPORT)
 Q
