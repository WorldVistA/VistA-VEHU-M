PSREF1 ; XAK,MJK/ALBANY ; 12 DEC 84  8:54 AM
 ;4.02 ; 12/13/84
CC F PI=1:1 Q:$P(PL,",",PI)=""  S DA=+PY($P(PL,",",PI)) W !!,$P(PL,",",PI),?5,$S($D(^PSDRUG(+$P(^PSRX(DA,0),"^",6),0)):$P(^(0),"^",1),1:""),?40,"SIG:",$P(^PSRX(DA,0),"^",10),?67,"QTY: ",$P(^(0),"^",7) D TWO
CCC G CQ:PPL="" W !!,"QUEUE/HOLD/SUSPEND",!,"(Enter '^' to bypass)  Q//" R PX G CQ:"^"=PX I "QHS"'[PX D QUES^PSRXL G CCC
 I "Q"[PX D Q^PSRXL G CQ
 S PX=PX_"^PSRXL" F PI=1:1 Q:$P(PPL,",",PI)=""  S DA=+$P(PPL,",",PI),ZD=$P(^PSRX(DA,2),"^",2),RXF=$S($D(^PSRX(DA,1,0)):+$P(^(0),"^",3),1:0) S:$D(^(RXF,0)) ZD=+^(0) D @PX
CQ I $D(IO)#2,IO'=IO(0),IO]"" C IO
 U IO(0) K SPFL1,PC,PSA,PPL,PL,PY,PI,PNM,DFN,NOW,PR,IOP,RCT,SPND,NEW1,NEW11,RX0,RX2 W ! Q
TWO I $D(^PS(52.5,"B",DA)),'$D(^PS(52.5,+$N(^(DA,0)),"P")) W !,*7,"RX IS ON SUSPENSE AND CANNOT BE REFILLED" Q
 I $D(^PSRX(DA,2)),$P(^(2),"^",6)<DT W *7,!,"PRESCRIPTION HAS EXPIRED." Q
 I $P(^(0),"^",15) S C=";"_$P(^(0),"^",15)_":",X=$P(^DD(52,100,0),"^",3),C=$F(X,C),C=$P($E(X,C,999),";",1) W *7,!,"PRESCRIPTION IS IN ",C," STATUS." Q
 S DAX=DA K DA S DA(1)=DAX K:$D(SPND) RFD S:$D(RFD) X=RFD D ^PSREF2 Q:'$D(X)  S RFD=X,RCT=DA,DA=DAX K DAX,DA(1)
 I $P(RX0,"^",12)]"" W !?5,*7,$P(RX0,"^",12)
 I $D(SPND),RFD=DT W !?5,"REFILLABLE TODAY." S:$D(PSA) MW=PSMW
R1 I '$D(PSA),$D(SPND),RFD=DT R !?5,"MAIL/WINDOW: MAIL//",X G Q:"^"=X S:X="" X="M" G R1:"MW"'[$E(X,1) S (PSMW,MW)=$E(X,1),PSA=1
R2 I $P(%PSITE,"^",21),MW="W" D MP
 I '$D(^PSRX(DA,1,0)) S ^(0)="^52.1DA^^"
R3 S ^PSRX(DA,1,RCT,0)=RFD_"^"_MW_"^^"_$P(RX0,"^",7)_"^^^"_CC_"^"_DT_"^"_PSITE,^PSRX(DA,1,"B",RFD,RCT)="",^(0)=$P(^PSRX(DA,1,0),"^",1,2)_"^"_RCT_"^"_($P(^(0),"^",4)+1),^PSRX("AD",RFD,DA,RCT)=""
 I '$P(%PSITE,"^",7) S PPL=PPL_DA_","
 E  D SPND
 I %PSITE S INV=$S($D(^PSRX(DA,1,RCT,0)):+$P(^(0),"^",4),1:+$P(RX0,"^",7)),^(660.1)=$S($D(^PSDRUG(+$P(RX0,"^",6),660.1)):^(660.1),1:0)-INV K INV
Q K D1,ANS,FL,RX2,LSTFIL,X1,X2,XS,%DT,J,JJ Q
SPND I RFD>DT S ZD=RFD D S^PSRXL W !?5,"SUSPENDED UNTIL ",$E(RFD,4,5),"-",$E(RFD,6,7),"-",$E(RFD,2,3) Q
 S PPL=PPL_DA_"," Q
 ;
MP W !,"METHOD OF PICK-UP: " S PSMP=$S($D(PSMP):PSMP,$D(^PSRX(DA,"MP")):^("MP"),1:"") W:PSMP]"" PSMP_" // " R PSX S PSMP=$S(PSX]"":PSX,1:PSMP)
 G:$E(PSX,1)="?"!$L(PSX)>60 MPQ G:$E(PSX,1)="^" CQ S ^PSRX(DA,"MP")=$S(PSMP]"":PSMP,'$D(^PSRX(DA,"MP")):"",1:^PSRX(DA,"MP")) Q
MPQ W !,"ENTER SPECIAL INSTRUCTIONS (MAX 60 CHARACTERS) FOR PATIENT PICK-UP WHICH WILL",!,"BE PRINTED IN PLACE OF THE ADDRESS ON THE MAILING LABEL" G MP