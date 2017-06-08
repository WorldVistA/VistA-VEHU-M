PXRMP54E ;SLC/PKR - Exchange inits for PXRM*2.0*54 ;11/05/2014
 ;;2.0;CLINICAL REMINDERS;**54**;Feb 04, 2005;Build 211
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PATCH PXRM*2*54 EBOLA RISK TRIAGE TOOL"
 I MODE["I" S ARRAY(LN,2)="11/05/2014@13:49:07"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
