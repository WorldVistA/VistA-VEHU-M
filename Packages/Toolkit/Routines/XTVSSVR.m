XTVSSVR ;ALB/GTS - VistA Package Sizing Manager; 26-FEB-2020
 ;;7.3;TOOLKIT;**143,152**;Apr 25, 1995;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
SRVREXT ; Entry point - Process XTVS Request Message
 ; -- Server Option: XTVS PKG EXTRACT SERVER
 ;
 ; Message Form:
 ;  REQUESTED BY: {Email address} - Recipient of size report
 ;  Extract Indicator: {0 OR 1} - 0 means no extract; 1 means extract Package file data
 ;  Report Indicator: {1 or 2} - 1 means All Packages Size rpt; 2 means Single Package Size rpt
 ;  Package Parameters: Line 1 is the package parameters for the selected package to report
 ;                       followed by parameters for all packages
 ;
 NEW XTVSLN,XMRG,XMY,XMER,XTVSEXTP,XTVSSNDR,XTVSRPTP,SELPKGPM
 NEW SELPKGPM,LNITMCT,XTPPARM,XTPKGLN
 SET (XTPKGLN,SELPKGPM)=""
 SET (LNITMCT,XTPPARM)=0
 SET XMER=1
 FOR  Q:XMER<0  X XMREC DO
 . IF XMER'<0 DO
 .. SET XTVSLN=XMRG
 .. DO PARSLN ;Process msg line to rebuild single pkg parameter def line (XT*7.3*152)
 ;
 IF XTVSEXTP=1 DO EXTPKG(XTVSSNDR) DO EEXT(XTVSSNDR,+$GET(XTVSRPTP)) ; Extract Package and send
 ;
 IF $GET(XTVSRPTP)=2 DO
 . IF SELPKGPM]"" DO ONEPKGSZ(XTVSSNDR,SELPKGPM) ; Return size report for single package
 . IF SELPKGPM="" DO WRERR("SRVREXT^XTVSSVR : Package Size Rpt error","Parameters for a selected package not sent in server request.",XTVSSNDR,"{MISSING PACKAGE NAME}")
 ;
 KILL ^TMP("XTVS-FORUMPKG",$J)
 QUIT
 ;
