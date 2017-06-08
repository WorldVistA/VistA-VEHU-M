PXRMP51E ;SLC/PKR - Exchange inits for PXRM*2.0*51 ;03/02/2015
 ;;2.0;CLINICAL REMINDERS;**51**;Feb 04, 2005;Build 211
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-TERATOGENIC MEDICATIONS ORDER CHECKS (UPDATE #2 PXRM*2*51)"
 I MODE["I" S ARRAY(LN,2)="02/19/2015@09:21:26"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
