PXRMP32E ;SLC/PKR - Exchange inits for PXRM*2.0*32 ;06/02/2014
 ;;2.0;CLINICAL REMINDERS;**32**;Feb 04, 2005;Build 194
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH EBP DIALOGS INCREMENT 3"
 I MODE["I" S ARRAY(LN,2)="05/29/2014@00:00:43"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