PARSLN ; Parse message line of package parameters (XT*7.3*152)
 ;
 ; The following partition variables must be set by/for calling procedure:
 ;  XTVSLN   - Curr line from rcved msg
 ;  XTVSSNDR - Mailman address of report requester
 ;  XTVSEXTP - Extract Indicator
 ;  XTVSRPTP - Requested Report type
 ;  XTPKGLN  - Current Parameter String concatonated from message lines
 ;  LNITMCT  - Last Array node number set in result array with complete package def on single node
 ;  SELPKGPM - Package requested for a Single Size report.
 ;  XTPPARM  - Indicator:
 ;                1 - SELPKGPM is being/has been defined
 ;                0 - SELPKGPM has not started/completed definition
 ;
 IF XTVSLN["REQUESTED BY:" SET XTVSSNDR=$P(XTVSLN,"REQUESTED BY: ",2) ;Addressee for report
 ;
 IF XTVSLN["Extract Indicator:" SET XTVSEXTP=+($PIECE($GET(XTVSLN),": ",2)) ;1 - Extract Packages
 IF XTVSLN["Report Indicator:" SET XTVSRPTP=+($PIECE($GET(XTVSLN),": ",2)) ;0/NULL - No Size rpt; 1 - All Packages Size rpt; 2 - Single Package Size rpt
 ;
 ; The full Package Parameter file is needed for TALLYRPT^XTVSRFL to set create ^TMP("XTVS-IDX-PKG",$J,PKGPFX,PKGNAME)
 ; for packages in the Param file with value = 1 when KIDS Prefix, Null when not KIDS Prefix. Package
 ; Component counting is prevented from counting an Additional Prefix in a package when it is another
 ; packages primary prefix
 ;
 ; Parse out all packages in server message; server message needs all packages so Create ^TMP("XTVS-IDX-PKG",$J) array for MULTX^XTVSRFL1
 ;    If SELPKGPM has been defined and has 9 ^ pces, 1oad XTVSLN into ^TMP("XTVS-FORUMPKG",$J,TMPSUB)
 IF (XTPPARM) DO
 . IF $L(SELPKGPM,"^")'<9 DO PKGLNRBD("XTVS-FORUMPKG",XTVSLN,.XTPKGLN,.LNITMCT) ; Rebuild Param file string
 . IF $L(SELPKGPM,"^")<9 SET SELPKGPM=SELPKGPM_XTVSLN ;Concat the msg lines compising the selected Package Params
 IF XTVSLN["Package Parameters:" SET XTPPARM=1 SET SELPKGPM=$P(XTVSLN,"Package Parameters: ",2)
 QUIT
 ;
PKGLNRBD(ARRYNAME,XTVSLN,XTPKGLN,LNITMCT) ;Rebuild multiple message lines into single pkg param line (XT*7.3*152)
 ; Input:
 ;  ARRYNAME - First Subscript of ^TMP array [VAL] 
 ;  XTVSLN   - Current message line [VAL]
 ;  XTPKGLN  - Package line being created [VAL]
 ;  LNITMCT  - Node # to store complete Package String in ^TMP array [REF]
 ;
 IF $L(XTPKGLN,"^")<9 SET XTPKGLN=XTPKGLN_XTVSLN
 IF $L(XTPKGLN,"^")'<9 DO
 . SET LNITMCT=LNITMCT+1
 . SET ^TMP(ARRYNAME,$J,LNITMCT)=XTPKGLN ; Add Package to Parameter Array node
 . SET XTPKGLN=""
 QUIT
 ;
EXTPKG(XTVSSNDR) ; Extract Package File
 ;
 ;Input
 ; XTVSSNDR - Requesters VA Mailman address
 ;
 NEW VPNAME,VPIEN,VPNAT,VPN,VPNATRSLT,VPCURST,ACTIVST
 KILL ^XTMP("XTSIZE",$J)
 ;NOTE: First pce of 0 node sets ^XTMP purge date 90 days from 'Today'
 SET ^XTMP("XTSIZE",$J,0)=$$FMADD^XLFDT($P($$NOW^XLFDT,"."),90)_"^"_$P($$NOW^XLFDT,".")_"^"_$$NOW^XLFDT_"-Kernel ToolKit Package File Extract by "_$S($G(XTVSUNME)]"":XTVSUNME,1:"{unknown user}")_"^"_^%ZOSF("PROD")
 ;
 SET VPIEN=0
 FOR  SET VPIEN=$ORDER(^DIC(9.4,VPIEN)) QUIT:'VPIEN  SET VPNAME=$P($G(^DIC(9.4,VPIEN,0)),"^") IF VPNAME]"" DO
 . SET VPNAT=$G(^DIC(9.4,VPIEN,7)),VPNAT=$P(VPNAT,"^",3)
 . SET VPNATRSLT=((VPNAT="I")!(VPNAT="Ia")!(VPNAT="Ib")!(VPNAT="Ic"))  ;Only extract Class I, Ia, Ib and Ic packages
 . SET VPN=$P($G(^DIC(9.4,VPIEN,0)),"^",2) ; PREFIX, Required, Do not extract if missing PREFIX
 . SET VPCURST=$P($G(^DIC(9.4,VPIEN,15002)),"^",3) ;Get CURRENT STATUS
 . SET ACTIVST=((VPCURST'="X")&(VPCURST'="D")) ;If CURRENT STATUS '= NO LONGER USED and '= DECOMMISSIONED
 . IF VPNATRSLT,VPN]"",ACTIVST DO  ;National pkg, Has prefix, Not inactive pkg
 .. IF VPNAME["""" DO
 ... SET VPNAME=$REPLACE(VPNAME,"""","''")
 ... DO NOTCE^XTVSLAPI("Double Quotes changed to 2 single quotes in the "_VPNAME_" Package name.~EXTPKG^XTVSSVR",XTVSSNDR,VPNAME)
 .. DO SETXTMP^XTVSLNA1 ;Extract Packages
 ;
 QUIT
 ;
EEXT(XTVSSNDR,XTVSSIZE) ; Email ^XTMP("XTSIZE") extract global
 ;
 ;Input
 ; XTVSSNDR - Requesters VA Mailman address
 ; XTVSSIZE - 1: Create Size Report for all package; Null: No report
 ;
 NEW XPID,QCHK
 SET QCHK=0
 SET XPID=$JOB ;Process ID
 SET XTVSSIZE=+$GET(XTVSSIZE)
 ;
 IF '$D(^XTMP("XTSIZE",XPID)) DO WRERR("EEXT^XTVSSVR : Package extract error","Extract failed!  ^XTMP(""XTSIZE"","_XPID_") not created on Server!",XTVSSNDR,"")
 IF $D(^XTMP("XTSIZE",XPID)) DO
 . NEW XMERR,XMY,XMTEXT,XMDUZ,XMSUB,XDATE
 . SET XMDUZ=DUZ
 . SET XMY(XTVSSNDR)=""
 . SET XMTEXT="^XTMP(""XTSIZE"","_XPID_","
 . SET XDATE=$P($P(^XTMP("XTSIZE",XPID,0),"^",3),"-")
 . SET XDATE=$$FMTE^XLFDT(XDATE,"1P")
 . SET XMSUB="PACKAGE FILE EXTRACT ("_$P(^XTMP("XTSIZE",XPID,0),"^",4)_" ; "_XDATE_" ; $JOB#: "_XPID_")"
 . DO ENT^XMPG
 . IF +XMZ'>0 DO WRERR("EEXT^XTVSSVR : Package extract error","Error: ^XTMP(""XTSIZE"","_XPID_") not sent in Packman to "_XTVSSNDR_"!",XTVSSNDR,"")
 . IF XTVSSIZE=1 DO SIZERPT(XTVSSNDR) ; Create size report for all packages
 KILL ^XTMP("XTSIZE",XPID)
 ;
 QUIT
 ;
WRERR(HDRTEXT,ERRTEXT,XTVSSNDR,PKGNAME) ; Write Server Mail extract send error to Error Trap & return msg to requester
 DO APPERROR^%ZTER(HDRTEXT) ;Write error to Error Trap
 ;
 ; Send size report request failure message
 NEW XMERR,XMY,XMTEXT,XMDUZ,XMSUB
 KILL ^TMP("XTVS-REMOTE-ERROR",$JOB)
 IF PKGNAME]"" DO
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,1)="Notice for Remote Package size report on "_^%ZOSF("PROD")_"."
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,2)="Remote size report request FAILED for "_PKGNAME_"."
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,3)=ERRTEXT
 IF PKGNAME']"" DO
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,1)="Remote package size report on "_^%ZOSF("PROD")_" failed!!"
 . SET ^TMP("XTVS-REMOTE-ERROR",$JOB,2)=ERRTEXT
 SET XMDUZ=DUZ
 SET XMY(XTVSSNDR)=""
 SET XMTEXT="^TMP(""XTVS-REMOTE-ERROR"","_$JOB_","
 SET XMSUB="PACKAGE SIZE REPORT ("_^%ZOSF("PROD")_") ; remote request FAILED!"
 DO ^XMD
 IF +XMZ'>0 DO
 . SET ERRTEXT="'Failed extract error message' FAILED to return to "_XTVSSNDR_"."
 . DO APPERROR^%ZTER("WRERR^XTVSSVR : Package extract error")
 KILL ^TMP("XTVS-REMOTE-ERROR",$JOB)
 QUIT
 ;
