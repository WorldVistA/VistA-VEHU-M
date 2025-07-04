PSSDSAPK ;BIR/RTR - Miscellaneous APIs for Dose Call ; Sep 02, 2009@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**117,168,160,178,254**;9/30/97;Build 109
 ;
 ;
 ;Disregard Package Use and Inactive Date in File 50, so you can still get General Dosing Guidelines
 ;Return Dispense Drug for Orderable Item
 ;PSSGTOI = Orderable Item
 ;PSSGTPK = Package O for Outpatient, N for Non-VA Med, I for Inpatient
 ;PSSGTRTE = Med Route Internal Entry Number
 ;PSSGTAB = String containing A for Additive, B for Solution
 ;PSSGTRES = result - 0 for No Drug found, or File 50 Internal Entry Number
DRG(PSSGTOI,PSSGTPK,PSSGTRTE,PSSGTAB) ;
 I '$G(PSSGTOI) Q 0
 I $G(PSSGTPK)'="O",$G(PSSGTPK)'="X",$G(PSSGTPK)'="I" Q 0
 N PSSGTRES,PSSGTPM,PSSGT1,PSSGT2,PSSGT3,PSSGT4,PSSGT5,PSSGTHL1,PSSGTHL2
 S PSSGTPM=$S(PSSGTPK="I":"U",1:PSSGTPK)
 S (PSSGTRES,PSSGTHL1,PSSGTHL2)=0
 I PSSGTPK="I",$G(PSSGTRTE),$P($G(^PS(51.2,PSSGTRTE,0)),"^",6)=1 I $G(PSSGTAB)["A"!($G(PSSGTAB)["B") G DRGINP
 F PSSGT1=0:0 S PSSGT1=$O(^PSDRUG("ASP",PSSGTOI,PSSGT1)) Q:'PSSGT1!(PSSGTHL2)  D
 .S PSSGT3=$P($G(^PSDRUG(PSSGT1,"ND")),"^"),PSSGT4=$P($G(^PSDRUG(PSSGT1,"ND")),"^",3)
 .I 'PSSGT3!('PSSGT4) Q
 .S PSSGT5=$P($$PROD0^PSNAPIS(PSSGT3,PSSGT4),"^",7) I +$G(PSSGT5)'>0 Q
 .I $$EXMT^PSSDSAPI(PSSGT1) Q
 .S:'PSSGTHL1 PSSGTHL1=PSSGT1
 .I $P($G(^PSDRUG(PSSGT1,2)),"^",3)'[PSSGTPM Q
 .S PSSGT2=$P($G(^PSDRUG(PSSGT1,"I")),"^") I PSSGT2,PSSGT2<DT Q
 .S PSSGTHL2=PSSGT1
 S PSSGTRES=$S(PSSGTHL2:PSSGTHL2,PSSGTHL1:PSSGTHL1,1:0)
 Q PSSGTRES
 ;
 ;
DRGINP ;Inpatient Order with IV Route
 S PSSDSIVF=1  ;Added in 2.0 to set Input exception if no drug found
 N PSSGT6,PSSGT7,PSSGT8,PSSGTN1,PSSGTN3,PSSGTN4
 I PSSGTAB["A" D
 .F PSSGT6=0:0 S PSSGT6=$O(^PS(52.6,"AOI",PSSGTOI,PSSGT6)) Q:'PSSGT6!(PSSGTRES)  D
 ..S PSSGT7=$P($G(^PS(52.6,PSSGT6,"I")),"^") I PSSGT7,PSSGT7'>DT Q
 ..S PSSGT8=$P($G(^PS(52.6,PSSGT6,0)),"^",2) I 'PSSGT8 Q
 ..;Dispense Drug can be inactive, and no need to check package use
 ..S PSSGTN1=$P($G(^PSDRUG(PSSGT8,"ND")),"^"),PSSGTN3=$P($G(^PSDRUG(PSSGT8,"ND")),"^",3)
 ..I 'PSSGTN1!('PSSGTN3) Q
 ..S PSSGTN4=$P($$PROD0^PSNAPIS(PSSGTN1,PSSGTN3),"^",7) I +$G(PSSGTN4)'>0 Q
 ..I $$EXMT^PSSDSAPI(PSSGT8) Q
 ..S PSSGTRES=PSSGT8
 I PSSGTRES Q PSSGTRES
 I PSSGTAB["B" D
 .F PSSGT6=0:0 S PSSGT6=$O(^PS(52.7,"AOI",PSSGTOI,PSSGT6)) Q:'PSSGT6!(PSSGTRES)  D
 ..I $P($G(^PS(52.7,PSSGT6,0)),"^",14)'=1 Q
 ..S PSSGT7=$P($G(^PS(52.7,PSSGT6,"I")),"^") I PSSGT7,PSSGT7'>DT Q
 ..S PSSGT8=$P($G(^PS(52.7,PSSGT6,0)),"^",2) I 'PSSGT8 Q
 ..;Dispense Drug can be inactive, and no need to check package use
 ..S PSSGTN1=$P($G(^PSDRUG(PSSGT8,"ND")),"^"),PSSGTN3=$P($G(^PSDRUG(PSSGT8,"ND")),"^",3)
 ..I 'PSSGTN1!('PSSGTN3) Q
 ..S PSSGTN4=$P($$PROD0^PSNAPIS(PSSGTN1,PSSGTN3),"^",7) I +$G(PSSGTN4)'>0 Q
 ..I $$EXMT^PSSDSAPI(PSSGT8) Q
 ..S PSSGTRES=PSSGT8
 Q PSSGTRES
 ;
 ;
PRE(PSSLGTOI,PSSDIAG) ;Determine if CPRS needs to do order checks
 ;PSSLGTOI = File 50.7 Internal Entry Number
 ;PSSDIAG = CPRS order dialog (U:Inpatient; I:IV Fluids; O:Outpatient; N:Non-VA Meds)
 ; If PSSDIAG is "I" then DO NOT use this call for additve entries.
 ;If 1 is returned then CPRS needs to do enhanced order checks.  This means it is either a UD,
 ; Outpatient, Non-VA, additive, or a premix solution.
 ;If 0 is returned then enhanced order check is not needed to perform.
 ;
 I '+$G(PSSLGTOI) Q 0
 I $G(PSSDIAG)="" Q 1
 I PSSDIAG="O" Q 1
 I PSSDIAG="N" Q 1
 I PSSDIAG="I" Q +$$SOL^PSSDSAPA(PSSLGTOI)
 I PSSDIAG="U" Q $$IPM^PSSDSAPA(PSSLGTOI)
 Q 1
 ;
 ;
CONV(PSSCVTVL) ;Convert hours into format for Dose API for Inpatient Medications
 N PSSCVTRS,PSSCVT1,PSSCVT2,PSSCVT3
 S PSSCVTRS=""
 I '$G(PSSCVTVL) Q PSSCVTRS
 S PSSCVT1=+PSSCVTVL
 I PSSCVT1<1 S PSSCVT2=PSSCVT1*60 S PSSCVT3=1440/PSSCVT2 S PSSCVTRS=$J(PSSCVT3,0,0) S:PSSCVTRS=24 PSSCVTRS="Q1H" Q PSSCVTRS
 S PSSCVT2=$J(PSSCVT1,0,0) S PSSCVTRS="Q"_PSSCVT2_"H"
 Q PSSCVTRS
 ;
 ;
ITEM ;Only Orderable Item passed in, no Dispense Drug
 N PSSDBI1,PSSDBI2,PSSDBI3,PSSDBI4,PSSDBI5,PSSDBI6,PSSDBI7,PSSDBI8,PSSDBI9,PSSDBI91,PSSDBI92,PSSDBI93,PSSDBI94
 S PSSDBI1=$G(PSSDSLCL)
 I $L(PSSDBI1)'>0 Q
 S PSSDBI1=$$UP^XLFSTR(PSSDBI1)
 ;Strip out commas up until first character not a number or decimal
 S PSSDBI6=0 F PSSDBI7=1:1:$L(PSSDBI1) Q:PSSDBI6  S PSSDBI8=$E(PSSDBI1,PSSDBI7) I PSSDBI8'?1N,PSSDBI8'?1".",PSSDBI8'?1"," S PSSDBI6=PSSDBI7
 I PSSDBI6=1 Q
 S PSSDBI9=$S('PSSDBI6:$L(PSSDBI1),1:(PSSDBI6-1))
 S PSSDBI91=$E(PSSDBI1,1,PSSDBI9),PSSDBI92=$E(PSSDBI1,(PSSDBI9+1),$L(PSSDBI1))
 S PSSDBI93=$TR(PSSDBI91,",","")
 S PSSDBI1=PSSDBI93_PSSDBI92
 I $E(PSSDBI1)=0 S PSSDBI1=$E(PSSDBI1,2,$L(PSSDBI1))
 I $L(PSSDBI1)'>0 Q
 S PSSDBI2=+PSSDBI1
 I 'PSSDBI2!($L(PSSDBI2)=$L(PSSDBI1)) Q
 S PSSDBI3=$E(PSSDBI1,($L(PSSDBI2)+1),$L(PSSDBI1))
 S PSSDBI4=$S($E(PSSDBI3)=" ":$E(PSSDBI3,2,$L(PSSDBI3)),1:PSSDBI3)
 I PSSDBI4="" Q
 I PSSDBIFL S PSSDBI5=$$UNITD^PSSDSAPI(PSSDBI4)
 I 'PSSDBIFL S PSSDBI5=$$UNIT^PSSDSAPI(PSSDBI4)
 I PSSDBI5="" Q
 S PSSDBAR("AMN")=PSSDBI2,PSSDBAR("UNIT")=PSSDBI5,PSSDBFAL=1
 Q
 ;
 ;
FRCON(PSSCFQ1) ;Convert frequency into a number for complex dose additions
 N PSSCFQRS,PSSCFQ2,PSSCFQ3,PSSCFQ4
 S PSSCFQRS=0
 I PSSCFQ1?1N.N!(PSSCFQ1?1N.N1"."1N.N) S PSSCFQRS=PSSCFQ1 Q PSSCFQRS
 I PSSCFQ1?1"Q"1N.N1"H" D  Q PSSCFQRS
 .S PSSCFQ2=$E(PSSCFQ1,2,($L(PSSCFQ1)-1))
 .S PSSCFQ3=60*PSSCFQ2
 .S PSSCFQRS=1440/PSSCFQ3
 I PSSCFQ1?1"Q"1N.N1"D" D  Q PSSCFQRS
 .S PSSCFQ2=$E(PSSCFQ1,2,($L(PSSCFQ1)-1))
 .S PSSCFQRS=1/PSSCFQ2 I PSSCFQRS["." S PSSCFQRS=$J(PSSCFQRS,0,4)
 I PSSCFQ1?1"Q"1N.N1"W" D  Q PSSCFQRS
 .S PSSCFQ2=$E(PSSCFQ1,2,($L(PSSCFQ1)-1))
 .S PSSCFQ3=7*PSSCFQ2
 .S PSSCFQ4=PSSCFQ3*1440
 .S PSSCFQRS=1440/PSSCFQ4 I PSSCFQRS["." S PSSCFQRS=$J(PSSCFQRS,0,4)
 I PSSCFQ1?1"Q"1N.N1"L" D  Q PSSCFQRS
 .S PSSCFQ2=$E(PSSCFQ1,2,($L(PSSCFQ1)-1))
 .S PSSCFQ3=30*PSSCFQ2
 .S PSSCFQ4=PSSCFQ3*1440
 .S PSSCFQRS=1440/PSSCFQ4 I PSSCFQRS["." S PSSCFQRS=$J(PSSCFQRS,0,4)
 I PSSCFQ1?1N.N1"XD" D  Q PSSCFQRS
 .S (PSSCFQ2,PSSCFQRS)=+PSSCFQ1
 .I PSSCFQRS["." S PSSCFQRS=$J(PSSCFQRS,0,4)
 I PSSCFQ1?1N.N1"XW" D  Q PSSCFQRS
 .S PSSCFQ2=+PSSCFQ1,PSSCFQRS=PSSCFQ2/7
 .I PSSCFQRS["." S PSSCFQRS=$J(PSSCFQRS,0,4)
 I PSSCFQ1?1N.N1"XL" D  Q PSSCFQRS
 .S PSSCFQ2=+PSSCFQ1,PSSCFQRS=PSSCFQ2/30
 .I PSSCFQRS["." S PSSCFQRS=$J(PSSCFQRS,0,4)
 I PSSCFQ1="QOD" S PSSCFQRS=.5 Q PSSCFQRS
 Q 0
 ;
 ;
SING ;
 S $P(PSSDBCAR(PSSDBEB1),"^")="S"
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",8)=1
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",9)=1
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",10)=$P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",7)
 S $P(PSSDBCAR(PSSDBEB1),"^",7)=1
 Q
 ;
 ;
DOWN ;
 S:PSSDBASA ^TMP($J,PSSDBASF,"OUT",0)=^TMP($J,PSSDBASE,"OUT",0) S:PSSDBASB ^TMP($J,PSSDBASG,"OUT",0)=^TMP($J,PSSDBASE,"OUT",0)
 Q
 ;
 ;
BDOSE ;Missing Numeric Dose or Dose Unit
 I 'PSSDBEB3!($P(PSSDBEB2,"^",11)="") D EXCPS^PSSDSAPD(1) D:$D(PSSDBCAZ(PSSDBEB1,"FRQ_ERROR")) EXCPS^PSSDSAPD(2) S PSSDBDGO=1 Q
 S $P(PSSDBCAR(PSSDBEB1),"^",20)=1 I '$P(PSSDBCAR(PSSDBEB1),"^",5) D EXCPS^PSSDSAPD(1) D:$D(PSSDBCAZ(PSSDBEB1,"FRQ_ERROR")) EXCPS^PSSDSAPD(2) S PSSDBFTX(PSSDBEB1,"FTX_ERROR")="" Q
 S PSSDBDGO=1
 D EXCPS^PSSDSAPD(1)
 I $D(PSSDBCAZ(PSSDBEB1,"FRQ_ERROR")) D EXCPS^PSSDSAPD(2)
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",5)=1
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",8)=1
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",9)=1
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",7)="DAY"
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",10)="DAY"
 S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",6)=$$DUNIT^PSSDSAPA S PSSDBAR("UNIT")=$P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",6) S $P(^TMP($J,PSSDBASE,"IN","DOSE",PSSDBEB1),"^",14)=$$DFM^PSSDSEXC
 S $P(PSSDBCAR(PSSDBEB1),"^",6)=1 S $P(PSSDBCAR(PSSDBEB1),"^",10)=1
 ; -- in 2.1 set Dummy Data flag
 S $P(PSSDBCAR(PSSDBEB1),"^",33)=1
 Q
 ;
 ;
FTX ;Pull Dosing sequences out of Input for complex orders where Free Text Dosage could not be evaluated
 N PSSDTX1
 S PSSDTX1="" F  S PSSDTX1=$O(PSSDBFTX(PSSDTX1)) Q:PSSDTX1=""  D
 .S PSSDBFTX(PSSDTX1,"NODE1")=$G(^TMP($J,PSSDBASE,"IN","DOSE",PSSDTX1))
 .S PSSDBFTX(PSSDTX1,"NODE2")=$G(^TMP($J,PSSDBASE,"IN","PROSPECTIVE",PSSDTX1))
 .K ^TMP($J,PSSDBASE,"IN","DOSE",PSSDTX1)
 .K ^TMP($J,PSSDBASE,"IN","PROSPECTIVE",PSSDTX1)
 Q
 ;
 ;
FTXRS ;Reset input globals that were pulled because of invalid dosage
 N PSSDTX2
 S PSSDTX2="" F  S PSSDTX2=$O(PSSDBFTX(PSSDTX2)) Q:PSSDTX2=""  D
 .S ^TMP($J,PSSDBASE,"IN","DOSE",PSSDTX2)=PSSDBFTX(PSSDTX2,"NODE1")
 .S ^TMP($J,PSSDBASE,"IN","PROSPECTIVE",PSSDTX2)=PSSDBFTX(PSSDTX2,"NODE2")
 Q
 ;
 ;
ERR1() ;Screen out Daily Dose errors for Single Dose Sequences, unless New Daily Dose created based on previous Dosing sequences
 ;Called from PSSDSEXC
 N PSSERS,PSSERSU
 S PSSERS=$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))
 S PSSERSU=$$UP^XLFSTR(PSSERS)
 I PSSERSU["DAILY DOSE",$P($G(PSSDBCAR(PSSDWLP)),"^",15) Q 1  ; 2.1 change to not show Daily Dose is Schedule indicates so
 I $P($G(PSSDBCAR(PSSDWLP)),"^")'="S"!($P($G(PSSDBCAR(PSSDWLP)),"^",11)) Q 0
 I PSSERSU'["DAILY DOSE" Q 0
 Q 1
 ;
 ;
ERR2() ;Screen out Frequency errors if Dosing Sequence is flagged for Single Dose only 
 ;Called from PSSDSEXC
 N PSSERH,PSSERHU,PSSERHRS
 S PSSERHRS=0
 I $P($G(PSSDBCAR(PSSDWE1)),"^",12)!($P($G(PSSDBCAR(PSSDWE1)),"^",5)=0) D
 .S PSSERH=PSSDWEGC
 .S PSSERHU=$$UP^XLFSTR(PSSERH)
 .I PSSERHU["UNDEFINED FREQUENCY"!(PSSERHU["FREQUENCY GREATER") S PSSERHRS=1
 Q PSSERHRS
 ;
 ;
INFERR ;Infusion Rate Height and Weight Errors
 I $D(PSSDBFDB(PSSDBLP,"HT_ERROR")) S PSSDBCAZ(PSSDBFDB(PSSDBLP,"RX_NUM"),"HT_ERROR")=""
 I $D(PSSDBFDB(PSSDBLP,"WT_ERROR")) S PSSDBCAZ(PSSDBFDB(PSSDBLP,"RX_NUM"),"WT_ERROR")=""
 Q
 ;
 ;
INFERRS ;
 I '$D(PSSDBCAZ(PSSDBEB1,"HT_ERROR")),'$D(PSSDBCAZ(PSSDBEB1,"WT_ERROR")) Q
 I $D(PSSDBCAZ(PSSDBEB1,"WT_ERROR")),$D(PSSDBCAZ(PSSDBEB1,"HT_ERROR")) D EXCPS^PSSDSAPD(14) Q
 I '$D(PSSDBCAZ(PSSDBEB1,"HT_ERROR")) D EXCPS^PSSDSAPD(13) Q
 D EXCPS^PSSDSAPD(12)
 Q
 ;
 ;
GENERRX ;Set General Dosing Guidelines exception
 ;This code, not being used, was moved from PSSDSEXC to have a record of old functionality, in case we need it again
 Q
 ;
 N PSSDWF1,PSSDWF2,PSSDWF3,PSSDWF4
 S PSSDWF2=0 F PSSDWF1=0:0 S PSSDWF1=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE5,PSSDWF1)) Q:'PSSDWF1  S PSSDWF2=PSSDWF1
 I 'PSSDWF2 D  Q
 .I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE5,1)="Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWE5),"^",2)
 .I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"EXCEPTIONS",1)="Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWE5),"^",2)
 .I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE5,2)="  General Dosing guidelines are not available"
 .I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"EXCEPTIONS",2)="  General Dosing guidelines are not available"
 .S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE5,1)="^^^^^^Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWE5),"^",2)_"^^^"_"General Dosing guidelines are not available"
 S PSSDWF2=PSSDWF2+1
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE5,PSSDWF2)="^^^^^^Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWE5),"^",2)_"^^^"_"General Dosing guidelines are not available"
 I PSSDBASA D
 .S PSSDWF3=0
 .F PSSDWF4=0:0 S PSSDWF4=$O(^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE5,PSSDWF4)) Q:'PSSDWF4  S PSSDWF3=PSSDWF4
 .S PSSDWF3=PSSDWF3+1
 .S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE5,PSSDWF3)="  General Dosing guidelines are not available"
 I PSSDBASB D
 .S PSSDWF3=0
 .F PSSDWF4=0:0 S PSSDWF4=$O(^TMP($J,PSSDBASG,"OUT",PSSDWE5,"EXCEPTIONS",PSSDWF4)) Q:'PSSDWF4  S PSSDWF3=PSSDWF4
 .S PSSDWF3=PSSDWF3+1
 .S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"EXCEPTIONS",PSSDWF3)="  General Dosing guidelines are not available"
 Q
 ;
 ;
