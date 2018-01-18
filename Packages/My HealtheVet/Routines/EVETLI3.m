EVETLI3 ;BP/LEL - Prevent/allow download activity for a veteran ; 10/25/02 3:10pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
EN ;Entry point for process
 N EVDFN,EVOPT,EVQUIT,EVTODAY,EVST,EVDT,EVBY,EVIEN,EVYN,EVDONE
 ;S EVTODAY=$$FMTE^XLFDT(X,5)
 S EVOPT="NAME",EVQUIT=0
 D LOOP
 Q
LOOP D @EVOPT Q:EVQUIT=1  G LOOP
 ;
NAME ;get veteran name for extract
 N DIR,X,Y
 S DIR(0)="PA^2"
 D EN^DPTLK
 I Y=-1 S EVQUIT=1 Q
 S EVDFN=$P(Y,"^",1)
 I EVDFN'="" S EVOPT="EXTRACT"
 Q
EXTRACT ;Extract current status
 N RECIN
 S RECIN="",EVIEN=""
 S EVIEN=$O(^EVET(2275,"B",EVDFN,EVIEN))
 D FIND^DIC(2275,"","@;.09I;.1;","AP",EVIEN,"","","","")
 I $D(^TMP("DILIST",$J,1))=0 W !,"Veteran is not in My HealtheVet" S EVOPT="NAME" Q
 S RECIN=^TMP("DILIST",$J,1,0)
 S EVST=$P(RECIN,"^",2)
 S EVDT=$P(RECIN,"^",3)
 I EVST="Y" S EVOPT="QUERYY"
 I EVST'="Y" S EVOPT="QUERYN"
 Q
QUERYY ;allow user to undo blocked status
 N X,Y,EVT
 ;S EVT=$TR($$XMLDATE^EVETU1(EVDT),"T"," ")
 S DIR(0)="Y",DIR("A")="DO YOU WANT TO UNBLOCK THE VETERAN? ",DIR("B")="Y"
 D ^DIR
 I X="" W !,"Enter Y to unblock, N to leave blocked" Q
 S EVYN=$E(X)
 I EVYN="N" S EVDONE=1 Q
 S EVST="N",EVDT="",EVBY=""
 S EVOPT="UPDATE"
 Q
QUERYN ;allow user to block download
 N X,Y
 S DIR(0)="Y",DIR("A")="DO YOU WANT TO BLOCK DOWNLOADS ",DIR("B")="Y"
 D ^DIR
 I X="" W !,"Enter Y to block downloads, N to leave unblocked" Q
 S EVYN=$E(X)
 I EVYN="N" S EVDONE=1 Q
 D NOW^%DTC
 S EVST="Y",EVDT=%,EVBY=DUZ
 S EVOPT="UPDATE"
 Q
UPDATE ;update 2275 entry
 N FDA
 S EVIEN=EVIEN_","
 S FDA(1,2275,EVIEN,.09)=EVST
 S FDA(1,2275,EVIEN,.1)=EVDT
 S FDA(1,2275,EVIEN,.11)=EVBY
 D FILE^DIE("K","FDA(1)","")
 S EVQUIT=1
 Q
