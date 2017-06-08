ZTRTHM ;HVB/MTZ - MULTIPLE CPU RTHIST OUTPUT (DSM-11) ;5/11/93  08:08
 ;;7.1;KERNEL;;May 11, 1993
 ;K (DT,DTIME,DUZ,U) ;   ***** EXCLUSIVE KILL *****
 W !,"   EDIT C2^DDPCIR:  r NODE  w NODE,ZCODE(ND)=N   (THEN COMMENT OUT THIS LINE)",! Q
 W !,?7,"Multiple CPU System Usage Histogram",!
 D CHKDDP^DDPCIR Q:%A  D CHKSYS^SYSROU Q:%A  S RV=-1 D CIRSTA^DDPCIR S N=0 F I=1:1 S N=$O(ZCODE(N)) Q:N=""  S CODE(I)=ZCODE(N),NDDP=I
B D KILL S DOMAIN="" I $D(^%ZOSF("MASTER")) S X=^("MASTER"),DOMAIN=@("^["""_$P(X,",")_""","""_$P(X,",",2)_"""]XMB(""NAME"")")
ASK S FIRST=1 R !,"Start at session #: FIRST// ",X:$S($D(DTIME):DTIME,1:60) Q:X["^"  G ASK1:X="",ASK:X'?1.3N S FIRST=X
ASK1 S LAST=999 R !,"Go to session #: LAST// ",X:$S($D(DTIME):DTIME,1:60) Q:X["^"  G ZIS:X="",ASK1:X'?1.3N S LAST=X
ZIS D ^%ZIS Q:POP'=0  U IO W #
 S FIRST=FIRST-1 F Z=0:0 S FIRST=$O(^RTH(FIRST)) Q:$D(^(FIRST))  I FIRST="" S QMSG="NO DATA" G QUIT
 S CODE(0)=$P($ZU(0),",",2),CONF(0)=^RTH(FIRST,"CONF"),SYS(0)=$P(CONF(0),", ",2),I=0 D GETLP S LAST=N1
 G NROOM:(LAST-FIRST+1*(NDDP+1)*100)>$S
 F I=1:1:NDDP I $D(^["MGR",CODE(I)]RTH(FIRST,"CONF")) S CONF(I)=^("CONF"),SYS(I)=$P(CONF(I),", ",2) D GETLP
 G PRINT
GETLP S P=0,N=FIRST-1 F Z=0:0 S N1=N,N=$O(^["MGR",CODE(I)]RTH(N)) Q:N=""!(N>LAST)  D GET
 Q
GET S STIME(I,N)=^["MGR",CODE(I)]RTH(N,"STIME"),ET(I,N)=$P(^("ETIME"),",",2)-$P(STIME(I,N),",",2) S:ET(I,N)<0 ET(I,N)=ET(I,N)+86400
 S %H=STIME(I,N),TIM=$P(%H,",",2) D YMD^%DTC S DT=X,H=TIM\3600,M=TIM\60#60,M=$S($L(M)=1:0_M,1:M) D DW^%DTC
 S TIME(I,N)=$E(X,1,3)_" "_$E(DT,4,7)_$E(DT,2,3)_"@"_H_M
 S IDLE(I,N)=^["MGR",CODE(I)]RTH(N,"IDLE")*10/ET(I,N)+.5\1
 S GLOREF(I,N)=^["MGR",CODE(I)]RTH(N,"GLOREF")/ET(I,N)+.5\1
 S DISK(I,N)=0 F Y=0:1:7 S DISK(I,N)=DISK(I,N)+^["MGR",CODE(I)]RTH(N,"DISK",Y,"READ")+^("WRITE")
 S DISK(I,N)=DISK(I,N)*10/ET(I,N)+.5\1
 S JOBS(I,N)=^["MGR",CODE(I)]RTH(N,"JOBS")/10/ET(I,N)+.5\1
 Q
PRINT S N="" F Z=0:0 S N=$O(DISK(0,N)) Q:N=""  D PRUN
 W !,"H 5..." H 5 S QMSG="DONE" G QUIT
PRUN W !!!?10,"ZRTHM    RUN # ",N,"    STARTED ",TIME(0,N),?57,DOMAIN
 W !!?10,"CODE",?20,"%IDLE",?28,"%DISK",?36,"GLOREF",?44,"JOBS",!
 F I=0:1:NDDP S D(I)=$D(ET(I,N)) W:D(I) !?10,CODE(I),?20,$J(IDLE(I,N),3),?28,$J(DISK(I,N),3),?36,$J(GLOREF(I,N),3),?44,$J(JOBS(I,N),3) W:'D(I) !?20,"***** NO DATA *****"
 W !!!?10,TIME(0,N),?45,"%CPU",!! D LINE0,LINE1 S DIV=1,INC=1,(CNT,TAB,UCIP)=0,RTN=0 F I=0:1:NDDP I D(I) S COM=CODE(I),HITS=100-IDLE(I,N) D STARS
 D LINE1,LINE0 W !!!?10,TIME(0,N),?45,"%DISK",!! D LINE0,LINE1 F I=0:1:NDDP I D(I) S COM=CODE(I),HITS=DISK(I,N) D STARS
 D LINE1,LINE0 W !!#
 Q
STARS S STARS=HITS/(DIV*INC),STARS=$E($P(STARS,".",2),1)>4+$P(STARS,".",1)
 W ?10,COM,?20,"|" F J=1:1:STARS W "*" Q:J=100
 S STAR=STARS+10\10*10 F J=STAR:10:100 W ?J+20,"|"
 W $J(HITS/DIV,5,1),!
 Q
LINE0 W ?20,"0         10        20        30        40        50        60        70        80        90        100",! Q
LINE1 W ?20,"|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|",! Q
NROOM X ^%ZIS("C") W *7,"*****  Too many sessions for available partition space!  *****" G B
QUIT X ^%ZIS("C") W !,QMSG,!
KILL K %A,%H,CNT,COM,CONF,D,DISK,DIV,DOMAIN,ET,FIRST,GLOREF,H,HITS,I,ID,IDLE,INC,J,JOBS,LAST,M,N,N1,P,POP,QMSG,RTH,RTN,RV,ST,STAR,STARS,STIME,SYS,TAB,TIM,TIME,UCIP,X,Y,Z,ZCODE Q
