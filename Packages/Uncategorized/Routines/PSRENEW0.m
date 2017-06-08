PSRENEW0 ; XAK,MJK/ALBANY ; 13 DEC 84  2:24 PM
 ;4.02 ; 12/13/84
 G SPND:$P(%PSITE,"^",7)
 F PI=1:1 Q:$P(PR,",",PI)=""  S DA=+PY($P(PR,",",PI)) D DIQ W !,"CANCEL ABOVE RX & CREATE A NEW ONE DATED ",$E(RXD,4,5),"-",$E(RXD,6,7),"-",$E(RXD,2,3),".  Y// " R X D R:"Y"[$E(X,1)
 Q
R S DA=PY($P(PR,",",PI)),X1=$P(DA,"^",2),DA=+DA
RE S OX=^PSRX(DA,0),NRX=$P(OX,"^",2,10)_"^M^RENEWED FROM RX# "_$P(OX,"^",1)_"^"_DT_"^^^"_CC_"^"_$P(OX,"^",17,99),^(0)=$P(^(0),"^",1,13)_"^^12^"_$P(^(0),"^",16,99)
AINSRT S K=1,I=0 F Z=0:0 S Z=$N(^PSRX(DA,"A",Z)) Q:Z'>0  S I=Z,K=K+1
 S I=I+1 S:'($D(^PSRX(DA,"A",0))#2) ^(0)="^52.3DA^^^" S ^(0)=$P(^(0),"^",1,2)_"^"_I_"^"_K
 S ^PSRX(DA,"A",I,0)=DT_"^C^"_CC_"^0^RENEWED"
 G RE1:$N(^PS(52.5,"B",DA,0))'>0
 S X=$N(^(0)) G RE1:'$D(^PS(52.5,X,0)) S Y2=+$P(^(0),"^",2),PSI=$D(^("P")) K ^PS(52.5,X),^PS(52.5,"C",Y2,X),^PS(52.5,"B",DA,X) I PSI K PSI G RE1
 I $D(^PSRX(DA,1)) F PSI=0:0 S PSI=$N(^PSRX(DA,1,PSI)) Q:PSI'>0  S PSLAST=PSI
 I $D(PSLAST) S PSI=^PSRX(DA,1,PSLAST,0) K ^PSRX(DA,1,PSLAST),^PSRX(DA,1,"B",+PSI,PSLAST) S ^(0)=$P(^PSRX(DA,1,0),"^",1,3)_"^"_($P(^(0),"^",4)-1),RXD=+PSI,X=$P(OX,"^",1) S:RXD<DT RXD=DT K PSLAST,PSI G RN
 S PSI=^PSRX(DA,0),^(0)=$P(PSI,"^",1,11)_"^CANCELLED FROM SUSPENSE BEFORE FILLING^"_$P(PSI,"^",13,99),RXD=$S($D(^(2)):$P(^(2),"^",2),1:0),X=$P(OX,"^",1) S:RXD<DT RXD=DT K PSI G RN
RE1 S RXD=DT,X2=$P(OX,"^",8)-10 D C^%DTC S:X>DT RXD=X S X=$P(OX,"^",1)
RN S END=$E(X,$L(X)),X=$S(END?1N:X_"A",1:$E(X,1,$L(X)-1)_$C($A(END)+1))
 S DLAYGO=52,DIC="^PSRX(",DR=.01,DIC(0)="L" D ^DIC G RN:Y<0!('$P(Y,"^",3))
 S ^PSRX(+Y,0)=$P(Y,"^",2)_"^"_NRX,^(2)=DT_"^"_RXD_"^^^^^^^"_PSITE,RX(+Y)="",^PSRX("C",$P(^DPT(DFN,0),"^",1),+Y)="",^PSRX("AD",RXD,+Y,0)="" S:'$P(%PSITE,"^",7) PPL=PPL_(+Y)_","
 S:'$D(^PS(55,DFN,"P",0)) ^(0)="^55.03PA^^" F I=$P(^(0),"^",3)+1:1 Q:'$D(^PS(55,DFN,"P",I,0))
 S ^PS(55,DFN,"P",I,0)=+Y,^(0)=$P(^PS(55,DFN,"P",0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),DA=+Y Q:$P(%PSITE,"^",7)  R !,"EDIT? Y//",X
RN0 I "Y"[$E(X,1) S DIE="^PSRX(",DR=$S($P(%PSITE,"^",21):"[PSRENEWMP]",1:"[PSRENEW]") D ^DIE I $P(%PSITE,"^",27) D ^PSOSHOW S X=$S("Y"[$E(X,1):"N",1:"Y") G RN0
 S X1=$P(^PSRX(DA,0),"^",13),X2=($P(^(0),"^",9)+1)*($P(^(0),"^",8)),X=X1,X2=$S($P(^(0),"^",8)=X2:X2,X2<181:184,X2=360:366,1:X2) D:X1 C^%DTC:X2 S ^(2)=$P(^PSRX(DA,2),"^",1,5)_"^"_X_"^"_$P(^(2),"^",7,99)
 I %PSITE,$D(^PSDRUG(+$P(^PSRX(DA,0),"^",6),660.1)) W:^(660.1)<0 !,*7,"  BELOW CURRENT INVENTORY."
 I %PSITE S ^PSDRUG(+$P(^PSRX(DA,0),"^",6),660.1)=$S($D(^PSDRUG(+$P(^PSRX(DA,0),"^",6),660.1)):^(660.1),1:0)-$P(^PSRX(DA,0),"^",7)
 Q:'$P(%PSITE,"^",7)  S RXD=$P(^PSRX(DA,2),"^",2),ZD=RXD I RXD>DT D S^PSRXL Q
 S PPL=PPL_DA_"," Q
DIQ S RX=^PSRX(DA,0) W !!,$P(RX,"^",1),?10,$P(^PSDRUG(+$P(RX,"^",6),0),"^",1),?46,"QTY: ",$P(RX,"^",7)
 S PHYS=$S($D(^DIC(6,+$P(RX,"^",4),0)):^(0),1:"UNKNOWN") S:PHYS PHYS=$S($D(^DIC(16,+PHYS,0)):^(0),1:"UNKNOWN") W ?56,"PHYS: ",$P(PHYS,"^",1)
 W !,"# OF REFILLS: ",$P(RX,"^",9),"  ISSUED: ",$E($P(RX,"^",13),4,5),"-",$E($P(RX,"^",13),6,7),"-",$E($P(RX,"^",13),2,3),"  SIG: ",$P(RX,"^",10),!
 Q
SPND F PI=1:1 Q:$P(PR,",",PI)=""  D R,DIQ W !,$S(RXD>DT:"SUSPEND UNTIL ",1:"ELIGIBLE "),$E(RXD,4,5),"-",$E(RXD,6,7),"-",$E(RXD,2,3)," (to change, edit FILL DATE)." S X="" D RN0
