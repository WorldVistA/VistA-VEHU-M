PXRMP82I ;ISP/AGP - PATCH 82 INSTALLATION ;Oct 26, 2022@13:16:14
 ;;2.0;CLINICAL REMINDERS;**82**;Feb 04, 2005;Build 28
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VAL-EHR CUTOVER BANNER"
 I MODE["I" S ARRAY(LN,2)="10/26/2022@14:12:52"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 Q
 ;
POST ;Post-init
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP82I")
 ;Enable options and protocols
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*82")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*82")
 Q
 ;
PRE ;Pre-init
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*82")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*82")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP82I")
 Q
 ;
