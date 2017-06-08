TIMEX ;557/THM-DATE AND TIME CHECK/UPDATE ROUTINE [ 03/22/95  8:33 AM ]
 ;;3.5;AHJ;;Nov 08, 1993
 ;
 S IOP="HOME",U="^",DTIME=$S($D(DTIME):DTIME,1:120) D ^%ZIS K IOP
EN W @IOF,!,"Date and Time Update for MSM PC 486 Systems",!!!
 I ^%ZOSF("OS")'["MSM" W *7,!!,"This is not an MSM system.",!! H 2 G EXIT
 I '$D(DUZ(0)) W !!,*7,"Your DUZ(0) is not defined.",!! H 2 G EXIT
 I DUZ(0)'="@" W !!,*7,"Programmer access is needed to run this program.",!! H 2 G EXIT
 W "Do you want help" S %=2 D YN G:%<0 EXIT D:%=1 HELP I %=1 W !!,"Press RETURN to continue or '^' to exit " R X:DTIME G:'$T!(X[U) EXIT
 ;
EN1 W @IOF,!,"Date and Time Check/Update for MSM PC 486 Systems",!!!
 W "Do you want to (C)heck or (M)odify the time on all systems? " R CTYPE:DTIME G:'$T!(CTYPE[U)!(CTYPE="") EXIT
 I CTYPE'?1"C",CTYPE'?1"M" W *7,!!,"Must be C to check or M to modify.",!! H 2 G EN1
 I CTYPE="C" D QUE^TIMEX1 G EN1
 ;
DATE K SYS W !! K %DT S %DT("A")=" Enter new date for ALL SYSTEMS: ",%DT="AE" D ^%DT G:Y<0 EXIT S (DATE1,DATE)=Y,DATE=$E(Y,4,5)_$E(Y,6,7)_$E(Y,2,3)
 ;