SIZERPT(XTVSSNDR) ; Create Size Report and return to user
 ; Requires ^XTMP("XTSIZE")
 NEW PKGNMEL1,PKGNMEL2,PKGNMEL3,LNNUM
 DO XTMPORD^XTVSLNA1($JOB,0,1) ; Create ^TMP("XTSIZE") Parameter file, Do Not create Change Report arrays, Create ^TMP("XTVS-FORUMPKG",$J)
 ;
 DO KIDSIDX^XTVSRFL1 ;Create Prefix-Package Indicies from KIDS
 ;
 DO TALLYRPT^XTVSRFL(1,1) ; Needs ^TMP("XTVS-FORUMPKG",$J,TMPSUB) and DO KIDSIDX^XTVSRFL1
 DO RPTSIZE(XTVSSNDR) ; Set report into Mail Message array
 ;
 KILL ^XTMP("XTSIZE",$J)
 KILL ^TMP("XTVS-VPS",$JOB),^TMP("XTVS-FORUMPKG",$JOB),^TMP("XTVS-PREFIX-IDX",$JOB),^TMP("XTVS-FORUM-PFXS",$JOB)
 KILL ^TMP("XTVS-VPS0",$JOB),^TMP("XTVS-IDX-PKG",$JOB),^TMP("XTVS-KIDSPFX-IDX",$JOB),^TMP("XTVS-FORUM2TMP",$JOB) ;,^TMP("XTSIZE","IDX",$JOB)
 KILL ^TMP("XTVS-FILERPT",$JOB),^TMP("XTSIZE",$JOB),^TMP("XTSIZE","IDX",$JOB),^TMP("XTVS-REMOTE-SIZE",$JOB) ; KILL ^TMP globals
 QUIT
 ;
