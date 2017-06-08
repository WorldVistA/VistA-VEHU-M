DIDT ;SF/XAK-DATE/TIME UTILITY;11/18/91  2:41 PM
 ;;19.0;VA FileMan;;Jul 14, 1992
%DT K % S:$D(%DT)[0 %DT="" S:$D(DDS)#2!(($D(ZTQUEUED))#2&($S('($D(IO)#2):0,IO="":1,1:0))) %DT=$P(%DT,"E")_$P(%DT,"E",2) G NA:%DT'["A"
 W !,$S($D(%DT("A")):%DT("A"),1:"DATE: "),$S($D(%DT("B")):%DT("B")_"//",1:"")
 R X:$S($D(DTIME):DTIME,1:999) S:'$T X="^",DTOUT=1
 I $D(%DT("B")),X="" S X=%DT("B")
 I "^"[X S Y=-1 K %I,% Q
NA S %(0)=X G 1:X'?.ANP
 F %=1:1:$L(X) Q:X?.UNP  S Y=$E(X,%) I Y?1L S X=$E(X,1,%-1)_$C($A(Y)-32)_$E(X,%+1,99)
 I %DT["E",X?."?" D HELP^%DTC G B
 I %DT["N",X?.N,+X=X G NO
 I X?1.A,(X["MID"!(X["NOON")) S X="@"_X
 I X'?1"NOV".E,X?1"N".1"OW".1P.E G N^%DTC:%DT["T"!(%DT["R") S X=$E(X,2,99),X="T"_$P(X,"OW")_$P(X,"OW",2)
 I X?1.N." "1.2A!(X?1.N1":"2N." ".2A)!(X?1.N1":"2N1":"2N." ".2A) S X="T@"_X
 I X?7N1"."1.N G R
 I X'["@",%DT'["R" G R
 I %DT'["T",%DT'["R" G NO
 S Y=$P(X,"@",2,9),X=$P(X,"@")
 F %=2,3 S %I=$P(Y,":",%) I %I,%I'?2N.PA G 1
 S:X="" X="T" S Y=$P(Y,":")_$P(Y,":",2)_$P(Y,":",3,9),%I=Y
 I Y?1.A S Y=$S(Y["MID":2400,Y["NOON":1200,1:"")
 G G:Y?4N,1:Y'?1.N.AP I %DT["R",Y="" G NO
 I %DT["S",Y?5.6N.A S %I=$P(Y,+Y,2),Y=+Y,%(3)=$E(Y,$L(Y)-1,$L(Y)),Y=$E(Y,1,$L(Y)-2)_$S(%I["A":"A",%I["P":"P",1:"") G 1:%(3)>59,G:Y?4N
 S:Y<13 Y=Y*100 I %I["A" S Y=$S(Y=1200:2400,Y>1159:Y-1200,1:Y)
 E  I Y<1200,%I["P"!(Y<600) G 1:Y<100 S Y=Y+1200
G G 1:Y>2400!'Y,1:Y#100>59 S %(1)=Y/10000
R I %DT["F"!(%DT["P") D TY S %(9)=%
7 G 8:X'?7N.1".".E S Y=$E(X,8,16),%=$E(Y_"000000",2,7)
 G NO:%DT'["T"&Y
 I %DT["E",(%'?.N)!(%>240000)!($E(%,3,4)>59)!($E(%,5,6)>59) G NO
 S:Y %(1)=+Y S X=$E(X,4,7)_($E(X,1,3)+1700)
8 S %I=0,%="" I X'?.N G T^%DTC:"T+-"[$E(X),U:X["^",X
 I %DT'["X",X\300=6!(X?2N) S (%I(1),%I(2))=0,%I(3)=X G 3
 F %I=0:1 S Y=$E(X,1,2),X=$E(X,3,9) G OT:Y="",1:%DT["X"&'Y S:%I=2 Y=Y_X,X="" S %I(%I+1)=Y
 ;
X S Y=$E(X),X=$E(X,2,99) I Y?1N G A:%?.N,Y
 I Y?1A G A:%?.A,Y
OT D:%]"" % G 1:%I>3,X:Y?1P,1:Y]"",@%I
Y D % S %=Y G 1:%I>3,X
A S %=%_Y G X
TY S %=$H#1461,%=$H\1461*4+(%\365)+141-(%=1460) Q
0 ;
1 W:%DT["E"&'$D(DIER) *7,$S('$D(DDS):" ??",1:"")
B G %DT:%DT["A",NO
U S X="^",%(0)=X
NO S Y=-1 G Q:%DT'["A",Q:X["^" W *7," ??" G %DT
2 I %I(2)>31,%DT'["X" S %I(3)=%I(2),%I(2)=0 G 3
 D TY S %I(3)=% D PF^%DTC:$D(%(9)) G C
3 I %I(3)?2N S %I(3)=%I(3)+$S(%DT'["P":200,$E(%(9),2,3)<%I(3):100,1:200) G C
 S %I(3)=%I(3)-1700 G 1:%I(3)'?3N
C I %I(1)>12 G 1
 I %I(2)>28,$E("303232332323",%I(1))+28<%I(2),%I(1)-2!(%I(2)-29)!(%I(3)#4)!(%I(3)=200) G 1
D D P
E I $D(%(1)) S:$D(%(3)) %(1)=$E(%(1)_"000",1,5)_%(3) S Y=+(Y_%(1))
 I %DT["E" S %=Y D DD W "  ("_Y_")" S Y=%
 I $D(%DT(0)) S %=%DT(0),%I=$S(%["-":Y,1:-Y) D:'% Z I $S(%DT["S":%,1:%\.0001/10000)+%I>0 G 1
Q S X=%(0) K %,%I,%H Q
Z I $P("NOW",%(0))="" S %=Y
 E  D NOW^%DTC
 S:%DT(0)["-" %=-% Q
DD Q:'Y  S Y=$S($E(Y,4,5):$P($T(M)," ",$E(Y,4,5)+2)_" ",1:"")_$S($E(Y,6,7):$E(Y,6,7)_", ",1:"")_($E(Y,1,3)+1700)_$S(Y[".":"."_$P(Y,".",2),1:"")
 I Y["." S Y=$P(Y,".")_"@"_$E(Y_0,14,15)_":"_$E(Y_"000",16,17)_$S($E(Y,18,19):":"_$E(Y_0,18,19),1:"")
 I $D(%DT)#2,%DT["S",Y["@",$P(Y,":",3)="" S Y=Y_":00"
 Q
P S Y=%I(3)_$E(%I(1)+100,2,3)_$E(%I(2)+100,2,3) Q
% I %?3.A S %=$F($T(M),$E(%,1,3))-4\4 I %>0,%I=1 S %I(1)=%,%=+%(0)
 S:%<1 %I=9 S %I=%I+1,%I(%I)=%,%=""
M ;; JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC
