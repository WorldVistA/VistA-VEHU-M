YSXRAC3 ; COMPILED XREF FOR FILE #601.22 ; 12/09/04
 ; 
 S DA(2)=DA(1) S DA(1)=0 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=2 DIKLM=1 S:DIKM1'=2&'$G(DIKPUSH(2)) DIKPUSH(2)=1,DA(2)=DA(1),DA(1)=DA,DA=0 G @DIKM1
A S DA(1)=$O(^YTD(601.2,DA(2),1,DA(1))) I DA(1)'>0 S DA(1)=0 G END
1 ;
B S DA=$O(^YTD(601.2,DA(2),1,DA(1),1,DA)) I DA'>0 S DA=0 Q:DIKM1=1  G A
2 ;
 S DIKZ(0)=$G(^YTD(601.2,DA(2),1,DA(1),1,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" D KILL^YTCROSS
CR1 S DIXR=464
 K X
 S X(1)=$P(DIKZ(0),U,1)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . D KMH^YTPXRM(.X,.DA)
CR2 K X
 G:'$D(DIKLM) B Q:$D(DIKILL)
END G ^YSXRAC4
