PSOORRLO ;BHAM ISC/SJA - returns patient's outpatient meds-original sort ;Dec 10, 2021@09:35
 ;;7.0;OUTPATIENT PHARMACY;**225,331,381,622,441**;DEC 1997;Build 209
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^VA(200 supported by DBIA 10060
 ;External reference to(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to OCL^PSJORRE supported by DBIA 2383
 ;
 ;Add Complex Orders to NVA Meds
 ;
OCL ;entry point to return condensed list
 ;*159-SD* Variables
 N SD,SDT,SDT1,ST,STT,PSEX,PSG,PST,GP,EXDT1
 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN)
 K ^TMP("PS",$J),^TMP("PSO",$J),^TMP("PS1",$J)
 S TFN=0,PSBDT=$G(BDT),PSEDT=$G(EDT) I +$G(PSBDT)<1 S X1=DT,X2=-120 D C^%DTC S PSBDT=X
 S EXDT=PSBDT-1,IFN=0
 F  S EXDT=$O(^PS(55,DFN,"P","A",EXDT)) Q:'EXDT  F  S IFN=$O(^PS(55,DFN,"P","A",EXDT,IFN)) Q:'IFN  D:$D(^PSRX(IFN,0))
 .S EXDT1=9999999-EXDT
 .Q:$P($G(^PSRX(IFN,"STA")),"^")=13
 .S TFN=TFN+1,RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2),LSTRD=$P(RX2,"^",13),LSTDS=$P(RX0,"^",8)
 .F I=0:0 S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^"),LSTDS=$P(^(0),"^",10) S:$P(^(0),"^",18)]"" LSTRD=$P(^(0),"^",18)
 .S ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 .S STT=$P("ERROR^ACTIVE;2:1^NON-VERIFIED;1:1^REFILL FILL;2:3^HOLD;2:7^NON-VERIFIED;1:1^ACTIVE/SUSP;2:6^^^^^DONE;2:9^EXPIRED;3:1^DISCONTINUED;4:3^DISCONTINUED;4:3^DISCONTINUED;4:3^DISCONTINUED (EDIT);4:4^HOLD;2:7^","^",ST0+2)
 .S ST=$P(STT,";"),GP=$P(STT,";",2)
 .I STA=0,+$G(^PSRX(IFN,"PARK")) S ST="ACTIVE/PARKED"  ;441 PAPI
 .;Status Groups: 1-PENDING, 2-ACTIVE, 3-Expired, 4-DISCONTINUED
 .S ^TMP("PSO",$J,GP,EXDT1,TFN,0)=IFN_"R;O"_"^"_$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")_"^^"_$P(RX2,"^",6)_"^"_($P(RX0,"^",9)-TRM)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)
 .S ^TMP("PSO",$J,GP,EXDT1,TFN,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 .S ^TMP("PSO",$J,GP,EXDT1,TFN,0)=^TMP("PSO",$J,GP,EXDT1,TFN,0)_"^"_ST_"^"_LSTFD_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^^"_$P(RX0,"^",13)_"^"_LSTRD_"^"_LSTDS
 .S ^TMP("PSO",$J,GP,EXDT1,TFN,"SCH",0)=0
 .S (SCH,SC)=0 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PSO",$J,GP,EXDT1,TFN,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^"),^TMP("PSO",$J,GP,EXDT1,TFN,"SCH",0)=^TMP("PSO",$J,GP,EXDT1,TFN,"SCH",0)+1
 .S ^TMP("PSO",$J,GP,EXDT1,TFN,"MDR",0)=0,(MDR,MR)=0 F  S MR=$O(^PSRX(IFN,"MEDR",MR)) Q:'MR  D
 ..Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0))  S MDR=MDR+1
 ..I $P($G(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),"^",3)]"" S ^TMP("PSO",$J,GP,EXDT1,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^",3)
 ..I $D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),$P($G(^(0)),"^",3)']"" S ^TMP("PSO",$J,GP,EXDT1,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^")
 ..S ^TMP("PSO",$J,GP,EXDT1,TFN,"MDR",0)=^TMP("PSO",$J,GP,EXDT1,TFN,"MDR",0)+1
 .S PSOELSE=0 I $D(^PSRX(IFN,"SIG")),'$P(^PSRX(IFN,"SIG"),"^",2) S PSOELSE=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG1^PSOORRL1
 .I '$G(PSOELSE) S ITFN=1 D
 ..S ^TMP("PSO",$J,GP,EXDT1,TFN,"SIG",ITFN,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PSO",$J,GP,EXDT1,TFN,"SIG",0)=+$G(^TMP("PSO",$J,GP,EXDT1,TFN,"SIG",0))+1
 ..F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S ITFN=ITFN+1,^TMP("PSO",$J,GP,EXDT1,TFN,"SIG",ITFN,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PSO",$J,GP,EXDT1,TFN,"SIG",0)=+$G(^TMP("PSO",$J,GP,EXDT1,TFN,"SIG",0))+1
 .S:$P($G(^PSRX(IFN,"IND")),U)]"" ^TMP("PSO",$J,GP,EXDT1,TFN,"IND",0)=$P(^PSRX(IFN,"IND"),U)  ;*441-IND
 K PSOELSE
 S IFN=0 F  S IFN=$O(^PS(52.41,"P",DFN,IFN)) Q:'IFN  S PSOR=^PS(52.41,IFN,0) D:$P(PSOR,"^",3)="" WAIT D:$P(PSOR,"^",3)'="DC"&($P(PSOR,"^",3)'="DE")&($P(PSOR,"^",3)'="")
 .S GP="1:3",PSEX="9999999"
 .Q:$P(PSOR,"^",3)="RF"
 .I $P(PSOR,"^",8)="",$P(PSOR,"^",9)="" D WAIT
 .I $P(PSOR,"^",8)="",$P(PSOR,"^",9)="" Q  ; QUIT IF STILL NULL AFTER WAITING
 .S TFN=TFN+1,^TMP("PSO",$J,GP,PSEX,TFN,0)=IFN_"P;O^"_$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 .S ^TMP("PSO",$J,GP,PSEX,TFN,0)=^TMP("PSO",$J,GP,PSEX,TFN,0)_"^^^^^^"_$P(PSOR,"^")_"^"_"PENDING^^^"_$P(PSOR,"^",10)_"^"
 .S ^TMP("PSO",$J,GP,PSEX,TFN,0)=^TMP("PSO",$J,GP,PSEX,TFN,0)_"^"_$S($P(PSOR,"^",3)="RNW":1,1:0)
 .S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,1,SCH)) Q:'SCH  S SD=SD+1,^TMP("PSO",$J,GP,PSEX,TFN,"SCH",SD,0)=$P(^PS(52.41,IFN,1,SCH,1),"^"),^TMP("PSO",$J,GP,PSEX,TFN,"SCH",0)=SD
 .S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,"SIG",SCH)) Q:'SCH  S SD=SD+1,^TMP("PSO",$J,GP,PSEX,TFN,"SIG",SD,0)=$P(^PS(52.41,IFN,"SIG",SCH,0),"^"),^TMP("PSO",$J,GP,PSEX,TFN,"SIG",0)=SD
 .S (IEN,SD)=1,INST=0 F  S INST=$O(^PS(52.41,IFN,2,INST)) Q:'INST  S (MIG,INST(INST))=^PS(52.41,IFN,2,INST,0),^TMP("PSO",$J,GP,PSEX,TFN,"SIO",0)=SD D
 ..F SG=1:1:$L(MIG," ") S:$L($G(^TMP("PSO",$J,GP,PSEX,TFN,"SIO",IEN,0))_" "_$P(MIG," ",SG))>80 IEN=IEN+1,SD=SD+1,^TMP("PSO",$J,GP,PSEX,TFN,"SIO",0)=SD D
 ...S ^TMP("PSO",$J,GP,PSEX,TFN,"SIO",IEN,0)=$G(^TMP("PSO",$J,GP,PSEX,TFN,"SIO",IEN,0))_" "_$P(MIG," ",SG)
 .S:$P($G(^PS(52.41,IFN,4)),U,2)]"" ^TMP("PSO",$J,GP,PSEX,TFN,"IND",0)=$P(^PS(52.41,IFN,4),U,2)  ;*441-IND
 D NVA
 S PSG=0,J=1 F  S PSG=$O(^TMP("PSO",$J,PSG)) Q:'PSG  S PST="" F  S PST=$O(^TMP("PSO",$J,PSG,PST)) Q:PST=""  S I=0 F  S I=$O(^TMP("PSO",$J,PSG,PST,I)) Q:'I  D
 .M ^TMP("PS",$J,J)=^TMP("PSO",$J,PSG,PST,I) S J=J+1
 S PSG=0 F  S PSG=$O(^TMP("PS1",$J,PSG)) Q:'PSG  S I=0 F  S I=$O(^TMP("PS1",$J,PSG,I)) Q:'I  D
 .M ^TMP("PS",$J,J)=^TMP("PS1",$J,PSG,I) S J=J+1
 K ^TMP("PSO",$J),^TMP("PS1",$J)
 D OCL^PSJORRE(DFN,$G(PSOBDTIN),$G(PSOEDTIN),.TFN,+$G(VIEW))
 D END^PSOORRL1
 K SDT,SDT1,GP,PSEX,PSG,PST,EDT,EDT1,BDT,DBT1,X
 Q
