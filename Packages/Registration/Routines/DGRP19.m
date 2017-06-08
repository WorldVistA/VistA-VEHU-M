DGRP19 ; COMPILED XREF FOR FILE #2.101 ; 06/24/93
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:$D(DA(1)) DIKLM=1 G:$D(DA(1)) 1 S DA(1)=DA,DA=0 G @DIKM1
0 ;
A S DA=$O(^DPT(DA(1),"DIS",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$S($D(^DPT(DA(1),"DIS",DA,0))#2:^(0),1:"")
 S X=$P(DIKZ(0),U,1)
 I X'="" X ^DD(2.101,.01,1,1,1.3) S Y(2)=$C(59)_$S($D(^DD(2.101,50,0)):$P(^(0),U,3),1:""),Y(1)=$S($D(^DPT(D0,"DIS",D1,0)):^(0),1:"") S X=$P($P(Y(2),$C(59)_$P(Y(1),U,10)_":",2),$C(59),1) S DIU=X K Y S X=DIV S X="1" X ^DD(2.101,.01,1,1,1.4)
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DPT("ADIS",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DPT("ADI",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S A1B2TAG="REG" D ^A1B2XFR
 S X=$P(DIKZ(0),U,2)
 I X'="" S SDX=$S(X=0:2,X=1:4,1:"") K:'SDX SDX I $D(SDX) S ^SC("AAS",SDX,(9999999-DA),DA(1))=$S('$D(^DPT(DA(1),"DIS",DA,0)):"",1:+$P(^(0),"^",4)) K SDX
 S X=$P(DIKZ(0),U,2)
 I X'="" X ^DD(2.101,1,1,2,1)
 S X=$P(DIKZ(0),U,2)
 I X'="" D UNSCHED^DGOERNOT
 S X=$P(DIKZ(0),U,4)
 I X'="" S SDX=$S($D(^DPT(DA(1),"DIS",DA,0)):+$P(^(0),"^",2),1:""),SDX=$S(SDX=0:2,SDX=1:4,1:"") K:'SDX SDX I $D(SDX) S ^SC("AAS",SDX,(9999999-DA),DA(1))=X K SDX
 S X=$P(DIKZ(0),U,4)
 I X'="" S SDX=$S($D(^DPT(DA(1),"DIS",DA,0)):$P(^(0),"^",2),1:""),SDX=$S(SDX=0:"TT",SDX=1:"UN",1:"") K:SDX']"" SDX I $D(SDX) S SDIV=" "_X D SSD^DGREG0 K SDIV,SDX
 S X=$P(DIKZ(0),U,6)
 I X'="" X ^DD(2.101,5,1,1,1.3) S Y(2)=$C(59)_$S($D(^DD(2.101,50,0)):$P(^(0),U,3),1:""),Y(1)=$S($D(^DPT(D0,"DIS",D1,0)):^(0),1:"") S X=$P($P(Y(2),$C(59)_$P(Y(1),U,10)_":",2),$C(59),1) S DIU=X K Y S X=DIV S X="" X ^DD(2.101,5,1,1,1.4)
 S X=$P(DIKZ(0),U,6)
 I X'="" S L=+^DPT(DA(1),"DIS",DA,0) S:$E(X,1,5)>$E(L,1,5) ^DPT("ADI",X,DA(1),DA)=""
 S X=$P(DIKZ(0),U,7)
 I X'="" S A1B2TAG="REG" D ^A1B2XFR
 S X=$P(DIKZ(0),U,12)
 I X'="" S DFN=DA(1) D EN^DGMTR
 S X=$P(DIKZ(0),U,10)
 I X'="" S ^DPT("ADA",$E(X,1,30),DA(1),DA)=""
 S DIKZ("ODS")=$S($D(^DPT(DA(1),"DIS",DA,"ODS"))#2:^("ODS"),1:"")
 S X=$P(DIKZ("ODS"),U,2)
 I X'="" S ^DPT("AODSR",$E(X,1,30),DA(1),DA)=""
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^DGRP20
