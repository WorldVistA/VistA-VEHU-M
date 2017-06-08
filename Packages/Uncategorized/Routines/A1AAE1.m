A1AAE1 ;
EN ;
SETUP ;
 S U="^",Y=DT,ZZKD=1 X ^DD("DD") S DTE=Y S ZZLCT=0
 K ^UTILITY($J)
 ;SEARCHES ADMIN FILE BY DATE FOR DOCS WITH KEYWORD(S)
ASKSM ;
 R !,"Do you want an [E]xtended or [K]eyword only search? ",ZZSM:DTIME G:ZZSM[U!(ZZSM="") EXIT D:ZZSM["?" SMHLP I "EKek"'[ZZSM G ASKSM S ZZSM=$S("Ee"[ZZSM:"E",1:"K")
ASKS ;
 S %DT="AEXP",%DT("A")="START WITH FILING DATE: " D ^%DT G:X[U!$D(DTOUT) EXIT G:Y<0 ASKS S STDT=Y
ASKE ;
 S %DT("A")="END WITH FILING DATE:  " D ^%DT S:X[U!$D(DTOUT) EXIT G:Y<0 ASKE S ENDT=Y G:ENDT<STDT EXIT
ASKKW ;ASKS KEYWORD(S)
 F I=1:1:3 S DIC="^DIZ(500002,",DIC(0)="AEQM" D ^DIC Q:X[U!(X="")  S ZZKW(I)=Y
 I ZZSM="E" F I=1:1:3 R !,"Document ID word to look for: ",ZZIW:DTIME G:$D(DTOUT) EXIT Q:ZZIW=""!(ZZIW[U)  D:ZZIW["?" SMHLP S ZZIW(I)=$S($L(ZZIW)=2:ZZIW_" ",1:$E(ZZIW,1,2)_$C($A($E(ZZIW,3))-1))
ASKM ;
 G:'$D(ZZKW) EXIT R !!!,"[E]xtended or [C]ondensed Print? ",ZZMODE:DTIME G:ZZMODE[U!('$T) EXIT I ZZMODE'["E"&(ZZMODE'["C") G ASKM
 S %ZIS="FQM" D ^%ZIS Q:IO=""!(POP)  I $D(IO("Q")) D QUEUE G EXIT
START ;ENTRY POINT FOR TASKMANAGER
 D EN^A1AAE3 Q
EXIT ;
 K ZZMODE,ZZANS,ENDT,STDT,X,Y Q
QUEUE ;Queueing
 S (ZTSAVE("STDT"),ZTSAVE("ZZIW("),ZTSAVE("ZZKD"),ZTSAVE("DTE"),ZTSAVE("ZZSM"),ZTSAVE("ENDT"),ZTSAVE("ZZKW("),ZTSAVE("ZZMODE"),ZTSAVE("ZZANS"))="" S ZTIO=ION,ZTDESC="KEYWORD SEARCH" S ZTRTN="EN^A1AAE2" D ^%ZTLOAD I 1
 I  W !!,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED!")  
 Q
SMHLP ;
 W !,"  [E]xtended search will locate similar words in document ID's and ",!,"  selected keywords.",!,"  [K]eyword search will locate documents with selected keywords.",!
 Q