WAIT ; IF PENDING ENTRY STILL BEING BUILT SEE IF IT COMPLETES WITHIN ANOTHER SECOND
 H 1 S PSOR=$G(^PS(52.41,IFN,0))
 Q
 ;
NVA ; Set Non-VA Med Orders in the ^TMP Global
 ;BHW;PSO*7*159;New SDT,SDT1 Variables
 ;BDT - ORCH CONTEXT MEDS START DATE
 ;EDT - ORCH CONTEXT MEDS END DATE
 ;SDT - NON-VA MED START DATE
 ;PSODCDT - NON-VA MED DISCONTINUE DATE
 N SDT,SDT1,PSODCDT,PSODC,PSOACT,PSOBDT,PSOEDT
 S PSOBDT=$G(BDT),PSOEDT=$G(EDT)
 I 'PSOBDT,'PSOEDT S PSOBDT=PSBDT,PSOEDT=DT  ;*381
 I PSOBDT,'PSOEDT S PSOEDT=DT   ;*381
 F I=0:0 S I=$O(^PS(55,DFN,"NVA",I)) Q:'I  S X=$G(^PS(55,DFN,"NVA",I,0)) D
 .Q:'$P(X,"^")
 .I $O(^PS(55,DFN,"NVA",I,3,0)) D NVANEW Q         ;If NEW Complex Db populated use it instead and Quit.
 .;
 .;Old Db structure logic below (backards compatability),
 .;  Prevents needing a Post install to go and modify these records of older NVA meds and update them to the New Db structure.
 .;  Insures No accidental data integrity issues that a flawed post install may introduce in these older documented NVA meds.
 .S DRG=$S($P(X,"^",2):$P($G(^PSDRUG($P(X,"^",2),0)),"^"),1:$P(^PS(50.7,$P(X,"^"),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(X,"^"),0),"^",2),0),"^"))
 .S SDT=$P(X,"^",9),PSODCDT=$P(X,"^",7)  ;*331
 .S (PSOACT,PSODC)=0
 .I 'PSODCDT S PSOACT=1
 .I PSODCDT S PSODC=1
 .I PSOACT D  ;ACTIVE NON-VA MED
 ..I 'SDT D TMPBLD Q
 ..I $E(SDT,4,5),$E(SDT,6,7) D
 ...I SDT>$G(PSOEDT) Q
 ...D TMPBLD  ;MED START DATE PRIOR TO PARAM. END DATE
 ..I $E(SDT,4,5),'$E(SDT,6,7) D  Q
 ...S SDT1=$E(SDT,1,5),BDT1=$E(+$G(PSOBDT),1,5),EDT1=$E(+$G(PSOEDT),1,5)
 ...I SDT1>EDT1 Q
 ...D TMPBLD  ;MED START DATE PRIOR TO PARAM. END DATE
 ..I '$E(SDT,4,5),'$E(SDT,6,7) D  Q
 ...S SDT1=$E(SDT,1,3),BDT1=$E(+$G(PSOBDT),1,3),EDT1=$E(+$G(PSOEDT),1,3)
 ...I SDT1>EDT1 Q
 ...D TMPBLD  ;MED START DATE PRIOR TO PARAM. END DATE
 .I PSODC D  ;DISCONTINUED NON-VA MED
 ..I SDT="",PSODCDT>$G(PSOBDT) D TMPBLD Q  ;NO MED START DATE AND MED DC DATE AFTER PARAM START DATE
 ..I PSODCDT<$G(PSOBDT) Q  ;QUIT IF MED DC DATE BEFORE PARAM START DATE
 ..I SDT>$G(PSOEDT) Q  ;QUIT IF MED START DATE AFTER PARAM END DATE
 ..D TMPBLD
 Q
 ; Old Db structure build for backwards compatibility records