RPTSIZE(XTVSSNDR) ; Create message with report
 NEW LINECNT,RUNDT
 SET LINECNT=0
 ;
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"VistA Application Sizing Information                               Sort Type: 1")
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"   Site Domain: "_$P($$NETNAME^XMXUTIL(DUZ),"@",2))
 DO NOW^%DTC S Y=X D DD^%DT
 SET RNDT=Y
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"      Run Date: "_RNDT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT," ")
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"                       Total")
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"Application             Rtn")
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"(Namespace)  Routines  Size  Files  Fields  Options  Protocols  RPCs  Templates")
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"===============================================================================")
 ;
 ; Add report lines to display array
 NEW PKGNAME,PKGPFX
 SET PKGNAME=""
 FOR  SET PKGNAME=$O(^TMP("XTVS-VPS",$J,PKGNAME)) QUIT:PKGNAME=""  SET PKGPFX="" DO
 . FOR  SET PKGPFX=$O(^TMP("XTVS-VPS",$J,PKGNAME,PKGPFX)) QUIT:PKGPFX=""  DO
 .. DO PDAD($G(^(PKGPFX)),PKGNAME,PKGPFX,.LINECNT)
 ;
 ; Send size report message
 NEW XMERR,XMY,XMTEXT,XMDUZ,XMSUB
 SET XMDUZ=DUZ
 SET XMY(XTVSSNDR)=""
 SET XMTEXT="^TMP(""XTVS-REMOTE-SIZE"","_$JOB_","
 SET XMSUB="PACKAGE SIZE REPORT ("_^%ZOSF("PROD")_" ; "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")_" ; $JOB#: "_$JOB_")"
 DO ^XMD
 IF +XMZ'>0 DO WRERR("RPTSIZE^XTVSSVR : Package extract error","Error: ^XTMP(""XTVS-REMOTE-SIZE"","_$JOB_") not sent in Packman to "_XTVSSNDR_"!",XTVSSNDR,"ALL Packages")
 ;
 QUIT
 ;
PDAD(DATA,PKGNAME,PKGPFX,LINECNT) ; Add data to message global
 NEW RTOT,TLCNT,FTOT,FLDTOT,OTOT,PTOT,RPTOT,TPLTTOT,DATANDE,SPCT
 SET RTOT=+DATA
 SET TLCNT=$P(DATA,"^",2)
 SET FTOT=$P(DATA,"^",3)
 SET FLDTOT=$P(DATA,"^",4)
 SET OTOT=$P(DATA,"^",5)
 SET PTOT=$P(DATA,"^",6)
 SET RPTOT=$P(DATA,"^",7)
 SET TPLTTOT=$P(DATA,"^",8)
 ;
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,PKGNAME)
 SET DATANDE=""
 SET DATANDE="("_PKGPFX_")"
 FOR SPCT=1:1:11-$LENGTH(DATANDE) SET DATANDE=DATANDE_" " ;Space out 2nd data element
 SET DATANDE=DATANDE_$J(RTOT,6)_"  "_$J(TLCNT,9)_"  "_$J(FTOT,4)_"  "_$J(FLDTOT,6)_"   "_$J(OTOT,6)_"    "_$J(PTOT,6)_" "_$J(RPTOT,6)_"  "_$J(TPLTTOT,6)
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,DATANDE)
 DO ADDLNE("^TMP(""XTVS-REMOTE-SIZE"")",.LINECNT,"-------------------------------------------------------------------------------")
 QUIT
 ;
ADDLNE(TMPARY,LINECNT,MSG) ; Add line to global
 ;Input
 ; TMMPARY - Array name to add a line (Closed root)
 ; LINECNT - Current array node number
 ; MSG     - Message to add to ListMan Display
 ;
 SET LINECNT=LINECNT+1
 SET @TMPARY@($J,LINECNT)=MSG
 QUIT
 ;
 ; Called by SRVREXT for a single package, SELPKGPM contains package parameters
