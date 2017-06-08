ZZPSODEL ;BHAM ISC/SAB - DELETES ONE PRESCRIPTION ; 07/16/92 17:43
 ;;6.0;OUTPATIENT PHARMACY; ***NOT VERIFIED***
 I '$D(^XUSEC("PSORPH",DUZ)) W !,*7,"Requires Pharmacy Key (PSORPH) !" Q
 S PSDEL=1,PS="DELETE",DIC("S")="I $P(^PSRX(+Y,0),""^"",15)'=13,$G(^(2))" D A1^PSORXVW K DIC("S") G KILL:"^"[X
 I $P($G(^PSRX(DA,2)),"^",13) W *7,!,"RX has been Released to patient or mailed." D KILL G PSORXDL
ENQ S PSOIB=$S($D(^PSRX(DA,"IB")):^PSRX(DA,"IB"),1:0) ;Check if copay
 S RX=^PSRX(DA,0),RXN=DA,DIE=52,DR="100///^S X=13;108" L +^PSRX(DA) D ^DIE L -^PSRX(DA) K ^PSRX("ACP",$P(^PSRX(DA,0),"^",2),$P(^(2),"^",2),0,DA) D ACT
 S DA=$O(^PS(52.5,"B",RXN,0)) I DA S DIK="^PS(52.5," D ^DIK
 I $D(^PS(52.4,RXN)) S DA=RXN,DIK="^PS(52.4," D ^DIK
 I +PSOIB>0,+$P(PSOIB,"^",2)>0 D RXDEL^PSOCPA ;If charged, delete copay
 ;Q:+$G(PSORX("INTERVENE"))  G PSORXDL:$D(DA)&('$G(PSOZVER)) I PSOPAR S ^(660.1)=$S($D(^PSDRUG(+$P(RX,"^",6),660.1)):^(660.1),1:0)+$P(RX,"^",7)
 S DFN=+$P(RX,"^",2) F I=0:0 S I=$O(^PS(55,DFN,"P",I)) Q:'I  I +^(I,0)=RXN K ^(0) S ^(0)=$P(^PS(55,DFN,"P",0),"^",1,3)_"^"_($P(^(0),"^",4)-1)
 F I=0:0 S I=$O(^PS(55,DFN,"P","A",I)) Q:'I  I $D(^(I,RXN)) K ^(RXN)
 K RX,RXN Q:+$G(PSORX("INTERVENE"))  ; G:$G(PSDEL) PSORXDL
 ;
KILL K PSDEL,I,II,J,N,PHYS,PS,RFDATE,RFL,RFL1,ST,ST0,%,%Y,D0,DA,DI,DIC,DIE,DIH,DIU,DIV,DR,Z,DIG,X,Y,PSOIB,RX,RXN Q
ACT ;adds activity info for deleted rx
 S RXF=0 F I=0:0 S I=$O(^PSRX(RXN,1,I)) Q:'I  S RXF=I K ^PSRX("ACP",$P(^PSRX(RXN,0),"^",2),$P(^PSRX(RXN,1,I,0),"^"),I,RXN)
 S DA=0 F FDA=0:0 S FDA=$O(^PSRX(RXN,"A",FDA)) Q:'FDA  S DA=FDA
 D NOW^%DTC S DA=DA+1,^PSRX(RXN,"A",0)="^52.3DA^"_DA_"^"_DA,^PSRX(RXN,"A",DA,0)=%_"^"_"D"_"^"_DUZ_"^"_RXF_"^"_"RX DELETED on "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)
EX W !,"...PRESCRIPTION #"_$P(RX,"^")_" MARKED DELETED!!"
 K RXF,I,FDA,DIC,DIE,%,%I,%H S DA=RXN
 Q
