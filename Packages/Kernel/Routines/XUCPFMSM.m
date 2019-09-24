XUCPFRMT ;SFISC/HVB/VYD/JC - Resource Usage Table or Graph ;4/17/96  08:38
 ;;7.3V2;TOOLKIT;;Nov 08, 1994
 I $D(^XTMP("XUCP","zzz"))'=11 W !!!,"There is no data to print from.",!,"Please run SORT RAW RESOURCE USAGE DATA option first." Q
 W !!!,"I will write out Resource Usage by Namespace, based on the preceding sort.",!
 N XTR,FRMT,ACT,%H,SDT,EDT,NODE,FNAME,XUCPQ,TOFILE,T,X,X1,C,D,I,N
 S DIR(0)="Y",DIR("A")="Subtotal by Node",DIR("B")="YES" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S ACT=$S(Y:"NODE",1:"CUM")
 I ACT'["CUM" S DIR(0)="Y",DIR("A")="Would you also like cumulative by option for all nodes",DIR("B")="YES" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S:Y ACT=ACT_"CUM"
 S DIR(0)="NA^1:8:0",DIR("A")="Namespace length: ",DIR("B")=4 D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S XTR=X
 S DIR(0)="SA^T:Table;G:Graph",DIR("A")="Format for report (<T>able/<G>raph): ",DIR("B")="T" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S FRMT=X
DEVICE S NODE=$O(^XTMP("XUCP",0))
 S %H=$P(^XTMP("XUCP","zzz"),"^") D YX^%DTC S SDT=Y,%H=$P(^XTMP("XUCP","zzz"),"^",2) D YX^%DTC S EDT=Y
 S SDT=$TR(SDT," ,@:"),EDT=$TR(EDT," ,@:")
 S FNAME=$TR(NODE,",")_$S(ACT["CUM":".CUM",1:".CP"_FRMT)
 S DIR("A")="Write to file ("_FNAME_")",DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR S TOFILE=Y Q:$D(DTOUT)!$D(DUOUT)
 S:TOFILE %ZIS("HFSNAME")=FNAME,%ZIS("HFSMODE")="W",IOP="HFS"_$S(FRMT="G":";132",1:";80")
 I TOFILE S DIR("A")="Would you like to queue this job for background execution",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR S XUCPQ=Y Q:$D(DTOUT)!$D(DUOUT)
 S:TOFILE&$G(XUCPQ) IOP="Q;"_IOP
 S %ZIS=$S('TOFILE:"MQ",$G(XUCPQ)&TOFILE:"NQ",1:"") D ^%ZIS Q:POP
 I FRMT="T",IOM<80 W !,"The TABLE format requires at least 80 column device." G DEVICE
 I FRMT="G",IOM<132 W !,"The GRAPH format requires at least 132 column device." G DEVICE
 I $D(IO("Q")) S ZTRTN="DQ^XUCPFRMT" D  Q
 .S ZTDESC="Resource Usage by Option ("_$S(FRMT="G":"Graph",1:"Table")_")"
 .S (ZTSAVE("XTR"),ZTSAVE("FRMT"),ZTSAVE("ACT"))="" D ^%ZTLOAD,HOME^%ZIS
 .W:$D(ZTSK) !,"Queued as task ",ZTSK,!
DQ ;PRINT REPORT (POSSIBLY BY TASKMAN)
 G:$D(^XTMP("XUCP","zzz"))<11 END ;quit if no sorted data to output
 N OPT,NODE,DATE,JOB,TIME,SC,SD,SN,XOPT,SDT,EDT
 S X=^%ZOSF("ERRTN"),@^%ZOSF("TRAP") ;necessary because of the NEW cmnd
 S %H=$P(^XTMP("XUCP","zzz"),U) D YX^%DTC S SDT=Y,%H=$P(^("zzz"),U,2) D YX^%DTC S EDT=Y
 K ^TMP($J)
COLLECT ;
 S (OPT,NODE,DATE,JOB,TIME)=""
 F  S OPT=$O(^XTMP("XUCP","zzz",OPT)) Q:OPT=""  D
 .F  S NODE=$O(^XTMP("XUCP","zzz",OPT,NODE)) Q:NODE=""  D
 ..F  S DATE=$O(^XTMP("XUCP","zzz",OPT,NODE,DATE)) Q:DATE=""  D
 ...F  S JOB=$O(^XTMP("XUCP","zzz",OPT,NODE,DATE,JOB)) Q:JOB=""  D
 ....F  S TIME=$O(^XTMP("XUCP","zzz",OPT,NODE,DATE,JOB,TIME)) Q:TIME=""  S X=^(TIME),XOPT=$E(OPT,1,XTR) D
 .....I ACT["NODE" D
 ......S X1=$G(^TMP($J,"N",NODE,XOPT))+1,^(XOPT)=X1
 ......S X1=$G(^TMP($J,"C",NODE,XOPT))+$P(X,U),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"D",NODE,XOPT))+$P(X,U,2),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"LR",NODE,XOPT))+$P(X,U,3),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"LW",NODE,XOPT))+$P(X,U,4),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"TI",NODE,XOPT))+$P(X,U,5),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"TO",NODE,XOPT))+$P(X,U,6),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"T",NODE,XOPT))+$P(X,U,7),^(XOPT)=X1
 .....I ACT["CUM" D
 ......S X1=$G(^TMP($J,"N","zCUM",XOPT))+1,^(XOPT)=X1
 ......S X1=$G(^TMP($J,"C","zCUM",XOPT))+$P(X,U),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"D","zCUM",XOPT))+$P(X,U,2),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"LR","zCUM",XOPT))+$P(X,U,3),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"LW","zCUM",XOPT))+$P(X,U,4),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"TI","zCUM",XOPT))+$P(X,U,5),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"TO","zCUM",XOPT))+$P(X,U,6),^(XOPT)=X1
 ......S X1=$G(^TMP($J,"T","zCUM",XOPT))+$P(X,U,7),^(XOPT)=X1
 U IO
