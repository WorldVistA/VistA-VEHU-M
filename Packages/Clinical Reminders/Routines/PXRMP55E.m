PXRMP55E ;SLC/PKR - Exchange inits for PXRM*2.0*55 ;12/22/2014
 ;;2.0;CLINICAL REMINDERS;**55**;Feb 04, 2005;Build 215
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PATCH PXRM*2*55 PNEUMOCOCCAL UPDATE"
 I MODE["I" S ARRAY(LN,2)="12/22/2014@10:43:12"
 I MODE["A" S ARRAY(LN,3)="U"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