PSTIME W !,"Enter new time for PRINT SERVER: " R TIME:DTIME G:TIME=""!(TIME[U)!('$T) EXIT
 S X=DATE1_"@"_TIME S %DT="T" D ^%DT I Y<0 W !!,*7,"That is not a valid time.",! H 1 G PSTIME
 S TIME=$P(Y,".",2) I $L(TIME)<6 S TIME=TIME_$E("000000",1,6-$L(TIME))
 D DD^%DT W !!,?10,"Date will be ",$P(Y,"@",1),"   Time will be ",$P(Y,"@",2),!
 ;
OK K DTOUT W !,"Are the date and time correct as entered" S %=2 D YN
 I %Y["?" W !!,"Enter Y to go ahead or N to exit.",! G OK
 G:%'=1 EN1 G:$D(DTOUT) EXIT
 W !!,"Note:  All other servers will be set to TWO minutes less than this",!,"as recommended by the PC 486 Cookbook Committee.",!
 X ^%ZOSF("UCI") S VOL=$P(Y,",",2) W !
 ;see what nodes are on-line
 S X="DDPCIR" X ^%ZOSF("TEST") I $T S CIR=$V($V(29,-5)+12,-3,0) F I=1:1 S X=$V(CIR+46,-3,2) D CNVEXT^DDPCIR S SYS(X)=X S CIR=$V(CIR,-3,0) Q:'CIR
 K NODDP I '$T S NODDP=1 W *7,"You're not running DDP in this UCI.",!,"Only this volume (",VOL,") will be changed.  OK" S %=2 D YN W:%'=1 "  (QUIT)  " G:%'=1 EXIT S SYS(VOL)=VOL W !
 ;
LOOP G:$D(NODDP) QUEUE W !,"Enter volume set to skip: " R SVOL:DTIME G:'$T!(SVOL[U) EXIT G:SVOL="" QUEUE
 S Y="",Y=$O(SYS(Y)),Y=$O(SYS(Y)) I Y="" W !,"You can't delete all volume sets.",! G LOOP
 I SVOL["?" W !!,"If you are running NON-MSM systems, you will want to remove their volume set",!,"names since MSM cannot 'job' commands to them.",!! D HELP1 W ! G LOOP
 I '$D(SYS(SVOL)) W !!,*7,"That volume set is not a current selection .",! D HELP1 W ! G LOOP
 K:SVOL]"" SYS(SVOL) G LOOP
 ;
QUEUE W !!,"Do you want to queue this to run later" S %=1 D YN D:%Y["?" HLP G:%Y["?" QUEUE G:%=-1!($D(DTOUT)) EXIT
 I %=1 S ZTDESC="CPU Date/time Change",ZTRTN="ZTSK^TIMEX",ZTIO="" F I="DATE","TIME","SYS*","VOL" S ZTSAVE(I)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued (#",ZTSK,")",! G EXIT
 X ^%ZOSF("UCI") I Y'["PSA" W !!,*7,"This can be run real-time ONLY from volume set PSA.",!! H 2 G EXIT
 D CALL(DATE,TIME) W !,"Local update done ...",!! G:$D(NODDP) EXIT K SYS("PSA")
 I '$D(NODDP) W "Sending job requests over network to other servers.",!! ;only if not queued, updating multiple vol sets
 ;
ZTSK Q:'$D(DATE)!('$D(TIME))
 I VOL="PSA",$D(ZTQUEUED) D CALL(DATE,TIME) ;only if queued
 W:'$D(ZTQUEUED) ! S I="" D  F  S I=$O(SYS(I)) Q:I=""  J CALL^TIMEX(DATE,TIME)["MGR",SYS(I),SYS(I)]::10 W:'$D(ZTQUEUED) "Sent to system ",SYS(I),!
 .S P1=$E(TIME,1,2),P2=$E(TIME,3,4),P3=$E(TIME,5,6),P2=P2-2
 .I P2<0 S P2=60+P2,P1=P1-1 I P1<0 S P1=24+P1
 .I $L(P1)=1 S P1="0"_P1
 .I $L(P2)=1 S P2="0"_P2
 .S TIME=P1_P2_P3
 ;
EXIT D ^%ZISC
 K %,%Y,DTOUT,%DT,%ER,%TS,%TN,CIR,DATE,I,IOP,N,SYS,SYSTEMS,TIME,UCI,X,Y,P1,P2,P3,VOL,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTSK,POP,SVOL,ZTDESC,ZX,CTYPE,DATE1,DATETIME,%H,%I,%N,%TIM,%TIM1,NODDP
 Q
 ;
CALL(DATE,TIME) ; 
 K X S X=$ZCALL(DATETIME,DATE,TIME)
 Q
 ;
HLP I $D(%Y),%Y["?" W !!,"Enter Y to queue later or N to run now.",!
 Q
 ;
YN S:'$D(%) %=0 W "? ",$P("YES// ^NO// ",U,%)
RX R %Y:DTIME E  S DTOUT=1,%Y=U W *7
 S:%Y]""!'% %=$A(%Y),%=$S(%=89:1,%=121:1,%=78:2,%=110:2,%=94:-1,1:0)
 I '%,%Y'?."?" W *7,"??",!?4,"Answer 'YES' OR 'NO': " G RX
 W:$X>73 ! W $P("  (YES)^  (NO)",U,%)
 Q
 ;
HELP W @IOF,!!!,"This routine will check or set the date and time for all servers.",!!
 W "It is important to note that the date/time may be set forward without",!
 W "any consequences but setting the date or time backwards should ONLY",!
 W "be done between 02:00 am and 03:00 am to avoid cross-system journal",!,"corruption.",!
 W !,"This routine will also allow the setting of one volume set by",!,"removing any undesired volumes at the 'skip' prompt.",!
 Q
 ;
HELP1 S ZX="" W "Currently: " F  S ZX=$O(SYS(ZX)) Q:ZX=""  W ZX,$S($O(SYS(ZX))]"":", ",1:"")
 Q
