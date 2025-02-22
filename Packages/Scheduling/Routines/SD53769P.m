SD53769P ;MNT/BJR - MARK EWL OPT/PROT OOO ;Oct 05, 2021@08:58
 ;;5.3;Scheduling;**769**;Aug 13, 1993;Build 22
 ;
 Q
 ;References to DELETE^XPDPROT supported by DBIA #5567
 ;References to OUT^XPDPROT supported by DBIA #5567
 ;References to OUT^XPDMENU supported by DBIA #1157
 ;References to BMES^XPDUTL supported by DBIA #10141
 ;References to XREF^XQORM supported by DBIA #10140
 ;References to GET1^DIQ supported by DBIA #2056
 ;References to GOTLOCAL^XMXAPIG supported by DBIA #3006
 ;References to ^XMD supported by DBIA #10070
 ;References to ^DIE supported by DBIA #10018
 ;
 ;Post-init routine for EWL Decommission
 ;
 ;
EN ;Entry point for SD*5.3*769 Post Install routine
 D DELPROT
 D DISPROT
 D DISOPT
 D CHKCLN
 D DISPAT
 D CHKCLN
 D INACLN
 D DISCLN
 Q
DELPROT ;Delete Protocol from List Protocol
 N SDOM,SDMN,SDPROT,SDCHK,SDOP,SDTEXT,XQORM
 F SDOM=1:1 S SDMN=$P($TEXT(MENLST+SDOM),";;",2) Q:SDMN="$$END"  D
 .F SDOP=1:1 S SDPROT=$P($TEXT(PROLST+SDOP),";;",2) Q:SDPROT="$$END"  D
 ..S SDCHK=$$DELETE^XPDPROT(SDMN,SDPROT)
 ..I SDCHK S SDTEXT="The "_SDPROT_" protocol has been deleted from the "_SDMN_" protocol menu." D BMES^XPDUTL(SDTEXT)
 ..I 'SDCHK S SDTEXT="The "_SDPROT_" protocol could not be deleted from the "_SDMN_" protocol menu. It may have already been removed." D BMES^XPDUTL(SDTEXT)
 S XQORM=$O(^ORD(101,"B","SDAM MENU",0))_";ORD(101,"
 D XREF^XQORM ;Force protocol recompile.
 Q
 ;
DISPROT ;Disable Protocols
 N SDPRTL,SDPR,SDTEXT
 F SDPR=1:1 S SDPRTL=$P($TEXT(DISLST+SDPR),";;",2) Q:SDPRTL="$$END"  D
 .D OUT^XPDPROT(SDPRTL,"DO NOT USE!! - EWL DECOM - SD*5.3*769")
 .S SDTEXT="The "_SDPRTL_" protocol has been disabled." D BMES^XPDUTL(SDTEXT)
 Q
DISOPT ;Mark Options OOO
 N SDOPT,SDCNT,SDTEXT
 F SDCNT=1:1 S SDOPT=$P($TEXT(OPTLST+SDCNT),";;",2) Q:SDOPT="$$END"  D
 .D OUT^XPDMENU(SDOPT,"DO NOT USE!! - EWL DECOM - SD*5.3*769")
 .S SDTEXT="The "_SDOPT_" option has been marked out of order." D BMES^XPDUTL(SDTEXT)
 Q
