DGX67 ; ;03/11/23
 ;;
1 N X,X1,X2 S DIXR=1177 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",1)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",1)
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,4,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,5))
 S X=$G(X(1))
 Q
2 N X,X1,X2 S DIXR=1178 D X2(U) K X2 M X2=X D X2("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",2)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",2)
 Q
X2(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,5,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,6))
 S X=$G(X(1))
 Q
3 N X,X1,X2 S DIXR=1179 D X3(U) K X2 M X2=X D X3("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",3)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",3)
 Q
X3(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,6,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,7))
 S X=$G(X(1))
 Q
4 N X,X1,X2 S DIXR=1180 D X4(U) K X2 M X2=X D X4("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",4)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",4)
 Q
X4(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,7,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,8))
 S X=$G(X(1))
 Q
5 N X,X1,X2 S DIXR=1181 D X5(U) K X2 M X2=X D X5("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",5)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",5)
 Q
X5(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,8,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,9))
 S X=$G(X(1))
 Q
6 N X,X1,X2 S DIXR=1249 D X6(U) K X2 M X2=X D X6("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",10)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",10)
 Q
X6(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,13,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,14))
 S X=$G(X(1))
 Q
7 N X,X1,X2 S DIXR=1250 D X7(U) K X2 M X2=X D X7("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",11)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",11)
 Q
X7(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,14,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,15))
 S X=$G(X(1))
 Q
8 N X,X1,X2 S DIXR=1251 D X8(U) K X2 M X2=X D X8("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",12)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",12)
 Q
X8(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,15,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,16))
 S X=$G(X(1))
 Q
9 N X,X1,X2 S DIXR=1252 D X9(U) K X2 M X2=X D X9("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",13)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",13)
 Q
X9(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,16,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,17))
 S X=$G(X(1))
 Q
10 N X,X1,X2 S DIXR=1253 D X10(U) K X2 M X2=X D X10("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",14)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",14)
 Q
X10(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,17,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,18))
 S X=$G(X(1))
 Q
11 N X,X1,X2 S DIXR=1254 D X11(U) K X2 M X2=X D X11("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",15)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",15)
 Q
X11(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,18,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,19))
 S X=$G(X(1))
 Q
12 N X,X1,X2 S DIXR=1255 D X12(U) K X2 M X2=X D X12("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",16)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",16)
 Q
X12(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,19,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,20))
 S X=$G(X(1))
 Q
13 N X,X1,X2 S DIXR=1256 D X13(U) K X2 M X2=X D X13("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",17)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",17)
 Q
X13(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,20,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,21))
 S X=$G(X(1))
 Q
14 N X,X1,X2 S DIXR=1257 D X14(U) K X2 M X2=X D X14("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",18)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",18)
 Q
X14(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,21,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,22))
 S X=$G(X(1))
 Q
15 N X,X1,X2 S DIXR=1258 D X15(U) K X2 M X2=X D X15("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",19)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",19)
 Q
X15(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,22,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,23))
 S X=$G(X(1))
 Q
16 N X,X1,X2 S DIXR=1259 D X16(U) K X2 M X2=X D X16("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",20)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",20)
 Q
X16(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,23,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,24))
 S X=$G(X(1))
 Q
17 N X,X1,X2 S DIXR=1260 D X17(U) K X2 M X2=X D X17("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",21)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",21)
 Q
X17(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,24,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,1))
 S X=$G(X(1))
 Q
18 N X,X1,X2 S DIXR=1261 D X18(U) K X2 M X2=X D X18("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",22)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",22)
 Q
X18(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,25,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,2))
 S X=$G(X(1))
 Q
19 N X,X1,X2 S DIXR=1262 D X19(U) K X2 M X2=X D X19("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",23)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",23)
 Q
X19(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,26,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,3))
 S X=$G(X(1))
 Q
20 N X,X1,X2 S DIXR=1263 D X20(U) K X2 M X2=X D X20("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",24)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",24)
 Q
X20(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,27,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,4))
 S X=$G(X(1))
 Q
