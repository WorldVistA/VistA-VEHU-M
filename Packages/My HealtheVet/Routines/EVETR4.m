EVETR4 ;BP/LEL - ;Report of date in ^EVET(2275 for a veteran ; 10/25/02 3:11pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;Report: MY HEALTHEVET REGISTRATION INFORMATION
 ;two entry points
EN1 ;entry point from menu system
 N EVDFN,EVQUIT,EVNAME
 S EVQUIT=0
 D NAME
 I EVQUIT'=1 D EN2^EVETR4(EVDFN,EVNAME)
 Q
NAME ;get veteran name for extract
 N DIR,X,Y
 S DIR(0)="PA^2"
 D EN^DPTLK
 I Y=-1 S EVQUIT=1 Q
 S EVDFN=$P(Y,"^",1)
 S EVNAME=$P(Y,"^",2)
 Q
EN2(EVDFN,EVNAME) ;print out report for selected DFN
 ; EVDFN=patient DFN to process
 ; EVNAME=patient name
 N EVQUIT,EVTODAY,EVIEN,X,ZTRTN,ZTSAVE,ZTDESC,%ZIS,POP
 N IO,IOF
 D NOW^%DTC
 S EVTODAY=$$FMTE^XLFDT(X,5)
 S EVQUIT=0
 D EXTRACT
 I EVQUIT=1 Q
 D EVDEV
 I EVQUIT=1 Q
 I $D(IO("Q")) D  Q
 . K IO("Q")
 . S ZTRTN="EPRINT^EVETR4",ZTSAVE("EVNAME")="",ZTSAVE("EVIEN")=""
 . S ZTSAVE("EVTODAY")="",ZTSAVE("IO")=""
 . S ZTDESC="MY HEALTHEVET REGISTRATION INFORMATION REPORT"
 . D ^%ZTLOAD
 . K ZTSK
 . D HOME^%ZIS
 . Q
 I EVQUIT=0 D EPRINT
 Q
 ;
EXTRACT ;get data from ^EVET(2275
 S EVIEN=""
 S EVIEN=$O(^EVET(2275,"B",EVDFN,EVIEN))
 I EVIEN="" S EVQUIT=1 W !!,"Veteran not registered with My HealthEvet" Q
 Q
EVDEV ;get output device
 S %ZIS="MQ"
 D ^%ZIS
 I POP'=0 S EVQUIT=1 Q
 Q
EPRINT ;print registration information 
 USE IO
 W !,?20,"MY HEALTHEVET REGISTRATION INFORMATION",?68,EVTODAY
 W !!,"Name: ",EVNAME
 W !!,"Enrollment date: ",$$GET1^DIQ(2275,EVIEN_",",.02)
 W !!,"User Name: ",$$GET1^DIQ(2275,EVIEN_",",.04)
 W !!,"Initial Single-Use Password: ",$$GET1^DIQ(2275,EVIEN_",",.05)
 W !!,"Email Address: ",$$GET1^DIQ(2275,EVIEN_",",.06)
 W !!!,"Web Site for My HealtEvet access: www.health-evet.va.gov"
 D ^%ZISC
 Q
