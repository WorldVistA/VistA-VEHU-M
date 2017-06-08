EVETR5 ;BP/LEL - ;Detailed Report of data in ^EVET(2276.1 for a date ; 8/4/03 11:19am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;Report: MY HEALTHEVET DAILY DOWNLOAD ACTIVITY FOR XX/XX/XXXX
EN ;Entry point for report
 N EVSTDATE,EVENDATE,EVRPTDT,EVOPT,EVDEBUG,EVQUIT,EVLIST,EVPTN,EVAREA,MAXAREA,EVREQCNT
 N EVOUT,CURDEV,EVPG,EVMAXLN,EVTODAY
 N IO,IOF
 ;debugging code only
 S EVDEBUG=0
 ;the number of possable areas extracted for a monster extract
 S MAXAREA=17
 ;
 K ^TMP("EVETR5",$J)
 D NOW^%DTC
 S EVTODAY=$$FMTE^XLFDT(X,5)
 S EVOPT="STDATE",EVQUIT=0,EVPG=0,EVMAXLN=22,CURDEV=$I,EVOUT=0,EVREQCNT=0
 D LOOP
 K ^TMP("EVETR5",$J)
 Q
ENQ ;QUEUED OUTPUT PROCESSING POINT
 D EXTRACT
 D DISPLAY
 Q
LOOP D @EVOPT Q:EVQUIT=1  G LOOP
 ;
STDATE ;get start date for range
 N DIR,X,Y
 S DIR(0)="D",DIR("A")="ENTER STARTING DATE: ",DIR("B")="TODAY"
 D ^DIR
 I X="^" S EVQUIT=1 Q
 I Y="" W !,"Enter a date or ^ to quit" Q
 S EVSTDATE=Y,EVOPT="ENDATE",EVRPTDT1=$$FMTE^XLFDT(Y,5)
 Q
ENDATE ;get end date for range
 N DIR,X,Y
 S DIR(0)="D",DIR("A")="ENTER ENDING DATE: ",DIR("B")="TODAY"
 D ^DIR
 I X="^" S EVQUIT=1 Q
 I Y="" W !,"Enter a date or ^ to quit" Q
 S EVENDATE=Y,EVOPT="EVDEV",EVRPTDT2=$$FMTE^XLFDT(Y,5)
 Q
EVDEV ;get output device
 N %ZIS,POP,ZTRTN,ZTDESC,ZTSAVE
 S %ZIS="Q"
 D ^%ZIS
 I POP'=0 S EVQUIT=1 Q
 I IO'=CURDEV D  Q
 . S EVOUT=1,EVMAXLN=60
 . K IO("Q")
 . S ZTSAVE("EVSTDATE")="",ZTSAVE("MAXAREA")="",ZTSAVE("EVMAXLN")=""
 . S ZTSAVE("EVOUT")="",ZTSAVE("EVPG")="",ZTSAVE("IO")=""
 . S ZTSAVE("EVRPTDT1")="",ZTSAVE("EVTODAY")="",ZTSAVE("EVREQCNT")=""
 . S ZTSAVE("EVENDATE")="",ZTSAVE("EVRPTDT2")=""
 . S ZTDESC="MY HEALTHEVET DAILY DOWNLOAD ACTIVITY"
 . S ZTRTN="ENQ^EVETR5"
 . D ^%ZTLOAD
 . K ZTSK
 . D HOME^%ZIS
 . S EVQUIT=1
 . K ^TMP("EVETR5",$J)
 . Q
 S EVOPT="EXTRACT"
 Q
EXTRACT ;Extract data
 N X,Y,EVLIST,REC,RECIN,MAXDT,EVTM
 S X=EVSTDATE,Y="",MAXDT=EVENDATE_".999999"
 S EVOPT="DISPLAY"
 F  S X=$O(^EVET(2276.1,"AC",X)) Q:(X="")!(X>MAXDT)  D
 . F  S Y=$O(^EVET(2276.1,"AC",X,Y)) Q:Y=""  D
 . . D FIND^DIC(2276.1,"","@;.02;.03;.04;.05;.08;","AP",Y,"","","","")
 . . S RECIN="",REC=""
 . . I $D(^TMP("DILIST",$J,1))'=0 S RECIN=^TMP("DILIST",$J,1,0)
 . . ;S EVPTN="",EVPTN=$$GET1^DIQ(2,$P(RECIN,"^",2)_",",.01)
 . . ;USE USERNAME NOT REAL NAME
 . . S EVPTN=$O(^EVET(2275,"B",$P(RECIN,"^",2),""))
 . . I EVPTN'="" S EVPTN=$P($G(^EVET(2275,EVPTN,0)),"^",4)
 . . I EVPTN="" S EVPTN="UNKNOWN: "_$P(RECIN,"^",2)
 . . D CNTAREA
 . . S $P(REC,"^",1)=$P(RECIN,"^",6)
 . . S $P(REC,"^",2)=$P(RECIN,"^",5)
 . . S $P(REC,"^",3)=$P(RECIN,"^",4)
 . . S $P(REC,"^",4)=EVAREA
 . . S ^TMP("EVETR5",$J,EVPTN,X)=REC
 . . S EVREQCNT=EVREQCNT+1
 . . Q
 . Q
 Q
CNTAREA ;count areas for cur extract record
 N EVX,EVA,EVCAT
 S EVX="",EVX=$G(^EVET(2276.1,Y,1,0))
 S EVAREA=$P(EVX,"^",3)
 ;if only one area adjust for 'monster' or 'all'
 I EVAREA=1 D
 . S EVCAT=$$GET1^DIQ(2276.11,"1,"_Y_",",.01)
 . I (EVCAT="monster")!(EVCAT="all") S EVAREA=MAXAREA
 . Q
 Q
DISPLAY ;Display retrieved data
 N EVLN,REC,X,Y,EVT,EVPRNAME,EVLPNAME,EVTOTT,EVTOTD,EVTOTE,EVTOTA,DTM
 S EVTOTT=0,EVTOTD=0,EVTOTE=0,EVTOTA=0,EVQUIT=0
 I $D(IO) USE IO
 D HDG
 S X="",Y=""
 F  S X=$O(^TMP("EVETR5",$J,X)) Q:X=""  D  Q:EVQUIT=1
 . F  S Y=$O(^TMP("EVETR5",$J,X,Y)) Q:Y=""  D  Q:EVQUIT=1
 . . S REC=^TMP("EVETR5",$J,X,Y)
 . . S EVPRNAME=X
 . . I X=EVLPNAME S EVPRNAME=""
 . . S EVLPNAME=X
 . . S DTM=$$FMTE^XLFDT(Y,2)
 . . W !,$E(EVPRNAME,1,20),?22,$P(DTM,"@"),?32,$P(DTM,"@",2),?42,$J($P(REC,"^",1),6),?50,$J($P(REC,"^",2),6),?58,$J($P(REC,"^",3),8),?70,$J($P(REC,"^",4),4)
 . . S EVTOTE=EVTOTE+$P(REC,"^",1)
 . . S EVTOTD=EVTOTD+$P(REC,"^",3)
 . . S EVTOTT=EVTOTT+$P(REC,"^",2)
 . . S EVTOTA=EVTOTA+$P(REC,"^",4)
 . . S EVLN=EVLN+1
 . . I EVLN>EVMAXLN D QRY D:EVQUIT'=1 HDG
 . . Q
 . Q
 I EVQUIT'=1 W !,"REQUESTS: ",EVREQCNT,?42,$J(EVTOTE,6),?50,$J(EVTOTT,6),?60,$J(EVTOTD,6),?70,$J(EVTOTA,4)
 I EVQUIT'=1 D QRY  ;last query to be sure all results are displayed
 S EVQUIT=1   ;set quit to exit program
 D ^%ZISC   ;return to home device
 Q
HDG ;print heading
 S EVPG=EVPG+1
 S EVLPNAME=""
 I EVPG>1 W @IOF   ;form feed for page
 W !,?13,"HEALTHeVET DOWNLOAD ACTIVITY FOR ",EVRPTDT1," - ",EVRPTDT2
 W !,?24,"DATE",?34,"TIME",?42,"EXTRACT",?52,"XMIT",?61,"CHAR",?70,"PAGE: ",EVPG
 W !,"VETERAN",?22,"STARTED",?32,"STARTED",?44,"TIME",?52,"TIME",?61,"SENT",?68,"# AREAS"
 S EVLN=3
 Q
QRY ;ask user to continue
 I EVOUT=1 Q   ;output not to terminal, no questions
 N DIR,X,Y
 S DIR(0)="F",DIR("B")=" ",DIR("A")="Press enter to continue, ^ to quit"
 D ^DIR
 I X="^" S EVQUIT=1
 Q
