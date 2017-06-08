ABMDCE ;ABQ*RLA;18JAN94; DELETE CLINIC ENROLLMENTS
 ;;0
 ;
 ; one time processing for MAS, approved by MAS to delete clinic
 ; enrollments and local primary care data for all VA patients
 ; Program written with sensitivity to journaling in mind.
DQ ;
 S DFN=0,T=0,U="^" K ^XTMP("ABMDCE")
 F  S DFN=$O(^DPT(DFN)) Q:DFN'>0  D
 .I $O(^DPT(DFN,"DE",0))>0 K ^DPT(DFN,"DE") S ^DPT(DFN,"DE",0)="^2.001P^",T=T+1
 ; now delete cross-references
 K ^DPT("AEB"),^DPT("AEB1") ;clinic enrollment
 D NOW^%DTC S ^XTMP("ABMDCE")=%_U_T
 ;
EXIT ;
 K DFN,X,%,%H,%I,T
 Q
QUE ;
 S ZTDESC="DELETE CLINIC ENROLLMENTS",ZTRTN="DQ^ABMDCE"
 S ZTIO=""
 D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK,!
 K ZTSK,IO("Q") D HOME^%ZIS
 Q
