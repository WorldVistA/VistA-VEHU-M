ORD18 ; COMPILED XREF FOR FILE #101.01 ; 11/19/98
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DISET) K DIKLM S:$D(DA(1)) DIKLM=1 G:$D(DA(1)) 1 S DA(1)=DA,DA=0 G @DIKM1
0 ;
A S DA=$O(^ORD(101,DA(1),10,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^ORD(101,DA(1),10,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^ORD(101,DA(1),10,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" D REDOX^ORDD101
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^ORD(101,"AD",$E(X,1,30),DA(1),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(101.01,.01,1,4,1.3) I X S X=DIV S Y(1)=$S($D(^ORD(101,D0,10,D1,1)):^(1),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y X ^DD(101.01,.01,1,4,1.1) X ^DD(101.01,.01,1,4,1.4)
 S X=$P(DIKZ(0),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(101.01,.01,1,5,1.3) I X S X=DIV S Y(1)=$S($D(^ORD(101,D0,10,D1,1)):^(1),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(101.01,.01,1,5,1.1) X ^DD(101.01,.01,1,5,1.4)
 S X=$P(DIKZ(0),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(101.01,.01,1,6,1.3) I X S X=DIV S Y(1)=$S($D(^ORD(101,D0,10,D1,1)):^(1),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y X ^DD(101.01,.01,1,6,1.1) X ^DD(101.01,.01,1,6,1.4)
 S X=$P(DIKZ(0),U,2)
 I X'="" D REDOX^ORDD101
 S X=$P(DIKZ(0),U,3)
 I X'="" D REDOX^ORDD101
 S X=$P(DIKZ(0),U,5)
 I X'="" D REDOX^ORDD101
 S X=$P(DIKZ(0),U,6)
 I X'="" D REDOX^ORDD101
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^ORD19
