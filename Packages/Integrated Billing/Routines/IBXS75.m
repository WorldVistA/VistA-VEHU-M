IBXS75 ; ;05/22/20
 ;;
1 N X,X1,X2 S DIXR=855 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 D
 . D TAX^IBCEF79(DA)
 K X M X=X2 D
 . D TAX^IBCEF79(DA)
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",399,DIIENS,.22,DION),$P($G(^DGCR(399,DA,0)),U,22))
 S X(2)=$G(@DIEZTMP@("V",399,DIIENS,232,DION),$P($G(^DGCR(399,DA,"U2")),U,10))
 S X(3)=$G(@DIEZTMP@("V",399,DIIENS,136,DION),$P($G(^DGCR(399,DA,"MP")),U,2))
 S X(4)=$G(@DIEZTMP@("V",399,DIIENS,.19,DION),$P($G(^DGCR(399,DA,0)),U,19))
 S X=$G(X(1))
 Q