PRINT ;PRINT DATA SUBTOTALED BY NODE (NODE zCUM IS ACTUALLY TOTALS)
 S OPT="",NODE=$S(ACT["NODE":"",1:"ZZZ")
 F  S NODE=$O(^TMP($J,"C",NODE)) Q:NODE=""!(NODE="zCUM"&(ACT'["CUM"))  D
 .S (SC,SD,SN)=0
HEADER .W:IOST'["HFS" @IOF W !?(9+((FRMT="G")*27))
 .W $S(NODE'="zCUM":"Node "_NODE,1:"Station "_$E($O(^XTMP("XUCP","")),1,4))
 .W " from ",SDT," to ",EDT,!
 .W:$L($P(^XTMP("XUCP","zzz"),U,3)) ?(8+((FRMT="G")*27)),"*** Merged data may not be continuous over the date range! ***",!
 .I FRMT="G" W "OPT",?10,"CPUSEC",?116,"PhyRd",?124,"SEC",?131,"N",!!
 .E  W !,?8,$J($E("OPT",1,XTR),XTR),$J("CPU",7),$J("PhyRd",7),$J("SEC",7),$J("N",6),$J("LogRd",8),$J("LogWt",7),$J("TTI",6),$J("TTO",8),!!
NDLOOP .F  S OPT=$O(^TMP($J,"C",NODE,OPT)) Q:OPT=""  D
 ..S C=^TMP($J,"C",NODE,OPT),D=^TMP($J,"D",NODE,OPT),T=^TMP($J,"T",NODE,OPT),N=^TMP($J,"N",NODE,OPT)
 ..S LR=^TMP($J,"LR",NODE,OPT),LW=^TMP($J,"LW",NODE,OPT),TI=^TMP($J,"TI",NODE,OPT),TO=^TMP($J,"TO",NODE,OPT)
 ..D GRPHOUT:FRMT="G",TABLOUT:FRMT="T"
 ..S SC=SC+^TMP($J,"C",NODE,OPT),SD=SD+^TMP($J,"D",NODE,OPT),SN=SN+^TMP($J,"N",NODE,OPT) ;accum totals
TOTALS .W ! W:FRMT="T" ?3+XTR W "TOTAL" W:FRMT="G" ?7
 .W $J(SC+.5\1,7) W:FRMT="G" ?114
 .W $J(SD,7),?$X+$S(FRMT="G":5,1:6),$J(SN,7)
END D ^%ZISC K ^TMP($J),XTR,FRMT,ACT,T,X,X1,C,D,I,N,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
GRPHOUT W $J(OPT,XTR),?8,$J(C,6,0) S X=C/3\1 W:X>50 "<" S:X>50 X=50 W ?(65-X) F I=1:1:X W "*"
 S Y=D/100\1 S:Y>49 Y=49 F I=1:1:Y W "-"
 W:D/100\1>49 ">" W ?115,$J(D,6),$J(T+.5\1,6),$J(N,5),!
 Q
TABLOUT W ?8,$J(OPT,XTR),$J(C+.5\1,7),$J(D,7),$J(T+.5\1,7),$J(N,6),$J(LR,8),$J(LW,7),$J(TI,6),$J(TO,8),!
 Q
