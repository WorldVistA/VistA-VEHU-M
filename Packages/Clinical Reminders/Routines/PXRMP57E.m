PXRMP57E ;SLC/PKR - Exchange inits for PXRM*2.0*57 ;12/22/2014
 ;;2.0;CLINICAL REMINDERS;**57**;Feb 04, 2005;Build 216
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*57  VA-ADVANCE DIRECTIVE NOTIFICATION AND SCREENING (D)"
 I MODE["I" S ARRAY(LN,2)="12/22/2014@10:26:48"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
