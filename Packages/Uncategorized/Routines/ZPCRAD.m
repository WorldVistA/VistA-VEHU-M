ZPCRAD ;BCP OF RADIOLOGY INFO
 ;
 ;  FLD(1)=patient name       FLD(2)=SSN
 ;  FLD(3)=exam date          FLD(4)=procedure name
 ;  FLD(5)=procedure status
 ;
EN I $D(BCP)=0 S BCP=0 ;no bcp output
BEGIN S X=254 X ^%ZOSF("RM")
 ;S (DTSTART,EXAMDT)=2960101,DTEND=2970508
 I BCP=0 S %DT("A")="Enter starting exam date: ",%DT="APE"
 I BCP=1 S %DT="X",X=ARG1
 D ^%DT I X="^" G EXIT
 S DTSTART=+Y
 I BCP=0 S %DT("A")="Enter ending exam date: "
 I BCP=1 S X=ARG2
 I X="^" G EXIT
 D ^%DT
 S DTEND=+Y_".24"
 I DTEND<DTSTART W !,"Ending date must be greater than start!" G BEGIN
 I BCP=0 R:20 XXX
 S DFN=0
 W !
 S INTDA=0
 S EXAMDT=DTSTART
 F  S EXAMDT=$O(^RADPT("AR",EXAMDT)) G:EXAMDT>DTEND!(+EXAMDT=0) EXIT D  ;
 .S ^ZSQLINT("RAD","EXAMDT")=EXAMDT
 .F  S DFN=$O(^RADPT("AR",EXAMDT,DFN)) Q:+DFN=0  D  ;
 ..F  S INTDA=$O(^RADPT("AR",EXAMDT,DFN,INTDA)) Q:+INTDA=0  D  ;
 ...K RA
 ...S FLD(1)=$P($G(^DPT(DFN,0)),"^",1) ;patient name
 ...S FLD(2)=$P($G(^DPT(DFN,0)),"^",9) ;SSN
 ...S X=EXAMDT D DTC S FLD(3)=DTXX ;converted exam date
 ...S FLD(3)=$TR(FLD(3),"@"," ") ;replace @ with space within date
PROC ...S PROC=0 F  S PROC=$O(^RADPT(DFN,"DT",INTDA,"P",PROC)) Q:+PROC=0  D  ;
 ....S REC=""
 ....S NODE=$G(^RADPT(DFN,"DT",INTDA,"P",PROC,0))
 ....S PROCNO=$P(NODE,"^",2) ;internal procedure number
 ....S FLD(4)=""
 ....I PROCNO'="" S FLD(4)=$P($G(^RAMIS(71,PROCNO,0)),"^",1) ;procedure name
 ....S STAT=$P(NODE,"^",3)
 ....S FLD(5)=""
 ....I STAT'="" S FLD(5)=$P($G(^FLD(72,STAT,0)),"^",1) ;procedure status
 ....F XX=1:1:5 S REC=REC_FLD(XX)_"^" ;
 ....S REC=$E(REC,1,$L(REC)-1)
 ....W REC,!
 Q
DTC ;DATE CONV Y2K COMPLIANT
 I X="" S DTXX="" Q
 S YR=$E(X,2,3),MO=$E(X,4,5),DAY=$E(X,6,7),CENT=$E(X,1,1)
 I MO="00" S MO="01"
 I DAY="00" S DAY="01"
 S CEN="19" I CENT="3" S CEN="20"
 I CEN="1" S CEN="18"
 S YR=CEN_YR
 S DTXX=MO_"/"_DAY_"/"_YR
 ;W "DTXX=",DTXX
 Q
BCP ;bcp entry
 I $D(ARG1)=0 S ARG1="2560101"
 I $D(ARG2)=0 S ARG2="3050101"
 S BCP=1
 G BEGIN
EXIT ;
 S ^ZSQLINT("RAD","FINISHED")=$H
 K ARG1,ARG2,BCP,CEN,CENT,DAY,DFN,DTEND,DTSTART,DTXX,EXAMDT,FLD,INTDA,MO,NODE,PROC,PROCNO,REC,STAT,X,XX,XXX,Y,YR
 Q
