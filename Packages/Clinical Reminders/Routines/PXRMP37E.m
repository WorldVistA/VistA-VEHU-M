PXRMP37E ;SLC/PKR - Exchange inits for PXRM*2.0*37 ;05/05/2015
 ;;2.0;CLINICAL REMINDERS;**37**;Feb 04, 2005;Build 208
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-CAREGIVER DIALOG TEMPLATES"
 I MODE["I" S ARRAY(LN,2)="04/27/2015@12:46:54"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
