IBXX17 ; COMPILED XREF FOR FILE #399.0404 ; 06/26/25
 ; 
 S DA(2)=DA(1) S DA(1)=0 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=2 DIKLM=1 S:DIKM1'=2&'$G(DIKPUSH(2)) DIKPUSH(2)=1,DA(2)=DA(1),DA(1)=DA,DA=0 G @DIKM1
A S DA(1)=$O(^DGCR(399,DA(2),"CP",DA(1))) I DA(1)'>0 S DA(1)=0 G END
1 ;
 K ^DGCR(399,DA(2),"CP",DA(1),"LNPRV","C")
B S DA=$O(^DGCR(399,DA(2),"CP",DA(1),"LNPRV",DA)) I DA'>0 S DA=0 Q:DIKM1=1  G A
2 ;
 S DIKZ(0)=$G(^DGCR(399,DA(2),"CP",DA(1),"LNPRV",DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(399.0404,.02,1,2,2.4)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(399.0404,.02,1,3,2.4)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(399.0404,.02,1,4,2.4)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(399.0404,.02,1,5,2.4)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" X ^DD(399.0404,.02,1,6,2.4)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X="" X ^DD(399.0404,.02,1,7,2.4)
 S DIKZ(0)=$G(^DGCR(399,DA(2),"CP",DA(1),"LNPRV",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^DGCR(399,DA(2),"CP",DA(1),"LNPRV","B",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(2),DIV(0)=D0,D1=DA(1),DIV(1)=D1,D2=DA,DIV(2)=D2 S Y(1)=$S($D(^DGCR(399,D0,"CP",D1,"LNPRV",D2,0)):^(0),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(399.0404,.01,1,2,2.4)
CR1 S DIXR=920
 K X
 S DIKZ(0)=$G(^DGCR(399,DA(2),"CP",DA(1),"LNPRV",DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X=$$EXTERNAL^DILFD(399.0404,.01,,X(1))
 S:$D(X)#2 X(2)=X
 S X=$G(X(1))
 I $G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGCR(399,DA(2),"CP",DA(1),"LNPRV","C",$E(X(2),1,30),DA)
CR2 K X
 G:'$D(DIKLM) B Q:$D(DIKILL)
END G ^IBXX18