ONEPKGSZ(XTVSSNDR,SELPKGPM) ; Report Package
 ;Input
 ; XTVSSNDR - Requesters VA Mailman address
 ; SELPKGPM - Selected package parameters
 ;
 NEW PKGNAME,PKGNUM,PKGPFX,PKGERR,PCENUM,PREFIX,ADDPRFX
 SET PKGERR=0
 KILL ^TMP("XTVS-PREFIX-IDX",$J),^TMP("XTVS-FORUM-PFXS",$J),^TMP("XTVS-IDX-PKG",$J)
 ;
 ;Create Prefix Indicies
 SET PKGNAME=$P(SELPKGPM,"^")
 ;
 SET PKGPFX=$P(SELPKGPM,"^",2)
 IF PKGPFX="" DO
 . SET PKGERR=1
 . DO WRERR("ONEPKGSZ^XTVSSVR : Package Size Rpt error","PREFIX not found for package selected.",XTVSSNDR,PKGNAME)
 IF 'PKGERR DO
 . ;
 . DO KIDSIDX^XTVSRFL1 ;Create Prefix-Package Indicies from KIDS
 . ;
 . DO TALLYRPT^XTVSRFL(1,1,SELPKGPM) ; Needs ^TMP("XTVS-FORUMPKG",$J,TMPSUB) and DO KIDSIDX^XTVSRFL1; p152 - v2 ba changed PKGNAME to SELPKGPM 
 . ;
 . DO ONERPT(XTVSSNDR,SELPKGPM,PKGNAME,PKGPFX) ;Report stat's for a single package
 ;
 KILL ^TMP("XTVS-VPS",$JOB),^TMP("XTVS-PREFIX-IDX",$JOB),^TMP("XTVS-FORUM-PFXS",$JOB)
 KILL ^TMP("XTVS-VPS0",$JOB),^TMP("XTVS-IDX-PKG",$JOB),^TMP("XTVS-KIDSPFX-IDX",$JOB)
 KILL ^TMP("XTVS-FILERPT",$JOB),^TMP("XTSIZE","IDX",$JOB),^TMP("XTVS-REMOTE-SIZE",$JOB)
 QUIT
 ;
