SD5357EN ;ALB/ESD - SD*5.3*57 Environment Checker; 25-SEP-96
 ;;5.3;Scheduling;**57**;AUG 13, 1993
ENVCHK ;Entry point for environment checker
 ;
 ;Input  : All variables set by KIDS
 ;Output : Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 ;
 N PATCHED
 W !!,">>> Beginning SD*5.3*57 environment check...",!!
 ;
 ;- Check for installation of SD*5.3*44 - required for install
 W !!,"      Checking for installation of patch SD*5.3*57 ..."
 S PATCHED=$$PATCH^XPDUTL("SD*5.3*44")
 I ('PATCHED) D
 .W !!,"     *** Required element missing ***"
 .W !,"      Installation of this patch requires that the Ambulatory"
 .W !,"      Care Reporting Project (ACRP) patch SD*5.3*44 be installed."
 .W !
 .S XPDABORT=2
 ;
 ;- Write abort message or successful message
 I (+$G(XPDABORT)) W !!,">>> Patch SD*5.3*57 aborted in environment checker.",!!
 W:('$G(XPDABORT)) !!,">>> Environment check passed.",!!
 ;
 Q