21 N X,X1,X2 S DIXR=1264 D X21(U) K X2 M X2=X D X21("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",25)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",25)
 Q
X21(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,28,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,5))
 S X=$G(X(1))
 Q
22 N X,X1,X2 S DIXR=1265 D X22(U) K X2 M X2=X D X22("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",6)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",6)
 Q
X22(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,9,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,10))
 S X=$G(X(1))
 Q
23 N X,X1,X2 S DIXR=1266 D X23(U) K X2 M X2=X D X23("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",7)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",7)
 Q
X23(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,10,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,11))
 S X=$G(X(1))
 Q
24 N X,X1,X2 S DIXR=1267 D X24(U) K X2 M X2=X D X24("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",8)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",8)
 Q
X24(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,11,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,12))
 S X=$G(X(1))
 Q
25 N X,X1,X2 S DIXR=1268 D X25(U) K X2 M X2=X D X25("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KPTFP^DGPTDDCR(.X,.DA,"P",9)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SPTFP^DGPTDDCR(.X,.DA,"P",9)
 Q
X25(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,12,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,13))
 S X=$G(X(1))
 Q
26 N X,X1,X2 S DIXR=1670 D X26(U) K X2 M X2=X D X26("F") K X1 M X1=X
 D
 . D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,"PROCEDURE","KILL")
 K X M X=X2 D
 . D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,"PROCEDURE","SET")
 Q
X26(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.05,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.05,DIIENS,4,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,5))
 S X(3)=$G(@DIEZTMP@("V",45.05,DIIENS,5,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,6))
 S X(4)=$G(@DIEZTMP@("V",45.05,DIIENS,6,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,7))
 S X(5)=$G(@DIEZTMP@("V",45.05,DIIENS,7,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,8))
 S X(6)=$G(@DIEZTMP@("V",45.05,DIIENS,8,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,9))
 S X(7)=$G(@DIEZTMP@("V",45.05,DIIENS,9,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,10))
 S X(8)=$G(@DIEZTMP@("V",45.05,DIIENS,10,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,11))
 S X(9)=$G(@DIEZTMP@("V",45.05,DIIENS,11,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,12))
 S X(10)=$G(@DIEZTMP@("V",45.05,DIIENS,12,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,13))
 S X(11)=$G(@DIEZTMP@("V",45.05,DIIENS,13,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,14))
 S X(12)=$G(@DIEZTMP@("V",45.05,DIIENS,14,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,15))
 S X(13)=$G(@DIEZTMP@("V",45.05,DIIENS,15,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,16))
 S X(14)=$G(@DIEZTMP@("V",45.05,DIIENS,16,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,17))
 S X(15)=$G(@DIEZTMP@("V",45.05,DIIENS,17,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,18))
 S X(16)=$G(@DIEZTMP@("V",45.05,DIIENS,18,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,19))
 S X(17)=$G(@DIEZTMP@("V",45.05,DIIENS,19,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,20))
 S X(18)=$G(@DIEZTMP@("V",45.05,DIIENS,20,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,21))
 S X(19)=$G(@DIEZTMP@("V",45.05,DIIENS,21,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,22))
 S X(20)=$G(@DIEZTMP@("V",45.05,DIIENS,22,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,23))
 S X(21)=$G(@DIEZTMP@("V",45.05,DIIENS,23,DION),$P($G(^DGPT(DA(1),"P",DA,0)),U,24))
 S X(22)=$G(@DIEZTMP@("V",45.05,DIIENS,24,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,1))
 S X(23)=$G(@DIEZTMP@("V",45.05,DIIENS,25,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,2))
 S X(24)=$G(@DIEZTMP@("V",45.05,DIIENS,26,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,3))
 S X(25)=$G(@DIEZTMP@("V",45.05,DIIENS,27,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,4))
 S X(26)=$G(@DIEZTMP@("V",45.05,DIIENS,28,DION),$P($G(^DGPT(DA(1),"P",DA,1)),U,5))
 S X=$G(X(1))
 Q
