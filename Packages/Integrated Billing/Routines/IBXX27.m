IBXX27 ; COMPILED XREF FOR FILE #399.042 ; 06/26/25
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGCR(399,DA(1),"RC",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGCR(399,DA(1),"RC",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^DGCR(399,DA(1),"RC","B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $P(^DGCR(399,DA(1),"RC",DA,0),U,5) S ^DGCR(399,DA(1),"RC","ABS",$P(^DGCR(399,DA(1),"RC",DA,0),U,5),$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D 21^IBCU2
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(0)=X S X=+$G(IBMAED) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"RC",D1,0)):^(0),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y S X=DIV S X=1 X ^DD(399.042,.02,1,2,1.4)
 S DIKZ(0)=$G(^DGCR(399,DA(1),"RC",DA,0))
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" D 31^IBCU2
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" S DGXRF=1 D TC^IBCU2 K DGXRF
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" S ^DGCR(399,DA(1),"RC","ABS",$E(X,1,30),+^DGCR(399,DA(1),"RC",DA,0),DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC1",$E(X,1,30),DA(1),DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC2",DA(1),$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC1",$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA(1),DA)=""
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC2",DA(1),$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA)=""
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" S ^DGCR(399,DA(1),"RC","ACP",$E(X,1,30),DA)=""
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^IBXX28
