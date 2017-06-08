EVETR3 ;BP/LEL - ;Report of data in ^EVET(2276.1 by date ; 10/25/02 3:11pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;Report: MY HEALTHEVET DOWNLOAD ACTIVITY BY DATE
EN ;Entry point for report
 N EVSTDATE,EVENDATE,EVOPT,EVDEBUG,EVQUIT,EVLIST
 N EVOUT,CURDEV,EVMAXLN,EVTODAY,IO,IOF
 ;debugging code only
 S EVDEBUG=0
 K ^TMP("EVETR3",$J)
 D NOW^%DTC
 S EVTODAY=$$FMTE^XLFDT(X,5)
 S EVOPT="STDATE",EVQUIT=0,EVMAXLN=22,CURDEV=$I,EVOUT=0
 D LOOP
 K ^TMP("EVETR3",$J)
 Q
ENQ ;QUEUED OUTPUT PROCESSING POINT
 D EXTRACT
 D DISPLAY
 K ^TMP("EVETR3",$J)
 Q
LOOP D @EVOPT Q:EVQUIT=1  G LOOP
 ;
STDATE ;get start date for range
 N DIR,X,Y
 S DIR(0)="D",DIR("A")="ENTER STARTING DATE: ",DIR("B")="TODAY"
 D ^DIR
 I X="^" S EVQUIT=1 Q
 I Y="" W !,"Enter a date or ^ to quit" Q
 S EVSTDATE=Y,EVOPT="ENDATE"
 Q
ENDATE ;get ending date for range
 N DIR,X,Y
 S DIR(0)="D",DIR("A")="ENTER ENDING DATE: ",DIR("B")="TODAY"
 D ^DIR
 I X="^" S EVOPT="STDATE" Q
 I Y="" W !,"Enter a date or ^ to quit" Q
 I Y'>EVSTDATE W !,"Ending date must be greater than starting date" Q
 S EVENDATE=Y_".999999",EVOPT="EVDEV"
 Q
EVDEV ;get output device
 N ZTRTN,ZTSAVE,ZTDESC,POP
 D ^%ZIS
 I POP'=0 S EVQUIT=1 Q
 I IO'=CURDEV S EVOUT=1,EVMAXLN=60
 S EVOPT="EXTRACT"
 I EVOUT=1 D  Q
 . K IO("Q")
 . S ZTRTN="ENQ^EVETR3"
 . S ZTSAVE("EVSTDATE")="",ZTSAVE("EVENDATE")="",ZTSAVE("EVOUT")=""
 . S ZTSAVE("EVTODAY")="",ZTSAVE("IO")="",ZTSAVE("EVMAXLN")=""
 . S ZTDESC="MY HEALTHEVET DOWNLOAD BY DATE"
 . D ^%ZTLOAD
 . K ZTSK
 . D HOME^%ZIS
 . S EVQUIT=1
 . K ^TMP("EVETR3",$J)
 . Q
 Q
EXTRACT ;Extract data
 N X,Y,EVLIST,EVDT,REC,RECIN
 S X=EVSTDATE,Y=""
 S EVOPT="DISPLAY"
 F  S X=$O(^EVET(2276.1,"AC",X)) Q:(X="")!(X>EVENDATE)  D
 . S EVDT=$P(X,".",1)
 . F  S Y=$O(^EVET(2276.1,"AC",X,Y)) Q:Y=""  D
 . . D FIND^DIC(2276.1,"","@;.04;.05;","AP",Y,"","","","")
 . . S RECIN="",REC=""
 . . I $D(^TMP("EVETR3",$J,EVDT))'=0 S REC=^TMP("EVETR3",$J,EVDT)
 . . I $D(^TMP("DILIST",$J,1))'=0 S RECIN=^TMP("DILIST",$J,1,0)
 . . S $P(REC,"^",1)=$P(REC,"^",1)+$P(RECIN,"^",2)
 . . S $P(REC,"^",2)=$P(REC,"^",2)+$P(RECIN,"^",3)
 . . S ^TMP("EVETR3",$J,EVDT)=REC
 . . Q
 . Q
 Q
DISPLAY ;Display retrieved data
 N EVLN,REC,X,EVT,EVTOTT,EVTOTD,EVPG
 S EVTOTT=0,EVTOTD=0,EVPG=0
 I EVOUT=1 USE IO
 D HDG
 S X=""
 F  S X=$O(^TMP("EVETR3",$J,X)) Q:X=""  D  Q:EVQUIT=1
 . S EVT=$$XMLDATE^EVETU1(X)
 . S REC=^TMP("EVETR3",$J,X)
 . W !,EVT,?12,$J($P(REC,"^",1),6),?20,$J($P(REC,"^",2),6)
 . S EVTOTD=EVTOTD+$P(REC,"^",1)
 . S EVTOTT=EVTOTT+$P(REC,"^",2)
 . S EVLN=EVLN+1
 . I EVLN>EVMAXLN D QRY D:EVQUIT'=1 HDG
 . Q
 I EVQUIT'=1 W !,"TOTALS",?12,$J(EVTOTD,6),?20,$J(EVTOTT,6)
 I EVQUIT'=1 D QRY  ;last query to be sure all results are displayed
 S EVQUIT=1   ;set quit to exit program
 D ^%ZISC   ;return to home device
 Q
HDG ;print heading
 S EVPG=EVPG+1
 I EVPG>1 W @IOF   ;form feed for page
 W !,?19,"MY HEALTHEVET DOWNLOAD ACTIVITY BY DATE",?68,EVTODAY
 W !,?70,"PAGE: ",EVPG
 W !,?4,"DATE",?14,"SENT",?22,"TIME"
 S EVLN=3
 Q
QRY ;ask user to continue
 I EVOUT=1 Q   ;output not to terminal, no questions
 N DIR,X,Y
 S DIR(0)="F",DIR("B")=" ",DIR("A")="Press enter to continue, ^ to quit"
 D ^DIR
 I X="^" S EVQUIT=1
 Q
