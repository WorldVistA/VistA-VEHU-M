DGPTX56 ; ;06/22/22
 ;;
1 N X,X1,X2 S DIXR=1162 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(2))]"" D
 . D KPTFMD^DGPTDDCR(.X,.DA,"M ICD1")
 K X M X=X2 I $G(X(2))]"" D
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD1")
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.02,DIIENS,10,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,10))
 S X(2)=$G(@DIEZTMP@("V",45.02,DIIENS,5,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,5))
 S X=$G(X(1))
 Q
2 N X,X1,X2 S DIXR=1163 D X2(U) K X2 M X2=X D X2("F") K X1 M X1=X
 I $G(X(2))]"" D
 . D KPTFMD^DGPTDDCR(.X,.DA,"M ICD2")
 K X M X=X2 I $G(X(2))]"" D
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD2")
 Q
X2(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.02,DIIENS,10,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,10))
 S X(2)=$G(@DIEZTMP@("V",45.02,DIIENS,6,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,6))
 S X=$G(X(1))
 Q
3 N X,X1,X2 S DIXR=1164 D X3(U) K X2 M X2=X D X3("F") K X1 M X1=X
 I $G(X(2))]"" D
 . D KPTFMD^DGPTDDCR(.X,.DA,"M ICD3")
 K X M X=X2 I $G(X(2))]"" D
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD3")
 Q
X3(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.02,DIIENS,10,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,10))
 S X(2)=$G(@DIEZTMP@("V",45.02,DIIENS,7,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,7))
 S X=$G(X(1))
 Q
4 N X,X1,X2 S DIXR=1165 D X4(U) K X2 M X2=X D X4("F") K X1 M X1=X
 I $G(X(2))]"" D
 . D KPTFMD^DGPTDDCR(.X,.DA,"M ICD4")
 K X M X=X2 I $G(X(2))]"" D
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD4")
 Q
X4(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.02,DIIENS,10,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,10))
 S X(2)=$G(@DIEZTMP@("V",45.02,DIIENS,8,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,8))
 S X=$G(X(1))
 Q
5 N X,X1,X2 S DIXR=1166 D X5(U) K X2 M X2=X D X5("F") K X1 M X1=X
 I $G(X(2))]"" D
 . D KPTFMD^DGPTDDCR(.X,.DA,"M ICD5")
 K X M X=X2 I $G(X(2))]"" D
 . D SPTFMD^DGPTDDCR(.X,.DA,"M ICD5")
 Q
X5(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.02,DIIENS,10,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,10))
 S X(2)=$G(@DIEZTMP@("V",45.02,DIIENS,9,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,9))
 S X=$G(X(1))
 Q
6 N X,X1,X2 S DIXR=1701 D X6(U) K X2 M X2=X D X6("F") K X1 M X1=X
 D
 . D NOTIFY^DGPTDD(.X1,.X2,.DA,45,"MOVEMENT","KILL")
 K X M X=X2 D
 . D NOTIFY^DGPTDD(.X1,.X2,.DA,45,"MOVEMENT","SET")
 Q
X6(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.02,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.02,DIIENS,5,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,5))
 S X(3)=$G(@DIEZTMP@("V",45.02,DIIENS,6,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,6))
 S X(4)=$G(@DIEZTMP@("V",45.02,DIIENS,7,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,7))
 S X(5)=$G(@DIEZTMP@("V",45.02,DIIENS,8,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,8))
 S X(6)=$G(@DIEZTMP@("V",45.02,DIIENS,9,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,9))
 S X(7)=$G(@DIEZTMP@("V",45.02,DIIENS,11,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,11))
 S X(8)=$G(@DIEZTMP@("V",45.02,DIIENS,12,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,12))
 S X(9)=$G(@DIEZTMP@("V",45.02,DIIENS,13,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,13))
 S X(10)=$G(@DIEZTMP@("V",45.02,DIIENS,14,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,14))
 S X(11)=$G(@DIEZTMP@("V",45.02,DIIENS,15,DION),$P($G(^DGPT(DA(1),"M",DA,0)),U,15))
 S X(12)=$G(@DIEZTMP@("V",45.02,DIIENS,81.01,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,1))
 S X(13)=$G(@DIEZTMP@("V",45.02,DIIENS,81.02,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,2))
 S X(14)=$G(@DIEZTMP@("V",45.02,DIIENS,81.03,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,3))
 S X(15)=$G(@DIEZTMP@("V",45.02,DIIENS,81.04,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,4))
 S X(16)=$G(@DIEZTMP@("V",45.02,DIIENS,81.05,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,5))
 S X(17)=$G(@DIEZTMP@("V",45.02,DIIENS,81.06,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,6))
 S X(18)=$G(@DIEZTMP@("V",45.02,DIIENS,81.07,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,7))
 S X(19)=$G(@DIEZTMP@("V",45.02,DIIENS,81.08,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,8))
 S X(20)=$G(@DIEZTMP@("V",45.02,DIIENS,81.09,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,9))
 S X(21)=$G(@DIEZTMP@("V",45.02,DIIENS,81.1,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,10))
 S X(22)=$G(@DIEZTMP@("V",45.02,DIIENS,81.11,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,11))
 S X(23)=$G(@DIEZTMP@("V",45.02,DIIENS,81.12,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,12))
 S X(24)=$G(@DIEZTMP@("V",45.02,DIIENS,81.13,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,13))
 S X(25)=$G(@DIEZTMP@("V",45.02,DIIENS,81.14,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,14))
 S X(26)=$G(@DIEZTMP@("V",45.02,DIIENS,81.15,DION),$P($G(^DGPT(DA(1),"M",DA,81)),U,15))
 S X=$G(X(1))
 Q
