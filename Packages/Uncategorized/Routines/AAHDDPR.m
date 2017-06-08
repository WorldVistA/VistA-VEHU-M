%AAHDDPR ;402,DJB,11/2/91,EDD**Printing, Count Fields
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 ;;This is run each time EDD is run, right after you select a File.
 ;;It sets up multiples in ^UTILITY($J,"TMP")
PRINTM ;Print Option in Main Menu
 I PRINTING'="YES" W *7,!!?2,"NOTE: To use this option you must have ^%ZIS routines and the DEVICE and",!?8,"TERMINAL TYPE files on your system." Q
 S FLAGP1=1 ;Redraws Main Menu. See MENU+2^%AAHDD.
PRINT ;
 S FLAGP=FLAGP=0 I FLAGP=0 W:$E(GEMIOST,1,2)="P-"&('FLAGM) @GEMIOF D ^%ZISC D  Q  ;If FLAGM user hit <RETURN> at Main Menu pompt.
 .S GEMSIZE=(IOSL-6),GEMIOF=IOF,GEMIOM=IOM-1,GEMIOSL=IOSL,GEMIOST=IOST
 S %ZIS("A")="  DEVICE: " D ^%ZIS K %ZIS("A") I POP S FLAGP=0 Q
 S GEMSIZE=(IOSL-6),GEMIOF=IOF,GEMIOM=IOM-1,GEMIOSL=IOSL,GEMIOST=IOST
 Q
TXT ;
 W @GEMIOF Q:'FLAGP  W:$E(GEMIOST,1,2)="P-" !!!
 I '$D(EDDDATE) S X="NOW",%DT="T" D ^%DT K %DT S EDDDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !,$E(GEMLINE1,1,GEMIOM),!?2,"File:---- ",ZNAM,!?2,"Global:-- ",ZGL,?(GEMIOM-17),"Date: ",EDDDATE,!,$E(GEMLINE1,1,GEMIOM),!
 Q
INIT ;
 I FLAGP W:$E(GEMIOST,1,2)="P-" "  Printing.." U IO
 D TXT Q
MULT ;
 NEW CNT,TMP
 D MULTBLD Q
MULTBLD ;
 K ^UTILITY($J)
 S CNT=1,^UTILITY($J,"TMP",ZNUM)=$P(^DD(ZNUM,0),U,4)_"^"_CNT,^UTILITY($J,"TOT")=$P(^DD(ZNUM,0),U,4)
 Q:'$D(^DD(ZNUM,"SB"))  S TMP(1)=ZNUM,CNT=2,TMP(CNT)=""
 F  S TMP(CNT)=$O(^DD(TMP(CNT-1),"SB",TMP(CNT))) D MULTBLD1 Q:CNT=1
 Q
MULTBLD1 ;
 I TMP(CNT)="" S CNT=CNT-1 Q
 I '$D(^DD(TMP(CNT),0)) Q
 S ^UTILITY($J,"TMP",TMP(CNT))=$P(^DD(TMP(CNT),0),U,4)_"^"_CNT_"^"_$O(^DD(TMP(CNT-1),"SB",TMP(CNT),""))
 S ^UTILITY($J,"TOT")=^UTILITY($J,"TOT")+$P(^DD(TMP(CNT),0),U,4)
 I $D(^DD(TMP(CNT),"SB")) S CNT=CNT+1,TMP(CNT)=""
 Q
