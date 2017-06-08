ZZDGL0 ; B'ham ISC/CML3 - CREATE DSM GLOBAL LIST UTILITIES ;1/10/92  12:31
 ;;1T3
 ;
ENGB ; build/rebuild global list
 ; will not pick up translated globals
 ; ^ZZGL(0)=number of globals
 S C=$G(^ZZGL(0)),%=1 I C W *7,!!,"A global list already exists!"
 I  F  W !!,"Do you want to overwrite the global list" S %=2 D YN^DICN Q:%  W !!?2,"Answer 'YES' to overwite the global list.  Answer 'NO' to quit now.",!,"WARNING! Overwriting the list will delete ALL of the old data."
 I %'=1 K %,%Y,C Q
 W !!,"Creating the global list..." K ^ZZGL,%GBL S ^ZZGL(0)=0 D ^%GUCI O 63::0 E  W !?5,"View Buffer busy...try again later...." G DONE
 S %UCIN=$P($ZU(%UCI,%SYS),","),%STB=$V(44),%UCNUM=%UCIN-1*20,%MM=$V($P($ZU(%UCI,%SYS),",",2)*($V(%STB+34)#256)+$V(%STB+12)+2),%BLK=$V(%UCNUM+4,%MM)#256*65536+$V(%UCNUM+2,%MM),%S="S"_$P($ZU(%UCI,%SYS),",",2)
%VIEW V %BLK:%S
 S %END=$V(1022,0),%NAM="",%PT=0
%NXT G %PTR:%END'>%PT
%C S %A=$V(%PT,0)#256,%PT=%PT+1,%NAM=%NAM_$C(%A\2) G %C:%A#2
 S %GBL(%NAM)="",%PT=%PT+8,%NAM="" G %NXT
%PTR S %BLK=$V(1016,0)#256*65536+$V(1014,0) G:%BLK %VIEW
 C 63 S X="" F C=1:1 S X=$O(%GBL(X)) Q:X=""  S ^ZZGL(C)=X
 S ^ZZGL(0)=C-1 W !,"...Global list completed." K %,%Y,%A,%BLK,%END,%GBL,%MM,%NAM,%PT,%S,%STB,%SYS,%UCI,%UCIN,%UCNUM,C,X Q
 ;
ENP ; pare list down
 I '$O(^ZZGL(0)) W !!,"NO GLOBALS FOUND!" Q
 K DIR S DIR(0)="LA^1:"_^ZZGL(0),DIR("A")="Select GLOBALS TO DELETE FROM THE LIST: ",DIR("?")="^D ENPH^ZZMGSU" W ! D ^DIR K DIR Q:'Y
 S X="" F  S X=$O(Y(X)) Q:X=""  F %=1:1 S C=$P(Y(X),",",%) Q:'C  K ^ZZGL(C) S ^(0)=^(0)-1
 F C=1:1:^ZZGL(0) I '$D(^ZZGL(C)) S (X,Y)=C F  S Y=$O(^ZZGL(Y)) Q:'Y  S ^(X)=^(Y),X=X+1
 F X=^ZZGL(0):0 S X=$O(^ZZGL(X)) Q:'X  K ^(X)
 K %,C,X,Y Q
 ;
ENQCNT ; count global nodes
 F  S CF=$O(^ZZGL(CF)) Q:'CF  D  
 .S C=0,GLO="^"_$P(^ZZGL(CF),"^"),$P(^(CF),"^",2)="" W:$D(ZTQUEUED) !,GLO,"..." I $D(@GLO)#2 S C=1
 .F C=C:1 S GLO=$Q(@GLO) Q:GLO=""  I '$D(ZTQUEUED),'(C#200) W "."
 .S $P(^ZZGL(CF),"^",2)=C Q
 I $D(ZTQUEUED) S %H=$H D YX^%DTC S XMSUB="GLOBAL NODE COUNT COMPLETED",XMDUZ="UTILITIES,GLOBAL LIST",XMY(DUZ)="",XMTEXT="ZZ(" K ZZ S ZZ(1,0)="  The task to produce the global node counts has been completed as of",ZZ(2,0)=Y_"." D ^XMD
 K %H,C,CF,GLO,Y,ZZ Q
 ;
DONE ;
 K %,%A,%BLK,%C,%END,%MM,%NAM,%PT,%S,%STB,%SYS,%UCI,%UCIN,%UCNUM,%Y,C,CF,CHK,GLO,X,Y Q
 ;
ENPH ;
 W !!?2,"Select any globals from this list that will not be moved.  Any globals",!,"selected will then be removed from the list."
 F  S %=2 W !!,"Would you like to see the list of globals" D YN^DICN Q:%  W !!?2,"Answer 'YES' to see the list of globals."
 D:%=1 ENPRT Q
 ;
ENPRT ; print global list
 K %ZIS,IO("Q"),IOP S %ZIS="Q",%ZIS("A")="PRINT DEVICE FOR GLOBAL LIST: ",%ZIS("B")="" W ! D ^%ZIS K %ZIS I POP D HOME^%ZIS W !!,"No device selected; global list not printed." Q
 I $D(IO("Q")) K ZTDTH,ZTSAVE S ZTRTN="ENQP^ZZDGL0" D ^%ZTLOAD W !!,"Global list print ",$S($D(ZTSK):"",1:"NOT "),"queued." K ZTSK Q
 ;
ENQP ; print starts here
 S PF=IO'=IO(0)!($E(IOST)="P") I PF D NOW^%DTC S GDT=$$DTC(%),TG=$G(^ZZGL(0))
 U IO W @IOF,! W:PF ?1,GDT W ?31,"DSM  GLOBAL  LIST" I PF W ?70-$L(TG),"Globals: ",TG
 W !!?6,"Global",?21,"Node Count",?46,"Global",?61,"Node Count",!,"-------------------------------------------------------------------------------"
 ;
WL ;
 S X=$G(^ZZGL(0)) I 'X W !!,"NO GLOBALS FOUND" Q
 W ! S %=X\2 F Y=1:1:% D:$Y+3>IOSL  Q:PF<0  W !?1,$J(Y,3,0),". ",$P(^ZZGL(Y),"^"),?21,$P(^(Y),"^",2),?41,$J(Y+%,3,0),". ",$P(^ZZGL(Y+%),"^"),?61,$P(^(Y+%),"^",2)
 .I 'PF W *7,!,"<>" R X:30 W:'$T *7 S:'$T X="^" I X["^" S PF=-1 W "  (print aborted)" Q
 .W # Q
 I %*2<X W !?41,$J(X,3,0),". ",$P(^ZZGL(X),"^"),?21,$P(^ZZGL(X),"^",2)
 I 'PF W *7 R !!,"End of list, press RETURN to continue: ",X:30 W:'$T *7
 W:PF>0 !!?35,"END OF LIST",@IOF D ^%ZISC K %,GDT,PF,TG,X,Y Q
 ;
ENRS ; get node count
 I '$O(^ZZGL(0)) W !!,"NO GLOBALS TO COUNT!" Q
 S CHK=0 F X=1:1:^ZZGL(0) I $P(^ZZGL(X),"^",2)="" S CHK=X Q
 I 'CHK W !!,"All of the globals have a node count."
 K DIR S DIR(0)="LA^1:"_^ZZGL(0),DIR("A")="Select GLOBAL TO START/RESTART COUNT: ",DIR("?")="^D ENRH^ZZMGSU" S:CHK DIR("B")=CHK W ! D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 S CF=Y-1 F  W !!,"Do you want to queue this count" S %=2 D YN^DICN Q:%  D  
 .W !!?2,"Answer 'YES' to queue this count, and you will receive a Mailman message when",!,"count has completed.  If you answer 'NO', this count will tie up your terminal",!,"until done.  Enter '^' to abort this count now."
 I %<0 K CF Q
 I %=1 K ZTDTH,ZTSAVE,ZTSK S ZTIO="",ZTRTN="ENQCNT^ZZDGL0",ZTSAVE("CF")="" D ^%ZTLOAD W !,"Global count ",$S($D(ZTSK):"",1:"NOT "),"queued." K CF,ZTSK Q
 W !!,"Starting global validation with:"
 ;
ENRH ;
 W !!?2,"Select the global at which you want to restart the validation process.  The",!,"first global found without a global count is number ",CHK," (",$P(^ZZGL(CHK),"^"),")."
 F  S %=2 W !!,"Would you like to see the list of globals" D YN^DICN Q:%  W !!?2,"Answer 'YES' to see the list of globals."
 W:%=1 !! D:%=1 ENPRT Q
 ;
DTC(Y) ; convert date/time to readable format
 I Y S Y=Y_$E(".",Y'[".")_"0000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_"  "_$E(Y,9,10)_":"_$E(Y,11,12)
 E  S Y="********"
 Q Y
