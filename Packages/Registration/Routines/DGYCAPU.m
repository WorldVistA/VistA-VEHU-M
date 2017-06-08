DGYCAPU ;ALB/MTC - MAS V5.2 PATCH #  ATTENDING PHYSICIAN UPDATE; 9-21-92
 ;;5.2;REGISTRATION;**8**;JUL 29,1992
 ;
 D LOOP
 Q
 ;
LOOP ;-- This function will loop through all the current inpatients
 ; identified by the "CN" x-ref of the Patient Movement file.
 ; Then a call will be made in INP^VADPT to get the current
 ; attending phyician. Lastly, the entry in the Patient file 
 ; field (.1041) will be updated with the current attending physician.
 N DGI,DGJ,DGK,DGX,DFN
 W !,">>> Updating Attending Physician field (#.1041) in the"
 W !,"    Patient file (#2) for all current inpatients."
 S DGI="" F DGK=1:1 S DGI=$O(^DGPM("CN",DGI)) Q:DGI']""  W:'(DGK#10) "." D
 . S DGJ=0 F  S DGJ=$O(^DGPM("CN",DGI,DGJ)) Q:'DGJ  D
 .. S DFN=$P($G(^DGPM(DGJ,0)),U,3) I DFN D INP^VADPT I +VAIN(11) D
 ... S DGX=$G(^DPT(DFN,.1041)) I +DGX'=+VAIN(11) S DIE="^DPT(",DA=DFN,DR=".1041///"_+VAIN(11) D ^DIE K DIE,DA,DR
 Q
 ;
