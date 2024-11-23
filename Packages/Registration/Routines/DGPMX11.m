DGPMX11 ; ;11/22/24
 ;;
1 N X,X1,X2 S DIXR=1198 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"" D
 . K ^DGPM("AC",X(1),X(2),X(3),DA)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"" D
 . S ^DGPM("AC",X(1),X(2),X(3),DA)=""
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",405,DIIENS,.01,DION),$P($G(^DGPM(DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",405,DIIENS,.02,DION),$P($G(^DGPM(DA,0)),U,2))
 S X(3)=$G(@DIEZTMP@("V",405,DIIENS,.03,DION),$P($G(^DGPM(DA,0)),U,3))
 S X=$G(X(1))
 Q
