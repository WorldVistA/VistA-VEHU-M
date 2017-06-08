XUSCLEAN ;SF/STAFF - CLEANUP BEFORE EXIT ;3/11/93  11:15
 ;;7.1;KERNEL;;May 11, 1993
 ;++++ Modified XUSCLEAN for SlotMaster ++++
H ;;Exit point for all applications
 LOCK  ;Unlock any locks
 I $D(^XUTL("XQ",$J,"T")) S %XQEA=^("T") F %XQEA1=%XQEA:-1:1 I $D(^XUTL("XQ",$J,%XQEA1)),$P(^(%XQEA1),U,16) S %XQEA2=+^(%XQEA1) I $D(^DIC(19,%XQEA2,15)),$L(^(15)) X ^(15) ;Unwind Exit Actions
 K %XQEA,%XQEA1,%XQEA2
 G:$D(IO("C")) H2 ;I $D(DUZ("NEWCODE")) D NEWCODE
 I $S($D(IOST)[0:1,IOST="":1,IOST["C-":1,1:0),'$D(XUERF) W !!!!!!!!!!!!!!!!!!!!!!!
 I $D(XQNOLOG) W !!,"==>  Sorry, all activity on this volume set is being halted!  Try again later.",*7,*7,*7,!!!!
 W !!,"Halting at " S X=$P($H,",",2),Y=$E(X#3600\60+100,2,3),X=X\3600,Z=0 S:X>11 Z=1 S:'X X=12 S:X>12 X=X-12 W X,":",Y," ",$S(Z:"pm",1:"am")
 D:$D(DUZ("NEWCODE")) NEWCODE
H2 D C K ^UTILITY($J),^TMP($J)
 S XQN=" " F  S XQN=$O(^UTILITY(XQN)) Q:XQN']""  K:"^ROU^GLO^LRLTR"'[XQN ^UTILITY(XQN,$J)
 S XQN="" F  S XQN=$O(^XUTL(XQN)) Q:XQN=""  K:XQN'="XQO" ^XUTL(XQN,$J)
 K ^XUTL("ZISPARAM",$I) ;,^DISV($S($D(DUZ)#2:+DUZ,1:0))
 S:'$D(XQXFLG)#2 XQXFLG="" I $D(XQCH),XQCH="HALT" S $P(XQXFLG,U,3)=""
 I ($D(XQNOHALT)#2)!($D(ZTQUEUED)#2)!($P(XQXFLG,U,3)="XUP") K XQNOHALT,XQXFLG Q  ;Return to REST^XQ12, ^XUP or Taskman.
 I $D(^%ZIS("H"))#2 X ^("H")
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 I $L($ZC(%GETSYM,"ZSLOT")) G HALT^ZSLOTZU  ; added line
 ;----------------------------------------------------------------------
 G HALT^ZU ;Go to ZU to do final halt.
C ;
 S XUDEV=$S($D(^XUTL("XQ",$J,"IOS")):^("IOS"),1:"")
 D ^%ZISC
 K I1,XUD I $D(^XUTL("XQ",$J,0))#2 S I1=+^(0) I $D(^XUSEC(0,I1,0)) S $P(^(0),"^",4)=$$NOW^XLFDT,XUD=+^(0)
 I $D(XUD)#2,XUD K ^XMB(3.7,XUD,100,$I) K:$D(I1) ^XUSEC(0,"CUR",XUD,I1)
 Q
NEWCODE ;Ask user to verify new code
 W !!,*7,"But, as I recall...",!,"You've changed your VERIFY CODE during this session.",!,"Please remember it for next time." H 4
 ;W !!,*7,"But, as I recall...",!,"You've changed your VERIFY CODE during this session." S XUK=3,XUH=DUZ("NEWCODE"),XUNC=1,DA=DUZ X ^%ZOSF("EOFF") D NEWCODE^XUS2
 Q
KILL ;To clean up ALL but kernel variables.
 K (DUZ,DTIME,DT,DISYS,IO,IOBS,IOF,IOM,ION,IOSL,IOST,IOT,IOS,IOXY,U,XRT0,%ZH0,XQVOL,XQY,XQY0,XQDIC,XQPSM,XQPT,XQAUDIT,XQXFLG,ZTSTOP,ZTQUEUED,ZTREQ),IO("C"),IO("Q")
 Q
XMR ;Entry point from XUS to DO xmr and cleanup after.
 D NEXT^XUS1 S XQXFLG="",XQXFLG("HALT")=1 G H2