TMPBLD S TFN=$G(TFN)+1,GP=$S($P(X,"^",7):3,1:2)
 S ^TMP("PS1",$J,GP,TFN,0)=I_"N;O^"_DRG
 S $P(^TMP("PS1",$J,GP,TFN,0),"^",8)=$P(X,"^",8)_"^"_$S($P(X,"^",7):"DISCONTINUED",1:"ACTIVE")
 S ^TMP("PS1",$J,GP,TFN,"SCH",0)=1,^TMP("PS1",$J,GP,TFN,"SCH",1,0)=$P(X,"^",5)
 S ^TMP("PS1",$J,GP,TFN,"SIG",0)=1,^TMP("PS1",$J,GP,TFN,"SIG",1,0)=$P(X,"^",3)_" "_$P(X,"^",4)_" "_$P(X,"^",5)
 S:$P($G(^PS(55,DFN,"NVA",I,2)),U)]"" ^TMP("PS1",$J,GP,TFN,"IND",0)=$P($G(^PS(55,DFN,"NVA",I,2)),U)  ;*441-IND
 Q
 ;
 ;New Db Complex NVA Meds Sig for CPRS Meds tab vs PSOORRL that returns NVA Meds info for Coversheet tab
NVANEW ;New NVA tag for Complex Order DB Structure
 N NVA,NON,PSODD,PSOOI
 S NVA=I,NON=X
 S PSODD=$P(NON,"^",2),PSOOI=$P(NON,"^")
 S SDT=$P(NON,"^",9),PSODCDT=$P(NON,"^",7)  ;*331
 S (PSOACT,PSODC)=0 S:'PSODCDT PSOACT=1 S:PSODCDT PSODC=1
 ;Build TMP return
 I PSOACT D  ;ACTIVE NON-VA MED
 .I 'SDT D TMPBLDNW Q   ;NO START DATE ALWAYS BUILD
 .I $E(SDT,4,5),$E(SDT,6,7) Q:SDT>$G(PSOEDT)  D TMPBLDNW  ;START DATE PRIOR TO PARAM. END DATE - BUILD
 .I $E(SDT,4,5),'$E(SDT,6,7) D  Q
 ..S SDT1=$E(SDT,1,5),BDT1=$E(+$G(PSOBDT),1,5),EDT1=$E(+$G(PSOEDT),1,5)
 ..Q:SDT1>EDT1
 ..D TMPBLDNW  ;START DATE PRIOR TO PARAM. END DATE - BUILD
 .I '$E(SDT,4,5),'$E(SDT,6,7) D  Q
 ..S SDT1=$E(SDT,1,3),BDT1=$E(+$G(PSOBDT),1,3),EDT1=$E(+$G(PSOEDT),1,3)
 ..Q:SDT1>EDT1
 ..D TMPBLDNW  ;START DATE PRIOR TO PARAM. END DATE - BUILD
 I PSODC D  ;DISCONTINUED NON-VA MED
 .I SDT="",PSODCDT>$G(PSOBDT) D TMPBLDNW Q  ;NO START DATE & DC DATE AFTER PARAM START DATE
 .Q:PSODCDT<$G(PSOBDT)    ;QUIT IF DC DATE BEFORE PARAM START DATE
 .Q:SDT>$G(PSOEDT)        ;QUIT IF START DATE AFTER PARAM END DATE
 .D TMPBLDNW Q
 Q
 ;
