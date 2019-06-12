XUCPRAW ;SFISC/HVB/VYD - Write out Option Resource Usage Logs ;4/17/96  12:56
 ;;7.3V2;TOOLKIT;;Nov 08, 1994
WRITE ;
 N ACT S ACT="WRT" ; WRTDLG is WRITE DIALOG
 G CHECK
SORT ;Store data in ^XTMP("XUCP","zzz" subtree.
 N ACT,KILLZZZ S ACT="SRT" ; SRTDLG is SORT DIALOG
 G CHECK
KILL ;Kill raw data. Routine tags are constructed with ACT variable
 N ACT S ACT="KIL" ; KILDLG is KILL DIALOG
CHECK I "zzz"[$O(^XTMP("XUCP","")) W !!!,"You don't have any raw data in ^XTMP(""XUCP"", global to "_$S(ACT="WRT":"output",ACT="SRT":"sort",1:"kill")_"!" Q
 G @(ACT_"DLG")
WRTDLG W !!!,"I will write out raw Resource Usage data in the ^XTMP(""XUCP"", global,",!,"sorted by Node, Job, Date and Time" G DTRANG
SRTDLG W !!!,"I will copy raw Resource Usage data into ^XTMP(""XUCP"",""zzz"" subtree",!,"sorted by Option, Node, Job, Date and Time.",!
 S DIR(0)="Y",DIR("A")="Merge with previous sort(s)",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DUOUT)!$D(DTOUT)  S:'Y KILLZZZ=1
 S DIR(0)="Y",DIR("A")="Output unformatted, sorted data after the sort",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DUOUT)!$D(DTOUT)  S:Y ACT=ACT_"WRT"
 G DTRANG
KILDLG W !!!,"I will kill the raw Resource Usage data in the ^XTMP(""XUCP"", global for the",!,"date range you specify.  I will not touch the ^XTMP(""XUCP"",""zzz"" subtree."
DTRANG W !!,"Please specify the date range to process."
 N SDAT,STIM,EDAT,ETIM,SDT,EDT,%DT,%H,%T,NODE,FNAME,XUCPQ,TOFILE
 S X=^%ZOSF("ERRTN"),@^%ZOSF("TRAP")
 S %DT="AEPTX",%DT("A")=" Start Date@Time: " D ^%DT Q:Y<0
 S X=Y D H^%DTC S SDAT=%H-1,STIM=$S(%T:%T-1,1:0)
 S %DT(0)=Y,%DT("A")="   End Date@Time: " D ^%DT K %DT Q:Y<0
 S X=$S($L($P(Y,".",2)):Y,1:Y+.24)
 D H^%DTC S EDAT=%H,ETIM=%T
 S NODE=$O(^XTMP("XUCP",0)) W !
 S %H=SDAT+1_","_(STIM+1) D YX^%DTC S SDT=$TR(Y," ,@:")
 S %H=EDAT_","_ETIM D YX^%DTC S EDT=$TR(Y," ,@:")
