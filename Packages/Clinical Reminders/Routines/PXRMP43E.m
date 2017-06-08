PXRMP43E ;SLC/PKR - Exchange inits for PXRM*2.0*43 ;06/03/2015
 ;;2.0;CLINICAL REMINDERS;**43**;Feb 04, 2005;Build 211
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MST SCREENING PXRM*2*43"
 I MODE["I" S ARRAY(LN,2)="06/03/2015@11:53:11"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
