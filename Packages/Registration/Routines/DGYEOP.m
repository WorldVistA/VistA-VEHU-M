DGYEOP ;BIR/DMA-gather OP pharmacy and long term care patients; 08 Sep 95 / 1:57 PM
 ;;1.0; DGYE ;**15,16**;28 Apr 92
 K ^TMP("DGYEnML",$J)
 ;
 S DGYED=$E(DT,1,5)-2-($E(DT,4,5)<3*88)_"01",DGYE2=DGYED+31
 ;OP runs for two months ago
 S DGYE=DGYED F  S DGYE=$O(^PSRX("AL",DGYE)) Q:'DGYE  Q:DGYE>DGYE2  S DGYE1=$O(^(DGYE,0)) I DGYE1,$D(^PSRX(DGYE1,0)) S DGYE1=^(0),DFN=+$P(DGYE1,"^",2) I $D(^DPT(DFN,0)) S NAM=$P(^(0),"^") D
 .S DGYE1=+$P(DGYE1,"^",6),DGYE1=$P($G(^PSDRUG(+DGYE1,0)),"^",2) D:DGYE1["HS501" SET("7A") D:DGYE1["OP10" SET("7B")
 ;
 S DGYE=DGYED-.4 F  S DGYE=$O(^DG(45.9,"AA",DGYE)),DGYE3=0 Q:'DGYE  Q:DGYE>DGYE2  F  S DGYE3=$O(^DG(45.9,"AA",DGYE,DGYE3)) Q:'DGYE3  I DGYE3,$D(^DG(45.9,DGYE3,0)) S DGYE1=^(0),DFN=+DGYE1 I $P(DGYE1,"^",6)=1,$P(DGYE1,"^",9)="N" D
 .I $D(^DPT(DFN,0)) S NAM=$P(^(0),"^") D
 ..I $P(DGYE1,"^",43)>3 D SET("6B")
 ..S DGYE4=$P(DGYE1,"^",44,46) I DGYE4[2!(DGYE4[3)!(DGYE4[4)!($P(DGYE1,"^",47)=2) D SET("6A")
 ..;if any of pieces 44, 45 or 46 is a 2, 3 or 4 or piece 47=2
 Q
 ;
SET(TSK) ;
 I DGYE5 S RTE=DFN_";DPT(" D MED^RTUTL3 S DGYER=$S($P(RTDATA,"^",3)["/":$P($P(RTDATA,"^",3),"/",2),1:"Unknown")
 S TMP=^DPT(DFN,0),^(0)=$G(^TMP("DGYE",$J,"nTASK",TSK,0))+1,J=^(0),^(J)=$P(TMP,"^",1,9)_"^"_DGYER
 Q
 ;
PRINT ;
 S LINE="",$P(LINE,"-",132)=""
 D HEAD
 S TSK="" F  S TSK=$O(^TMP("DGYE",$J,"nTASK",TSK)),DONE=0,DFN=0 K GET Q:TSK=""  S TCNT=^(TSK,0),DGYECNT(TSK)=0,TOT=$$REVIEW^DGYEUTL1(TSK) F  S DFN=$O(^TMP("DGYE",$J,"nTASK",TSK,DFN)) Q:'DFN  D  I TOT,DONE=TOT Q
 .S DO=DFN I TOT,TCNT>TOT F  S DO=$R(TCNT)+1 Q:'$D(GET(DO))
 .S DATA=^(DO),GET(DO)="" I $Y+5>IOSL D HEAD
 .W !,?5,$P(DATA,"^",9),?20,$P(DATA,"^"),?55,$$FMTE^XLFDT($P(DATA,"^",3)),?70,$P(DATA,"^",2),?80,$P(DATA,"^",6),?87,DGYER,?119,TSK,!,LINE
 .S DGYECNT(TSK)=DGYECNT(TSK)+1,^TMP("DGYEnML",$J,TSK,DO)=DATA,DONE=DONE+1
 .S Y=$P(DATA,"^",9),^TMP("DGYEPL",$J,$E(Y,8,9)_$E(Y,6,7)_$E(Y,4,5)_$E(Y,1,3),"***")=$P(DATA,"^")_"^"_DGYER
 Q
HEAD W @IOF,!!,?9,"SSN",?25,"PATIENT NAME",?56,"DOB",?69,"SEX",?78,"RACE",?87,"CHART LOCATION",?119,"TASK",!,LINE Q
