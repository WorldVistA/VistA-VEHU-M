IBOSTUS1 ;ALB/SGD - MCCR BILL STATUS REPORT ;25 MAY 88 14:19
 ;;2.0;INTEGRATED BILLING;**31,118**;21-MAR-94
 ;
 ;MAP TO DGCROST1
 ;
EN ; - Entry point from IBOSTUS.
 K IBST1,IBST2
 S IBBEF="",IBSUB=$S(IBDTP["BILL":"AP",IBDTP["ENTERED":"APD",1:"D")
 S X1=IBBEG\1,X2=-1 D C^%DTC S IBNEX=X_.2359,X=80 X ^%ZOSF("RM")
 F  S IBNEX=$O(^DGCR(399,IBSUB,IBNEX)) Q:'IBNEX!(IBNEX>(IBEND\1_.2359))  D
 .S IBIFN=0 F  S IBIFN=$O(^DGCR(399,IBSUB,IBNEX,IBIFN)) Q:'IBIFN  D SET S IBBEF=IBNEX
 ;
 D STATS ; Print statistics.
 Q
 ;
SET S IBS=$G(^DGCR(399,IBIFN,"S"))
 I $P(IBS,U,17)'="" S IBBS="CANCELLED" G SET1
 I $P(IBS,U,14)'="" S IBBS="PRINTED" G SET1
 I $P(IBS,U,10)'="" S IBBS="AUTHORIZED" G SET1
 I $P(IBS,U,4)'=""!($P(IBS,U,7)'="") S IBBS="REVIEWED" G SET1
 S IBBS="ENTERED"
 ;
SET1 S IBF=1,IB0=$G(^DGCR(399,IBIFN,0))
 S IBCAT=$S($D(^DGCR(399.3,+$P(IB0,U,7),0)):$P(^(0),U),1:"UNSPECIFIED")_$S($P(IB0,U,5)>2:"-OPT",1:"-INPT")
 S IBU1=$G(^DGCR(399,IBIFN,"U1")),IBAMT=$S(IBU1="":0,$P(IBU1,U,2)]"":$P(IBU1,U)-$P(IBU1,U,2),1:+IBU1)
 ;
 ; - Add statistics.
 S IBST1(IBCAT,"C")=1+$G(IBST1(IBCAT,"C"))
 S IBST1(IBCAT,"$")=IBAMT+$G(IBST1(IBCAT,"$"))
 S IBST2(IBBS,"C")=1+$G(IBST2(IBBS,"C"))
 S IBST2(IBBS,"$")=IBAMT+$G(IBST2(IBBS,"$"))
 Q
 ;
STATS ; - Print statistics.
 S IBQ=0 D HEAD I '$D(IBF) W !!,?5,"***No bills found***" Q
 F IB0="IBST1","IBST2" K IBTOT W:IB0="IBST2" ! D  Q:IBQ
 .I IB0="IBST2" W !
 .S IB1=$S(IB0="IBST1":"Rate Type",1:"Bill Status") W !,IB1,":"
 .S IBCAT="" F  S IBCAT=$O(@IB0@(IBCAT)) Q:IBCAT=""  D  Q:IBQ
 ..I $Y>(IOSL-2),$E(IOST,1,2)="C-" D  Q:IBQ
 ...S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBQ=1 Q
 ...D HEAD W !,IB1,":"
 ..W ?13,IBCAT,?52,$J(@IB0@(IBCAT,"$"),11,2)
 ..W ?67,$J(@IB0@(IBCAT,"C"),7)," BILLS",!
 ..S IBTOT("C")=$G(IBTOT("C"))+@IB0@(IBCAT,"C")
 ..S IBTOT("$")=$G(IBTOT("$"))+@IB0@(IBCAT,"$")
 .W ?51,"------------",?66,"--------------"
 .W !,IB1," Totals:",?52,$J($G(IBTOT("$")),11,2)
 .W ?67,$J($G(IBTOT("C")),7)," BILLS"
 ;
 Q
 ;
HEAD ; - Report heading.
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S IBRUN=Y,Y=IBBEG X ^DD("DD")
 W @IOF,*13,!,"MCCR BILL STATUS STATISTICS",?63,IBRUN
 W !,"Sorted by ",IBDTP,": ",Y
 I IBBEG<IBEND S Y=IBEND X ^DD("DD") W " thru ",Y
 W !,$TR($J("",80)," ","=")
 Q
