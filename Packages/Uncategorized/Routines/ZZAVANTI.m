ZZAVANTI        ;emc/maw-master monitor ;5/1/02
 ;;1.0;AVANTI DEMO AND TRAINING SUPPORT SYSTEM UTILITIES; May 01, 2002
 I '$D(IOF) D HOME^%ZIS
 S ZZCURNSP=$ZU(5)
 S ZZSTOP=0
 F  D  Q:ZZSTOP
 .W @IOF
 .W !,"AVANTI Demonstration and Training Support System"
 .W ?59,$$HTE^XLFDT($H)
 .W !,"SYSTEM: ",$ZU(110)
 .W !!,"NSP",?10,"JOBS",?16,"ERRS",?22,"TM",?26,"XWB",?30,"Port(s)"
 .K JOB,ZZJOB
 .D BUILD^%SS
 .S ZZX=0
 .F  S ZZX=$O(JOB(0,ZZX)) Q:'ZZX  D
 ..S ZZPID=JOB(0,ZZX)
 ..S ZZJDATA=$$JobVw^%SS(ZZPID)
 ..S ZZNSPN=$P(ZZJDATA,"^",14)
 ..I ZZNSPN=""!(ZZNSPN["cache") S ZZNSPN="%SYS"
 ..I '$D(ZZJOB(ZZNSPN)) S ZZJOB(ZZNSPN)="0^^"
 ..S $P(ZZJOB(ZZNSPN),"^")=$P(ZZJOB(ZZNSPN),"^")+1
 ..I ZZNSPN="%SYS" K ZZJDATA Q
 ..;
 ..I $P(ZZJDATA,"^",6)="XWBTCPL" D
 ...S $P(ZZJOB(ZZNSPN),"^",2)=1
 ...S DEV=$P(ZZJDATA,"^",3)
 ...S ZZXWBP=$$STRIP^XLFSTR($P(DEV,"TCP|",2),"*,")
 ...I $P(ZZJOB(ZZNSPN),"^",3)'="" S $P(ZZJOB(ZZNSPN),"^",3)=$P(ZZJOB(ZZNSPN),"^",3)_" "_ZZXWBP
 ...I $P(ZZJOB(ZZNSPN),"^",3)="" S $P(ZZJOB(ZZNSPN),"^",3)=ZZXWBP
 .K Info,JOB
 .;
 .; report...
 .S ZZTOT=0
 .S ZZNSPN=""
 .F  S ZZNSPN=$O(ZZJOB(ZZNSPN)) Q:ZZNSPN=""  D
 ..S ZZJDATA=ZZJOB(ZZNSPN)
 ..;
 ..; get TM status in the namespace...
 ..I ZZNSPN'=ZZCURNSP&(ZZNSPN'="%SYS") S X=$ZU(5,ZZNSPN)
 ..S ZZTMSTAT=$$TM^%ZTLOAD
 ..S ZZTMSTAT=$S(ZZTMSTAT:"Y",1:"-")
 ..; get error count for today on the namespace...
 ..S ZZH=+$H
 ..S (ZZECNT,ZZERR)=0
 ..F  S ZZERR=$O(^%ZTER(1,ZZH,1,ZZERR)) Q:'ZZERR  S ZZECNT=ZZECNT+1
 ..;
 ..I $ZU(5)'=ZZCURNSP S X=$ZU(5,ZZCURNSP)
 ..W !,ZZNSPN
 ..W ?10,$J($P(ZZJDATA,"^"),4)
 ..S ZZTOT=ZZTOT+$P(ZZJDATA,"^")
 ..W ?16,$J(ZZECNT,4)
 ..W ?23,ZZTMSTAT
 ..I $P(ZZJDATA,"^",2)="" W ?27,"-"
 ..I $P(ZZJDATA,"^",2)'="" D
 ...W ?27,"Y"
 ...W ?30,$P(ZZJDATA,"^",3)
 .W !,?10,"----"
 .W !,"Total"
 .W ?10,$J(ZZTOT,4)
 .K MSYS,BS,FF,RM,SL,SUB,XY,NSYS,NJOB,NUSR,NLIC,NGLO,NROU,JOB,SORT
 .K DEV,ZZECNT,ZZJDATA,ZZJOB,ZZNSPN,ZZPID,ZZTMSTAT,ZZTOT,ZZX,ZZXWB,ZZXWBP
 .F I=$Y:1:(IOSL-6) W !
 .W !!,"[R]efresh  [B]roker Start/Stop   [A]uto LogOn Reset"
 .W !,"[S]ysStat  [T]askMan Start/Stop  [C]lear Jobs  [Q]uit"
 .R !,"Select OPTION: ",ZZGO:15
 .;R !!,"Press <enter> to continue, ""^"" to exit > ",ZZGO:15
 .I ZZGO="^"!(ZZGO="Q")!(ZZGO="q") S ZZSTOP=1 Q
 .I ZZGO="R"!(ZZGO="r") Q
 .I ZZGO="B"!(ZZGO="b") D ^ZZAVANT1 Q
 .I ZZGO="A"!(ZZGO="a") D ^ZZAVANT2 Q
 .I ZZGO="S"!(ZZGO="s") D  Q
 ..D ^%SS
 ..R !!,"Press <return> to continue...",ZZX:15
 ..K ZZX
 .I ZZGO="T"!(ZZGO="t") D ^ZZAVANT3 Q
 .I ZZGO="C"!(ZZGO="c") D ^ZZAVANT4 Q
 K ZZGO,ZZNSP,ZZSTOP
 Q
