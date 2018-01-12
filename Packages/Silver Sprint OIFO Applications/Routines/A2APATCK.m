A2APATCK ;WASH/PEH - CHECK PATCHED ROUTINES ;2/13/01  16:15
 ;;1.0;VERHLP;;
 ;THIS ROUTINE PRODUCES A LISTINGS THAT CHECKS INSTALLED PATCHES.
 ;THE ROUTINE WILL ASK FOR SPECIFIED ROUTINES TO CHECK, STORE THOSE
 ;ROUTINES IN ^UTILITY($J, LOAD THOSE ROUTINES IN IT'S PARTITION
 ;RETRIEVE THE SECOND LINE, EXTRACT THE PATCHES INSTALLED AND
 ;VERIFY THEM WITH THE ENTRIES IN ^A2AP(1200035
 ;
 ;THE ENTRIES IN ^A2AP(1200035 COME FROM THE FORUM PATCH MODULE DATABASE.
 ;
A S (HEAD,SEL)="" K %ZIS,%IS,IOP,IOC,ZTIO W !!,"CHECK INSTALLED PATCHES" S %IS="MQ" D ^%ZIS G:POP EXIT
 U IO(0)
A1 R !,"HEADER COMMENT: ",HEAD:999,! G EXIT:HEAD="^" I $E(HEAD)="?" W !,"Enter <cr> and I will use the standard header." G A1
 IF HEAD="" S HEAD=$S($D(^DD("SITE"))#2:^("SITE"),1:"VAMC")
 K ^UTILITY($J),^TMP($J)
A2 R !,"Search 'R'outine(s), 'P'ackage or 'A'll Namespaces: ",SEL:999,! G EXIT:$E(SEL)="^"!(SEL="") S SEL=$E(SEL) I SEL="?"!("RPA"'[SEL) W !,"Enter 'R' to check individual routines, 'P' to check a package",!,"or 'A' for all namespaces" G A2
 I SEL="A" W !,"By Selecting 'A'll, the check will run for the latest verified version" D A^A2APATC2 G:$O(^TMP($J," "))="" EXIT G A4 ;Go collect all Namespace "Patched" routines
 I SEL="P" D P^A2APATC2 I '$D(CVER) W !!,"NO Package Selected." G EXIT ;Get namespace and lastest version number
 I SEL="R" W *7,!,"YOU MUST SELECT ROUTINES THAT ARE CONTAINED WITHIN THE SAME NAMESPACE.",!,"THIS ROUTINE DOES NOT CHECK FOR MULTIPLE VERSION NUMBERS",! X ^%ZOSF("RSEL") I $O(^UTILITY($J," "))="" W !!,"NO routines selected." G EXIT
 ;Check for latest version number
 I SEL="R" N VER1,CVER,RTNS S (RTNS,CVER)="" S VER1=0,RTNS="" F  S RTNS=$O(^UTILITY($J,RTNS)),VER1=0 Q:RTNS=""  F  S VER1=$O(^A2AP(1200035,"PATCHED",RTNS,VER1)) Q:VER1=""  S:VER1>CVER CVER=VER1
A3 W !!,"Version Number ",CVER S VER=CVER 
 I SEL="R" S FORM="L" G QUE
 S VER=+VER I VER<0 W !,"Please enter a number." G A3
 D:SEL="P" GET^A2APATC2 ;Go collect all Package "Patched" routines
A4 ;W !!,"'S'hort or 'L'ong form: S//" R FORM:999 S:FORM="" FORM="S" G EXIT:$E(FORM)="^"!(FORM="") S FORM=$E(FORM) I FORM="?"!("SL"'[FORM) W !,"Enter 'S' to display only errors or 'L' to diplay all patched routines." G A4
 S FORM="S" W !!,"2ND Line of the routine will be displayed where the line is not in the proper",!,"format.",!,"Processing Patches..."
QUE I $D(IO("Q")) S ZTRTN="5^A2APATC1",ZTDTH="",ZTDESC="CHECK INSTALLED PATCHES" S:SEL="P" ZTSAVE(PACK1)="" F I="FORM","HEAD","%R","^UTILITY($J,","^TMP($J,","VER","SEL" S ZTSAVE(I)=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G EXIT
 D 5^A2APATC1
 ;
EXIT ;Kill variables start again
 K %Y,%DT,%R,FORM,RN,ST,RUN,ROU,CVER,PAC,PACK,PACK1,PACKAGE,I,IOC,J,%Z1,%Z2,%Z4,%Z3,HDR,LC,PG,S,^UTILITY($J) I POP!($D(ZTQUEUED))!(HEAD="^")!(SEL="^") K HEAD,SEL D MES,^%ZISC Q
 K HEAD,SEL D ^%ZISC
 W !! S DIR(0)="YAM",DIR("A")="Would you like to update data for site tracking on FORUM? ",DIR("B")="NO" D ^DIR K DIR Q:Y'=1  D ^A2APSTU
 ;
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
 ;
MES ;
 W !!!,"** Please submit any questions, problems or enchancement requests to: **",!!,?15," CSINFRAST@FORUM.VA.GOV"