MTCH() ;Called from PSSDSAPD, looking for Local Possible Dosages Match
 N PSSDSLTM
 I $P(PSSDBNOD,"^")=PSSDSLCL Q 1
 I $E(PSSDSLCL)=0 S PSSDSLTM=$E(PSSDSLCL,2,$L(PSSDSLCL)) I $L(PSSDSLTM)>0,PSSDSLTM=$P(PSSDBNOD,"^") Q 1
 I $E(PSSDSLCL)'=0 S PSSDSLTM=0_PSSDSLCL I PSSDSLTM=$P(PSSDBNOD,"^") Q 1
 Q 0
 ;
 ;
DPOP ;Use Pre release logic to find Dose unit and Numeric Dose
 N PSSDDPOP,PSSDSLPO
 S PSSDDPOP=$$EN^PSSDSBBP(PSSDBFDB(PSSDBLP,"DRUG_IEN"),PSSDSLCL)
 I PSSDDPOP S PSSDBAR("AMN")=$P(PSSDDPOP,"^",2),PSSDBAR("UNIT")=$P($G(^PS(51.24,+$P(PSSDDPOP,"^"),0)),"^",2) S PSSDBFAL=1 Q
 I $E(PSSDSLCL)=0 S PSSDSLPO=$E(PSSDSLCL,2,$L(PSSDSLCL)) I $L(PSSDSLPO)>0 D  I PSSDDPOP S PSSDBAR("AMN")=$P(PSSDDPOP,"^",2),PSSDBAR("UNIT")=$P($G(^PS(51.24,+$P(PSSDDPOP,"^"),0)),"^",2) S PSSDBFAL=1 Q
 .S PSSDDPOP=$$EN^PSSDSBBP(PSSDBFDB(PSSDBLP,"DRUG_IEN"),PSSDSLPO)
 I $E(PSSDSLCL)'=0 S PSSDSLPO=0_PSSDSLCL D  I PSSDDPOP S PSSDBAR("AMN")=$P(PSSDDPOP,"^",2),PSSDBAR("UNIT")=$P($G(^PS(51.24,+$P(PSSDDPOP,"^"),0)),"^",2) S PSSDBFAL=1 Q
 .S PSSDDPOP=$$EN^PSSDSBBP(PSSDBFDB(PSSDBLP,"DRUG_IEN"),PSSDSLPO)
 Q
 ;
 ;
