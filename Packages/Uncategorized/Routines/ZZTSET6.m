ZZTSET6 ;bciofo/maw-part 6 of test system reset procedures ;10/1/97
 ;;1.0;test system utilities;
 ;
 W !!,"PART 6:  RESET RPC BROKER PARAMETERS FILE (routine ^ZZTSET6)"
 ;
 ; environment checks...
 W !!,"First, an environment check..."
 S ZZCHKFLG=1
 ;
 ; rpc broker parameters file exists?...
 I '$D(^XWB(8994.1,0)) D
 .S ZZCHKFLG=0
 .I 'ZZCHKFLG W !?2,"No RPC BROKER PARAMETERS file exists here!"
 ;
 ; a BOX-VOLUME pair exists?...
 S ZZX=0
 S ZZBOX=""
 F  S ZZBOX=$O(^%ZIS(14.7,"B",ZZBOX)) Q:ZZBOX=""  S ZZX=ZZX+1
 I ZZX=1 D
 .S ZZBOX=$O(^%ZIS(14.7,"B",""))
 .S ZZBOXIFN=$O(^%ZIS(14.7,"B",ZZBOX,0))
 I ZZX=0!(ZZX>1) D
 .S ZZCHKFLG=0
 .W !?2
 .I ZZX=0 W "No defined BOX-VOLUME PAIR entry in the TASKMAN PARAMETERS file!" Q
 .W "Expected only ONE BOX-VOLUME PAIR, but ",ZZX," entries exist in the"
 .W !?2,"TASKMAN PARAMETERS file!"
 ;
 ; a domain name exists?...
 S ZZDOMIFN=+^XMB(1,1,0)
 S ZZDOMAIN=$P($G(^DIC(4.2,ZZDOMIFN,0)),U)
 I ZZDOMAIN="" D
 .S ZZCHKFLG=0
 .W !?2,"No defined DOMAIN name exits in the Domain file!"
 ;
 I 'ZZCHKFLG D  Q
 .W $C(7)
 .W !!,"The environment failed the minimum checks.  Part 6 aborted."
 .K ZZCHKFLG,ZZDOMAIN,ZZDOMIFN,ZZX
 ;
 K ZZCHKFLG,ZZX
 W "environment passed minimum configuration check."
 ;
 ; get/show the existing parameters file settings...
 W !!,"The existing RPC BROKER PARAMETERS file settings are:"
 S ZZCURDOM=+$G(^XWB(8994.1,1,0))
 S ZZCURDOM=$P($G(^DIC(4.2,ZZCURDOM,0)),U)
 W !?2,"Current DOMAIN entry: "
 W $S(ZZCURDOM'="":ZZCURDOM,1:"No DOMAIN is currently defined in the file.")
 S ZZDOMF=$S(ZZCURDOM=ZZDOMAIN:1,1:0)
 ;
 I '+$O(^XWB(8994.1,1,7,0)) D
 .W $C(7)
 .W !?2,"There are NO defined BOX-VOLUME PAIR entries in the current file."
 .S ZZBVF=0
 ;
 I +$O(^XWB(8994.1,1,7,0)) D
 .S ZZBVF=1
 .S ZZBV=""
 .F  S ZZBV=$O(^XWB(8994.1,1,7,"B",ZZBV)) Q:ZZBV=""  D
 ..S ZZBVNAME=$P($G(^%ZIS(14.7,ZZBV,0),"*UNDEFINED*"),U)
 ..W !?4,"BOX-VOLUME PAIR: ",ZZBVNAME
 ..;
 ..I '+$O(^XWB(8994.1,1,7,"B",ZZBV,0)) D  Q
 ...W $C(7)
 ...W !?6,"There are NO defined PORTS for this BOX-VOLUME PAIR in the file."
 ...S ZZPORTF=0
 ..;
 ..S ZZBVIFN=0,ZZPORTF=1
 ..F  S ZZBVIFN=$O(^XWB(8994.1,1,7,"B",ZZBV,ZZBVIFN)) Q:'ZZBVIFN  D
 ...S ZZPIFN=0
 ...F  S ZZPIFN=$O(^XWB(8994.1,1,7,ZZBVIFN,1,ZZPIFN)) Q:'ZZPIFN  D
 ....S ZZBVDATA=$G(^XWB(8994.1,1,7,ZZBVIFN,1,ZZPIFN,0))
 ....W !?6,"Port: ",$P(ZZBVDATA,U)
 ....W "  Status: ",$$STAT^ZZTSET6($P(ZZBVDATA,U,2))
 .K ZZBV,ZZBVDATA,ZZBVIFN,ZZBVNAME,ZZPIFN
 ;
 W !!,"This part will reset the RPC BROKER PARAMETERS file with new values for"
 W !,"your Test system.  This will include resetting the DOMAIN name to that"
 W !,"which you are using for this test domain, resetting the TCP port(s) through"
 W !,"which the listener operates, resetting the STATUS field to 'STOPPED',"
 W !,"and setting the CONTROLLED BY LISTENER STARTER field to 'YES' so that"
 W !,"the XWB LISTENER STARTER option will start up the listener when Kernel"
 W !,"Task Manager is started.  Following are the actions I will take:"
 ;
 W !!,"The DOMAIN name '"
 I ZZDOMF W ZZDOMAIN,"' will be retained."
 I 'ZZDOMF W ZZCURDOM,"' will be changed to '",ZZDOMAIN,"'."
 ;
 ; if no BOX-VOLUME PAIR, add the current one from the taskman parameter file...
 W !,"The BOX-VOLUME PAIR '",ZZBOX,"' will be "
 W $S('$G(ZZBVF):"entered.",1:"re-used.")
 ;
 ; if no PORT(s), add one (9200)...
 W !
 I '$G(ZZPORTF) W "PORT number 9200 will be entered."        
 I $G(ZZPORTF) W "Existing PORT number(s) will be re-used."        
 ;
 W !,"STATUS on PORT(s) will be set to 'STOPPED'."
 ;
 ; go for launch?...
 S DIR(0)="YA"
 S DIR("A")="Okay to continue with Part 6? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W " ...Part 6 ABORTED!!"
 .K ZZBVF,ZZCURDOM,ZZDOMAIN,ZZDOMF,ZZPORTF
 ;
 ; reset domain name...
 I 'ZZDOMF D
 .K ^XWB(8994.1,"B")
 .S $P(^XWB(8994.1,1,0),U)=ZZDOMIFN
 .S ^XWB(8994.1,"B",ZZDOMIFN,1)=""
 .I ZZCURDOM="" D
 ..S $P(^XWB(8994.1,0),U,3)=1
 ..S $P(^XWB(8994.1,0),U,4)=1
 ;
 ; if no box-volume pair, enter the one from the taskman parameters file, and
 ; enter a tcp port (9200 is the broker developers' default) as well...
 I 'ZZBVF D
 .S ^XWB(8994.1,1,7,0)="^8994.17P^1^1"
 .S ^XWB(8994.1,1,7,1,0)=ZZBOXIFN
 .S ^XWB(8994.1,1,7,"B",ZZBOXIFN,1)=""
 ;
 S ZZX=0
 F  S ZZX=$O(^XWB(8994.1,1,7,ZZX)) Q:'ZZX  D
 .I '$O(^XWB(8994.1,1,7,ZZX,1,0)) D
 ..S ^XWB(8994.1,1,7,ZZX,1,0)="^8994.171^1^1"
 ..S ^XWB(8994.1,1,7,ZZX,1,1,0)="9200^^^"
 ..S ^XWB(8994.1,1,7,ZZX,1,"B","9200",1)=""
 .S ZZY=0
 .F  S ZZY=$O(^XWB(8994.1,1,7,ZZX,1,ZZY)) Q:'ZZY  D
 ..S ZZDATA=^XWB(8994.1,1,7,ZZX,1,ZZY,0)
 ..S $P(ZZDATA,U,2)=6
 ..S $P(ZZDATA,U,4)=1
 ..S ^XWB(8994.1,1,7,ZZX,1,ZZY,0)=ZZDATA
 ..K ZZDATA
 K ZZBOX,ZZBOXIFN,ZZBVF,ZZCURDOM,ZZDOMAIN,ZZDOMF,ZZDOMIFN,ZZPORTF,ZZX,ZZY
 W !!,"Part 6 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,DIRUT,X,Y
 Q
 ;
STAT(X) ; get/return file status of defined TCP ports...
 N Y,ZZSTAT
 S ZZSTAT="UNKNOWN"
 I X'="" D
 .S X=X_":"
 .S Y=$P($G(^DD(8994.171,1,0)),U,3)
 .S ZZSTAT=$P($P(Y,X,2),";")
 .I ZZSTAT="" S ZZSTAT="UNKNOWN"
 Q ZZSTAT
  
