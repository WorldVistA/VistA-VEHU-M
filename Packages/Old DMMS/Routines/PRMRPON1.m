PRMRPON1 ;GLRISC/JES,GWB,DAD-PRODUCE AUTOMATED INPUT SHEET FOR 10-2633 ; 1/29/89  12:04 ;
 ;VERSION 1.01
 U IO S (PRMRO,PRMRD,PRMRH)=0 S:$E(IOST)="C" PRMRD=1 W @IOF D HEAD
 D HEAD Q:PRMRO  W !?20,"PATIENT INJURY CONTROL WORKSHEET",?58,"DATE:",PRMRL17,!!!,"PATIENT:",PRMRL33,?46,"DATE OF INCIDENT:",PRMRL17,!,"(IN)npatient (OU)tpatient (MI)scellaneous",?46,"TIME OF INCIDENT:",PRMRL17
 D HEAD Q:PRMRO  W !!,"WARD:",PRMRL17,!!,"REPORTER:",PRMRL71,!,"(NU) Nursing Staff  (PH) Physician/Dentist  (AL) Allied Health  (OT) Other"
 D HEAD Q:PRMRO  W !!,"SERVICE(S) INVOLVED:",PRMRL60,!!,"BRIEF DESCRIPTION OF INCIDENT (UP TO 60 CHARACTERS):",!!,PRMRL80
 D HEAD Q:PRMRO  S X="" W !!,"TYPE OF INCIDENT (CIRCLE ONE):",! S N=0 F I=1:1:PRMRIT S N=$O(PRMRHLD(N)) W !,"("_$P(PRMRHLD(N),"^",1)_")",?8,$P(PRMRHLD(N),"^",2) D HEAD Q:PRMRO
 I PRMRD W !!,"""^"" TO STOP: " R X:DTIME Q:X["^"!'$T
 D CON W !,"LOCATION OF INCIDENT: (CIRCLE ONE):"
 D HEAD Q:PRMRO  W !!,"(PA) Patient's Room           (TR) Treatment area",!,"(BA) Bathroom                 (NO) Non-treatment area",!,"(HA) Hallway/stairs           (ON) Outside of hospital - on grounds"
 D HEAD Q:PRMRO  W !,"(OT) Other                    (OT) Outside of hospital - off grounds",!!,"WITNESSED: (NO) Not witnessed   (WI) Witnessed by reporter   (OT) Other"
 D HEAD Q:PRMRO  W !!,"PROCEDURE AND DATE (IF PRECIPITATED INCIDENT):",!!,PRMRL80
 D HEAD Q:PRMRO  W !!,"PATIENT MENTAL STATUS (CIRCLE ALL RELEVANT)",!!,"(AL) Alert  (DI) Disoriented  (AG) Agitated  (NO) Non-responsive  (UN) Unknown"
 D HEAD Q:PRMRO  W !!,"PATIENT ACTIVITY STATUS: (CIRCLE ALL RELEVANT)",!!,"(UP) Up as tolerated      (WA) Ward restriction  (AM) Ambulatory with assistance",!,"(BA) Bathroom privileges  (BE) Bedrest"
 D HEAD Q:PRMRO  W !!,"FALL FACTOR (CIRCLE MOST IMPORTANT):"
 D HEAD Q:PRMRO  W !!,"(MC) Medical condition related   (ME) Medication related   (OT) Other/unknown",!,"(EN) Environment related         (EQ) Equipment related",!!,"FALL FACTOR COMMENTS: ",PRMRL58
 D HEAD Q:PRMRO  W !!,"MEDICATION ERROR FACTOR (CIRCLE MOST IMPORTANT):"
 D HEAD Q:PRMRO  W !!,"(OM) Omission error (AL) Allergy not noted  (DO) Wrong dose  (RO) Wrong route",!,"(TI) Wrong time     (PA) Wrong patient      (RA) Wrong rate  (ME) Wrong medicine"
 D HEAD Q:PRMRO  W !!,"MEDICATION ERROR COMMENTS: ",PRMRL53,!!,"MEDICATION ERROR RESPONSIBLE PARTY:",PRMRL45
 D HEAD Q:PRMRO  W !!,"PROTECTIVE MEASURE(S) IN EFFECT AT TIME OF INCIDENT (CIRCLE ALL RELEVANT):"
 D HEAD Q:PRMRO  W !!,"(SI) Side rails                                 (BE) Bed brakes",!,"(PR) Prosthetic equipment (wheelchair, etc.)    (RE) Restraints",!,"(CA) Call light, night light, alarm             (ES) Escort"
 D HEAD Q:PRMRO  W !,"(SP) Special precautions (including suicide)    (OT) Other"
 D HEAD Q:PRMRO  W !!,"EXAMINATION DATE:",PRMRL33,"____",?54,"TIME",PRMRL17,"_____",!!,"EXAMINING PHYSICIAN:",PRMRL60,!!,"FINDINGS:"
 D HEAD Q:PRMRO  W !!,"(NO) No evidence of injury       (SU) Sutures or other therapy ordered/done",!,"(RO) Routine lab/x-rays ordered  (FI) First aid given            (OT) Other"
 D HEAD Q:PRMRO  W !!,"SEVERITY OF INJURY:",!!,"(MIT) Minor temporary   (MIP) Minor permanent   (POT) Potential major",!,"(MAT) Major temporary   (MAP) Major permanent   (DEA) Death       (NO) None"
 D HEAD Q:PRMRO  W !!,"EXAMINATION PLAN:",!!,"(KE) Keep under observation   (PR) Prolong stay   (TR) Transfer out   (NO) None" D HEAD Q:PRMRO  W @IOF
 Q
HEAD ; PRINT APPROPRIATE PAGE BREAKS
 Q:'PRMRD  I PRMRH,PRMRD,$Y>(IOSL-6) W !!,"""^"" TO STOP: " R X:DTIME S:X["^"!'$T PRMRO=1 S PRMRH=0
 W:'PRMRH @IOF S PRMRH=1
 Q
CON W !!?20,"...... continued next page ......",@IOF Q
