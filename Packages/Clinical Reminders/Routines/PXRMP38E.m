PXRMP38E ;SLC/PKR - Exchange inits for PXRM*2.0*38 ;11/24/2014
 ;;2.0;CLINICAL REMINDERS;**38**;Feb 04, 2005;Build 207
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-ONCOLOGY LUNG TEMPLATE PXRM*2.0*38"
 I MODE["I" S ARRAY(LN,2)="11/21/2014@07:34:10"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-PATCH 38 POST COMPONENTS"
 I MODE["I" S ARRAY(LN,2)="01/09/2014@11:48:04"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
