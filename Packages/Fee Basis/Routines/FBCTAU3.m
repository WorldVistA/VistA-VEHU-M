FBCTAU3 ; ;10/25/18
 ;;
1 N X,X1,X2 S DIXR=394 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 D
 . D:X2(1)="" DELB^FBUCDD2(.DA)
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",161.01,DIIENS,.01,DION),$P($G(^FBAAA(DA(1),1,DA,0)),U,1))
 S X=$G(X(1))
 Q
2 N X,X1,X2 S DIXR=1183 D X2(U) K X2 M X2=X D X2("F") K X1 M X1=X
 D
 . D AUD^FBAAAUD(0)
 K X M X=X2 D
 . D AUD^FBAAAUD(1)
 Q
X2(DION) K X
 S X(1)=$G(@DIEZTMP@("V",161.01,DIIENS,.01,DION),$P($G(^FBAAA(DA(1),1,DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",161.01,DIIENS,.02,DION),$P($G(^FBAAA(DA(1),1,DA,0)),U,2))
 S X(3)=$G(@DIEZTMP@("V",161.01,DIIENS,.06,DION),$P($G(^FBAAA(DA(1),1,DA,0)),U,15))
 S X(4)=$G(@DIEZTMP@("V",161.01,DIIENS,.07,DION),$P($G(^FBAAA(DA(1),1,DA,0)),U,7))
 S X(5)=$G(@DIEZTMP@("V",161.01,DIIENS,.095,DION),$P($G(^FBAAA(DA(1),1,DA,0)),U,13))
 S X=$G(X(1))
 Q