FRDR ;Check if Duration exists, and is less than Duration of Schedule
 I $G(PSSDBAR("TYPE"))="SINGLE DOSE" Q
 N PSSDRSC1,PSSDRSC2,PSSDRSC3,PSSDRSC4,PSSDRSC5
 S PSSDRSC1=PSSDBFRB(PSSDBFDB(PSSDBLP,"RX_NUM"),"DRATE") I PSSDRSC1="" Q
 S PSSDRSC3=$$DRT^PSSDSAPD(PSSDRSC1) I PSSDRSC3'>0 Q
 S PSSDRSC4=1440/PSSDRSC3
 S PSSDRSC5=$S($P($G(PSSDBAR("FREQZZ")),"^",2)'="":$P(PSSDBAR("FREQZZ"),"^",2),1:PSSDBAR("FREQ"))
 I PSSDRSC5="" Q
 S PSSDRSC2=$$FRCON(PSSDRSC5)
 I PSSDRSC2,PSSDRSC4,PSSDRSC4>PSSDRSC2 D
 .S PSSDBCAZ(PSSDBFDB(PSSDBLP,"RX_NUM"),"FRQD_ERROR")=""
 .S PSSDBCAZ(PSSDBFDB(PSSDBLP,"RX_NUM"),"FRQ_ERROR")=""
 Q
 ;
 ;
NOEXP ;Don't show any exceptions for a drug level error
 N PSSNOE1,PSSNOE2
 F PSSNOE1=0:0 S PSSNOE1=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)) Q:'PSSNOE1  D
 .S PSSNOE2=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",10)
 .I PSSNOE2["Invalid or Undefined Frequency" D NOEXPF^PSSDSAPB Q
 .I PSSNOE2=""!(PSSNOE2["GCNSEQNO") S PSSNOE9(PSSDWE1)="" D NOEXPG Q
 .I PSSNOE2["Drug not matched to NDF"!(PSSNOE2["No active IV Additive/Solution marked for IV fluid order entry") S PSSNOE9(PSSDWE1)="" D NOEXPS
 Q
 ;
 ;
NOEXPS ;Set Drug level error
 I PSSNOE2["Drug not matched to NDF" S PSSENHKZ(PSSDWE1)=1
 I PSSDBASA D
 .S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,1)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",7)
 .S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,2)="  Reason(s): "_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",10)
 I PSSDBASB D
 .S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",1)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",7)
 .S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",2)="  Reason(s): "_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",10)
 Q
 ;
 ;
NOEXPG ;Set GCNSEQNO exception
 S PSSENHKZ(PSSDWE1)=1
 I PSSDBASA D
 .S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,1)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",7)
 I PSSDBASB D
 .S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",1)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSNOE1)),"^",7)
 Q
 ;
 ;
