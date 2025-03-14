GMTSPST5 ;HINES/RMS - TIU OBJECT FOR REMOTE ALLERGIES VIA RDI ;Aug 21, 2018@14:28
 ;;2.7;Health Summary;**94**;Oct 20, 1995;Build 41
 ;
 ;Reference to ORRDI1 supported by DBIA 4659
 ;Reference to ^XTMP("ORRDI","OUTAGE INFO" supported by DBIA 5440
 ;
ENHS ;ENTRY POINT FOR HEALTH SUMMARY OF REMOTE AND LOCAL ALLERGY/ADR DATA
 N GMTSHDR,GMTSRET,GMTSALG,GMTSALGR,GMTSFAC,GMTSREAC,GMTSRDI,GMTSDOWN,GMTSSTAT,GMTSSMSG
 Q:'$G(DFN)
 S GMTSSMSG=""
 ;Track usage of this routine
 D ADD^GMTSPSTR("GMTSPST5")
 ;
 ;Get Remote Allergy/ADR Data
 D RMTALG
 I GMTSSTAT=1 D
 .F GMTSALG=1:1:GMTSRET D
 .. S GMTSFAC=$G(^XTMP("ORRDI","ART",DFN,GMTSALG,"FACILITY",0))
 .. S GMTSREAC=$G(^XTMP("ORRDI","ART",DFN,GMTSALG,"GMRALLERGY",0))
 .. Q:$$YESCHK
 .. Q:GMTSFAC']""!(GMTSREAC']"")
 .. S GMTSFAC=$P(GMTSFAC,"^",2)
 .. S GMTSREAC=$P(GMTSREAC,U,2)
 .. S GMTSALGR(GMTSFAC,GMTSREAC)=""
 .S GMTSRET=$O(^XTMP("ORRDI","ART",DFN,"ASSESSMENT",""),-1)
 .F GMTSALG=1:1:+GMTSRET D
 .. S GMTSFAC=$G(^XTMP("ORRDI","ART",DFN,"ASSESSMENT",GMTSALG,"FACILITY",0))
 .. S GMTSREAC=$G(^XTMP("ORRDI","ART",DFN,"ASSESSMENT",GMTSALG))
 .. Q:$$YESCHK
 .. Q:GMTSFAC']""!(GMTSREAC']"")
 .. S GMTSFAC=$P(GMTSFAC,"^",2)
 .. S GMTSREAC=$P(GMTSREAC,U,2)
 .. S GMTSALGR(GMTSFAC,GMTSREAC)=""
 ;
 ;Get Local Allergy/ADR Data
 N LOCFAC S LOCFAC=$P($$SITE^VASITE,"^",2)
 N GMI,GMRAL D EN1^GMRADPT
 ; HERE, 1=Allergy List, 0=NKA, NULL=No Assessment
 I GMRAL=1 D
 . S GMI=0 F  S GMI=$O(GMRAL(GMI)) Q:GMI'>0  S GMTSALGR(LOCFAC,$P(GMRAL(GMI),U,2))=""
 I GMRAL=0 D
 . S GMTSALGR(LOCFAC,"No Known Allergies")=""
 I GMRAL="" D
 . S GMTSALGR(LOCFAC,"No Allergy Assessment Completed")=""
 ;
 ;Display HS Component
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"FACILITY",?40,"ALLERGY/ADR",!,"--------",?40,"-----------"
 D CKP^GMTSUP Q:$D(GMTSQIT)
 I GMTSSTAT=0 D  ;Q   ;Took out QUIT here so local allergy info can display
 .D CKP^GMTSUP Q:$D(GMTSQIT)
 .W !,GMTSSMSG
 .D CKP^GMTSUP Q:$D(GMTSQIT)
 S GMTSFAC="" F  S GMTSFAC=$O(GMTSALGR(GMTSFAC)) Q:GMTSFAC']""  D  ;
 . S GMTSREAC="" F  S GMTSREAC=$O(GMTSALGR(GMTSFAC,GMTSREAC)) Q:GMTSREAC']""  D  ;
 .. D CKP^GMTSUP Q:$D(GMTSQIT)
 .. W !,$E(GMTSFAC,1,38),?40,GMTSREAC
 .. D CKP^GMTSUP Q:$D(GMTSQIT)
 W ! D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
 ;
RMTALG ;
 ;ZEXCEPT: GMTSDOWN,GMTSHDR,GMTSREAC,GMTSRET,GMTSSMSG,GMTSSTAT
 S GMTSSTAT=0
 S GMTSSMSG=""
 S GMTSHDR=$$HAVEHDR^ORRDI1 I '+$G(GMTSHDR) D  Q
 . S GMTSSMSG="*** WARNING: Remote Data from HDR not available ***"
 D  Q:$G(GMTSDOWN)
 . I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) H $$GET^XPAR("ALL","ORRDI PING FREQ")/2
 . I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) S GMTSDOWN=1 D
 .. S GMTSSMSG="*** WARNING: Connection to Remote Data Currently Down ***"
 D  ;RDI/HDR CALL ENCAPSULATION
 . D SAVDEV^%ZISUTL("GMTSHFS")
 . S GMTSRET=$$GET^ORRDI1(DFN,"ART")
 . D USE^%ZISUTL("GMTSHFS")
 . D RMDEV^%ZISUTL("GMTSHFS")
 I GMTSRET=-1 D  Q
 . S GMTSSMSG="*** WARNING: Connection to Remote Data Not Available ***"
 I '$D(^XTMP("ORRDI","ART",DFN))!('+GMTSRET) D  Q
 . I $D(^XTMP("ORRDI","ART",DFN,"ASSESSMENT")) S GMTSSTAT=1 Q
 . S GMTSSMSG="No Remote Allergy/ADR Data available for this patient"
 S GMTSSTAT=1
 Q
 ;
YESCHK() ;DO NOT INCLUDE IF A 'YES' ASSESSMENT
 I $P(GMTSREAC,U,2)'="YES" Q 0
 I $P(GMTSREAC,U,2)="YES" I $P(GMTSREAC,U,3)["99VA8" Q 1
 Q 1 ;STOP IF THERE IS ANY PROBLEMATIC DATA
 ;----------------------------------------------------------