CHKCLN ;Check wait list clinics for active appointments
 N SDCLN,SDCLNS,SDWLSCN,SDWLCNT,SDWLN
 K ^TMP("SD769P",$J)
 S SDCLN=0 F  S SDCLN=$O(^SDWL(409.32,SDCLN)) Q:'SDCLN  D
 .S SDCLNS=SDCLN_","
 .Q:($P(^SDWL(409.32,SDCLN,0),U,4))
 .Q:($$GET1^DIQ(409.32,SDCLNS,.01)["VCL")
 .S SDCLNS=SDCLN_"," S SDWLSCN=$P($G(^SDWL(409.32,SDCLN,0)),U,1)
 .I $D(^SDWL(409.3,"SC",SDWLSCN))&'$P($G(^SDWL(409.32,SDCLN,0)),U,4) D
 ..S SDWLN="",SDWLCNT=0 F  S SDWLN=$O(^SDWL(409.3,"SC",SDWLSCN,SDWLN)) Q:SDWLN=""  D
 ...I '$D(^SDWL(409.3,SDWLN,"DIS")) S ^TMP("SD769P",$J,"DIS",SDWLSCN,SDWLN)=""
 Q
DISPAT ;Remove entries without patient info
 N SDWLN,SDCNT,SDPAT,SDCLN,SDIEN,SDTM,SDPOS,SDSPL,DA,DIE,DR,SDWLCL
 S SDWLCL=0 F  S SDWLCL=$O(^TMP("SD769P",$J,"DIS",SDWLCL)) Q:'SDWLCL  D
 .S SDWLN=0 F  S SDWLN=$O(^TMP("SD769P",$J,"DIS",SDWLCL,SDWLN)) Q:'SDWLN  D
 ..S SDPAT=$$GET1^DIQ(409.3,SDWLN,.01),SDCLN=$$GET1^DIQ(409.3,SDWLN,8),SDIEN=SDWLN
 ..S SDTM=$$GET1^DIQ(409.3,SDWLN,5),SDPOS=$$GET1^DIQ(409.3,SDWLN,6),SDSPL=$$GET1^DIQ(409.3,SDWLN,7)
 ..I SDPAT="",SDTM="",SDPOS="",SDSPL="" D
 ...S $P(^SDWL(409.3,SDWLN,0),U)=0,DA=SDIEN,DIK="^SDWL(409.3," D ^DIK
 ...S SDTXT="Wait List Entry number "_SDIEN_" with no patient info has been deleted." D BMES^XPDUTL(SDTXT)
 Q
INACLN ;Inactivate wait list clinics without active appointments
 N SDCLN,SDCLNS,SDWLSCN,SDWLCNT,SDWLN,SDWLSTOP,SDX,DR,DA,DIE,SDTXT
 K ^TMP("SD769P",$J)
 S SDCLN=0 F  S SDCLN=$O(^SDWL(409.32,SDCLN)) Q:'SDCLN  D
 .S SDCLNS=SDCLN_","
 .Q:($P(^SDWL(409.32,SDCLN,0),U,4))'=""
 .Q:($$GET1^DIQ(409.32,SDCLNS,.01)["VCL")
 .S SDCLNS=SDCLN_",",SDWLSCN=$P($G(^SDWL(409.32,SDCLN,0)),U,1),SDWLSTOP=0
 .I $D(^SDWL(409.3,"SC",SDWLSCN))&'$P($G(^SDWL(409.32,SDCLN,0)),U,4) D
 ..S SDWLN="",SDWLCNT=0 F  S SDWLN=$O(^SDWL(409.3,"SC",SDWLSCN,SDWLN)) Q:SDWLN=""  D
 ...S SDX=$G(^SDWL(409.3,SDWLN,0)) I '$D(^SDWL(409.3,SDWLN,"DIS")) S ^TMP("SD769P",$J,"DIS",SDWLN)="",SDWLSTOP=1
 .I SDWLSTOP S SDTEXT="Clinic "_$$GET1^DIQ(409.32,SDCLNS,.01)_" has Patients on the Wait List and cannot be inactivated." D BMES^XPDUTL(SDTEXT) Q
 .S DR="3///^S X=DT;4///^S X=.5",DIE="^SDWL(409.32,",DA=SDCLN D ^DIE
 .S SDTXT="Wait List Clinic "_$$GET1^DIQ(409.32,SDCLNS,.01)_" has been inactivated." D BMES^XPDUTL(SDTXT)
 Q
LSTOTH ;List active Wait List entries not clinic specific
 N SDPAT,SDCLN,SDIEN,SDTM,SDPOS,SDSPL
 S SDIEN=0 F  S SDIEN=$O(^SDWL(409.3,SDIEN)) Q:'SDIEN  D
 .Q:$P(^SDWL(409.3,SDIEN,0),U,8)'=""  ;Quit if Clinic exists
 .Q:$D(^SDWL(409.3,SDIEN,"DIS"))  ;Quit if Dispositioned
 .I $P(^SDWL(409.3,SDIEN,0),U,5)'="" S ^TMP("SD769P",$J,"TEAM",SDIEN)="" Q
 .I $P(^SDWL(409.3,SDIEN,0),U,6)'="" S ^TMP("SD769P",$J,"POS",SDIEN)="" Q
 .I $P(^SDWL(409.3,SDIEN,0),U,7)'="" S ^TMP("SD769P",$J,"SPEC",SDIEN)="" Q
 Q
DISCLN ;
 N DIFROM ;when invoking ^XMD in post-init routine of the KIDS build, the calling routine must NEW the DIFROM variable
 N XMSUB,XMTEXT,XMY ;input vars for ^XMD call
 N SDWLN,SDTEXT,SDLN,SDPT,SDTM,SDPOS,SDPOSS,SDTMS,SDTEAM,SDSPEC,SDSPECS,SDSPECTY,SDPOSIT ;local vars
 ;construct mailman msg
 S XMSUB="SD*5.3*769 Post-Install Job Results" ;msg subject
 I $$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY("G.SD EWL BACKGROUND UPDATE")="" ;send message to mail group
 I '$$GOTLOCAL^XMXAPIG("SD EWL BACKGROUND UPDATE") S XMY($G(DUZ))="" ;msg addressee array
 S XMTEXT="SDTEXT(" ;array containing the text of msg
 S SDLN=1 ;msg line #
 S SDTEXT(SDLN)="SD*5.3*769 post-install job results."
 S SDLN=2
 S SDTEXT(SDLN)="The Following Wait List Entries need to be scheduled for the following patients.",SDLN=SDLN+1
 S SDTEXT(SDLN)="PATIENT                        CLINIC",SDLN=SDLN+1
 S SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 S SDWLN=0 F  S SDWLN=$O(^TMP("SD769P",$J,"DIS",SDWLN)) Q:'SDWLN  D
 .S SDCLNS=SDWLN_"," S SDWLSCN=$$GET1^DIQ(409.3,SDCLNS,8),SDPT=$$GET1^DIQ(409.3,SDCLNS,.01)
 .S SDPT=SDPT_"                               ",SDPT=$E(SDPT,1,31)
 .S SDLN=SDLN+1,SDTEXT(SDLN)=SDPT_SDWLSCN
 S SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDLN=SDLN+1,SDTEXT(SDLN)="PATIENT                        TEAM",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 S SDTM=0 F  S SDTM=$O(^TMP("SD769P",$J,"TEAM",SDTM)) Q:'SDTM  D
 .S SDTMS=SDTM_"," S SDTEAM=$$GET1^DIQ(409.3,SDTMS,5),SDPT=$$GET1^DIQ(409.3,SDTMS,.01)
 .S SDPT=SDPT_"                               ",SDPT=$E(SDPT,1,31)
 .S SDLN=SDLN+1,SDTEXT(SDLN)=SDPT_SDTEAM
 S SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDLN=SDLN+1,SDTEXT(SDLN)="PATIENT                        POSITION",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 S SDPOS=0 F  S SDPOS=$O(^TMP("SD769P",$J,"POS",SDPOS)) Q:'SDPOS  D
 .S SDPOSS=SDPOS_"," S SDPOSIT=$$GET1^DIQ(409.3,SDPOSS,6),SDPT=$$GET1^DIQ(409.3,SDPOSS,.01)
 .S SDPT=SDPT_"                               ",SDPT=$E(SDPT,1,31)
 .S SDLN=SDLN+1,SDTEXT(SDLN)=SDPT_SDPOSIT
 S SDLN=SDLN+1,SDTEXT(SDLN)=""
 S SDLN=SDLN+1,SDTEXT(SDLN)="PATIENT                        SPECIALTY",SDLN=SDLN+1
 S SDLN=SDLN+1,SDTEXT(SDLN)="----------------------------------------------------------",SDLN=SDLN+1
 S SDSPEC=0 F  S SDSPEC=$O(^TMP("SD769P",$J,"SPEC",SDSPEC)) Q:'SDSPEC  D
 .S SDSPECS=SDSPEC_"," S SDSPECTY=$$GET1^DIQ(409.3,SDSPECS,7),SDPT=$$GET1^DIQ(409.3,SDSPECS,.01)
 .S SDPT=SDPT_"                               ",SDPT=$E(SDPT,1,31)
 .S SDLN=SDLN+1,SDTEXT(SDLN)=SDPT_SDPOSIT
 D ^XMD
 K ^TMP("SD769P",$J)
MENLST ;Protocol Menu list
 ;;SDAM MENU
 ;;$$END
 ;
PROLST ;Protocol to remove
 ;;SD WAIT LIST DISPOSITION
 ;;SD WAIT LIST DISPLAY
 ;;$$END
 ;
DISLST ;Protocols to Disable
 ;;SDWL XFER ACC ACCEPT
 ;;SDWL XFER ACC EWL
 ;;SDWL XFER ACC MNU MAIN
 ;;SDWL XFER ACC MNU VIEW
 ;;SDWL XFER ACC PCMM
 ;;SDWL XFER ACC PRINT C/S
 ;;SDWL XFER ACC REJECT
 ;;SDWL XFER ACC VIEW
 ;;SDWL XFER REQ INAC
 ;;SDWL XFER REQ MNU INAC
 ;;SDWL XFER REQ MNU MAIN
 ;;SDWL XFER REQ MNU REMV
 ;;SDWL XFER REQ MNU VIEW
 ;;SDWL XFER REQ NEW
 ;;SDWL XFER REQ REMV
 ;;SDWL XFER REQ REMV CONF
 ;;SDWL XFER REQ VIEW
 ;;SD WAIT LIST DISPLAY
 ;;SD WAIT LIST DISPOSITION
 ;;$$END
 ;
OPTLST ;Options to mark OOO
 ;;SCMC PCMM EWL MENU
 ;;SD WAIT CLEAN-UP MENU REMOVE
 ;;SD WAIT ENROLL CLEANUP RPT
 ;;SD WAIT ENROLLEE APPLY TF
 ;;SD WAIT ENROLLEE B/R UTILITY
 ;;SD WAIT ENROLLEE TEMP FILE
 ;;SD WAIT LIST 30>30>120 REPORT
 ;;SD WAIT LIST ADHOC REPORT V1
 ;;SD WAIT LIST ADHOC REPORT V2
 ;;SD WAIT LIST APPT REPORT
 ;;SD WAIT LIST CLEANUP
 ;;SD WAIT LIST ENROLL REPORT
 ;;SD WAIT LIST GUI
 ;;SD WAIT LIST INQUIRY
 ;;SD WAIT LIST MENU
 ;;SD WAIT LIST OPEN CLOSED ENTRY
 ;;SD WAIT LIST OVERDUE REPORT
 ;;SD WAIT LIST PAR ENTER/EDIT
 ;;SD WAIT LIST PRM CARE/TEAM
 ;;SD WAIT LIST REOPEN ENTRIES
 ;;SD WAIT LIST REPORTS MENU
 ;;SD WAIT LIST SC PRIORITY EDIT
 ;;SD WAIT LIST STAT REPORT
 ;;SD WAIT LIST UPLOAD VSSC
 ;;SD WAIT LIST UTILITIES
 ;;SDWL 30 DAY REPORT
 ;;SDWL BATCH CLINIC CHANGE
 ;;SDWL ENTER/EDIT WITH ACA FLAG
 ;;SDWL NON-REMOVAL REASON RPT
 ;;SDWL TRANSFER ACCEPT
 ;;SDWL TRANSFER PRINT REQUESTS
 ;;SDWL TRANSFER REQUEST
 ;;SDWL WAIT TIME STATISTICS
 ;;SDWL-XFER-SERVER
 ;;SD WAIT LIST DISPOSITION ENTRY
 ;;$$END
