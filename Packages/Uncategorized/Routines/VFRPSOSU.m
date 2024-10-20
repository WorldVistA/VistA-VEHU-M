PSOSULBL ;BHAM ISC/JMB,SAB - PRINT SUSPENDED LABELS ; 04/08/93 11:18
 ;;6.0;OUTPATIENT PHARMACY;**32,59,98,126**;APRIL 1993
DEV D:'$D(PSOPAR) ^PSOLSET G:'$D(PSOPAR) DEV S PSOION=ION
 I '$P(PSOPAR,"^",8) G START
 I '$D(PSOPROP)!($G(PSOPROP)=ION) W *7,!,"PROFILES MUST BE SENT TO PRINTER !!",! K IOP,%ZIS,IO("Q"),POP S %ZIS="MNQ",%ZIS("A")="Select PROFILE DEVICE: " D ^%ZIS K %ZIS("A") G:POP EXIT G:$E(IOST)["C"!(PSOION=ION) DEV S PSOPROP=ION D ^%ZISC
START I $G(PSOCUTDT)']"" S X1=DT,X2=-45 D C^%DTC S PSODTCUT=X,PSOPRPAS=$P(PSOPAR,"^",7)
ASK K ^TMP($J),PSOSU,PSOSUSPR S PFIOQ=0,PDUZ=DUZ W !
 S %DT="AEX",%DT("A")="PRINT LABELS THRU DATE: ",%DT("B")="TODAY" D ^%DT K %DT G:Y<0 EXIT S PRTDT=Y
 I '$O(^PS(52.5,"C",0))!($O(^(0))>PRTDT) W *7,!!,"NOTHING THRU DATE TO PRINT" G ASK
 W ! S DIR("A")="SORT BY PATIENT NAME OR ID#"
 S DIR("?")="Enter 'P' to sort the labels alphabetically by name or 'I' to sort by identification number. Press return to print in the order they were entered.",DIR(0)="SBO^P:PATIENT NAME;I:IDENTIFICATION NUMBER"
 D ^DIR K DIR G:$G(DIRUT) EXIT S PSRT=$S(Y="P":1,1:0)
 S X1=PRTDT,X2=$P(PSOPAR,"^",27) D C^%DTC S XDATE=X K IOP,POP,IO("Q"),ZTSK
 W ! S %ZIS("A")="PRINTER 'LABEL' DEVICE: ",%ZIS("B")="",%ZIS="MQN" D ^%ZIS S PSLION=ION I POP S IOP=PSOION D ^%ZIS G EXIT
 F J=0,1 S @("PSOBAR"_J)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_J)) S @("PSOBAR"_J)=^("BAR"_J)
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&$P(PSOPAR,"^",19)
 K PSOION D ^%ZISC I $D(IO("Q")) K IO("Q")
BEG F DFN=0:0 S DFN=$O(^PS(52.5,"AC",DFN)) Q:'DFN  D  D:'PSRT PID^VADPT6 D CHKDEAD D:'DEAD&($G(PSOSFLAG)) PRT
 .S PSOSFLAG=0 F ZZ=0:0 S ZZ=$O(^PS(52.5,"AC",DFN,ZZ)) Q:'ZZ!$G(PSOSFLAG)  I ZZ'>PRTDT S PSOSFLAG=1
 D PPL G EXIT
PRT F SDT=0:0 S SDT=$O(^PS(52.5,"AC",DFN,SDT)) D:SDT CHK Q:'SDT
 Q
EXIT D ^%ZISC K ^TMP($J),%,%ZIS,CNT,COM,DA,DEAD,DFN,DIRUT,DTTM,G,JJ,PDUZ,IOP,ORD,PFIOQ,PSLION,PSRT,POP,PRF,PRTDT,PSLIO,PSNP,PSODBQ,PSOSFLAG,PSOSU,PSOTIME,PSOOUT,PSOPRFLG,PSOSUSPR,PSSPND,PST,PTL,PPLHLD,ZTSK
 K RF,RFCNT,RX,SDT,SFN,SREC,STOP,SUSPT,VADM,VAPA,X,X1,X2,XAK,XDATE,Y,Z,ZZ,ZII,ZTDESC,ZTRTN,ZTSAVE S:$D(ZTQUEUED) ZTREQ="@" Q
CHK I SDT'>XDATE D TMP Q
 Q
TMP F SFN=0:0 S SFN=$O(^PS(52.5,"AC",DFN,SDT,SFN)) Q:'SFN  I +$P($G(^PS(52.5,+SFN,0)),"^",6)=$G(PSOSITE),$G(^("P"))'=1,$P(^PSRX($P(^(0),"^"),0),"^",2)=DFN,$D(^DPT(DFN,0)),$P(^PSRX($P(^PS(52.5,SFN,0),"^"),0),"^",15)<9  D
 .I +$P(^PSRX($P(^PS(52.5,SFN,0),"^"),2),"^",6),+$P($G(^(2)),"^",6)<DT S DIE=52,DA=$P(^PS(52.5,SFN,0),"^"),DR="100///"_11 L +^PSRX(DA) D ^DIE L -^PSRX(DA) S DA=SFN,DIK="^PS(52.5," D ^DIK K DIE,DIK,DA Q
 .S SRT=$S(PSRT:$P(^DPT(DFN,0),"^")_$P(^(0),"^",9),1:VA("PID"))
 .I '$P(^PS(52.5,SFN,0),"^",5) S ^TMP($J,SRT,SFN)=+^PS(52.5,SFN,0)
 .E  S ^TMP($J,SRT,"PART",+^PS(52.5,SFN,0))=^PS(52.5,SFN,0)
 Q