DPL ;Set Dose display text, called from PSSDSAPD
 S PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM"))=""
 I $D(PSSDBFDB(PSSDBLP,"DOSE_AMT")),$D(PSSDBFDB(PSSDBLP,"DOSE_UNIT")) S PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM"))=PSSDBFDB(PSSDBLP,"DOSE_AMT")_" "_PSSDBFDB(PSSDBLP,"DOSE_UNIT") D DPLZ Q
 I $G(PSSDBDS(PSSDBLP,"DRG_AMT")),$G(PSSDBDS(PSSDBLP,"DRG_UNIT"))'="" S PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM"))=$G(PSSDBDS(PSSDBLP,"DRG_AMT"))_" "_$G(PSSDBDS(PSSDBLP,"DRG_UNIT")) D DPLZ Q
 S PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM"))=$S($G(PSSDBDS(PSSDBLP,"DOSE"))'="":$P($G(PSSDBDS(PSSDBLP,"DOSE")),"&",5),1:$G(PSSDBDS(PSSDBLP,"DO")))
 Q
 ;
 ;
DPLZ ;
 I $E(PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM")))="." S PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM"))="0"_PSSDSDPL(PSSDBFDB(PSSDBLP,"RX_NUM"))
 Q
 ;
COMMENT ;
 ;The following line at DRG+12 was commented out, but needed to uncomment for CCR 4971, but other changes seemed to
 ;resolve this issue
 ;.S:'PSSGTHL1 PSSGTHL1=PSSGT1
 ;Original reason for comment:
 ;Commented the Package Use and Inactive Date check out in 2.0 because of the logic failure of a Drug Level error from
 ;CPRS, we check the Drug level error and don't return to error to CPRS if the enhanced order check was shown, to avoid
 ;duplicate "dosing" error messages. But we need to restore in 2.1 to get General Dosing Guidelines, and look at another
 ;way to handle the duplicate "dosing" drug level error messages.
 Q
 ;
 ;
