ZZTIME ; B'ham ISC/CML3 - SET ALL SYSTEMS' TIME ; [ 10/16/92  4:16 PM ]
 ;;
 D DT^DICRW
 I '$O(^DIZ(521550,0)) W *7,!!,"I need to know the name of each of your systems.  Please enter their 3 character",!,"names now.",! D NODESET I '$O(^DIZ(521550,0)) W *7,!!,"Sorry, but I cannot continue without your system names." G DONE
 ;
 W #!!?27,"MANUAL  NODE  TIME  UPDATE"
 W !!,"This allows you to manually set the time for all of your system's nodes.  While"
 W !,"this allows you to determine the date and time for this node (",$ZU(0),"), it uses",!,"the SYSTEM NODE file to determine the date/time of the other nodes."
 W !!,"(Please see the accompaning documentation before running this.)"
 ;
 D NOW^%DTC S OK=0 I $S(%#1<.02:1,1:%#1>.03) S X=0 F  S X=$O(^DIZ(521550,X)) Q:'X  I $P($G(^(X,0)),"^",3)<OK S OK=$P(^(0),"^",3) Q
 I OK W *7,*7,!!,"This should only be run between 2am and 3am to avoid corruption of the",!,"cross-system journal!" G DONE
 ;
 F  S %=2 W !!,"Do you want to continue" D YN^DICN Q:%  D  ;
 .W !!,"Answer 'YES' if you want to manually set the date/time on all of your system's",!,"nodes.  Answer 'NO' (or enter an up-arrow) if you do not wish to set the time",!,"now."
 G:%'=1 DONE
 ;
GETDATE ;
 K %DT S TDIFF=30
 F  D NOW^%DTC S DATETIME=% D CHANGE S Y=DATETIME D DD^%DT W !!,"Select DATE/TIME: ",Y,"// " R X:600 W:'$T *7 S:'$T X="^" Q:"^"[X  D:X?1."?"  S %DT="ERSTX" D ^%DT Q:Y>0
 .W !!,"Enter the DATE AND TIME to which this node's clock should be set.  The date/time",!,"entered will also be used as a reference in setting the date/time on the other",!,"nodes."
 G:X="^" DONE S:X]"" DATETIME=Y
 D NOW^%DTC I DATETIME<%,$S(%#1<.02:1,1:%#1>.03) W *7,*7,!!,"If you wish to set the time backwards, you must run this only between 2am and",!,"3am to avoid coruption of the cross-system journal." G GETDATE
 W !!,"Working:"
 ;
ENSTART ; code to do the work here
 S ND=$P($ZU(0),",",2)_"^"_$P($ZU(0),",") D ENDTSET(DATETIME,0,ND) S LOOP=0
 ;
LOOP ; loop through nodes
 S $ZT="LOOP^ZZTIME"
 F  S LOOP=$O(^DIZ(521550,LOOP)) Q:'LOOP  S ND=$G(^(LOOP,0)) I $P(ND,"^")?3U,$P(ND,"^",2)?3U,$P(ND,"^",2)_","_$P(ND,"^")'=$ZU(0) J ENDTSET^ZZTIME(DATETIME,$P(ND,"^",3),ND)[$P(ND,"^",2),$P(ND,"^")]
 ;
DONE ;
 K %,%Y,DA,DR,DIC,DIE,DR,LOOP,ND,OK,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTUCI Q
 ;
ENDTSET(DATETIME,TDIFF,ND) ; date/time set here
 I TDIFF D CHANGE
 S SDATE=$E(DATETIME,4,5)_$E(DATETIME,6,7)_$E(DATETIME,2,3)
 S STIME=$E(DATETIME_"00000",9,14)
 S X=$ZCALL(DATETIME,SDATE,STIME)
 I '$D(ZTQUEUED) W !!,$P(ND,"^",2),",",$P(ND,"^"),$S('X:" ",1:" NOT "),"updated."
 K %,%H,%I,SDATE,STIME,X Q
 Q
 ;
NODESET ;
 K DA,DIC,DIE,DR
 F  S DIC="^DIZ(521550,",DIC(0)="AEQLM",DLAYGO=521550 W ! D ^DIC Q:Y'>0  S DA=+Y,DIE=DIC,DR="1;.02;.03" D ^DIE
 K DA,DIC,DIE,DLAYGO,DR Q
 ;
 Q
 ;
ENQUEUED ; start here from TaskMan
 ;
 D NOW^%DTC S OK=0 I $S(%#1<.02:1,1:%#1>.03) S X=0 F  S X=$O(^DIZ(521550,X)) Q:'X  I $P($G(^(X,0)),"^",3)<OK S OK=$P(^(0),"^",3) Q
 I OK G DONE ; W *7,*7,!!,"This should only be run between 2am and 3am to avoid corruption of the",!,"cross-sytem journal!" G DONE
 ;
 D NOW^%DTC S DATETIME=% G ENSTART
 ;
ENOPT ; build option
 W #!!?25,"AUTOMATIC  NODE  TIME  UPDATE"
 W !!,"This will allow you to create/edit an option that can be set to run at a regular",!,"interval to make sure that the date/time of all of the nodes on your system",!,"concur.  This will create the option, and then allow you to determine"
 W " when the",!,"option should first run and how often it should run."
 W !!,"PLEASE NOTE that this option will run on the node that has TaskMan running.",!,"It is the date/time on that node that will used to set the other nodes, in",!,"conjunction with the TIME DIFFERENTIAL set for the other nodes."
 W !!,"PLEASE NOTE that if this option runs before 2am or after 3am, it will look at",!,"the TIME DIFFERENTIAL field for the nodes.  If any are negative numbers (to",!,"set time backwards), the option will abort.",!!
 K DIC S X="ZZ SYSTEM TIME UPDATE",DIC="^DIC(19,",DIC(0)="M" D ^DIC
 S %=1,OPT=0 I Y>0 S OPT=+Y W !!,"The option to update the system time (ZZ SYSTEM TIME UPDATE) already exists." F  S %=2 W !!,"Do you wish to overwrite it" D YN^DICN Q:%  D  ;
 .W !!,"Answer 'YES' to overwrite this option, in which case you will given the",!,"opportunity to change the QUEUED TO RUN AT WHAT TIME and RESCHEDULING FREQUENCY fields.  Answer 'NO' (or up-arrow) to exit now."
 G:%'=1 DONE
 S DIC="^DIC(19,",DIC(0)="LM",DLAYGO=19,X="ZZ SYSTEM TIME UPDATE",DIC("DR")="1////Update Time on All Nodes;4////R" D ^DIC
 I Y'>0 W *7,!!,"Option could not be created (reason unknown)." G DONE
 K ^DIC(19,+Y,1) D NOW^%DTC
 S ^DIC(19,+Y,1,1,0)="  This is used to make sure that the date/time on all of the system's nodes",^DIC(19,+Y,1,2,0)="concur.  This is designed to run automatically at a regular interval.",^DIC(19,+Y,1,0)="^^2^2^"_$P(%,".")_"^"
 W !!,"ZZ SYSTEM TIME UPDATE created."
 K DA,DR S DA=+Y,DIE="^DIC(19,",DR="25////ENQUEUED^ZZTIME;203////"_$P($ZU(0),",",2)_";200;202" D ^DIE
 G DONE
 ;
CHANGE ;
 N H,HRS,M,MIN,S,SEC,T,X,X1,X2
 S DATETIME=DATETIME_"00000",X=$P(DATETIME,".")
 S T=1 S:TDIFF<0 T=-1,TDIFF=-TDIFF
 S M=TDIFF\60,S=TDIFF#60,H=M\60,M=M#60,X2=H\24,H=H#24
 S HRS=+$E(DATETIME,9,10),MIN=+$E(DATETIME,11,12),SEC=+$E(DATETIME,13,14)
 I S S SEC=SEC+(S*T) S:SEC>59 SEC=SEC-60,M=M+1 S:SEC<0 SEC=SEC+60,M=M+1
 I M S MIN=MIN+(M*T) S:MIN>59 MIN=MIN-60,H=H+1 S:MIN<0 MIN=MIN+60,H=H+1
 S:H HRS=HRS+(H*T)
 S:HRS>24!(HRS=24&MIN) HRS=HRS-24,X2=X2+1 S:HRS<0 HRS=HRS+24,X2=X2+1
 I X2 S X1=X,X2=X2*T D C^%DTC
 S DATETIME=X_"."_$E(0,HRS<10)_HRS_$E(0,MIN<10)_MIN_$E(0,SEC<10)_SEC Q
