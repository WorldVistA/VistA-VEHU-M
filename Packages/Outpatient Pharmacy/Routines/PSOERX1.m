PSOERX1 ;ALB/BWF - eRx Utilities/RPC's ;Aug 14, 2020@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**467,520,527,508,551,581,635,617,700,746**;DEC 1997;Build 106
 ;
EN(PSOIEN) ; -- main entry point for PSO ERX HOLDING QUEUE
 D EN^PSOERSE1(PSOIEN)
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="eRx Patient: "_$$GET1^DIQ(52.49,PSOIEN,.04,"E")
 S VALMHDR(2)="eRx Reference #: "_$$GET1^DIQ(52.49,PSOIEN,.01,"E")
 I $$GET1^DIQ(52.49,PSOIEN,10.5,"I")=2 D
 . S VALMHDR(2)=VALMHDR(2)_"  "_IORVON_"ERX HAS DO NOT FILL INDICATOR PER PROVIDER"_IORVOFF
 S VALMHDR(3)=$$BHW^PSOERXIU(PSOIEN)
 I $G(VALMBCK)="R" K @VALMAR S VALMBCK="" D INIT
 Q
 ;
INIT ;
 Q:'$G(PSOIEN)
 ; - Resetting list to NORMAL video attributes
 D RESET^PSOERUT0()
 D INIT^PSOERX1G
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K @VALMAR
 ; PSO*7*527 - set VALMBCK and PSOREFSH to force refresh when returning to list view
 S VALMBCK="R",PSOREFSH=1
 Q
 ;
EXPND ; -- expand code
 Q
