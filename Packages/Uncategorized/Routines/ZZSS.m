ZZSS ;at/jas; birmingham ocio/albany ocio ;PROGRAM TO LIST JOBS AND PIDS
 ;
HERE K JOB,PROG,JJ,sw10,pid,i,base,user,CNT,rx,XX,M,PASS,TAB
 S IOP="HOME" D ^%ZIS S rx=""
 s sw10=$v(0,-2,$ZU(40,0,1))\1024#2
 s base=$v($zu(40,2,47),-2,"S")
 s maxpid=$v($zu(40,2,47)-(2*$zu(40,0,4)),-2,4)
 K PASS S (NCNT,CNT)=0
 f i=1:1:maxpid s pid=$v(i*4+base,-3,4) s:pid JOB(pid)=pid
 S JJ="" F  S JJ=$O(JOB(JJ)) Q:JJ=""  Q:rx["^"  S pid=JOB(JJ),XX=$V(-1,pid),JOB(pid)=XX,NCNT=NCNT+1
 Q
1 ;entry point
 D ZZSS
 D PREP^XGF
 D SAY^XGF(0,30,"System Status Information")
 D SAY^XGF(1,2,"Pid"),SAY^XGF(1,7,"Routine"),SAY^XGF(1,17,"Namespace"),SAY^XGF(1,31,"CPU Cycles"),SAY^XGF(1,42,"Global Hits"),SAY^XGF(1,55,"Owner")
 S N="" K M
PAINT ;PAINT AND DISPLAY
 D WIN^XGF(2,0,20,79)
 I N=-1 D IOXY^XGF(10,30) W "<End of File>" G QUEST Q
 S CNT=CNT+1 F I=3:1:19 S N=$N(JOB(N)),PASS(CNT,I)=N Q:N=-1  D USER,IOXY^XGF(I,2) W $P(JOB(N),"^",1),?7,$P(JOB(N),"^",6),?17,$E($P(JOB(N),"^",14),1,14),?31,$P($P(JOB(N),"^",7),",",1),?42,$P($P(JOB(N),"^",7),",",2),?55,WHO,?75,$E($P(JOB(N),"|TCP|",2),1,4)
 D QUEST
 Q
BACK ;
 S CNT=CNT-1
 I CNT=0 D IOXY^XGF(0,0) W "<Top of Records>" S CNT=1 G QUEST Q
 D WIN^XGF(2,0,20,79)
 F I=3:1:19 S N=PASS(CNT,I) D USER,IOXY^XGF(I,2) W $P(JOB(N),"^",1),?7,$P(JOB(N),"^",6),?17,$P(JOB(N),"^",14),?31,$P($P(JOB(N),"^",7),",",1),?42,$P($P(JOB(N),"^",7),",",2),?55,WHO
 D QUEST
 Q        
QUEST ;
 D IOXY^XGF(22,0) W "                                        "
 D IOXY^XGF(23,0) R "(S)tart (B)ack (M)onitor (N)ext Page (P)id (^) :",NP:20 S NP=$$UP^XLFSTR(NP) Q:NP="^"  I NP="" D IOXY^XGF(23,34) W "     " D IOXY^XGF(23,50) W "<Select S,B,M,N,P or ^ >" D QUEST
 G:NP="N" PAINT G:NP="S" 1 G:NP="B" BACK G:NP="M" MONITOR I NP="P" S N="",COL=2,TAB=7 G:NP="P" PID
 Q
PID ;
 D PREP^XGF
 D WIN^XGF(2,0,20,79)
 D SAY^XGF(1,1,"Pid"),SAY^XGF(1,TAB-1,"Routine")
PID1 I COL>60 S COL=2,TAB=7 D IOXY^XGF(22,0) R "<Carriage Return> ",R:20 I R="" G PID I R'="" G 1
 F I=3:1:19 S N=$N(JOB(N)) Q:N=-1  D IOXY^XGF(I,COL-1) W $P(JOB(N),"^",1),?TAB-1,$P(JOB(N),"^",6)
 I N=-1 D IOXY^XGF(22,0) R "<Carriage Return> ",R:20 I R="" G 1 I R'=1 G 1
 S COL=COL+14,TAB=TAB+14 D SAY^XGF(1,COL-1,"Pid"),SAY^XGF(1,COL+4,"Routine")
 D PID1
 Q
USER ;
 S WHO=$P(JOB(N),"^",14)
 I WHO["%SYS"!(WHO["MGR") S WHO="System        " Q
 I WHO["SMA",($P(JOB(N),"^",6)["XWBTCP") S WHO="Broker(SMA)" Q
 I WHO["SMB",($P(JOB(N),"^",6)["XWBTCP") S WHO="Broker(SMB)" Q
 I WHO["DMA",($P(JOB(N),"^",6)["XWBTCP") S WHO="Broker(DMA)" Q
 I WHO["INH",($P(JOB(N),"^",6)["XWBTCP") S WHO="Broker(INH)" Q
 I WHO["ALF",($P(JOB(N),"^",6)["XWBTCP") S WHO="Broker(ALF)" Q
 I WHO["SMA",($P(JOB(N),"^",6)["%ZISTCP") S WHO="Listener(SMA)" Q
 I WHO["SMB",($P(JOB(N),"^",6)["%ZISTCP") S WHO="Listener(SMB)" Q
 I WHO["DMA",($P(JOB(N),"^",6)["%ZISTCP") S WHO="Listener(DMA)" Q
 I WHO["INH",($P(JOB(N),"^",6)["%ZISTCP") S WHO="Listener(INH)" Q
 I WHO["ALF",($P(JOB(N),"^",6)["%ZISTCP") S WHO="Listener(ALF)" Q
 I WHO["SMA",($P(JOB(N),"^",6)["XM") S WHO="Mailman(SMA)" Q
 I WHO["SMB",($P(JOB(N),"^",6)["XM") S WHO="Mailman(SMB)" Q
 I WHO["DMA",($P(JOB(N),"^",6)["XM") S WHO="Mailman(DMA)" Q
 I WHO["INH",($P(JOB(N),"^",6)["XM") S WHO="Mailman(INH)" Q
 I WHO["ALF",($P(JOB(N),"^",6)["XM") S WHO="Mailman(ALF)" Q
 I WHO["SMA",($P(JOB(N),"^",6)["%ZTM") S WHO="Taskman(SMA)" Q
 I WHO["SMB",($P(JOB(N),"^",6)["%ZTM") S WHO="Taskman(SMB)" Q
 I WHO["DMA",($P(JOB(N),"^",6)["%ZTM") S WHO="Taskman(DMA)" Q
 I WHO["INH",($P(JOB(N),"^",6)["%ZTM") S WHO="Taskman(INH)" Q
 I WHO["ALF",($P(JOB(N),"^",6)["%ZTM") S WHO="Taskman(ALF)" Q
 I WHO["SMA",($P(JOB(N),"^",3)["|TNT|") S WHO="Telent(SMA)" Q
 I WHO["SMB",($P(JOB(N),"^",3)["|TNT|") S WHO="Telent(SMB)" Q
 I WHO["DMA",($P(JOB(N),"^",3)["|TNT|") S WHO="Telent(DMA)" Q
 I WHO["INH",($P(JOB(N),"^",3)["|TNT|") S WHO="Telent(INH)" Q
 I WHO["ALF",($P(JOB(N),"^",3)["|TNT|") S WHO="Telent(ALF)" Q
 I WHO["SMA",('$D(^XUTL("XQ",N,0))) S WHO="Unknown(SMA)" Q
 I WHO["SMB",('$D(^XUTL("XQ",N,0))) S WHO="Unknown(SMB)" Q
 I WHO["DMA",('$D(^XUTL("XQ",N,0))) S WHO="Unknown(DMA)" Q
 I WHO["INH",('$D(^XUTL("XQ",N,0))) S WHO="Unknown(INH)" Q
 I WHO["ALF",('$D(^XUTL("XQ",N,0))) S WHO="Unknown(ALF)" Q
 I WHO["SMA",($D(^["SMA"]XUTL("XQ",N,0))) S WHO=$E($P(^["SMA"]VA(200,^["SMA"]XUTL("XQ",N,"DUZ"),0),"^",1),1,14) Q
 I WHO["SMB",($D(^["SMB"]XUTL("XQ",N,0))) S WHO=$E($P(^["SMB"]VA(200,^["SMB"]XUTL("XQ",N,"DUZ"),0),"^",1),1,14) Q
 I WHO["DMA",($D(^["DMA"]XUTL("XQ",N,0))) S WHO=$E($P(^["DMA"]VA(200,^["DMA"]XUTL("XQ",N,"DUZ"),0),"^",1),1,14) Q
 I WHO["INH",($D(^["INH"]XUTL("XQ",N,0))) S WHO=$E($P(^["INH"]VA(200,^["INY"]XUTL("XQ",N,"DUZ"),0),"^",1),1,14) Q
 I WHO["ALF",($D(^["ALF"]XUTL("XQ",N,0))) S WHO=$E($P(^["ALF"]VA(200,^["ALF"]XUTL("XQ",N,"DUZ"),0),"^",1),1,14) Q
 I WHO["SYSTEM",($P(JOB(N),"^",5))["openm\mgr" S WHO="System"  Q
 I $P(JOB(N),"^",5)["openm\mgr",($P(JOB(N),"^",14)["openm\mgr") S WHO="System" Q
 Q
MONITOR ;
 D PREP^XGF
 D WIN^XGF(2,0,18,79)
 D IOXY^XGF(1,1) W "Pid" D IOXY^XGF(1,10) W "CPU Cycles" D IOXY^XGF(1,30) W "Global Hits" D IOXY^XGF(1,50) W "Progam"
 D IOXY^XGF(23,0) R "Enter PID of the Job to Monitor ",M:20 G:M="" 1 S M=$$UP^XLFSTR(M) I '$D(JOB(M)) Q
AGAIN S MPID=$V(-1,M),MCPU=$P($P(MPID,"^",7),",",1),MGLO=$P($P(MPID,"^",7),",",2)
 D IOXY^XGF(3,1) W $P(MPID,"^",1) D IOXY^XGF(3,10) W MCPU D IOXY^XGF(3,30) W MGLO D IOXY^XGF(3,50) W $P(MPID,"^",6)
 D IOXY^XGF(23,50) R "Enter ^ to Stop the Monitor",UA I UA="^" G 1
 G AGAIN
 Q
2 ;entry point
 D HERE^ZZSS
 F  S N=$N(JOB(N)),PASS(CNT,I)=N Q:N=-1  I $P(JOB(N),"^",3)["|TCP|" W !,$P(JOB(N),"^",1),?7,$P(JOB(N),"^",6),?17,$E($P(JOB(N),"^",14),1,14),?31,$E($P(JOB(N),"|TCP|",2),1,4) W:$P(JOB(N),"^",6)["XWBTCPC" ?41,"Broker Connection" W:$P(JOB(N),"^",6)["XWBTCPL" ?41,"Broker Listener" W:$P(JOB(N),"^",6)["%ZISTCPS" ?41,"MailMan Listener"
 Q