PPL W ! D TIME I $G(PSOOUT) W !!,?5,*7,"NOTHING QUEUED TO PRINT",! Q
 W !!,"Preparing to queue labels.  Please wait."
 K PPL,PPL1 S ORD="" F  S ORD=$O(^TMP($J,ORD)) Q:ORD=""  D PPL1
 W !!,"LABELS QUEUED TO PRINT" W:$P(PSOPAR,"^",8) !!,"PROFILES QUEUED TO PRINT",!
 Q
PPL1 W "." S (PSOPRFLG,SUSPT)=1 S:$D(PSOPROP) PFIO=PSOPROP
 I $D(^TMP($J,ORD,"PART")) F PTL=0:0 S PTL=$O(^TMP($J,ORD,"PART",PTL)) Q:'PTL  S PPL=PTL,PDUZ=DUZ,RXP=$P(^TMP($J,ORD,"PART",PTL),"^",5),DFN=$P(^TMP($J,ORD,"PART",PTL),"^",3) D QLBL^PSORXL
 S PDUZ=DUZ K RXP,PPL,^TMP($J,ORD,"PART") F SFN=0:0 S SFN=$O(^TMP($J,ORD,SFN)) Q:'SFN  D
 .I $L($G(PPL))<240 S PPL=$P(^TMP($J,ORD,SFN),"^")_","_$G(PPL)
 .E  S PPL1=$P(^TMP($J,ORD,SFN),"^")_","_$G(PPL1)
 .S DFN=$P(^PS(52.5,SFN,0),"^",3) I $P(PSOPAR,"^",8),'$D(^PSRX($P(^PS(52.5,SFN,0),"^"),1)) S PSOPRFLG=0
 S PSNP=$S($P(PSOPAR,"^",8):1,1:0) I $G(PPL) S PPLHLD=$G(PPL1) K PPL1 D QLBL^PSORXL I $G(PPLHLD) S PPL=PPLHLD,PSNP=0,PDUZ=DUZ D QLBL^PSORXL
 K PPL,PPL1 Q
AREC S $P(^PSRX(RX,0),"^",15)=0 S SFN=$O(^PS(52.5,"B",RX,0)) Q:'SFN  D NOW^%DTC S DTTM=% S COM="Suspense Label "_$S($G(^PS(52.5,SFN,"P"))=0:"Printed",$G(^PS(52.5,SFN,"P"))="":"Printed",1:"Reprinted")_$S($G(RXP):" (PARTIAL)",1:"")
 S ^PS(52.5,SFN,"P")=1 K ^PS(52.5,"AC",DFN,$P(^PS(52.5,SFN,0),"^",2),SFN) S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(RX,"A",JJ)) Q:'JJ  S CNT=JJ
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RX,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 S CNT=CNT+1,^PSRX(RX,"A",0)="^52.3DA^"_CNT_"^"_CNT L +^PSRX(RX) S ^PSRX(RX,"A",CNT,0)=DTTM_"^S^"_DUZ_"^"_$S($G(RXP):6,1:RFCNT)_"^"_COM L -^PSRX(RX) Q
CHKDEAD D DEM^VADPT I VADM(1)="" W !,"PATIENT NAME IS UNKNOWN" S DEAD=0 Q
 I VADM(6)="" S DEAD=0 Q
 F SDT=0:0 S SDT=$O(^PS(52.5,"AC",DFN,SDT)) Q:SDT=""  F SFN=0:0 S SFN=$O(^PS(52.5,"AC",DFN,SDT,SFN)) Q:SFN=""  S RX=$P(^PS(52.5,SFN,0),"^") D DEAD
 Q
DEAD S $P(^PSRX(RX,0),"^",15)=12,COM="Died ("_$P(VADM(6),"^",2)_")",DA(1)=RX
 S DEAD=1 D ARECD^PSOSUPAT S DIK="^PS(52.5,",DA=SFN D ^DIK K DIK Q
TIME K %DT,PSOTIME,PSOOUT D NOW^%DTC S %DT="RAETX",%DT(0)=%,%DT("B")="NOW",%DT("A")="QUEUE TO RUN AT WHAT TIME: " D ^%DT K %DT S PSOTIME=Y I $D(DTOUT)!(Y=-1) S PSOOUT=1 Q
 S PSOSUSPR=1,PSODBQ=1 K:X="N"!(X="NO")!(X="NOW") PSOTIME Q