ONERPT(XTVSSNDR,SELPKGPM,PKGNAME,PKGPFX) ; Report a single package
 ;;INPUT:
 ;   XTVSSNDR  - Requesting user Email address
 ;   SELPKGPM  - Package Parameters (single package)
 ;   PKGNAME   - Package name to report
 ;   PKGPFX    - Package Prefix
 ;
 NEW Q,PCENUM,ADP,RDP,FTOT,FLDTOT,FFCTRSLT,RTOT,OTOT,PRCTOT,RPTOT,TPLTTOT,PKGIEN,RNDT,TLCNT
 NEW PARMDAT,PARMDAT3,PARMDAT4,PARMDAT7,PARMDAT8,LINECNT
 SET (PKGIEN,LINECNT)=0
 IF PKGNAME["''" DO
 . IF $D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))) SET PKGIEN=$O(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""),""))
 . IF '$D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))),$D(^DIC(9.4,"B",PKGNAME)) SET PKGIEN=$O(^DIC(9.4,"B",PKGNAME,""))
 IF PKGNAME'["''" SET PKGIEN=+$O(^DIC(9.4,"B",PKGNAME,""))
 ;
 ; Piece # on SELPKGPM = node # on ^TMP("XTVS-PARAM-CAP",$J)
 ;
 SET PARMDAT=$P(SELPKGPM,"^",5) ;Additional Prefixes
 SET (ADP,Q,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET Q=$P(PARMDAT,"|",PCENUM) Q:Q=""  IF $$MULTX^XTVSRFL1(Q,PKGNAME) SET ADP=ADP+1 SET ADP(ADP)=Q
 ;
 SET PARMDAT=$P(SELPKGPM,"^",6) ;Excepted Prefixes
 SET (RDP,Q,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET Q=$P(PARMDAT,"|",PCENUM) Q:Q=""  SET RDP=RDP+1 SET RDP(RDP)=Q
 ;
 ; counting files and fields
 SET PARMDAT3=$P(SELPKGPM,"^",3) ;*Lowest File#
 SET PARMDAT4=$P(SELPKGPM,"^",4) ;*Highest File#
 SET PARMDAT7=$P(SELPKGPM,"^",7) ;File Numbers
 SET PARMDAT8=$P(SELPKGPM,"^",8) ;File Ranges
 SET FFCTRSLT=$$COUNTFLS^XTVSRFL1(PKGPFX,PARMDAT3,PARMDAT4,PARMDAT7,PARMDAT8) ; Count Files^Fields
 SET FTOT=$P(FFCTRSLT,"^") ;Extract File ctr
 SET FLDTOT=$P(FFCTRSLT,"^",2) ;Extract Field ctr
 ;
 ; counting routines
 S TLCNT=0
 S RTOT=$$ROUTINE^XTVSRFL1(PKGPFX,.TLCNT,.RDP,.ADP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S RTOT=RTOT+$$ROUTINE^XTVSRFL1(ADP(Q),.TLCNT,.RDP,.ADP) ;ADP(Q) added prefixes called individually
 ;
 ; counting options
 S OTOT=0
 D CNTR^XTVSRFL1("^DIC(19,",.OTOT,PKGPFX,.RDP,.ADP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR^XTVSRFL1("^DIC(19,",.OTOT,ADP(Q),.RDP,.ADP)
 ;
 ; counting protocols
 S PRCTOT=$$PROTOCOL^XTVSRFL1(PKGPFX,PKGIEN,.RDP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S PRCTOT=PRCTOT+$$PROTOCOL^XTVSRFL1(ADP(Q),PKGIEN,.RDP)
 ;
 ; counting remote procedures
 S RPTOT=0
 D CNTR^XTVSRFL1("^XWB(8994,",.RPTOT,PKGPFX,.RDP,.ADP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR^XTVSRFL1("^XWB(8994,",.RPTOT,ADP(Q),.RDP,.ADP)
 ;
 ; counting edit, print, & sort templates
 S TPLTTOT=0
 D CNTR^XTVSRFL1("^DIPT(",.TPLTTOT,PKGPFX,.RDP,.ADP) ;Print Templates
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR^XTVSRFL1("^DIPT(",.TPLTTOT,ADP(Q),.RDP,.ADP)
 ;
 D CNTR^XTVSRFL1("^DIBT(",.TPLTTOT,PKGPFX,.RDP) ;Sort Templates
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR^XTVSRFL1("^DIBT(",.TPLTTOT,ADP(Q),.RDP,.ADP)
 ;
 D CNTR^XTVSRFL1("^DIE(",.TPLTTOT,PKGPFX,.RDP) ;Input Templates
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR^XTVSRFL1("^DIE(",.TPLTTOT,ADP(Q),.RDP,.ADP)
 ;
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT," ")
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"  VistA Application Sizing Information")
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT," ")
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"    Site Domain: "_$P($$NETNAME^XMXUTIL(DUZ),"@",2))
 DO NOW^%DTC S Y=X D DD^%DT
 SET RNDT=Y
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"       Run Date: "_RNDT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT," ")
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"VistA Application: "_PKGNAME)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"==================")
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of Routines:     "_RTOT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Size of Routines:       "_TLCNT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of Files:        "_FTOT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of Fields:       "_FLDTOT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of Options:      "_OTOT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of Protocols:    "_PRCTOT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of RPCs:         "_RPTOT)
 DO ADDLNE("^TMP(""XTVS-REMOTE-RPT"")",.LINECNT,"Number of Templates:    "_TPLTTOT)
 ;
 ; Send size report message
 NEW XMERR,XMY,XMTEXT,XMDUZ,XMSUB
 SET XMDUZ=DUZ
 SET XMY(XTVSSNDR)=""
 SET XMTEXT="^TMP(""XTVS-REMOTE-RPT"","_$JOB_","
 SET XMSUB="PACKAGE SIZE REPORT ("_^%ZOSF("PROD")_" ; "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")_" ; $JOB#: "_$JOB_")"
 DO ^XMD
 IF +XMZ'>0 DO WRERR("ONERPT^XTVSSVR : Package extract error","Error: ^XTMP(""XTVS-REMOTE-RPT"") not sent in Packman to "_XTVSSNDR_"!",XTVSSNDR,PKGNAME)
 ;
 QUIT
