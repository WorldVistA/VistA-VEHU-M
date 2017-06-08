PXRMP50E ;SLC/PKR - Exchange inits for PXRM*2.0*50 ;11/17/2014
 ;;2.0;CLINICAL REMINDERS;**50**;Feb 04, 2005;Build 212
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PATCH*2.0*50 NATIONAL TAXONOMY UPDATE 1"
 I MODE["I" S ARRAY(LN,2)="11/14/2014@11:42:29"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PATCH*2.0*50 UPDATE AAA URLS"
 I MODE["I" S ARRAY(LN,2)="10/14/2014@17:18:55"
 I MODE["A" S ARRAY(LN,3)="M"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
