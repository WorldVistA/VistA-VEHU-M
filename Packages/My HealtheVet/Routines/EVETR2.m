EVETR2 ;BP/LEL - ;Report of data in ^EVET(2276.1 for a veteran ; 10/25/02 3:11pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;Report: MY HEALTHEVET DOWNLOAD REQUESTS FOR A VETERAN
EN ;Entry point for report
 ;date selection code left in for when requirements change - lel
 N EVDFN,EVSTDATE,EVENDATE,EVOPT,EVDEBUG,EVQUIT,EVLIST,EVPTNAME
 N EVOUT,CURDEV,EVMAXLN,EVTODAY,IO,IOF
 ;debugging code only
 S EVDEBUG=0
 K ^TMP("EVETR2",$J)
 D NOW^%DTC
 S EVTODAY=$$FMTE^XLFDT(X,5)
 S EVOPT="NAME",EVQUIT=0,EVMAXLN=22,CURDEV=$I,EVOUT=0
 D LOOP
 K ^TMP("EVETR2",$J)
 Q
ENQ ;QUEUED OUTPUT PROCESSING POINT
 D EXTRACT
 D DISPLAY
 Q
LOOP D @EVOPT Q:EVQUIT=1  G LOOP
 ;
NAME ;get veteran name for extract
 N DIR,X,Y
 S DIR(0)="PA^2"
 D EN^DPTLK
 I Y=-1 S EVQUIT=1 Q
 S EVDFN=$P(Y,"^",1)
 S EVPTNAME=$P(Y,"^",2)
 I EVDFN'="" S EVOPT="STDATE"
 Q
EVDEV ;get output device
 N ZTSAVE,POP,%ZIS,ZTDESC,ZTRTN
 S %ZIS="MQ"
 D ^%ZIS
 I POP'=0 S EVQUIT=1 Q
 I IO'=CURDEV S EVOUT=1,EVMAXLN=60
 S EVOPT="EXTRACT"
 I $D(IO("Q")) D
 . K IO("Q")
 . S ZTRTN="ENQ^EVETR2",ZTSAVE("EVDFN")="",ZTSAVE("EVMAXLN")=""
 . S ZTSAVE("EVQUIT")="",ZTSAVE("EVPTNAME")="",ZTSAVE("EVOUT")=""
 . S ZTSAVE("IO")="",ZTSAVE("EVSTDATE")="",ZTSAVE("EVENDATE")=""
 . S ZTSAVE("EVTODAY")=""
 . S ZTDESC="MY HEALTHEVET DOWNLOAD REQUESTS, VET"
 . D ^%ZTLOAD
 . K ZTSK
 . D HOME^%ZIS
 . S EVQUIT=1
 . K ^TMP("EVETR2",$J)
 . Q
 Q
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
 I X="^" S EVQUIT=1 Q
 I Y="" W !,"Enter a date or ^ to quit" Q
 I Y<EVSTDATE W !,"Ending date can not be less than starting date" Q
 S EVENDATE=Y_".999999",EVOPT="EVDEV"
 Q
EXTRACT ;Extract data
 N X,Y,Z,EVLIST,EVDT,REC,RECIN,ZFLAG
 S X="",Y=""
 S EVOPT="DISPLAY"
 F  S X=$O(^EVET(2276.1,"C",EVDFN,X)) Q:(X="")  D
 . S RECIN="",REC=""
 . D FIND^DIC(2276.1,"","@;.03I;.04;.05;","AP",X,"","","","")
 . I $D(^TMP("DILIST",$J,1))=0 Q
 . S RECIN=^TMP("DILIST",$J,1,0)
 . S EVDT=$P(RECIN,"^",2)
 . I EVDT<EVSTDATE Q    ;date before start of report
 . I EVDT>EVENDATE S X="999999999" Q    ;date after end of report
 . I $D(^TMP("EVETR2",$J,EVDT))'=0 S REC=^TMP("EVETR2",$J,EVDT)
 . S $P(REC,"^",1)=$P(REC,"^",1)+$P(RECIN,"^",3)
 . S $P(REC,"^",2)=$P(REC,"^",2)+$P(RECIN,"^",4)
 . S ^TMP("EVETR2",$J,EVDT)=REC
 . S ZFLAG=""
 . F Z=1:1 D  Q:ZFLAG=1
 . . D FIND^DIC(2276.11,","_X_",","@;.01;.02;","AP",Z,"","","","")
 . . S RECIN=""
 . . I $D(^TMP("DILIST",$J,1))=0 S ZFLAG=1 Q
 . . S RECIN=^TMP("DILIST",$J,1,0)
 . . S REC=""
 . . S $P(REC,"^",1)=$P(RECIN,"^",2)
 . . S $P(REC,"^",2)=$P(RECIN,"^",3)
 . . S ^TMP("EVETR2",$J,EVDT,Z)=REC
 . . Q
 . Q
 Q
DISPLAY ;Display retrieved data
 N EVLN,REC,X,Y,EVT,SUBHDR,EVPG,PREFX
 S EVPG=0
 I EVOUT=1 U IO
 D HDG
 S X=""
 F  S X=$O(^TMP("EVETR2",$J,X)) Q:X=""  D  Q:EVQUIT=1
 . S EVT=$TR($$XMLDATE^EVETU1(X),"T"," ")
 . S REC=^TMP("EVETR2",$J,X)
 . W !,EVT,?12,$J($P(REC,"^",1),6),?20,$J($P(REC,"^",2),6)
 . S EVLN=EVLN+1
 . I EVLN>EVMAXLN D QRY D:EVQUIT'=1 HDG Q:EVQUIT=1
 . S Y="",SUBHDR=0
 . F  S Y=$O(^TMP("EVETR2",$J,X,Y)) Q:Y=""  D  Q:EVQUIT=1
 . . S REC=^TMP("EVETR2",$J,X,Y)
 . . S PREFX=""
 . . I SUBHDR=0 S SUBHDR=1 S PREFX="REQUESTED:"
 . . W !,?5,PREFX,?16,$P(REC,"^",1),?40,"SINCE ",$P(REC,"^",2)
 . . S EVLN=EVLN+1
 . . I EVLN>EVMAXLN D QRY D:EVQUIT'=1 HDG
 . Q
 I EVQUIT'=1 D QRY  ;last query to be sure all results are displayed
 S EVQUIT=1   ;set quit to exit program
 D ^%ZISC   ;return to home device
 Q
HDG ;print heading
 S EVPG=EVPG+1
 I EVPG>1 W @IOF   ;form feed for page
 W !,?17,"MY HEALTHEVET DOWNLOAD REQUESTS FOR A VETERAN",?68,EVTODAY
 W !,"REPORT FOR ",EVPTNAME,?70,"PAGE: ",EVPG
 W !,"DATE/TIME",?21,"SENT",?28,"RUN TIME"
 S EVLN=3
 S SUBHDR=0  ;to allow reprinting of text block on new page
 Q
QRY ;ask user to continue
 I EVOUT=1 Q  ;output not to terminal, no questions
 N DIR,X,Y
 S DIR(0)="F",DIR("B")=" ",DIR("A")="Press enter to continue, ^ to quit"
 D ^DIR
 I X="^" S EVQUIT=1
 Q
