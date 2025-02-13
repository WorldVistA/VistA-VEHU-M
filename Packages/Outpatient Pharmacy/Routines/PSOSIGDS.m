PSOSIGDS ;BIR/RTR - Utility to calculate Days Supply ;May 04, 2021@09:52:11
 ;;7.0;OUTPATIENT PHARMACY;**46,222,391,282,444,612,441**;DEC 1997;Build 209
 ;External reference to PS(51 supported by DBIA 2224
 ;External reference to PS(51.1 supported by DBIA 2225
 ;External reference to PS(55 supported by DBIA 2228
 ;External reference to PSDRUG( supported by DBIA 221
 ;External reference to YSCL(603.01 supported by DBIA 2697
 ;External reference to PSNDF(50.68 supported by DBIA 3735
 ;External reference $$MXDAYSUP^PSSUTIL1 supported by DBIA 6229
 ;
EN(PSOSIGX) ;
 N VARIABLE
 Q
SCH ;*282 Centralized Call
 D SCH^PSOSIG
 Q
QTY(PSOQX) ;
 Q
QTYOPS ;
 N QDOSE
QTYCP ;CPRS days supply call comes through here
 N PSOZMIN,PSQQUIT,QTSH,PSQ,PSQMIN,PSQMINZ,PSOQRND,PSOLOWER,PSOLOWX,PSOLOWXL,PSOLOWST
 K PSOFRQ S PSQQUIT=0
 I '$G(PSOCPRQT) S QDOSE=0 F PSQ=0:0 S PSQ=$O(PSOQX("DOSE",PSQ)) Q:'PSQ  S QDOSE=PSQ S:'$G(PSOQX("DOSE ORDERED",PSQ)) PSQQUIT=1
 ;Q:PSQQUIT!('QDOSE)
 I '$G(PSOCPRQT) Q:PSQQUIT
 Q:'$G(QDOSE)
 G:QDOSE>1 COMP
 Q:'$G(PSOQX("DOSE ORDERED",1))
 S PSOLOWER=0
 I $G(PSOQX("DURATION",1)) D
 .S PSOLOWX=$L(PSOQX("DURATION",1))
 .S PSOLOWXL=$S($E(PSOQX("DURATION",1),PSOLOWX)="M":1,$E(PSOQX("DURATION",1),PSOLOWX)="H":60,$E(PSOQX("DURATION",1),PSOLOWX)="S":.01666,$E(PSOQX("DURATION",1),PSOLOWX)="W":10080,$E(PSOQX("DURATION",1),PSOLOWX)="L":43200,1:1440)
 .S PSOLOWER=PSOLOWXL*(+$G(PSOQX("DURATION",1)))
 S QTSH=$G(PSOQX("SCHEDULE",1)) D QTS Q:PSQQUIT!('$G(PSOFRQ))
 S PSQMIN=$S($G(PSOLOWER):$G(PSOLOWER),1:0) ; PSQMIN=Minutes based in duration, or 0 if no duration
 ;If Duration, determine using QTY how many days, regardless of duration, then use what is lower, that # of days or the duration, ROund that up, and check against Rx patient status
 ;if no duration, just figure out using QTY # of days, then compare that against Rx patient status
 S PSOZMIN=0
 S PSOZMIN=PSOQX("QTY")/PSOQX("DOSE ORDERED",1)
 S PSOZMIN=PSOZMIN*PSOFRQ
 I $G(PSOLOWER) S PSOZMIN=$S(PSOLOWER<PSOZMIN:PSOLOWER,1:PSOZMIN)
 S PSOZMIN=PSOZMIN/1440
 D ROUND G QEND
 Q
COMP ;COMPLEX DOSE HERE
 N PSQMNL,PSQMNLX,PSODUTOT,PSOLEFT,PSOZMIN,PSODUPTT,PSODUDIF,PSODUMIS,PSODUREP,PSQ1,PSODUX,PSODUXX,PSODSMIN,PSOFRQZ,PSOQUTOT
 N PSOQLD,PSOQLDA,PSOQLDT,PSOQLDX
 ;PSODUTOT = TOTAL OF ALL DURATIONS
 ;PSODUPTT = TOTAL OF DISPENSE UNITS PER DOSE
 ;PSODUDIF = DIFF. OF DURATION VS DAYS SUPPLY
 ;PSOQUTOT=QTY
 ;PSODUMIS = # OF SEQUENCES MISSING A DURATION IF >1 CAN'T DEFAULT
 ;PSODUREP = SEQUENCE # THAT IS MISSING DURATION
 ;PSODSMIN = MINUTES OF DAYS SUPPLY
 S (PSODUTOT,PSODUDIF,PSODUMIS,PSODUREP,PSODSMIN,PSOQLDA,PSOQLDT,PSOQLDX)=0
 ;next lines, add complex dose days supply calculation with ANDs
 F PSOQLD=1:1:QDOSE S:$G(PSOQX("CONJUNCTION",PSOQLD))["A" PSOQLDA=1 S:$G(PSOQX("CONJUNCTION",PSOQLD))["T" PSOQLDT=1 S:$G(PSOQX("CONJUNCTION",PSOQLD))["X" PSOQLDX=1
 I $G(PSOQLDA)!($G(PSOQLDX)) G QEND
 S PSOQUTOT=+$G(PSOQX("QTY"))
 F PSQ1=1:1:QDOSE D  Q:PSODUMIS>1
 .I '$G(PSOQX("DURATION",PSQ1)) S PSODUMIS=PSODUMIS+1,PSODUREP=PSQ1 Q
 G:PSODUMIS>1 QEND ; More than 1 sequence missing a duration
 F PSQ=1:1:QDOSE D  Q:$G(PSQQUIT)
 .I '$G(PSOQX("DOSE ORDERED",PSQ))!($G(PSOQX("SCHEDULE",PSQ))="") S PSQQUIT=1 Q
 .S QTSH=$G(PSOQX("SCHEDULE",PSQ)) D QTS S:'$G(PSOFRQ) PSQQUIT=1 Q:$G(PSQQUIT)
 .I $G(PSOQX("DURATION",PSQ)) S PSQMNL=$L(PSOQX("DURATION",PSQ)) D
 ..S PSQMNLX=$S($E(PSOQX("DURATION",PSQ),PSQMNL)="M":1,$E(PSOQX("DURATION",PSQ),PSQMNL)="H":60,$E(PSOQX("DURATION",PSQ),PSQMNL)="S":.01666,$E(PSOQX("DURATION",PSQ),PSQMNL)="W":10080,$E(PSOQX("DURATION",PSQ),PSQMNL)="L":43200,1:1440)
 ..S PSQMIN=PSQMNLX*(+$G(PSOQX("DURATION",PSQ)))
 ..S PSODUTOT=PSODUTOT+(PSQMNLX*(+$G(PSOQX("DURATION",PSQ))))
 .I '$G(PSOQX("DURATION",PSQ)) S PSOFRQZ=PSOFRQ Q
 .S PSQMINZ=PSQMIN/PSOFRQ
 .S PSODUPTT=$S($G(PSODUPTT):$G(PSODUPTT),1:0)+(PSQMINZ*+$G(PSOQX("DOSE ORDERED",PSQ)))
 I $G(PSQQUIT) G QEND
 I $G(PSOQUTOT)<0 G QEND
 I '$G(PSODUMIS),$G(PSODUPTT)>$G(PSOQUTOT) G QEND
 I '$G(PSODUMIS) S PSOZMIN=+$G(PSODUTOT)/1440 D ROUND G QEND
 I PSODUPTT'<PSOQUTOT!('$G(PSOFRQZ)) G QEND
 S PSODUPTT=PSOQUTOT-PSODUPTT S PSOLEFT=(PSODUPTT/+$G(PSOQX("DOSE ORDERED",PSODUREP)))*(+$G(PSOFRQZ))
 S PSODUTOT=PSODUTOT+PSOLEFT S PSOZMIN=PSODUTOT/1440 D ROUND
 G QEND
QTS ;*282 Centralized Call
 D QTS^PSOSIG
 Q
QEND ;
 K PSOFRQ
 Q
ROUND ;
 Q:'$G(PSOZMIN)
 I PSOZMIN'["." S PSOQX("DAYS SUPPLY")=PSOZMIN G RXP
 S PSOQX("DAYS SUPPLY")=$P(PSOZMIN,".")+1
RXP ;Compare against Rx Patient Status
 Q:'$G(PSOQX("PATIENT"))
 N PSO55,PSO553
 S PSO55=$P($G(^PS(55,PSOQX("PATIENT"),"PS")),"^") I 'PSO55 G CLOZ
 S PSO553=$P($G(^PS(53,PSO55,0)),"^",3) I 'PSO553 G CLOZ
 I PSO553<$G(PSOQX("DAYS SUPPLY")) S PSOQX("DAYS SUPPLY")=PSO553
CLOZ ;check for clozapine
 N PSOCLPAT,PSOCLMAX
 Q:'$G(PSOQX("DRUG"))
 I $P($G(^PSDRUG(PSOQX("DRUG"),"CLOZ1")),"^")="PSOCLO1" D
 .S PSOCLPAT=$O(^YSCL(603.01,"C",PSOQX("PATIENT"),0)) Q:'PSOCLPAT
 .S PSOCLPAT=$P($G(^YSCL(603.01,PSOCLPAT,0)),"^",3)
 .;BEGIN - JCH - PSO*7.0*612 - Local override defaults to 4 Day Supply
 .I $P($G(^YSCL(603.01,PSOCLPAT,0)),"^")?1U6N S PSOCLPAT="Z"
 .S PSOCLMAX=$S(PSOCLPAT="M":28,PSOCLPAT="B":14,PSOCLPAT="W":7,PSOCLPAT="Z":4,1:0)
 .;END - JCH - PSO*7.0*612
 .I PSOCLMAX,PSOCLMAX<$G(PSOQX("DAYS SUPPLY")) S PSOQX("DAYS SUPPLY")=PSOCLMAX
 Q
DAY(DATE) ;First 5 digits of FileMan date
 N X
 I DATE'?5N Q -1
 S X=$E(DATE,4,5) I X<1!(X>12) Q -1
 S X=DATE+1+(X=12*88)_"01"
 Q $E($$FMADD^XLFDT(X,-1),6,7)
 ;
QTYX(PSOQX) ;
 N PSOQLP,PSOQLN,PSOQAR,PSOCPRQT,QDOSE,QDOSEX S PSOCPRQT=1 F PSOQLP=0:0 S PSOQLP=$O(PSOQX("DURATION",PSOQLP)) Q:'PSOQLP  D
 .S PSOQAR("DURATION",PSOQLP)=$G(PSOQX("DURATION",PSOQLP))
 .I $E(PSOQX("DURATION",PSOQLP))?1A S PSOQLN=$L(PSOQX("DURATION",PSOQLP)) S PSOQX("DURATION",PSOQLP)=$E(PSOQX("DURATION",PSOQLP),2,PSOQLN)_$E(PSOQX("DURATION",PSOQLP))
 S QDOSE=0 F QDOSEX=0:0 S QDOSEX=$O(PSOQX("DOSE ORDERED",QDOSEX)) Q:'QDOSEX  S QDOSE=QDOSE+1
 D QTYCP
 F PSOQLP=0:0 S PSOQLP=$O(PSOQAR("DURATION",PSOQLP)) Q:'PSOQLP  D
 .S PSOQX("DURATION",PSOQLP)=$G(PSOQAR("DURATION",PSOQLP))
 K PSOCPRQT
 Q
DSUP(PSOQX) ;Default Days Supply for CPRS, without QTY (just patient and drug)
 ;Should we add to accept # of refills?
 ;If no Drug, should we base on Orderable Item *441 MWA yes we should!!!
 N CS,DR,OI,MXDS,DRMXDS,OIISCLOZ S CS=0,MXDS=90,DR=$G(PSOQX("DRUG")),OIISCLOZ=0
 I DR S CS=$$CSDS(DR),MXDS=$$MXDAYSUP^PSSUTIL1(DR)
 ;441 added OI check for clozapine
 I 'DR S OI=$G(PSOQX("OI")) D:OI
 .N IDT,PAC S DR=0 F  S DR=$O(^PSDRUG("ASP",OI,DR)) Q:'DR  Q:OIISCLOZ   D
 ..S:($P($G(^PSDRUG(DR,"CLOZ1")),"^")="PSOCLO1") OIISCLOZ=1
 ..S DRMXDS=$$MXDAYSUP^PSSUTIL1(DR) I DRMXDS>MXDS S MXDS=DRMXDS
 ..I CS Q
 ..S IDT=$P($G(^PSDRUG(DR,"I")),"^"),PAC=$P($G(^(2)),"^",3)
 ..I IDT,IDT<DT Q
 ..I PAC'["O" Q
 ..S CS=$$CSDS(DR)
 S PSOQX("DAYS SUPPLY")=$S(CS:30,1:90)
 I PSOQX("DAYS SUPPLY")>MXDS S PSOQX("DAYS SUPPLY")=MXDS
 Q:'$G(PSOQX("PATIENT"))
 N PSO55,PSO553
 S PSO55=$P($G(^PS(55,PSOQX("PATIENT"),"PS")),"^") I 'PSO55 G DSUPDG
 S PSO553=$P($G(^PS(53,PSO55,0)),"^",3) I 'PSO553 G DSUPDG
 I PSO553<$G(PSOQX("DAYS SUPPLY")) S PSOQX("DAYS SUPPLY")=PSO553
DSUPDG ;
 N PSOCLPAT,PSOCLMAX,YSCLPSN
 Q:'DR
 I ($P($G(^PSDRUG(DR,"CLOZ1")),"^")="PSOCLO1")!(OIISCLOZ) D
 .;BEGIN: JCH - PSO*7*612
 .N PSOCZPTS,PSOERR,PSODFN
 .S PSODFN=+$G(PSOQX("PATIENT"))
 .S YSCLPSN=$$GET1^DIQ(55,PSODFN,53,"I") Q:YSCLPSN=""  ; Get current Clozapine number associated with patient's Clozapine registration
 .D FIND^DIC(603.01,"","","QX",PSODFN,"","C","I $P($G(^(0)),""^"")=$G(YSCLPSN)","","PSOCZPTS","PSOERR")
 .S PSOCLPAT=$G(PSOCZPTS("DILIST",2,1))
 .;END: JCH - PSO*7*612
 .S PSOCLPAT=$P($G(^YSCL(603.01,PSOCLPAT,0)),"^",3)
 .;BEGIN: JCH - PSO*7*612 - default Days Supply to 4 when registered to Local Override clozapine #
 .S:YSCLPSN?1U6N PSOCLPAT="Z"
 .S PSOCLMAX=$S(PSOCLPAT="M":28,PSOCLPAT="B":14,PSOCLPAT="W":7,PSOCLPAT="Z":4,1:0)
 .;END: JCH - PSO*7*612
 .I PSOCLMAX,PSOCLMAX<$G(PSOQX("DAYS SUPPLY")) S PSOQX("DAYS SUPPLY")=PSOCLMAX
 Q
MAX(PSOQX) ;
 G EN^PSOSIGMX
 Q
 ;
CSDS(DR) ;
 Q:'DR 0
 I $P($G(^PSDRUG(DR,"ND")),"^",3) S CS=+$P($G(^PSNDF(50.68,$P(^("ND"),"^",3),7)),"^")
 E  S CS=$P($G(^PSDRUG(DR,0)),"^",3),CS=$S(CS[1:1,CS[2:2,CS[3:3,CS[4:4,CS[5:5,1:0)
 I CS=1!(CS=2)!(CS=3)!(CS=4)!(CS=5) Q 1
 Q 0
