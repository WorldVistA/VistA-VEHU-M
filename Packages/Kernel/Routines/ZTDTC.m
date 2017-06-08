DIDTC ; SF/XAK - DATE/TIME OPERATIONS ;1/16/92  11:36 AM
 ;;19.0;VA FileMan;;Jul 14, 1992
D I 'X1!'X2 S X="" Q
 S X=X1 D H S X1=%H,X=X2,X2=%Y+1 D H S X=X1-%H,%Y=%Y+1&X2
 K %H,X1,X2 Q
 ;
C S X=X1 Q:'X  D H S %H=%H+X2 D YMD S:$P(X1,".",2) X=X_"."_$P(X1,".",2) K X1,X2 Q
S S %=%#60/100+(%#3600\60)/100+(%\3600)/100 Q
 ;
H I X<1410000 S %H=0,%Y=-1 Q
 S %Y=$E(X,1,3),%M=$E(X,4,5),%D=$E(X,6,7)
 S %T=$E(X_0,9,10)*60+$E(X_"000",11,12)*60+$E(X_"00000",13,14)
TOH S %H=%M>2&'(%Y#4)+$P("^31^59^90^120^151^181^212^243^273^304^334","^",%M)+%D
 S %='%M!'%D,%Y=%Y-141,%H=%H+(%Y*365)+(%Y\4)-(%Y>59)+%,%Y=$S(%:-1,1:%H+4#7)
 K %M,%D,% Q
 ;
DOW D H S Y=%Y K %H,%Y Q
DW D H S Y=%Y,X=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",Y+1)_"DAY"
 S:Y<0 X="" Q
7 S %=%H>21608+%H-.1,%Y=%\365.25+141,%=%#365.25\1
 S %D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1
 S X=%Y_"00"+%M_"00"+%D Q
 ;
YX D YMD S Y=X_% G DD^%DT
YMD D 7 S %=$P(%H,",",2) D S K %D,%M,%Y Q
T F %=1:1 S Y=$E(X,%) Q:"+-"[Y  G 1^%DT:$E("TODAY",%)'=Y
 S X=$E(X,%+1,99) G PM:Y="" I +X'=X D DMW S X=%
 G:'X 1^%DT
PM S @("%H=$H"_Y_X) D TT G 1^%DT:%I(3)'?3N,D^%DT
N F %=2:1 S Y=$E(X,%) Q:"+-"[Y  G 1^%DT:$E("NOW",%)'=Y
 I Y="" S %H=$H G RT
 S X=$E(X,%+1,99)
 I X?1.N1"H" S X=X*3600,%H=$H,@("X=$P(%H,"","",2)"_Y_X),%=$S(X<0:-1,1:0)+(X\86400),X=X#86400,%H=$P(%H,",")+%_","_X G RT
 D DMW G 1^%DT:'% S @("%H=$H"_Y_%),%H=%H_","_$P($H,",",2)
RT D TT S %=$P(%H,",",2) D S S %=X_% I %DT'["S" S %=+$E(%,1,12)
 Q:'$D(%(0))  S Y=% G E^%DT
PF S %H=$H D YMD S %(9)=X,X=%DT["F"*2-1 I @("%I(1)*100+%I(2)"_$E("> <",X+2)_"$E(%(9),4,7)") S %I(3)=%I(3)+X
 Q
TT D 7 S %I(1)=%M,%I(2)=%D,%I(3)=%Y K %M,%D,%Y Q
NOW S %H=$H,%H=$S($P(%H,",",2):%H,1:%H-1)
 D TT S %=$P(%H,",",2) D S S %=X_$S(%:%,1:.24) Q
DMW S %=$S(X?1.N1"D":+X,X?1.N1"W":X*7,X?1.N1"M":X*30,+X=X:X,1:0)
 Q
COMMA ;
 S %D=X<0 S:%D X=-X S %=$S($D(X2):+X2,1:2),X=$J(X,1,%),%=$L(X)-3-$E(23456789,%),%L=$S($D(X3):X3,1:12)
 F %=%:-3 Q:$E(X,%)=""  S X=$E(X,1,%)_","_$E(X,%+1,99)
 S:$D(X2) X=$E("$",X2["$")_X S X=$J($E("(",%D)_X_$E(" )",%D+1),%L) K %,%D,%L
 Q
HELP S DDH=$S($D(DDH):DDH,1:0),A1="Examples of Valid Dates:" D %
 S A1="  JAN 20 1957 or 20 JAN 57 or 1/20/57"_$S(%DT'["N":" or 012057",1:"") D %
 S A1="  T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7,  etc." D %
 S A1="  T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc." D %
 S A1="If the year is omitted, the computer "_$S(%DT["P":"assumes a date in the PAST.",1:"uses the CURRENT YEAR.") D %
 I %DT'["X" S A1="You may omit the precise day, as:  JAN, 1957" D %
 I %DT'["T",%DT'["R" G 0
 S A1="If the date is omitted, the current date is assumed." D %
 S A1="Follow the date with a time, such as JAN 20@10, T@10AM, 10:30, etc." D %
 S A1="You may enter a time, such as NOON, MIDNIGHT or NOW." D %
 I %DT["S" S A1="Seconds may be entered as 10:30:30 or 103030AM." D %
 I %DT["R" S A1="Time is REQUIRED in this response." D %
0 Q:'$D(%DT(0))
 S A1=" " D % S A1="Enter a date which is "_$S(%DT(0)["-":"less",1:"greater")_" than or equal to " D %
 S Y=$S(%DT(0)["-":$P(%DT(0),"-",2),1:%DT(0)) D DD^%DT:Y'["NOW"
 I '$D(DDS) W Y,"." K A1 Q
 S DDH(DDH,"T")=DDH(DDH,"T")_Y_"." K A1 Q
 ;
% I '$D(DDS) W !,"     ",A1 Q
 S DDH=DDH+1,DDH(DDH,"T")="     "_A1 Q
