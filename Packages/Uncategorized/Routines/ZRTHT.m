ZRTHT ;HVB/MTZ - TIME SERIES RTHIST OUTPUT (DSM-11) ;7/7/88  09:26
 ;;6.0;
 W !,?7,"Time series histogram",!
 ;K (DT,DUZ,U) ;***** EXCLUSIVE KILL *****
 S DOMAIN="" I $D(^%ZOSF("MASTER")) S X=^("MASTER"),DOMAIN=@("^["""_$P(X,",")_""","""_$P(X,",",2)_"""]XMB(""NAME"")")
ASK S FIRST=1,PF=0 R !,"Start at session #: FIRST// ",X:$S($D(DTIME):DTIME,1:60) Q:X["^"  G ASK1:X="",ASK:X'?1.3N S FIRST=X
ASK1 S LAST=999 R !,"Go to session #: LAST// ",X:$S($D(DTIME):DTIME,1:60) Q:X["^"  G ZIS:X="",ASK1:X'?1.3N S LAST=X
ZIS D ^%ZIS Q:POP=1  U IO W #
 S P=0,N=FIRST-1 F Z=0:0 S N1=N,N=$N(^RTH(N)) S:$S<800 PF=1 Q:N<0!(N>LAST)!(PF=1)  D GET
 G PRINT
GET S CONF=^RTH(N,"CONF")
 S STIME(N)=^RTH(N,"STIME"),ET(N)=$P(^("ETIME"),",",2)-$P(STIME(N),",",2) S:ET(N)<0 ET(N)=ET(N)+86400
 S %H=STIME(N),TIM=$P(%H,",",2) D YMD^%DTC S DT=X,H=TIM\3600,M=TIM\60#60,M=$S($L(M)=1:0_M,1:M) D DW^%DTC
 S STIME(N)=$E(X,1,3)_" "_$E(DT,4,7)_$E(DT,2,3)_"@"_H_M
 S IDLE(N)=^RTH(N,"IDLE")*10/ET(N)+.5\1
 S GLOREF(N)=^RTH(N,"GLOREF")/ET(N)+.5\1
 S DISK(N)=0 F Y=0:1:7 S DISK(N)=DISK(N)+^RTH(N,"DISK",Y,"READ")+^RTH(N,"DISK",Y,"WRITE") Q:Y>7
 S DISK(N)=DISK(N)*10/ET(N)+.5\1
 S JOBS(N)=^RTH(N,"JOBS")/10/ET(N)+.5\1
 Q
PRINT Q:'$D(CONF)  W !,"ZRTHT",?19,CONF,?57,DOMAIN,!!,"START DATE@TIME",?21,"RUN",?28,"%IDLE",?36,"%DISK",?44,"GLOREF",?52,"JOBS",!
 F N=FIRST:1:N1 W !,STIME(N),?20,$J(N,3),?28,$J(IDLE(N),3),?36,$J(DISK(N),3),?44,$J(GLOREF(N),3),?52,$J(JOBS(N),3)
 W:PF !,"*****  More sessions not printed - partition full  *****" W ! I $Y>20 W # S P=1
 W !!,CONF,?35,"%CPU",!! D LINE0,LINE1 S DIV=1,INC=1,(CNT,TAB,UCIP)=0,RTN="" F N=FIRST:1:N1 S COM=STIME(N),HITS=100-IDLE(N) D STARS
 D LINE1,LINE0 W:$Y>42!(P>0&($Y>31)) # W !!,CONF,?35,"%DISK",!! D LINE0,LINE1 F N=FIRST:1:N1 S COM=STIME(N),HITS=DISK(N) D STARS
 D LINE1,LINE0 W # X ^%ZIS("C") Q
 Q
STARS S STARS=HITS/(DIV*INC),STARS=$E($P(STARS,".",2),1)>4+$P(STARS,".",1)
 W COM,?20,"|" F I=1:1:STARS W "*" Q:I=100
 S STAR=STARS+10\10*10 F I=STAR:10:100 W ?I+20,"|"
 W $J(HITS/DIV,5,1),!
 Q
LINE0 W ?20,"0         10        20        30        40        50        60        70        80        90        100",! Q
LINE1 W ?20,"|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|",! Q
