SD5368EN ;ALB/JRP - ENVIRONMENT CHECK ROUTINE;16-OCT-1996
 ;;5.3;Scheduling;**68**;AUG 13, 1993
 ;
EN ;Main entry point for patch SD*5.3*68 environment check routine
 ;
 ;Input  : All variables set by KIDS
 ;Output : Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 ;
 N PATCHED
 W !!,">>> Beginning SD*5.3*68 environment check"
 ;
 ;Check for installation of SD*5.3*44 - required for install
 W !!,"      Checking for installation of patch SD*5.3*44 ... "
 S PATCHED=$$PATCH^XPDUTL("SD*5.3*44")
 I ('PATCHED) D
 .W !!,"      *** Required element missing ***"
 .W !,"      Installation of this patch requires that Ambulatory Care"
 .W !,"      Reporting (Scheduling patch SD*5.3*44) be installed."
 .W !
 .S XPDABORT=2
 I (PATCHED) W "OK"
 ;
 ;Check for installation of SD*5.3*57 - required for install
 W !!,"      Checking for installation of patch SD*5.3*57 ... "
 S PATCHED=$$PATCH^XPDUTL("SD*5.3*57")
 I ('PATCHED) D
 .W !!,"      *** Required element missing ***"
 .W !,"      Installation of this patch requires that Scheduling"
 .W !,"      patch SD*5.3*57 be installed."
 .W !
 .S XPDABORT=2
 I (PATCHED) W "OK"
 ;Done - print success/abort message
 W !
 ;Abort
 I (+($G(XPDABORT))) W !,">>> Installation of patch SD*5.3*68 has been aborted"
 ;Success
 I ('($G(XPDABORT))) W !,">>> Installation of patch SD*5.3*68 will proceed as planned"
 W !!
 Q