TMPBLDNW ;New tag for New Complex NVA Meds Db structure
 N DD,DDX,DOSE,SCHD,MEDR,DURA,CONJ,DRG
 S TFN=$G(TFN)+1
 F DD=0:0 S DD=$O(^PS(55,DFN,"NVA",NVA,3,DD)) Q:'DD  D
 .S DDX=DD_","_NVA_","_DFN
 .S DOSE=$$GET1^DIQ(55.516,DDX,"DOSAGE")
 .S SCHD=$$GET1^DIQ(55.516,DDX,"SCHEDULE")
 .S MEDR=$$GET1^DIQ(55.516,DDX,"MEDICATION ROUTE")
 .S DURA=$$GET1^DIQ(55.516,DDX,"DURATION")
 .S CONJ=$$GET1^DIQ(55.516,DDX,"CONJUNCTION")
 .S DRG=$S(PSODD:$P($G(^PSDRUG(PSODD,0)),"^"),+PSOOI&('PSODD):$P(^PS(50.7,+PSOOI,0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,+PSOOI,0),"^",2),0),"^"),1:"")
 .S GP=$S($P(NON,"^",7):3,1:2)
 .;*441 - Complex dose
 .I $G(VIEW)=1 D NVACXV1 Q
 .I $G(VIEW)=2 D NVACXV2 Q
 .I $G(VIEW)=3 D NVACXV3 Q
 .D NVACXNV
 Q
 ;
NVACXV1  ;
 S ^TMP("PS1",$J,GP,TFN,0)=NVA_"N;O^"_DRG
 S $P(^TMP("PS1",$J,GP,TFN,0),"^",8)=$P(NON,"^",8)_"^"_$S($P(NON,"^",7):"DISCONTINUED",1:"ACTIVE")
 ;Sig
 S ^TMP("PS1",$J,GP,TFN,"SCH",0)=DD
 S ^TMP("PS1",$J,GP,TFN,"SCH",DD,0)=SCHD
 S ^TMP("PS1",$J,GP,TFN,"SIG",0)=DD
 S ^TMP("PS1",$J,GP,TFN,"SIG",DD,0)=DOSE_" "_MEDR_" "_SCHD
 S:DURA]"" ^TMP("PS1",$J,GP,TFN,"SIG",DD,0)=^TMP("PS1",$J,GP,TFN,"SIG",DD,0)_" FOR "_DURA
 S:CONJ]"" ^TMP("PS1",$J,GP,TFN,"SIG",DD,0)=^TMP("PS1",$J,GP,TFN,"SIG",DD,0)_" "_CONJ
 S:$P($G(^PS(55,DFN,"NVA",NVA,2)),U)]"" ^TMP("PS1",$J,GP,TFN,"IND",0)=$P($G(^PS(55,DFN,"NVA",NVA,2)),U)  ;*441-IND
 Q
