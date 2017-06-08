DVBHPOST ;ALB/JLU ;Post init routine. ;3/19/90
 ;;V4.0;HINQ;;03/25/92 
 ;
EN W !!,"I will now run the HINQ Post init program.",!
 D BUL
 Q:'$D(^TMP("DVBHINQ"))
 I ^TMP("DVBHINQ")>3.2 W !!,"The rest of this post init was run in V",^TMP("DVBHINQ")," I do not need to run it again." D KILL Q
 ;
 ;;;DIS last here for final release
 D FIND,PROT,NEWP,PURG,SWIT,DIS
 W !,"Post init program finished."
KILL K ^TMP("DVBHINQ") Q
 ;
TXT ;print templates to delete
 ;;^DVBHINQ SCREEN 1^DVBHINQ SCREEN 2^DVBHINQ SCREEN 3^DVBHINQ SCREEN 4 1^DVBHINQ SCREEN 4 2^DVBHINQ SCREEN 5^DVBHINQ SCREEN 5 1^
 Q
 ;
FIND W !!,"  *** Deleting old print templates.",!!
 S ZX=$P($T(TXT+1),";;",2)
 S ZZ="DVBHINQ" F  S ZZ=$O(^DIPT("B",ZZ)) Q:ZZ'["DVBHINQ"  I ZX[ZZ S DA=+$O(^DIPT("B",ZZ,0)) I DA S DIK="^DIPT(" D ^DIK W ZZ,! K DIK,DA
 Q
 ;
DIS ;Checking the disability file
 D ^DVBHDBA1
 Q
 ;
 ;ADDING THE DVBHINQ MAILGROUP TO THE BULLETIN FILE.
BUL W !!,"  *** Looking at HINQ bulletin.",!
 S DA=$O(^XMB(3.6,"B","DVB HINQ RESPONSE","")) Q:'DA  S DIE="^XMB(3.6,",DR="4///"_"DVBHINQ" D ^DIE K DA,DR,DIE
 W !!,"'DVBHINQ' added to 'DVB HINQ RESPONSE' bulletin."
 Q
 ;
SWIT ;Converts all "New" HINQs back to pendings to be reHINQed.
 W !,"  *** Conversion of HINQ Suspense file."
 W !,"I will know convert all 'N'ew HINQs to 'P'ending HINQs for re-HINQing.",!
 S DIE="^DVB(395.5,"
 F X=0:0 S X=$O(^DVB(395.5,"AC","N",X)) Q:'X  D @$S($D(^DVB(395.5,X,0)):"SWIT1",1:"SWIT2")
 S CT=0
 W !
 F X=0:0 S X=$O(^DVB(395.5,X)),CT=CT+1 Q:'X  W:(CT#10)=0 "." I $D(^DVB(395.5,X,"HQ")) S ^("HQ")=$E(^("HQ"),1,8)_"E"_$E(^("HQ"),10,999)
 W !!,"Conversion is finished!"
 K DIE,DA,X,CT
 Q
 ;
SWIT1 S DA=X,DR="4///P" D ^DIE
 W "."
 Q
SWIT2 K ^DVB(395.5,"AC","N",X)
 Q
 ;
CLEN W !,"  *** Deleting file 395.5 entries with no zero nodes",!!
 S X=0 K ^TMP($J)
 F N=1:1 S X=$O(^DVB(395.5,X)) Q:'X  W:N#10=0 "." D CHK
 ;
CLENC W !,"  *** Remove invalid 'C, D' x-ref's",!!
 S X=0
 F N=1:1 S X=$O(^DVB(395.5,"C",X)) Q:'X  W:N#10=0 "." F X1=0:0 S X1=$O(^DVB(395.5,"C",X,X1)) Q:'X1  I $D(^TMP($J,X1)) K ^DVB(395.5,"C",X,X1)
 ;
 S X=0
 F N=1:1 S X=$O(^DVB(395.5,"D",X)) Q:'X  W:N#10=0 "." F X1=0:0 S X1=$O(^DVB(395.5,"D",X,X1)) Q:'X1  I $D(^TMP($J,X1)) K ^DVB(395.5,"D",X,X1)
 K ^TMP($J),X,X1,N Q
 ;
CHK I $D(^DVB(395.5,X))=10 D KIL Q
 I $D(^DVB(395.5,X,0)),'$L(^(0)) D KIL Q
 Q
KIL K ^DVB(395.5,X),^DVB(395.5,"B",X),^DVB(395.5,"AC","N",X),^DVB(395.5,"AD","P",X) S ^TMP($J,X)="" Q
 ;
NEWP ;
 W !,"  *** Moving HINQ Employee numbers to New Person file #200 ***",!!
 ;F N=0:0 S N=$O(^DIC(3,"AC",N)) Q:'N  S DA=$O(^(N,0)) I DA S DIE="^VA(200,",DR="14.9///"_N D ^DIE W "  ",DA K DE,DQ,DIE,DA
 F N=0:0 S N=$O(^DIC(3,N)) Q:'N  I $D(^(N,.1)),+$P(^(.1),"^",9) W:N#100=0 "." S DA=N I DA S HINQNO=+$P(^(.1),"^",9),DIE="^VA(200,",DR="14.9///"_HINQNO D ^DIE D:'$D(X) WARN W:$D(X) "  ",DA,"  " K DE,DQ,DIE,DA
 ;
 K HINQNO,N,DA Q
WARN W !?5,"Could not add user ",$P(^DIC(3,N,0),"^"),"'s HINQ EMPLOYEE #"
 W !?5,"Duplicate HINQ EMPLOYEE # with "
 W $S($D(^VA(200,+$O(^VA(200,"AC",HINQNO,0)),0)):" '"_$P(^(0),"^")_"' ",1:"")
 W !! Q
 ;
PROT W !?2
 W "*** Adding Write Protection to field 14.9 of the User File #3 ***",!!
 S ^DD(3,14.9,9)="^"
 ;
 W !?2
 W "* Removing Write Protection from field 14.9 of the New Person File #200 *",!!
 K ^DD(200,14.9,9)
 Q
 ;
PURG ;Runs the purge option only saving 7 days.
 I ^TMP("DVBHINQPURGE")="NO" Q
 W !!,"  *** Purging Suspense file #395.5 entries to 7 days",!!
 D 7^DVBHQPU
 K ^TMP("DVBHINQPURGE")
 Q
