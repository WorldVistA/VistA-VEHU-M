XUS91 ; REPORT OF USERS SIGNED ON ; 6AUG1986 3:43 PM
 ;;5.01;
 S U="^",Y="",XQZCNT=0 I $D(^%ZOSF("UCI")) X ^%ZOSF("UCI")
 S XQHDR="User Status Report (Troy ISC Version)"
 S %H=$H D YMD^%DTC S DT=X
 W ! K ^UTILITY($J) S XQJN=0 F I=0:0 S XQJN=$N(^XUTL("XQ",XQJN)) Q:XQJN<0  S X=XQJN X ^%ZOSF("JOBPARAM") I Y]"",Y'["@@@",Y'=0 S XQK=$P(Y,U,1),XQKZ=Y X ^%ZOSF("UCI") D PASS1
 S IOP="" D ^%ZIS K IOP S XQPG=0,XQUI=0 D NEWPG
PRINT S XQUN=-1 F I=0:0 S XQUN=$N(^UTILITY($J,XQUN)) Q:(XQUN=-1)!XQUI  S XQJN=0 F J=0:0 S XQJN=$N(^UTILITY($J,XQUN,XQJN)) Q:(XQJN=-1)!XQUI  S XQV=^(XQJN),XQKZ=^(XQJN,"XQKZ") D LIST
 W !!,"Total Jobs: ",XQZCNT
 G END
PASS1 ;
 W "." S XQUN="UNKNOWN" I $D(^XUTL("XQ",XQJN,"DUZ")) S XQUN=^("DUZ"),XQUN=$S($D(^DIC(3,XQUN,0)):$P(^(0),U,1),1:"UNKNOWN")
 S XQV="UNKNOWN" I $D(^XUTL("XQ",XQJN,0)) S XQV=$P(^(0),".",2)_"00",XQV=$E(XQV,1,2)_":"_$E(XQV,3,4)
 S XQV=XQV_U_$S('$D(^XUTL("XQ",XQJN,"IO")):"UNKNOWN",1:^("IO"))
 S XQK="UNKNOWN" I $D(^XUTL("XQ",XQJN,"T")),^("T") S XQK=^("T") I $D(^(XQK)) S XQK=$E($P(^(XQK),U,3),1,29)
 I XQK="UNKNOWN",$D(^XUTL("XQ",XQJN,"ZTSK")) S XQJ=^("ZTSK") S:$D(^("XQM")) XQJ=$P(^DIC(19,^("XQM"),0),U,2) S XQK=$E(XQJ,1,19)_" *Tasked"
 S ^UTILITY($J,XQUN,XQJN)=XQV_U_XQK,^(XQJN,"XQKZ")=XQKZ,XQZCNT=XQZCNT+1
 Q
LIST ;
 D:$Y>19 NEWPG Q:XQUI
 W !,$J(XQJN,3),?3,"-",XQKZ,?12,$E(XQUN,1,19),?33,$P(XQV,U,1),?42,$P(XQV,U,2),?50,$P(XQV,U,3,99)
 Q
NEWPG ;
 I XQPG,$E(IOST,1)="C" D CON S XQUI=(X="^") Q:XQUI
 D HDR Q
CON ;
 W !!,"Press return to continue or '^' to escape " R X:DTIME S:'$T X=U
 Q
HDR ;
 W @IOF S XQPG=XQPG+1
 S Y=$P($H,",",2)\60,Y=(Y#60/100+(Y\60)/100+DT) D DT^DIO2
 W ?22,XQHDR,?71,"PAGE ",XQPG
 W !!,"JOB-UCI,VOL USER NAME            TIME ON  DEVICE  CURRENT MENU OPTION"
 W !,"----------- -------------------  -------  ------  ------------------------------"
 Q
END ;
 K XQKZ,XQZCNT,XQI,XQJN,XQUN,ZJ,XQJ,XQK,XQUI,XQPG,XQHDR,XQV,^UTILITY($J)
 Q
AOLD ;
 W !!,"This option will purge the log of old access and verify codes.",!,"It will remove the record of all inactive access and verify codes older",!,"than the date specified and allow for their re-use."
 W !!,"Do you wish to continue" S %=2 D YN^DICN G:%=2!(%<0) ENDA G:%'=1 AOLD
DAYS W !!,"How far back do you wish to retain codes? (7-90 days) " R X:DTIME G:'$T!'$L(X)!(X[U) ENDA I X<7!(X>90) W !,*7,"Enter the number of days indicating at what date codes should be purged." G DAYS
 S XUDAYS=X,(XUT(1),XUT(2))=0,XUDT=$H-XUDAYS S XUI=-1 F XUJ=0:0 S XUI=$N(^DIC(3,"AOLD",XUI)) Q:XUI<0  S XUJ=$N(^(XUI,-1)) S XUK=^(XUJ) I XUK<XUDT K ^DIC(3,"AOLD",XUI,XUJ) S XUT(1)=XUT(1)+1 W "."
 S XUI=-1 F XUJ=0:0 S XUI=$N(^DIC(3,XUI)) Q:XUI<0!(XUI'=+XUI)  S XUK=-1 F I=1:1 S XUK=$N(^DIC(3,XUI,"VOLD",XUK)) Q:XUK=-1  I ^(XUK)<XUDT K ^DIC(3,XUI,"VOLD",XUK) S XUT(2)=XUT(2)+1 W "."
 F I=1:1:2 W !!,$S('XUT(I):"No",1:XUT(I))," old ",$S(I=1:"access",1:"verify")," codes have been purged."
ENDA K XUT,XUDAYS,XUDT,XUI,XUJ,XUK
 Q
TESTM ;
 W !!,"This option will allow you to simulate signing on as another user to test their",!,"menus and keys.  You can step through menus, but cannot execute options.",!,"Return to your own identity by entering a '*'.",!
 S DIC=3,DIC(0)="AEQMZ" D ^DIC Q:Y<0
 I '$D(^DIC(3,+Y,201)) W !!,*7,"This user has no primary menu." Q
 S XQM=^(201),DUZ("SAV")=DUZ_U_DUZ(0),DUZ=+Y,DUZ(0)=$P(Y(0),U,4),%=$P(^DIC(3,+Y,0),U,1),DUZ("SAV")=DUZ("SAV")_U_$P(%,",",2)_" "_$P(%,",",1) G ^XQ
 Q
TESTN ;
 S DUZ=+DUZ("SAV"),DUZ(0)=$P(DUZ("SAV"),U,2),XQM=+^DIC(3,DUZ,201) K DUZ("SAV")
 W !!,"OK...  Returning to your own identity."
 G ^XQ
