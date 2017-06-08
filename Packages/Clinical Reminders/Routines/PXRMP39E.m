PXRMP39E ;SLC/PKR - Exchange inits for PXRM*2.0*39 ;10/31/2014
 ;;2.0;CLINICAL REMINDERS;**39**;Feb 04, 2005;Build 209
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-AH/BPR PXRM*2*39"
 I MODE["I" S ARRAY(LN,2)="10/28/2014@04:02:26"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-PATCH 39 POST COMPONENTS"
 I MODE["I" S ARRAY(LN,2)="01/17/2014@11:47:21"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
