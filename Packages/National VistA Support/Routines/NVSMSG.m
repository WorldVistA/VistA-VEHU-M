NVSMSG ;slcciofo/maw,mb-alert and messaging utility ;02:21 PM  19 Apr 2000
 ;;2.0;NVS system management utility;**11,12**; Jan 01, 1999
 ;
 ; **NOTE: THIS ROUTINE IS USED ONLY ON INTERSYSTEMS CACHE SYSTEMS**
 ;
 ; This routine is invoked by various AVANTI system monitoring utilities
 ; (e.g., the backup procedure (^BACKIRM) and the dead process check
 ; (^NVSDEAD)).  It retrieves the text contained in a log file stored in
 ; NT, sets it up as a mail message, and sends the message to the
 ; <default> G.IRM mail group.  The mail group can be changed as the
 ; site wishes by changing the lookup in the code below.
 ;
EN(NVSSTG,NVSLOG,NVSALERT)      ;
 ;
 ; NVSSTG   = a text string passed by value that will be used as the
 ;              mail message and alert subject
 ; NVSLOG   = log file name (drive:\directory\filename.LOG)
 ;              -->y:\backup\01012000.log or y:\backup\deadchk.log
 ;              passed by value from from the calling routine
 ; NVSALERT = passed by value as 0 to not send an alert, just a mail
 ;              message or 1 to send both an alert and a mail message
 ;
 S $ZT=$G(^%ZOSF("ERRTN"))
 S U="^"
 S NVSDEVOK=1
 S NVSALERT=+$G(NVSALERT)
 ;
 ; if NVSALERT=1 then the situation is likely critical so let's get
 ; a cstat...
 I NVSALERT D
 .S NVSCSTAT=1
 .S X=$ZF(-1,"T:\ANONYMOUS\CSTAT\CSTAT.CMD")
 ;
 I $G(NVSSTG)="" S NVSSTG="SYSTEM PROCESS MESSAGE"
 I $G(NVSLOG)'="" D
 .F NVSI=1:1 S NVSFILE=$P(NVSLOG,"\",NVSI) Q:NVSFILE=""
 .S NVSFILE=$P(NVSLOG,"\",NVSI-1)
 .S NVSDIR=$P(NVSLOG,"\",1,NVSI-2)_"\"
 .K NVSI
 .;
 .; delete any existing temp global used for this messaging utility...
 .K ^TMP($J),^XTMP("NVSMSG")
 .S ^XTMP("NVSMSG",0)=$$DT^XLFDT_U_$$DT^XLFDT_U_"NVS Procedure Error Message"
 .;
 .; call Kernel to retrieve the log file contents and set the temporary
 .; global for us...
 .S NVSDEVOK=$$FTG^%ZISH(NVSDIR,NVSFILE,"^XTMP(""NVSMSG"",1)",2,"OVF")
 .;
 .; if NVSDEVOK is 0, then the log file couldn't be retrieved, or the
 .; temporary global array could not be set.  so, set up the message to
 .; relay this information...
 .I 'NVSDEVOK D
 ..S ^TMP($J,1,0)="Log file: "_NVSLOG_" could not be retrieved!"
 ..S ^TMP($J,2,0)="Check the Y: drive to see if it may be full."
 ;
 ; if NVSLOG was not passed, set up the message to relay this error...
 I $G(NVSLOG)="" D
 .S NVSDEVOK=0
 .S ^TMP($J,1,0)="No log file was set up by the "_NVSSTG_"."
 .S ^TMP($J,2,0)="Please check the y:\backup directory to confirm."
 ;
 ; retrieve the text from the temporary global and put into our local array...
 I NVSDEVOK D
 .S NVSLINCT=0
 .F  S NVSLINCT=$O(^XTMP("NVSMSG",NVSLINCT)) Q:'NVSLINCT  D
 ..S ^TMP($J,NVSLINCT)=^XTMP("NVSMSG",NVSLINCT)
 ..I ^TMP($J,NVSLINCT)["WARNING"!(^TMP($J,NVSLINCT)["$ZE") S NVSWARN=1
 .;
 .; check for NVSWARN.  if it exists, then warnings and/or errors exist in
 .; the log file.  let's insert a line right at the top of the message text
 .; indicating that fact...
 .I +$G(NVSWARN) D
 ..S ^TMP($J,.1)="**********************>> WARNING <<***********************"
 ..S ^TMP($J,.2)="* ERROR AND/OR WARNING MESSAGES EXIST IN THIS LOG FILE!! *"
 ..S ^TMP($J,.3)="* RECOMMEND COMPLETE REVIEW OF THE LOG FILE AND          *"
 ..S ^TMP($J,.4)="* CORRECTIVE ACTION BE TAKEN IMMEDIATELY!!               *"
 ..S ^TMP($J,.5)="**********************************************************"
 ..K NVSWARN
 .;
 .; if we generated a CSTAT because of the alert status of this message, let's
 .; tell the recipients that we did that and what the file name is...
 .I +$G(NVSCSTAT) D
 ..S ^TMP($J,.6)=" "
 ..S ^TMP($J,.7)="NOTE!! THE CSTAT COMMAND FILE WAS CALLED AS A RESULT OF THIS PROBLEM."
 ..S ^TMP($J,.8)="Please look for the CSTAT reports in t:\anonymous\cstat\."
 ..S ^TMP($J,.9)=" "
 .K NVSLINCT        
 ;
 ; **send e-mail >> the site can change the default mail group from G.IRM to
 ;                  some other group by editing the "IRM" in the x-ref lookup
 ;                  below -- i.e., +$O(^XMB(3.8,"B","mail group name",0))
 ;
 ; check for the existence of G.IRM mail group, and that that group has at least
 ; one member...
 S NVSMGRP=+$O(^XMB(3.8,"B","IRM",0))
 I '$O(^XMB(3.8,NVSMGRP,1,0)) S NVSMGRP=0
 I NVSMGRP S NVSMGRP="G.IRM"
 ;
 ; if no such mail group or no members, send the message to postmaster...
 I NVSMGRP=0 S NVSMGRP=.5
 ;
 S XMDUZ=.5
 S XMSUB=NVSSTG_" "_$E(NVSFILE,1,2)_"/"_$E(NVSFILE,3,4)_"/"_$E(NVSFILE,5,8)_"@"_$E(NVSFILE,10,13)
 S XMY(NVSMGRP)=""
 ;
 ; if the situation requires an alert be sent, it may be critical enough to
 ; warrant national support attention.  add G.CSAVANTI@FORUM to the recipients...
 I +$G(NVSALERT)=1 S XMY("G.CSAVANTI@FORUM.VA.GOV")=""
 S XMTEXT="^TMP("_$J_","
 D ^XMD
 K XMDUZ
 ;
 ; send an alert to mailgroup...
 I +$G(NVSALERT)=1 D
 .S DUZ=".5"
 .S XQA(NVSMGRP)=""
 .S XQAMSG="** "_NVSSTG_" PROBLEM - PLEASE REFER TO MESSAGE NUMBER "_$G(XMZ)_" **"
 .D SETUP^XQALERT
 .K XQA,XQAMSG
 ;
 K NVSALERT,NVSCSTAT,NVSDEVOK,NVSDIR,NVSFILE,NVSLOG,NVSMGRP,NVSSTG
 K XMSUB,XMTEXT,XMY,XMZ
 K ^TMP($J),^XTMP("NVSMSG")
 Q
