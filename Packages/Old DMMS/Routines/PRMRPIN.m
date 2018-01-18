PRMRPIN ; GENERATED FROM 'PRMR INC PRINT 2633' PRINT TEMPLATE (#233) ; 04/17/89 ; (FILE 513.72, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(233,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>24 Q:'DN  W ?24 W "PATIENT INCIDENT REPORT           (VA FORM 10-2633-X)"
 D T Q:'DN  W ?2 D ^PRMRCONF K DIP
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "PATIENT:"
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,23)
 D N:$X>34 Q:'DN  W ?34 W "DATE/TIME OF INCIDENT:"
 D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,1) D DT
 D N:$X>0 Q:'DN  W ?0 W "SSN:"
 D N:$X>11 Q:'DN  W ?11 X DXS(1,9.2) S X=$P(DIP(101),U,9) S D0=I(0,0) K DIP W X
 D N:$X>34 Q:'DN  W ?34 W "DATE OF REPORT:"
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,5) D DT
 D N:$X>0 Q:'DN  W ?0 W "IP WARD:"
 D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^DIC(42,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>34 Q:'DN  W ?34 W "SUSPENSE DATE:"
 S X=$S($D(^PRMQ(513.72,D0,5)):^(5),1:"") D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,4) D DT
 D N:$X>34 Q:'DN  W ?34 W "DATE RD/VACO NOTIFIED:"
 D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,2) D DT
 D N:$X>0 Q:'DN  W ?0 W "REPORTER:"
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^DIC(3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>34 Q:'DN  W ?34 W "DISPOSITION DATE:"
 S X=$S($D(^PRMQ(513.72,D0,2)):^(2),1:"") D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,21) D DT
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 W "DISPOSITION AUTHORITY:"
 S X=$S($D(^PRMQ(513.72,D0,2)):^(2),1:"") D N:$X>57 Q:'DN  W ?57 S Y=$P(X,U,22) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 W "DISPOSITION:"
 S X=$S($D(^PRMQ(513.72,D0,5)):^(5),1:"") D N:$X>47 Q:'DN  W ?47 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "SUMMARY OF INVESTIGATION:"
 S X=$S($D(^PRMQ(513.72,D0,8)):^(8),1:"") D N:$X>11 Q:'DN  S DIWL=12,DIWR=79 S Y=$P(X,U,1) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "NEEDED ACTION:"
 S X=$S($D(^PRMQ(513.72,D0,5)):^(5),1:"") D N:$X>11 Q:'DN  W ?11,$E($P(X,U,5),1,60)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "INCIDENT TYPE: "
 D N:$X>16 Q:'DN  W ?16 X DXS(2,9.2) S X=$P(DIP(101),U,2) S D0=I(0,0) K DIP W X
 D N:$X>0 Q:'DN  W ?0 W "DESCRIPTION:"
 S X=$S($D(^PRMQ(513.72,D0,0)):^(0),1:"") D N:$X>16 Q:'DN  W ?16,$E($P(X,U,14),1,60)
 D N:$X>0 Q:'DN  W ?0 W "LOCATION: "
 D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 W ?51 S Y=$P(X,U,17) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "PROCEDURE:"
 G ^PRMRPIN1
