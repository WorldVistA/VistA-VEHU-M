PSSJXR14 ; COMPILED XREF FOR FILE #55.09 ; 03/07/23
 ; 
 S DA(1)=0 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=2 DIKLM=1 S:DIKM1'=2&'$G(DIKPUSH(2)) DIKPUSH(2)=1,DA(2)=DA(1),DA(1)=DA,DA=0 G @DIKM1
A S DA(1)=$O(^PS(55,DA(2),5,DA(1))) I DA(1)'>0 S DA(1)=0 G END
1 ;
B S DA=$O(^PS(55,DA(2),5,DA(1),9,DA)) I DA'>0 S DA=0 Q:DIKM1=1  G A
2 ;
 S DIKZ(0)=$G(^PS(55,DA(2),5,DA(1),9,DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I '$D(DIU(0)),'$D(PSGPO) S PSGAL(36)=X,PSGAL("C")=6000,PSGALFF=1,PSGALFN=55.09 D ^PSGAL5
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" I '$D(DIU(0)),'$D(PSGPO) S PSGAL(37)=X,PSGAL("C")=6000,PSGALFF=2,PSGALFN=55.09 D ^PSGAL5
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" I '$D(DIU(0)),'$D(PSGPO) S PSGAL(78)=X,PSGAL("C")=6000,PSGALFF=3,PSGALFN=55.09 D ^PSGAL5
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I '$D(DIU(0)),'$D(PSGPO) S PSGAL(79)=X,PSGAL("C")=6000,PSGALFF=4,PSGALFN=55.09 D ^PSGAL5
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I '$D(DIU(0)),'$D(PSGPO) S PSGAL(35)=X,PSGAL("C")=6000,PSGALFF=.01,PSGALFN=55.09 D ^PSGAL5
 G:'$D(DIKLM) B Q:$D(DIKILL)
END G ^PSSJXR15