DEVICE I ACT["WRT" D  Q:$D(DTOUT)!$D(DUOUT)
 .S FNAME=$TR(NODE,",")_$S(ACT["SRT":".SRT",1:".RAW")
 .S DIR("A")="Write to file ("_FNAME_")"
 .S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR S TOFILE=Y
 .S:TOFILE %ZIS("HFSNAME")=FNAME,%ZIS("HFSMODE")="W",IOP="HFS"
 I ACT'["WRT"!$G(TOFILE) D  Q:$D(DTOUT)!$D(DUOUT)
 .S DIR("A")="Would you like to queue this job"
 .S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR S XUCPQ=Y
 I ACT["WRT" D  Q:$D(DTOUT)!$D(DUOUT)!$G(POP)
 .S %ZIS=$S('$G(TOFILE):"MQ",$G(TOFILE)&$G(XUCPQ):"NQ",1:"")
 .S:$G(TOFILE)&$G(XUCPQ) IOP="Q;"_IOP
 .D ^%ZIS
 I $D(IO("Q"))!$G(XUCPQ) D  Q  ;SEND JOB TO TASKMAN
 .S ZTRTN="LOOP^XUCPRAW",ZTDESC=$S(ACT="WRT":"Output",ACT="SRT":"Sort",ACT="SRTWRT":"Sort and Output",1:"Kill")_" Raw Usage data in ^XTMP(""XUCP"","
 .S (ZTSAVE("SDAT"),ZTSAVE("STIM"),ZTSAVE("EDAT"),ZTSAVE("ETIM"))=""
 .S ZTSAVE("ACT")="" S:$D(KILLZZZ) ZTSAVE("KILLZZZ")=""
 .S:ACT'["WRT" ZTIO="" D ^%ZTLOAD,HOME^%ZIS
 .W:$D(ZTSK) !,"Queued as task ",ZTSK,!
LOOP ;ENTRY POINT TO OUTPUT/SORT/KILL RAW DATA (POSSIBLY BY TASKMAN)
 N B,C,D,DATE,DB,DC,DI,DLR,DLW,DP,DT,DTI,DTO,EDT,ETIME,I,J,JOB,LR,LW,N,NODE,OPT,P,SDT,T,TI,TIME,TO,Y0,ZH
 S X=^%ZOSF("ERRTN"),@^%ZOSF("TRAP"),OPT=0
 I ACT["SRT" K:$D(KILLZZZ) ^XTMP("XUCP","zzz") S (N,D,J,T)=0 D
 .I '$D(KILLZZZ),$D(^XTMP("XUCP","zzz"))#2 D
 ..S SDT=$S($P(^XTMP("XUCP","zzz"),U)<((SDAT+1)_","_(STIM+1)):$P(^("zzz"),U),1:(SDAT+1)_","_(STIM+1)) S EDT=$S($P(^("zzz"),U,2)>(EDAT_","_ETIM):$P(^("zzz"),U,2),1:(EDAT_","_ETIM))
 .E  S SDT=(SDAT+1)_","_(STIM+1),EDT=EDAT_","_ETIM
 .S ^XTMP("XUCP","zzz")=SDT_U_EDT_$S('$D(KILLZZZ):U_"MERGED",1:"")
 U:ACT["WRT" IO
 S NODE=0 F  S NODE=$O(^XTMP("XUCP",NODE)) Q:NODE=""!(NODE="zzz")  D
 .S DATE=SDAT F  S DATE=$O(^XTMP("XUCP",NODE,DATE)) Q:DATE>EDAT!(DATE="")  D
 ..S JOB="" F  S JOB=$O(^XTMP("XUCP",NODE,DATE,JOB)) Q:JOB=""  D
 ...S TIME=$S(DATE=(SDAT+1):STIM,1:""),ETIME=$S(DATE=EDAT:ETIM,1:86400)
 ...F  S TIME=$O(^XTMP("XUCP",NODE,DATE,JOB,TIME)) Q:TIME>ETIME!(TIME="")  W:ACT="WRT" NODE_U_JOB_U_DATE_U_TIME_U_^(TIME),! K:ACT="KIL" ^(TIME) I ACT["SRT" S Y0=^(TIME) D
 ....I NODE=N,DATE=D,JOB=J D
 .....S DT=$S(TIME-T>0:TIME-T,1:86400+TIME-T),DC=+Y0-C,DI=$P(Y0,U,2)-I
 .....S DLR=$P(Y0,U,3)-LR,DLW=$P(Y0,U,4)-LW,DTI=$P(Y0,U,5)-TI,DTO=$P(Y0,U,6)-TO
 .....S ^XTMP("XUCP","zzz",OPT,NODE,DATE,JOB,TIME)=DC_U_DI_U_DLR_U_DLW_U_DTI_U_DTO_U_DT_U_ZH
 ....S N=NODE,D=DATE,J=JOB,T=TIME,C=+Y0,I=$P(Y0,U,2),LR=$P(Y0,U,3),LW=$P(Y0,U,4)
 ....S TI=$P(Y0,U,5),TO=$P(Y0,U,6),OPT=$P(Y0,U,7),ZH=$P(Y0,U,8)
 D:ACT="SRTWRT" SRTOUT
END D:ACT["WRT" ^%ZISC
 W:'$D(ZTQUEUED) !,"I'm finished "_$S(ACT="WRT":"outputt",ACT="SRT":"sort",ACT="SRTWRT":"sorting and outputt",1:"kill")_"ing the data."
 K SDAT,STIM,EDAT,ETIM,ACT,KILLZZZ
 Q
SRTOUT S (OPT,NODE,DATE,JOB,TIME)=""
 F  S OPT=$O(^XTMP("XUCP","zzz",OPT)) Q:OPT=""  D
 .F  S NODE=$O(^XTMP("XUCP","zzz",OPT,NODE)) Q:NODE=""  D
 ..F  S DATE=$O(^XTMP("XUCP","zzz",OPT,NODE,DATE)) Q:DATE=""  D
 ...F  S JOB=$O(^XTMP("XUCP","zzz",OPT,NODE,DATE,JOB)) Q:JOB=""  D
 ....F  S TIME=$O(^XTMP("XUCP","zzz",OPT,NODE,DATE,JOB,TIME)) Q:TIME=""  W OPT_U_NODE_U_JOB_U_DATE_U_TIME_U_^(TIME),!
