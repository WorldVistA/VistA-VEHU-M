PXRMP61E ;SLC/PKR - Exchange inits for PXRM*2.0*61 ;08/10/2015
 ;;2.0;CLINICAL REMINDERS;**61**;Feb 04, 2005;Build 221
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*61 IRAQ UPDATES"
 I MODE["I" S ARRAY(LN,2)="08/10/2015@04:50:40"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*61 TAXONOMY UPDATES INC 2"
 I MODE["I" S ARRAY(LN,2)="08/20/2015@14:01:14"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
