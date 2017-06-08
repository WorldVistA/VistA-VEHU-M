PXRMP29E ;SLC/PKR - Exchange inits for PXRM*2.0*29 ;04/08/2014
 ;;2.0;CLINICAL REMINDERS;**29**;Feb 04, 2005;Build 196
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH ACT DIALOGS T-1"
 I MODE["I" S ARRAY(LN,2)="04/07/2014@09:32:06"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH CBT-D DIALOGS T-1"
 I MODE["I" S ARRAY(LN,2)="04/07/2014@09:34:11"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH CPT DIALOGS T-2"
 I MODE["I" S ARRAY(LN,2)="04/07/2014@09:38:19"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH PEI DIALOGS T-2"
 I MODE["I" S ARRAY(LN,2)="04/07/2014@09:40:54"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
