RJPTFQA1 ;RJ WILM DE; Patients readmitted between two dates; May 21, 1987
 ;;4.0
 K ^UTILITY("RJPTF",$J) S:'$D(DTIME) DTIME=300 S %DT="APE",%DT("A")="From Discharge Date: " D ^%DT G:Y=-1 X S Z1=Y,%DT("A")="To Discharge Date: " D ^%DT G:Y=-1 X S Z2=Y
1 R !,"Print out re-admissions with in time frame (in weeks): 4// ",X:DTIME S X=$S('$T:"^",X="":4,X["^":"^",X?.N:X,1:"") Q:X["^"  G:X=""!(X<1) H1 S Z3=X*7 W " weeks"
 W !!,"This report can be queued by typing a ""Q"" at the DEVICE: prompt." S %IS="QM",%IS("B")="" K IOP D ^%ZIS G:POP X
 I $D(IO("Q")) S PGM="QQ^RJPTFQA1" D ^RJPTFQ S ^%ZTSK(ZTSK,"Z1")=Z1,^%ZTSK(ZTSK,"Z2")=Z2,^%ZTSK(ZTSK,"Z3")=Z3 G X
 W !,"This may take a while..."
S S RJD13="Regular^NBC/While ASIH^Expiration 6 mo limit^Irregular^Transfer^Death with Autopsy^Death without Autopsy",X=0 F I=1:1 S X=$O(^DGPT("AAD",X)) Q:X=""  D AD
 D O
X X ^%ZIS("C") K %DT,Z1,Z2,X,%IS,D,I,J,PTF1,PTF2,RJD,RJD1,RJD2,RJD3,RJD4,RJD5,RJD6,RJNM,Y,Z,Z3,^UTILITY("RJPTF",$J),RJD13,RJD14,RJD15 Q
AD S Y=Z1-1 F I=0:0 S Y=$O(^DGPT("AAD",X,Y)) Q:Y=""  S Z=$O(^DGPT("AAD",X,Y)) Q:Z=""  D AD1 Q:Z=""
 Q
AD1 I Z>Z2 S Z="" Q
 Q:(Z-Y)>Z3
 S PTF1=$O(^DGPT("AAD",X,Y,0)),PTF2=$O(^DGPT("AAD",X,Z,0)) Q:PTF1=""!(PTF2="")
 S RJNM=$S($D(^DPT(X,0)):$P(^(0),"^",1)_"^"_$P(^(0),"^",9),1:"") Q:RJNM=""  S RJD=$S($D(^DGPT(PTF1,70)):^(70),1:"") I RJD="" S RJD1="",RJD2="^",RJD14="" G AD2
 S RJD1="" S:$P(RJD,"^",2)'="" RJD1=$S($D(^DIC(42.4,$P(RJD,"^",2),0)):$P(^(0),"^",1),1:"")
 S RJD2="^" S:$P(RJD,"^",10)'="" RJD2=$S($D(^ICD9($P(RJD,"^",10),0)):$P(^(0),"^",1)_"^"_$P(^(0),"^",3),1:"^")
 S RJD14="" S:$P(RJD,"^",3)'="" RJD14=$P(RJD13,"^",$P(RJD,"^",3))
AD2 S RJD3=$S($D(^DGPT(PTF2,0)):$P(^(0),"^",2),1:"") S RJD4=$S($D(^DGPT(PTF2,70)):^(70),1:"")
 S RJD5="" S:$P(RJD4,"^",2)'="" RJD5=$S($D(^DIC(42.4,$P(RJD4,"^",2),0)):$P(^(0),"^",1),1:"")
 S RJD6="" S:$P(RJD4,"^",10)'="" RJD6=$S($D(^ICD9($P(RJD4,"^",10),0)):$P(^(0),"^",1)_"^"_$P(^(0),"^",3),1:"^")
 S RJD15="" S:$P(RJD4,"^",3)'="" RJD15=$P(RJD13,"^",$P(RJD,"^",3))
 S ^UTILITY("RJPTF",$J,X,Y)=$E(RJNM,1,28)_"^"_PTF1_"^"_$P(RJD,"^",1)_"^"_$E(RJD1,1,16)_"^"_$P(RJD2,"^",1)_"^"_$E($P(RJD2,"^",2),1,22)_"^"_PTF2_"^"_RJD3_"^"_$P(RJD4,"^",1)_"^"_$E(RJD5,1,16)
 S ^UTILITY("RJPTF",$J,X,Y)=^UTILITY("RJPTF",$J,X,Y)_"^"_$P(RJD6,"^",1)_"^"_$E($P(RJD6,"^",2),1,22)_"^"_$E(RJD14,1,20)_"^"_$E(RJD15,1,20)
 Q
O U IO W @IOF,!!,"Re-Admissions between discharge dates: " S X=Z1 D O1 W " and " S X=Z2 D O1
 W !,"Re-Admissions time frame: ",Z3," days"
 W !!,"Patient Name",?30,"PTF #",?40,"Admission",?52,"Discharge",?62,"Discharge Bed",?80,"Type of Discharge",?102,"DXLS",?109,"DXLS Description"
 W ! F I=1:1:131 W "="
 S Z=0 F I=1:1 S Z=$O(^UTILITY("RJPTF",$J,Z)) Q:Z=""  D O2
 Q
O1 I X="" Q
 W $E(X,4,5),"-",$E(X,6,7),"-",$E(X,2,3) Q
O2 S Y=0 F J=1:1 S Y=$O(^UTILITY("RJPTF",$J,Z,Y)) Q:Y=""  D O3
 Q
O3 S D=^UTILITY("RJPTF",$J,Z,Y) W !,$P(D,"^",1),?30,$P(D,"^",3),?40 S X=Y D O1 W ?52 S X=$P(D,"^",4) D O1 W ?62,$P(D,"^",5),?80,$P(D,"^",14),?102,$P(D,"^",6),?109,$P(D,"^",7)
 W !,$P(D,"^",2),?30,$P(D,"^",8),?40 S X=$P(D,"^",9) D O1 W ?52 S X=$P(D,"^",10) D O1 W ?62,$P(D,"^",11),?80,$P(D,"^",15),?102,$P(D,"^",12),?109,$P(D,"^",13)
 W ! Q
H1 W !,"Enter a number for the specified number of weeks that re-admissions occur",!,"between or enter an ""^"" to exit." G 1
QQ S Z1=^%ZTSK(ZTSK,"Z1"),Z2=^%ZTSK(ZTSK,"Z2"),Z3=^%ZTSK(ZTSK,"Z3") G S