NVACXV2  ;
 N ST,GP S ST=$S($P(NON,"^",7):"DISCONTINUED",1:"ACTIVE"),GP=$S(ST="ACTIVE":1,1:3)
 S ^TMP("PS1",$J,GP,ST,DRG,TFN,0)=I_"N;O^"_DRG
 S $P(^TMP("PS1",$J,GP,ST,DRG,TFN,0),"^",8)=$P(NON,"^",8)_"^"_$S($P(NON,"^",7):"DISCONTINUED",1:"ACTIVE")
 S ^TMP("PS1",$J,GP,ST,DRG,TFN,"SCH",0)=DD
 S ^TMP("PS1",$J,GP,ST,DRG,TFN,"SCH",DD,0)=SCHD
 S ^TMP("PS1",$J,GP,ST,DRG,TFN,"SIG",0)=DD
 S ^TMP("PS1",$J,GP,ST,DRG,TFN,"SIG",DD,0)=DOSE_" "_MEDR_" "_SCHD_$S(DURA]"":" FOR "_DURA,1:"")_$S(CONJ]"":" "_CONJ,1:"")
 S:$P($G(^PS(55,DFN,"NVA",I,2)),U)]"" ^TMP("PS1",$J,GP,ST,DRG,TFN,"IND",0)=$P($G(^PS(55,DFN,"NVA",I,2)),U)  ;*441-IND
 Q
 ;
NVACXV3  ;
 N ST S ST="ACTIVE"
 S ^TMP("PS1",$J,DRG,ST,TFN,0)=I_"N;O^"_DRG
 S $P(^TMP("PS1",$J,DRG,ST,TFN,0),"^",8)=$P(NON,"^",8)_"^"_$S($P(NON,"^",7):"DISCONTINUED",1:"ACTIVE")
 S ^TMP("PS1",$J,DRG,ST,TFN,"SCH",0)=DD
 S ^TMP("PS1",$J,DRG,ST,TFN,"SCH",DD,0)=SCHD
 S ^TMP("PS1",$J,DRG,ST,TFN,"SIG",0)=DD
 S ^TMP("PS1",$J,DRG,ST,TFN,"SIG",DD,0)=DOSE_" "_MEDR_" "_SCHD_$S(DURA]"":" FOR "_DURA,1:"")_$S(CONJ]"":" "_CONJ,1:"")
 S:$P($G(^PS(55,DFN,"NVA",I,2)),U)]"" ^TMP("PS1",$J,DRG,ST,TFN,"IND",0)=$P($G(^PS(55,DFN,"NVA",I,2)),U)  ;*441-IND
 Q
 ;
NVACXNV  ;
 S ^TMP("PS",$J,TFN,0)=I_"N;O^"_DRG
 S $P(^TMP("PS",$J,TFN,0),"^",8)=$P(X,"^",8)_"^"_$S($P(X,"^",7):"DISCONTINUED",1:"ACTIVE")
 S ^TMP("PS",$J,TFN,"SCH",0)=DD
 S ^TMP("PS",$J,TFN,"SCH",DD,0)=SCHD
 S ^TMP("PS",$J,TFN,"SIG",0)=DD
 S ^TMP("PS",$J,TFN,"SIG",DD,0)=DOSE_" "_MEDR_" "_SCHD_$S(DURA]"":" FOR "_DURA,1:"")_$S(CONJ]"":" "_CONJ,1:"")
 S:$P($G(^PS(55,DFN,"NVA",I,2)),U)]"" ^TMP("PS",$J,TFN,"IND",0)=$P($G(^PS(55,DFN,"NVA",I,2)),U)  ;*441-IND
 Q
 ;
