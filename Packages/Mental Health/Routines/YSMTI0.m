YSMTI0 ;ALB/ASF - MUTLIPLE PSYCH TESTS FULL PROFILES ;7/23/99  10:36
 ;;5.01;MENTAL HEALTH;**53,187**;Dec 30, 1994;Build 74
 ;
 K IOP S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENTASK^YSMTI0",ZTDESC="YSMTI0" S ZTSAVE("YS*")="" D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7)
 U IO D DATES,TOP,LP,HOME^%ZIS D ^%ZISC U IO
 Q
ENTASK ;taskman entry
 S:$D(ZTQUEUED) ZTREQ="@"
 D ENFRNT^YSMTI,TOP,LP Q
TOP ;
 S YSLN="",$P(YSLN,"_",79)=""
 W @IOF,!?10,"**** M U L T I P L E   T E S T   A D M I N I S T R A T I O N S ***"
 W !,VADM(1),?40,"SSN: xxx-xx-"_$E($P(VADM(2),U,2),8,11),"  ",$P(VADM(5),U,2),?60,"  DOB: ",$P(VADM(3),U,2)
 S X=$P(^YTT(601,YSTEST,"P"),U) W !?(72-$L(X)/2),X
 W !,YSLN
 W !,"Scales",?15,"Administrations",!,YSLN,!?4
 ;S Y=0 F I=1:1:8 S Y=$O(YSDATES(Y)) Q:Y'>0  W $J($$FMTE^XLFDT(9999999-Y,"2D"),9)
 S Y=0 F I=1:1:8 S Y=$O(YSDATES(Y)) Q:Y'>0  W $J($$FMTE^XLFDT(9999999-Y,"5D"),10)
 ;W !
 Q
DATES ;
 S YSSNUMB=$P(^YTT(601,YSTEST,0),U),YSSNUMB=$S(YSSNUMB?1"MC".E:25,1:13)
 K YSDATES S YSDATES=0 F  S YSDATES=$O(^TMP("YSMTI",$J,YSDFN,YSTEST,1,YSDATES)) Q:YSDATES'>0  S YSDATES(9999999-YSDATES)=""
 Q
LP ;loop thru TMP
 F YSCALEN=1:1:YSSNUMB W !,$J($P($P(^YTT(601,YSTEST,"S",YSCALEN,0),U,2)," "),5)," "  D LP1
 Q
LP1 S YSDATES=0 F  S YSDATES=$O(YSDATES(YSDATES)) Q:YSDATES'>0  S YSED=9999999-YSDATES D LP2
 Q
LP2 S Y=^TMP("YSMTI",$J,YSDFN,YSTEST,YSCALEN,YSED)
 S S=$P(Y,U,2) W $J(S,6),?$X+3
 Q
FRONT ; front end output
 S YSDFN=P3,(YSET,YSTEST)=P4 K ^TMP("YSMTI",$J)
 S YSSNUMB=$P(^YTT(601,YSTEST,0),U),YSSNUMB=$S(YSSNUMB?1"MC".E:25,1:13)
 D ENFRNT^YSMTI
 W "11111<BOT>",$C(13)
FOUT1 ;
 F YSNSCALE=1:1:YSSNUMB D FOUT2
 W "<EOT>",$C(13) Q
FOUT2 S YSED=0 F  S YSED=$O(^TMP("YSMTI",$J,YSDFN,YSET,YSNSCALE,YSED)) Q:YSED'>0  D FRONT1
 Q
FRONT1 S Y=^TMP("YSMTI",$J,YSDFN,YSET,YSNSCALE,YSED)
 ;S Y1=$P(^YTT(601,YSET,0),U,1)_U_$E(YSED,4,5)_"/"_$E(YSED,6,7)_"/"_$E(YSED,2,3)_U_YSNSCALE_U_$P(Y,U,1)_U_$P(Y,U,2)
 S Y1=$P(^YTT(601,YSET,0),U,1)_U_$$FMTE^XLFDT(YSED,"5ZD")_U_YSNSCALE_U_$P(Y,U,1)_U_$P(Y,U,2)
 W Y1,$C(13)
 Q
