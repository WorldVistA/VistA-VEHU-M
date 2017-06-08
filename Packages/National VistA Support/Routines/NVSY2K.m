NVSY2K ;slcciofo/mb,mw-avanti systems y2k status check ;10/1/99
 ;;1.0;NVSIS UTILITIES;
 ;
 ; **FOR USE ON AVANTI SYSTEMS ONLY**
 ;
 ; The original code was provided by Mike Simmons @ Compaq.  It has been
 ; modified to allow sending a mail message to report results.  It's purpose
 ; is to check and report on all Avanti systems for installed Service Pack and
 ; HotFix from NT registries.
 ;
 ; To use:  simply install this routine into VAH on the active production
 ;          Avanti system in namespace VAH.  Then, from programmer mode,
 ;          DO ^NVSY2K.  All required action is completed in the background
 ;          and the results sent via network mail.
 ;
 S $ZT="EOF"
 K ^TMP("NVSY2K",$J)
 ;
 ; get current system name...
 S NVSSYS=$ZU(110)
 S NVSSYSID=+$E(NVSSYS,$L(NVSSYS))
 ;
 ; get default HFS location (most likely T:\TEMP)...
 S NVSDIR=$G(^XTV(8989.3,1,"DEV"))
 S NVSDIR=$TR(NVSDIR,"/","\")
 I $E(NVSDIR,$L(NVSDIR))'="\" S NVSDIR=NVSDIR_"\"
 S NVSFILE="Y2KCHK_"_NVSSYS_".txt"
 S NVSHFILE=NVSDIR_NVSFILE
 ;
 ; delete any previous iteration of the host file...
 S X=$ZF(-1,"del "_NVSHFILE)
 ;
 ; create and open the host file for use...
 O NVSHFILE:"WNS":5
 I $T'>0 S ^TMP("NVSY2K",$J,1)="OPEN of "_NVSHFILE_" failed."
 ;
 ; if the host file set up was successful, let's continue...
 I '$D(^TMP("NVSY2K",$J)) D
 .U NVSHFILE
 .W "Report Generated from System "_NVSSYS
 .;
 .; call NT utility for the local system...
 .D LOCAL
 .;
 .; call NT utility for the remote system(s)...
 .D ALL
 .;
 .; okay, we've run the utilities and built the data file.  now, let's
 .; retrieve the data...
 .S X=$$FTG^%ZISH(NVSDIR,NVSFILE,"^TMP(""NVSY2K"","_$J_",0)",3,"")
 .I X'=1 S ^TMP("NVSY2K",$J,1)="Report file built, but couldn't retrieve it."
 .;
 .; data retrieved, delete the host file...
 .S X=$ZF(-1,"del "_NVSHFILE)
 ;
 ; pull the data into a local variable in prep for mail transmission...
 S I=0
 F  S I=$O(^TMP("NVSY2K",$J,I)) Q:'I  S NVSTEXT(I)=^TMP("NVSY2K",$J,I)
 ;
 ; set up and send the mail message...
 S XMDUZ=.5
 S XMSUB="Y2KCHK @ "_^XMB("NETNAME")
 S XMTEXT="NVSTEXT("
 ;
 ; the following recipients are Avanti Team members assigned to monitor/report
 ; system Y2K preparation/compliance activities...
 S XMY("WANG,MARK@FORUM.VA.GOV")=""
 S XMY("WANG,MARK@ISC-SLC.VA.GOV")=""
 S XMY("NEVIUS,GORDON@FORUM.VA.GOV")=""
 S XMY("NEVIUS,GORDON@ISC-SF.VA.GOV")=""
 S XMY("EDWARDS,JAN-PAUL@FORUM.VA.GOV")=""
 S XMY("EDWARDS,JAN-PAUL@TUSCALOOSA.VA.GOV")=""
 S XMY("TETT@ISC-ALBANY.VA.GOV")=""
 D ^XMD
 ;
 ; clean up and exit...
 K I,NVSDATE,NVSDIR,NVSFILE,NVSHF,NVSHFILE,NVSREG,NVSREGR,NVSSP,NVSSYS,NVSTEXT,NVSTIME
 K X,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y,^TMP("NVSY2K",$J)
 S $ZT=""
 Q
 ;        
LOCAL ; Check current local system...
 S NVSSYS1=NVSSYS
 D SYSCHK
 Q
 ;
ALL ; Check other systems...
 S NVSSYS2=$E(NVSSYS,1,$L(NVSSYS)-1)
 F NVSOID=1:1:4 I NVSOID'=NVSSYSID D
 .S NVSSYS1=NVSSYS2_NVSOID
 .D SYSCHK
 K NVSOID,NVSSYS2
 Q
 ;
SYSCHK ; decide which NT utility to use...
 O NVSHFILE:"WA":5
 U NVSHFILE
 W !!,"Date: "
 C NVSHFILE
 S NVSDATE="date /t >> "_NVSHFILE
 S X=$ZF(-1,NVSDATE)
 O NVSHFILE:"WA":5
 U NVSHFILE
 W "Time: "
 C NVSHFILE
 S NVSTIME="time /t >> "_NVSHFILE
 S X=$ZF(-1,NVSTIME)
 S X=$ZF(-1,"dir c:\ntreskit\regread.exe")
 S NVSREGR=X
 S X=$ZF(-1,"dir c:\ntreskit\reg.exe")
 S NVSREG=X
 O NVSHFILE:"WA":5
 U NVSHFILE
 W !,NVSSYS1,!
 C NVSHFILE
 I $G(NVSREGR)=0,$G(NVSREG)=0 D REG,FILE Q
 I $G(NVSREG)=0 D REG,FILE Q
 I $G(NVSREGR)=0 D REGREAD,FILE Q
 Q
 ;
REGREAD ; use if nt resource kit 4.0 installed
 S NVSSP="regread \\"_NVSSYS1_" ""software\microsoft\windows nt\currentversion"" >> "_NVSHFILE
 S NVSHF="regread \\"_NVSSYS1_" ""software\microsoft\windows nt\currentversion\hotfix"" >> "_NVSHFILE
 Q
 ;
REG ; use if nt resource kit 4.0 supplement 3 installed
 S NVSSP="reg query ""software\microsoft\windows nt\currentversion\csdversion"" \\"_NVSSYS1_" >> "_NVSHFILE
 S NVSHF="reg query ""software\microsoft\windows nt\currentversion\hotfix"" \\"_NVSSYS1_" >> "_NVSHFILE
 Q
 ;
FILE S X=$ZF(-1,NVSSP)
 O NVSHFILE:"WA":5
 U NVSHFILE
 W !
 C NVSHFILE
 S X=$ZF(-1,NVSHF)
 Q
 ;
EOF U O
 W !
 C NVSHFILE
 Q
