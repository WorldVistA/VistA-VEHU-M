PRMRTYPO ;GLRISC/JES,DDA - LIST OF UNCLOSED INCIDENTS BY TYPE ; 1/29/89  08:34 ;
 ;VERSION 1.01
 D ^PRMRDATE G:PRMRSTOP QUIT
 S %ZIS="QM" D ^%ZIS K %ZIS K:POP IO("Q") G:POP QUIP
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="EN^PRMRTYPO",ZTDESC="Number of Unclosed Incidents by Type" D PLOOP,^%ZTLOAD K ZTSK,ZTIO G QUIP
 G EN
PLOOP ;
 F I="PRMR1HED","PRMR2HED","PRMRENGD","PRMRNBEG","PRMRNEND","PRMRSPOT","PRMRSTOP" S ZTSAVE(I)=""
 Q
EN ;
 S (PRMROUT,GTOTINC,N,SKIP,TOTYPE,TYPE)=0 F I=0:0 S N=$O(^PRMQ(513.72,N)) Q:N'?1.N  I $D(^PRMQ(513.72,N,"I")) D RANGE I OK D GETSUBT S TARRAY(TYPE,DATE,NAME)=^PRMQ(513.941,TYPE,0)_"^"_ENGLDATE
 U IO S (PRMRHEAD,PRMRDEV)=0 S:$E(IOST)="C" PRMRDEV=1 D HEAD
 S (DATE,LTYPE,NAME,TYPE)="" F I=0:0 S TYPE=$O(TARRAY(TYPE)) Q:TYPE=""  F II=0:0 S DATE=$O(TARRAY(TYPE,DATE)) Q:DATE=""  F III=0:0 S NAME=$O(TARRAY(TYPE,DATE,NAME)) Q:NAME=""  D WRITE G:PRMROUT QUIP
 D WRITOT D HEAD G:PRMROUT QUIP W !!?10,"TOTAL UNCLOSED INCIDENTS: ",GTOTINC
 I PRMRDEV W !!,"Press <Return> to continue: " R X:DTIME
QUIP ;
 K:$D(ZTSK) ^%ZTSK(ZTSK) W @IOF X ^%ZIS("C")
QUIT ;
 K PRMROUT,PRMRHEAD,PRMRDEV,DATE,ENGLDATE,GTOTINC,I,II,III,LTYPE,N,NAME,OK,POP,PRMR1HED,PRMR2HED,PRMRENGD,PRMRNBEG,PRMRNEND,PRMRSPOT,PRMRSTOP,PRMRWHEN,RDATE,SKIP,TARRAY,TOTYPE,TYPE,Y,%DT
 Q
RANGE ;
 S OK=0,RDATE=$P(^PRMQ(513.72,N,0),"^",1) S:((RDATE=PRMRNBEG)!(RDATE>PRMRNBEG))&((RDATE=PRMRNEND)!(RDATE<PRMRNEND)) OK=1
 Q:'$D(^PRMQ(513.72,N,2))
 S:$P(^PRMQ(513.72,N,2),"^",21) OK=0
 Q
GETSUBT ;
 S TYPE=^PRMQ(513.72,N,"I"),DATE=$E($P(^PRMQ(513.72,N,0),"^",1),1,7),NAME=$P(^DPT($P(^PRMQ(513.72,N,0),"^",2),0),"^",1) S Y=DATE X ^DD("DD") S ENGLDATE=Y
 S GTOTINC=GTOTINC+1 I $D(TOTYPE(TYPE)) S TOTYPE(TYPE)=TOTYPE(TYPE)+1
 E  S TOTYPE(TYPE)=1
 Q
WRITE ;
 G:LTYPE=TYPE NOTYPE D:SKIP&(TYPE>LTYPE) WRITOT S LTYPE=TYPE,SKIP=1 D HEAD Q:PRMROUT  W !!?2,$P(TARRAY(TYPE,DATE,NAME),"^",1),?10,$P(TARRAY(TYPE,DATE,NAME),"^",2),!
NOTYPE ;
 D HEAD Q:PRMROUT  W !?30,$P(TARRAY(TYPE,DATE,NAME),"^",3),?50,NAME Q
WRITOT ;
 Q:GTOTINC<1  D HEAD Q:PRMROUT  W !!?10,"TOTAL INCIDENTS THIS TYPE: ",TOTYPE(LTYPE),! Q
HEAD ; INSERT PROPER PAGE BREAKS
 Q:PRMROUT
 I PRMRHEAD,PRMRDEV,$Y>(IOSL-5) W !!,"""^"" TO STOP: " R X:DTIME S:X["^"!'$T PRMROUT=1 S PRMRHEAD=0
 Q:PRMROUT
 I 'PRMRHEAD&PRMRDEV D HDR S PRMRHEAD=1
 I ('PRMRDEV&($Y>(IOSL-5)))!('PRMRDEV&'PRMRHEAD) D HDR S PRMRHEAD=1
 Q
HDR ; WRITE HEADER
 W @IOF X PRMR1HED W !?21,"UNCLOSED INCEDENTS BY INCIDENT TYPE",!,@PRMRSPOT,PRMR2HED D ^PRMRCONF W ?2,"CODE    DESCRIPTION",?30,"DATE",?50,"PATIENT",! F I=1:1:80 W "-"
 Q