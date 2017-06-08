DGRPXX23 ; COMPILED XREF FOR FILE #2.011 ; 06/24/93
 ; 
 S DA(2)=DA(1) S DA(1)=0 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:$D(DA(2)) DIKLM=1 G:$D(DA(2)) 2 S DA(2)=DA(1) S DA(1)=DA,DA=0 G @DIKM1
A S DA(1)=$O(^DPT(DA(2),"DE",DA(1))) I DA(1)'>0 S DA(1)=0 G END
1 ;
B S DA=$O(^DPT(DA(2),"DE",DA(1),1,DA)) I DA'>0 S DA=0 Q:DIKM1=1  G A
2 ;
 S DIKZ(0)=$S($D(^DPT(DA(2),"DE",DA(1),1,DA,0))#2:^(0),1:"")
 S X=$P(DIKZ(0),U,1)
 I X'="" X ^DD(2.011,.01,1,1,1.3) S Y(2)=$C(59)_$S($D(^DD(2.001,2,0)):$P(^(0),U,3),1:""),Y(1)=$S($D(^DPT(D0,"DE",D1,0)):^(0),1:"") S X=$P($P(Y(2),$C(59)_$P(Y(1),U,2)_":",2),$C(59),1) S DIU=X K Y S X="" X ^DD(2.011,.01,1,1,1.4)
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DPT("AEB",$E(X,1,30),DA(2),DA(1),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S SD=+^DPT(DA(2),"DE",DA(1),0),^DPT("AEB1",SD,$E(X,1,30),DA(2),DA(1),DA)="" K SD
 S X=$P(DIKZ(0),U,3)
 I X'="" X ^DD(2.011,3,1,1,1.3) S Y(2)=$C(59)_$S($D(^DD(2.001,2,0)):$P(^(0),U,3),1:""),Y(1)=$S($D(^DPT(D0,"DE",D1,0)):^(0),1:"") S X=$P($P(Y(2),$C(59)_$P(Y(1),U,2)_":",2),$C(59),1) S DIU=X K Y S X="I" X ^DD(2.011,3,1,1,1.4)
 S X=$P(DIKZ(0),U,3)
 I X'="" K ^DPT("AEB",$P(^DPT(DA(2),"DE",DA(1),1,DA,0),"^",1),DA(2),DA(1),DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DPT(D0,"DE",D1,1,D2,0)):^(0),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(2.011,3,1,4,1.4)
 G:'$D(DIKLM) B Q:$D(DISET)
END Q
