ECXFEKE1 ;BIR/DMA,CML-Print Feeder Keys (CONTINUED); [ 03/28/96  5:44 PM ] ;2/1/24  10:46
 ;;3.0;DSS EXTRACTS;**11,8,40,149,174,190**;Dec 22, 1997;Build 36
 ;
SELLABKE() ;** Function to prompt user selection of type of Lab Feeder Key
 ;
 ;** Variable Definitions
 ;**  ECXKEY    - Value of user selection returned to calling code
 ;**                Returns  N - LMIP Code formated feeder keys
 ;**                         O - Locally formated feeder keys
 ;**                        -1 - User uparrow (^) or Time out
 ;
 N ECXKEY
 W !!,"The Feeder Key List for the Feeder System LAB can be printed by:"
 W !,?5,"(O)ld Feeder Key sort by Local Feeder Key values"
 W !,?5,"(N)ew Feeder Key sort by LMIP Codes"
 S DIR(0)="S^O:OLD;N:NEW"
 S:$D(^ECX(728,1,"LMIP")) DIR("B")="NEW"
 S:'$D(^ECX(728,1,"LMIP")) DIR("B")="OLD"
 D ^DIR
 S:$D(DIRUT) ECXKEY=-1
 S:'$D(DIRUT) ECXKEY=Y
 K Y,DIR,DIRUT,DTOUT,DUOUT
 Q ECXKEY
 ;
SUR ;
 G SUR25 ; Updated for FY25 and beyond - ECX*3*190
 F EC=1:1:16 S EC1=$P($T(@("S"_EC)),";",3),EC2=$P(EC1,U),ECD=$P(EC1,U,2),^TMP($J,"SUR",EC2_"-10",EC)=ECD_" PATIENT TIME",^TMP($J,"SUR",EC2_"-40",EC)=ECD_" SURGEON TIME" D
 .S ^TMP($J,"SUR",EC2_"-60",EC)=ECD_" RECOVERY ROOM TIME",^TMP($J,"SUR",EC2_"-70",EC)=ECD_" TECHNICIAN TIME",^TMP($J,"SUR",EC2_"-30",EC)=ECD_" CLEANUP TIME"
 .S ^TMP($J,"SUR",EC2_"-22",1)=ECD_" ANESTHESIA TIME (SPECIAL)"
 .S ^TMP($J,"SUR",EC2_"-21",1)=ECD_" ANESTHESIA TIME (GENERAL)"
 .S ^TMP($J,"SUR",EC2_"-23",1)=ECD_" ANESTHESIA TIME (LOCAL)"
 .S ^TMP($J,"SUR",EC2_"-24",1)=ECD_" ANESTHESIA TIME (SPI/EPI)"
 .S ^TMP($J,"SUR",EC2_"-25",1)=ECD_" ANESTHESIA TIME (OTHER)"
 .S ^TMP($J,"SUR",EC2_"-26",1)=ECD_" ANESTHESIA TIME (UNKNOWN)"
 .S ^TMP($J,"SUR",EC2_"-27",1)=ECD_" ANESTHESIA TIME (MONITORED)"
 S EC=0 F  S EC=$O(^SRO(131.9,EC)) Q:'EC  I $D(^(EC,0)) S ECD=$P(^(0),U),^TMP($J,"SUR",$$RJ^XLFSTR(EC,5,0),EC)=ECD
 Q