CKWRN ;Set flag indicating a warning exists
 N PSSWAF1,PSSWAF2,PSSWAF3
 S PSSWAF3=0 F PSSWAF1=0:0 S PSSWAF1=$O(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSWAF1)) Q:'PSSWAF1!(PSSWAF3)  D
 .I $G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSWAF1,"TEXT"))'="" D
 ..S PSSWAF2=$S($G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSWAF1,"SEV"))="Warning":0,1:1)
 ..I 'PSSWAF2 S $P(PSSDBCAR(PSSDWLP),"^",22)=1,PSSWAF3=1
 Q
 ;
 ;
ADOSE ;Add DOSE subscript to any EXCEPTION from interface without DOSE subscript
 I '$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS",PSSDWEX3,"")) Q
 N PSSDWEZ4,PSSDWEZ5,PSSDWEZ6,PSSDWEZ7
 S PSSDWEZ4=0 F PSSDWEZ7=0:0 S PSSDWEZ7=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEZ7)) Q:'PSSDWEZ7  S PSSDWEZ4=PSSDWEZ7
 S PSSDWEZ4=PSSDWEZ4+1
 F PSSDWEZ5=0:0 S PSSDWEZ5=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS",PSSDWEX3,PSSDWEZ5)) Q:'PSSDWEZ5  D
 .S PSSDWEZ6=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS",PSSDWEX3,PSSDWEZ5)
 .S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEZ4)=PSSDWEZ6
 .I $P(PSSDWEZ6,"^",10)'="" S $P(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEZ4),"^",7)="Maximum Single Dose Check could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX3),"^",2) ;Changed for 2.0
 .S PSSDWEZ4=PSSDWEZ4+1
 Q
