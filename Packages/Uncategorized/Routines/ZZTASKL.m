ZZTASKL ; ;[ 06/08/92  10:57 AM ]
 ;0.01
 S IOP="HOME" D ^%ZIS
 D NOW^%DTC,^%DT S DT=X
 F I=1:1:50 W !,?25,"Future Task Listing for ",$E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3)
 W @IOF
 S ZTIO=0
 F I=0:0 S ZTIO=$O(^%ZTSCH("IO",ZTIO)) Q:ZTIO=""  D NEXT
 S ZTDTH=""
 F I=0:0 S ZTDTH=$O(^%ZTSCH(ZTDTH)) Q:ZTDTH'?5N1","1N.N  D NEXT1
 Q
NEXT ;
 F ZTSK=0:0 S ZTSK=$O(^%ZTSCH("IO",ZTIO,"VAH,PSA",ZTSK)) Q:ZTSK=""  D DIS
 Q
NEXT1 ;
 F ZTSK=0:0 S ZTSK=$O(^%ZTSCH(ZTDTH,ZTSK)) Q:ZTSK=""  D DIS
 Q
DIS ;
 S %ZT=^%ZTSK(ZTSK,0)
 S %ZT1=$S($D(^%ZTSK(ZTSK,.1))#2:^(.1),1:"")
 S %ZT2=$S($D(^%ZTSK(ZTSK,.2))#2:^(.2),1:"")
 W !,ZTSK I %ZT["ZTSK^XQ1",$P(%ZT,"^",4)="VAH,PSA",$D(^%ZTSK(ZTSK,.3,"XQM"))#2,$D(^DIC(19,+^("XQM"),0))#2 W ?10,$P(^(0),"^")_"   "_$P(^(0),"^",2)
 E  W ?10,$P(%ZT,"^",1,2) I $P(%ZT,"^",13)]"" W ?30,$P(%ZT,"^",13)
 I $P(%ZT,"^",3)>0 S ZTC2=$P(%ZT,"^",10) W:$X>25 ! W ?19," (",ZTC2 W:ZTC2]"" ")" I ZTC2="" S %ZTF=$P(%ZT,"^",4)="VAH,PSA"!($P(%ZT,"^",11)="VAH,PSA")&($D(^DIC(3,+$P(%ZT,"^",3),0))#2) W:%ZTF $P(^(0),"^") W:'%ZTF "USER #"_$P(%ZT,"^",3) W ")"
 I $P(%ZT,"^",4)]"" W:$X>37 ! W ?39,$P(%ZT,"^",4)
 S %ZTF=1,%ZTT=$P(%ZT,"^",5) I %ZTT W:$X>47 ! W ?49,"(FROM " D T W ")  "
 ;
STATUS ;Determine And Display Status Of Task
 W ?49 S ZTSTAT=$P(%ZT1,"^") I ZTSTAT="" W "---OLD OR IRREGULAR ENTRY" G S0
 I ZTSTAT'="A",$P(%ZT2,"^")]"" W "ON DEVICE '",$P($P(%ZT2,"^"),";",1),"'",!?49
 W !,?30,"---" I ZTSTAT=1 W "QUEUED FOR " S %ZTT=$P(%ZT,"^",6) D T G S0
 I "2345B"[ZTSTAT W $S(ZTSTAT=2:"IN VALIDATION",ZTSTAT=3:"READY TO RUN",ZTSTAT=4:"IN PREPARATION",ZTSTAT=5:"RUNNING",ZTSTAT="B":"REJECTED: "_$P(%ZT1,"^",3),1:"") G S0
 I ZTSTAT="A",$D(^%ZTSK(ZTSK,.26))#2 W "WAITING FOR HUNT GROUP ",^%ZTSK(ZTSK,.26) G S0
 I ZTSTAT="A" W "WAITING FOR DEVICE '",$P($P(%ZT2,"^"),";",1),"'" G S0
 I ZTSTAT="G" W "WAITING FOR LINK ",$P(%ZT,"^",14) G S0
 I "6CF"[ZTSTAT W $S(ZTSTAT=6:"COMPLETED ",ZTSTAT="C":"ERRORED ",ZTSTAT="F":"DEQUEUED ",1:"") S %ZTT=$P(%ZT1,"^",2) D T G S0:ZTSTAT'="C" W !?10,"Error = ",$P(%ZT1,"^",3) G S0
 W "IRREGULAR ENTRY"
S0 W !,"-------------------------------------------------------------------------------"
 S X="" Q  ; Output: X.
 ;
T ;Print Informal-format Conversion Of $H-format Date ; Input: %ZTT, DT.
 S %H=%ZTT D 7^%DTC W $S(DT=X:"TODAY",DT+1=X:"TOMORROW",1:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3))_" AT " S X=$P(%ZTT,",",2)\60,%H=X\60 W $E(%H+100,2,3)_":"_$E(X#60+100,2,3)
 K %,%D,%H,%M,%Y,X Q  ; Output: %ZTT, DT.
 ;
BUILD ;
 J QUE^XQ81["VAH","CSA"] J QUE^XQ81["VAH","CSB"]
 Q