SUR25 ; Code implemented with ECX*3*190
 ; Rather than build the feeder keys from a fixed list, the Specialty Codes
 ; will come from the SPECIALTY CODES file (#45.3). In addition, Organs
 ; transplanted will be listed for specific Specialty Codes.
 N CODE,IEN,DESC
 S CODE="" F  S CODE=$O(^DIC(45.3,"B",CODE)) Q:CODE=""  S IEN=0 F  S IEN=$O(^DIC(45.3,"B",CODE,IEN)) Q:'IEN  D
 . S DESC=$P(^DIC(45.3,IEN,0),"^",2)
 . S ^TMP($J,"SUR","0"_CODE_"-10",CODE)=DESC_" PATIENT TIME"
 . S ^TMP($J,"SUR","0"_CODE_"-40",CODE)=DESC_" SURGEON TIME"
 . S ^TMP($J,"SUR","0"_CODE_"-60",CODE)=DESC_" RECOVERY ROOM TIME"
 . S ^TMP($J,"SUR","0"_CODE_"-70",CODE)=DESC_" TECHNICIAN TIME"
 . S ^TMP($J,"SUR","0"_CODE_"-30",CODE)=DESC_" CLEANUP TIME"
 . S ^TMP($J,"SUR","0"_CODE_"-22",1)=DESC_" ANESTHESIA TIME (SPECIAL)"
 . S ^TMP($J,"SUR","0"_CODE_"-21",1)=DESC_" ANESTHESIA TIME (GENERAL)"
 . S ^TMP($J,"SUR","0"_CODE_"-23",1)=DESC_" ANESTHESIA TIME (LOCAL)"
 . S ^TMP($J,"SUR","0"_CODE_"-24",1)=DESC_" ANESTHESIA TIME (SPI/EPI)"
 . S ^TMP($J,"SUR","0"_CODE_"-25",1)=DESC_" ANESTHESIA TIME (OTHER)"
 . S ^TMP($J,"SUR","0"_CODE_"-26",1)=DESC_" ANESTHESIA TIME (UNKNOWN)"
 . S ^TMP($J,"SUR","0"_CODE_"-27",1)=DESC_" ANESTHESIA TIME (MONITORED)"
 . I "48^49^50^59^62"[CODE D
 . . S ^TMP($J,"SUR","0"_CODE_"-HART",1)=DESC_" HEART TRANSPLANT"
 . . S ^TMP($J,"SUR","0"_CODE_"-LUNG",1)=DESC_" LUNG TRANSPLANT"
 . . S ^TMP($J,"SUR","0"_CODE_"-KDNY",1)=DESC_" KIDNEY TRANSPLANT"
 . . S ^TMP($J,"SUR","0"_CODE_"-LIVR",1)=DESC_" LIVER TRANSPLANT"
 . . S ^TMP($J,"SUR","0"_CODE_"-PCRS",1)=DESC_" PANCREAS TRANSPLANT"
 . . S ^TMP($J,"SUR","0"_CODE_"-INTN",1)=DESC_" INTESTINE TRANSPLANT"
 . . S ^TMP($J,"SUR","0"_CODE_"-OTHR",1)=DESC_" OTHER TRANSPLANT"
 S IEN=0 F  S IEN=$O(^SRO(131.9,IEN)) Q:'IEN  I $D(^(IEN,0)) S DESC=$P(^(0),U),^TMP($J,"SUR",$$RJ^XLFSTR(IEN,5,0),IEN)=DESC
 Q
 ;
S1 ;;050^GENERAL(OR WHEN NOT DEFINED BELOW)
S2 ;;051^GYNECOLOGY
S3 ;;052^NEUROSURGERY
S4 ;;053^OPHTHALMOLOGY
S5 ;;054^ORTHOPEDICS
S6 ;;055^OTORHINOLARYNGOLOGY (ENT)
S7 ;;056^PLASTIC SURGERY (INCLUDES HEAD AND NECK)
S8 ;;057^PROCTOLOGY
S9 ;;058^THORACIC SURGERY (INC. CARDIAC SURG.)
S10 ;;059^UROLOGY
S11 ;;060^ORAL SURGERY (DENTAL)
S12 ;;061^PODIATRY
S13 ;;062^PERIPHERAL VASCULAR
S14 ;;500^CARDIAC SURGERY
S15 ;;501^TRANSPLANTATION
S16 ;;502^ANESTHESIOLOGY
 ;
DEN F EC=3:1 S EC1=$T(DEN+EC) Q:EC1'?1"D"2N.E  S ECD=$P(EC1,";",3),EC1=$P(EC1," "),^TMP($J,"DEN",EC1,EC)=ECD
 Q
 ;
D08C ;;COMPLETE EXAM
D08S ;;SCREENING EXAM
D09 ;;ADMIN PROCEDURE
D10 ;;X-RAYS EXTRAORAL #
D11 ;;X-RAYS INTRAORAL #
D12 ;;PROPHY NATURAL DENTITION
D13 ;;PROPHY DENTURE
D14 ;;OPERATING ROOM
D15 ;;NEOPLASM CONFIRMED MALIGNANT #
D16 ;;NEOPLASM REMOVED #
D17 ;;BIOPSY/SMEAR #
D18 ;;FRACTURE #
D20 ;;OTHER SIGNIF. SURG. (CTV)
D21 ;;SURFACES RESTORED #
D22 ;;ROOT CANAL THERAPY #
D23 ;;PERIDONTAL QUADS (SURGICAL) #
D24 ;;PERIO QUADS (ROOT PLANE) #
D25G ;;PATIENT ED (CTV) GROUP
D25I ;;PATIENT ED (CTV) INDIVIDUAL
D26S ;;SPOT CHECK EXAM (STAFF)
D26F ;;SPOT CHECK EXAM (FEE)
D27 ;;INDIVIDUAL CROWNS #
D28 ;;POST & CORES #
D29 ;;FIXED PARTIALS (ABUT) #
D30 ;;FIXED PARTIALS (PONT ONLY) #
D31 ;;REMOVABLE PARTIALS #
D32 ;;COMPLETE DENTURES #
D33 ;;PROSTHETIC REPAIR #
D34 ;;SPLINT AND SPEC. PROCESS (CTV)
D35 ;;EXTRACTIONS #
D36 ;;SURGICAL EXTRACTIONS #
D37 ;;OTHER SIG TREATMENT (CTV)
D38 ;;DIVISION (STATION DIVISION)
D39C ;;COMPLETIONS
D39T ;;TERMINATIONS
D40 ;;INTERDISCIPLINARY CONSULT
D41 ;;EVALUATIONS
D42 ;;PRE AUTHORIZATION/2ND OPINION
D43M ;;SPOT CHECK DISCREPANCY (STAFF)
D43R ;;SPOT CHECK DISCREPANCY (FEE)
 ;
PRINT ;
 ;setting EC9=EC1 is just for the benefit of the new ECS feeder key list - don't want to mess-up the other lists
 S (QFLG,PG)=0,$P(LN,"-",81)=""
 S EC="" F  S EC=$O(^TMP($J,EC)),EC1="" Q:EC=""  Q:QFLG  D HEAD F  S EC1=$O(^TMP($J,EC,EC1)),EC9=EC1,EC2=""  Q:EC1=""  Q:QFLG  D
 .I EC="CLI" S EC9=$P(EC9,";",2)
 .I EC="ECS",$G(ECECS)="N" S EC9=$P(EC9,";",2)
 .I EC="LAB",EC9[".8" S EC9=$$ADD0(EC9)
 .F  S EC2=$O(^TMP($J,EC,EC1,EC2)) Q:EC2=""!QFLG  D  ;149 Added QFLG so loop stops if user enters "^"
 ..I $G(ECXPORT) D  ;Section added in 149
 ...S ^TMP("ECXPORT",$J,CNT)=$S($G(ECECS)="N"&(EC="ECS"):"Procedure-CPT^",$G(ECECS)="O"&(EC="ECS"):"Category-Procedure^",$G(ECLAB)="O"&(EC="LAB"):"Local Feeder Key^",$G(ECLAB)="N"&(EC="LAB"):"LMIP codes^",1:"")
 ...S ^TMP("ECXPORT",$J,CNT)=^TMP("ECXPORT",$J,CNT)_EC_U_$S(EC="PHA":$E(EC9,2,99),1:EC9)_U_$P(^TMP($J,EC,EC1,EC2),U) ;174
 ...S ^TMP("ECXPORT",$J,CNT)=^TMP("ECXPORT",$J,CNT)_$S(EC="PHA":U_$P(^TMP($J,EC,EC1,EC2),U,2)_U_$S($P(^TMP($J,EC,EC1,EC2),U,3)="N":"Non-Drug",1:"Drug"),1:""),CNT=CNT+1 ;174
 ..I '$G(ECXPORT) D:($Y+3>IOSL) HEAD Q:QFLG  ;149
 ..I '$G(ECXPORT) I EC="PHA" W !,?2,$E(EC9,2,99),?24,$E($P(^TMP($J,EC,EC1,EC2),U),1,40),?67,$$RJ^XLFSTR($P(^(EC2),U,2),12) Q  ;149
 ..I '$G(ECXPORT) W !,?5,EC9,?27,^TMP($J,EC,EC1,EC2) ;149
 I '$G(ECXPORT) I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR ;149
 .I '$G(ECXPORT) S SS=22-$Y F JJ=1:1:SS W ! ;149
 K EC,EC1,EC2,EC3,EC9,ECCSC,ECD,ECLIST,ECNDC,ECNDF,ECNFC,ECPHA,ECECS,ECLAB,ECSC,ECST,ECY,JJ,LN,P1,P2,P3,PG,POP,QFLG,SC,SS,X,Y,DIR,DIRUT,DUOUT K:'$G(ECXPORT) ^TMP($J) ;149
 I '$G(ECXPORT) W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" ;149
 Q
HEAD ;
 I $G(ECXPORT) S ^TMP("ECXPORT",$J,CNT)=$S(EC="LAB"!(EC="ECS"):LECOL,EC="PHA":PCOL,1:COL),CNT=CNT+1 Q  ;149 set up column headers for specific key systems
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 W:$Y!($E(IOST)="C") @IOF
 S PG=PG+1 W !,?21,"Feeder Key List For Feeder System ",EC,?70,"Page: ",PG
 I EC="PHA" W !,?22,"(NEW Feeder Key from NDF Match)",!,?24,"Showing ",$S(PHATYPE="N":"Non-Drug",PHATYPE="D":"Drug",1:"All")_" feeder keys",!!,?2,"Feeder Key",?24,"Description",?66,"Price Per",!,?66,"Dispense Unit",!,LN,! Q  ;174
 I $D(ECECS)&(EC="ECS") W !?21,$S(ECECS="O":"(OLD Feeder Key sorted by Category-Procedure)",1:"(NEW Feeder Key sorted by Procedure-CPT Code)")
 I $D(ECLAB)&(EC="LAB") W !?15,$S(ECLAB="O":"(OLD Feeder Key sorted by Local Feeder Key values)",1:"      (NEW Feeder Key sorted by LMIP Codes)")
 W !!,?5,"Feeder Key",?27,"Description",!,LN,!
 Q
ADD0(ECXFKEY) ;** Append zeros to decimal place on feeder key
 ;
 ;** Variable Definitions
 ;**  ECXFKEY   - Value of Feeder Key
 ;**                Returns  feeder key with zeros appended to make a
 ;**                          four place decimal.
 ;
 N ECXD,LPCNT,LPEND,ECXFEKEY,ECXDEC
 S ECXDEC=$P(ECXFKEY,".",2)
 S LPEND=4-$L(ECXDEC)
 F LPCNT=1:1:LPEND S ECXDEC=ECXDEC_"0"
 S ECXFEKEY=$P(ECXFKEY,".",1)_"."_ECXDEC
 Q ECXFEKEY
 ;
