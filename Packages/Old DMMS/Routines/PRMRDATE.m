PRMRDATE ;GLRISC/JES - EXTRAPOLATE DATE FOR SORT/PRINTS ; 2/7/89  12:31 ;
 ;VERSION 1.01
 S:'$D(DTIME) DTIME=300 S:DTIME="" DTIME=300
 S Y=DT X ^DD("DD") S PRMRENGD=Y G RANGE
BLURBS ;
 W !!,"Enter Quarter Period and FY you wish Semi-Annual Report to end with" Q
BLURBQ ;
 W !!,"Enter Quarter Period in this format: 2nd quarter 1988 would be 2-88 or 2/88",! Q
BLURBY ;
 W !!,*7,"Enter 2 or 4 digit FY in this century" Q
RANGE ;
 S PRMRSTOP=0 W !!,"Select range of report:",!,"(M)onthly  (Q)uarterly  (S)emi-Annual  (Y)early  (R)andom",! R "(or enter ""^"" to exit) ",WHEN:DTIME G:(WHEN="")!(WHEN="^") ABORT
 S WHEN=$E(WHEN,1) S:WHEN?1L WHEN=$C($A(WHEN)-32)
 S (SEMI,YEAR)=0 G:WHEN["M" MONTH G:WHEN["Q" QUART
 I WHEN["S" S SEMI=1 D BLURBS G QUART
 G:WHEN["Y" YEAR G:WHEN["R" RANDOM W !!,*7,"Enter M or Q or S or Y or R" G PRMRDATE
MONTH ;
 S EOM("01")="31^JANUARY",EOM("02")="28^FEBRUARY",EOM("03")="31^MARCH",EOM("04")="30^APRIL",EOM("05")="31^MAY",EOM("06")="30^JUNE"
 S EOM("07")="31^JULY",EOM("08")="31^AUGUST",EOM("09")="30^SEPTEMBER",EOM(10)="31^OCTOBER",EOM(11)="30^NOVEMBER",EOM(12)="31^DECEMBER"
 S %DT="AE",%DT("A")="Enter Month and Year: " D ^%DT G:(X="^")!(X="") RANGE I $E(Y,4,5)="00" W *7,*7,!!,"Please enter month and year only" G RANGE
 S MOE=$E(Y,4,5),PRMRNEND=$E(Y,1,5)_$P(EOM(MOE),"^",1) S:($E(Y,2,3)#4=0)&($E(Y,4,5)="02") PRMRNEND=PRMRNEND+1 S PRMRNBEG=$E(PRMRNEND,1,5)_"01",PRMR2HED="MONTH OF "_$P(EOM(MOE),"^",2)_" 19"_$E(Y,2,3),PRMRSPOT="?27" G QUIT
QUART ;
 W !
ENTERQ ;
 R !,"Enter Quarter and Year: ",QUART:DTIME
 I QUART["?" D BLURBQ G ENTERQ
 G:(QUART="^")!(QUART="") RANGE I (QUART'?1N1"-"2N)&(QUART'?1N1"/"2N) D BLURBQ G ENTERQ
 I ($E(QUART,1)>4)!($E(QUART,1)<1) W *7,*7,!!,"Enter Quarter 1 to 4 only",! G ENTERQ
 S QU=$E(QUART,1),YR=$E(QUART,3,4)
 S QUBEG(1)=2_YR-1_1001,QUBEG(2)=2_YR_"0101",QUBEG(3)=2_YR_"0401",QUBEG(4)=2_YR_"0701",QUEND(1)=2_YR-1_1231,QUEND(2)=2_YR_"0331",QUEND(3)=2_YR_"0630",QUEND(4)=2_YR_"0930",QUQUA(1)="FIRST",QUQUA(2)="SECOND",QUQUA(3)="THIRD",QUQUA(4)="FOURTH"
 S:SEMI SEBEG(1)=2_YR-1_"0701",SEBEG(2)=2_YR-1_1001,SEBEG(3)=2_YR_"0101",SEBEG(4)=2_YR_"0401"
 S PRMRNBEG=QUBEG(QU),PRMRNEND=QUEND(QU),PRMR2HED=QUQUA(QU)_" QUARTER FY 19"_YR S:SEMI PRMRNBEG=SEBEG(QU),PRMR2HED="SEMI-ANNUAL PERIOD ENDING "_PRMR2HED G QUIT
YEAR ;
 S YEAR=1 R !!,"Enter FY: ",YR:DTIME I YR["?" D BLURBY G YEAR
 G:(YR="^")!(YR="") RANGE I ($L(YR)<2)!($L(YR)>4)!(($L(YR)=4)&($E(YR,1,2)'=19)) D BLURBY G YEAR
 S:$L(YR)=4 YR=$E(YR,3,4) S PRMRNBEG=2_YR-1_1001,PRMRNEND=2_YR_"0930",PRMR2HED="FISCAL YEAR 19"_YR G QUIT
RANDOM ;
 W !!,"Enter beginning and ending dates for time period desired for this report:",! S %DT="AEX",%DT("A")="Beginning Date: " D ^%DT G:(X="^")!(X="") RANGE S PRMRNBEG=Y X ^DD("DD") S BEGIN=Y
 S %DT="AEX",%DT("A")="Ending Date: " D ^%DT G:(X="^")!(X="") RANGE I Y<PRMRNBEG W !!,*7,"You cannot have an ending date prior to beginning date.  Please try again." G RANDOM
 S PRMRNEND=Y X ^DD("DD") S PRMR2HED="PERIOD FROM "_BEGIN_" TO "_Y G QUIT
ABORT ;
 K PRMR1HED,PRMR2HED,PRMRENGD,PRMRNBEG,PRMRNEND,PRMRSPOT,WHEN S PRMRSTOP=1 W !!,*7,*7,*7,"You have not selected a date range.",!,"No report will be produced.",!! G KILL
QUIT ;
 S PRMRNBEG=PRMRNBEG_".0001",PRMRNEND=PRMRNEND_".9999",PRMR1HED="W !?65,PRMRENGD,!!?30,""INCIDENT REPORTS"""
 S:(WHEN["M")!(WHEN["Q") PRMRSPOT="?27" S:WHEN["S" PRMRSPOT="?14" S:WHEN["Y" PRMRSPOT="?30" S:WHEN["R" PRMRSPOT="?20"
KILL ;
 K BEGIN,EOM,MOE,MON,QU,QUART,QUBEG,QUEND,QUQUA,SEBEG,SEMI,WHEN,X,Y,YEAR,YR S %DT("A")="Date: " Q
