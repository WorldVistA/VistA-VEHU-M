TIMEX1 ;557/THM-CHECK TIME ACROSS CPUs [ 03/22/95  8:34 AM ]
 ;;3.5;AHJ;;Nov 08, 1993
 ;
QUIT Q  ;program must be entered properly    
 ;
10(HOMEUCI,HOMEVOL,JOB) N %M S %M=$P($H,",",2)\60
 ;
20 N %I,%N S %TIM=%M\60_":"_(%M#60\10)_(%M#10)
 S %N=" AM" S:%M'<720 %M=%M-720,%N=" PM" S:%M<60 %M=%M+720
 S %I=%M\600 S:'%I %I=" " S %TIM1=%I_(%M\60#10)_":"_(%M#60\10)_(%M#10)_%N
 I '$D(%NP) S ^[HOMEUCI,HOMEVOL]TMP("TIMEX1",JOB,$P($ZU(0),",",2))=%TIM1
 K %NP,%TIME1 Q
 ;
INT S %NP="" G 10
 ;
INTT N %M S %M=$P(%H,",",2)\60,%NP="" G 20
 ;
QUE S IOP="HOME" D ^%ZIS K IOP,^TMP("TIMEX1",$J) X ^%ZOSF("UCI") S HOMEUCI=$P(Y,",",1),HOMEVOL=$P(Y,",",2),JOB=$J
 ;see what nodes are on-line
 S X="DDPCIR" X ^%ZOSF("TEST") I $T S CIR=$V($V(29,-5)+12,-3,0) F J=1:1 S X=$V(CIR+46,-3,2) D CNVEXT^DDPCIR S SYS(X)="" S CIR=$V(CIR,-3,0) Q:'CIR
 K SYS("VAA") ;kill VAX reference - can't job to it
 K NODDP I '$T S NODDP=1 W *7,!!,"You're not running DDP in this UCI.",!,"Only this volume (",HOMEVOL,") will be reported." H 2 W !
 S SYS(HOMEVOL)="" ;get this volume set too
 W @IOF,!!,"Checking the volume sets ...",!! H 1
 S ZZ="" F X=0:0 S ZZ=$O(SYS(ZZ)) Q:ZZ=""  J 10^TIMEX1(HOMEUCI,HOMEVOL,JOB)["MGR",ZZ,ZZ]::10
 S SEC=0 S ZZ="" F X=0:0 S ZZ=$O(SYS(ZZ)) Q:ZZ=""  D
CHK .I '$D(^TMP("TIMEX1",$J,ZZ)) W "." S SEC=SEC+1 H 1 W:SEC>60 !!,*7,"All times have not returned in 60 seconds.",!,"Program aborted.",!! G:SEC>60 EXIT G CHK
 W @IOF,!!,"Here are the current times on your systems:",!!!!! S VOL=""  F ZI=0:0 S VOL=$O(^TMP("TIMEX1",$J,VOL)) Q:VOL=""  W ?10,VOL," .......... ",^TMP("TIMEX1",$J,VOL),!
 ;
EXIT W !!,"Press RETURN to continue   " R ZI:60 K ^TMP("TIMEX1",$J),VOL,SYS,ZI,SEC,ZZ,HOMEUCI,HOMEVOL,Y,POP,JOB Q
