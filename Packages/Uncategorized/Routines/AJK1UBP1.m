AJK1UBP1 ;580/MRL - Collections, Purge Utilities; 18-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine contains the functionality necessary to purge
 ;old, inactive, records from the system.  There is both an
 ;auto-purge entry point as well as an interactive entry point.
 ;
 Q
 ;
EN ; --* ask user
 ;
 ; ==> write the warning first
 ;
 F I=1:1 S T=$P($T(INTRO+I),";;",2) Q:T=""  W !?5,T
 W ! K I,T
 ;
 I '$$KEY^AJK1UBCP G END
 S X=$$PIECE^AJK1UBCP(13) S:'X X=365 ;default
 S DIR(0)="NA^365:9999999",DIR("B")=X
 S DIR("A")="Purge records at least how many DAYS old: "
 S DIR("?")="ENTER A NUMBER BETWEEN 365 AND 9,999,999"
 S DIR("?",1)="Enter the number of days, in age, a record must be"
 S DIR("?",2)="in order to be purged from the AJK1UB TRANSMITAL"
 S DIR("?",3)="file.  The record must also NOT be active in order"
 S DIR("?",4)="to be purged.  All status changes entered for this"
 S DIR("?",5)="record, in the AJK1UB STATUS CHANGE file, will also"
 S DIR("?",6)="be purged."
 D ^DIR G ABORT:$D(DIRUT)
 S AJK=+X,AJKAUTO=0
 ;
OK ; --- ok with you
 W !!,"Are you sure you want to start this process" S %=2 D YN^DICN
 I % G QUE:%=1,ABORT
 W !?4,"Answer YES if you'd like to start this process in the background"
 W !?4,"otherwise please respond NO or enter an up-arrow to abort."
 G OK
 ;
ABORT ; --- user aborted process
 ;
 W !!,"Purge process not started...aborted."
 ;
END ; --- that's all folk's
 ;
 K AJK,AJKAUTO,AJKI,AJKOD,AJKP,DA,DIK,DIR,DIRUT,F,I,J,TXT,X,X1,X2
 K XMSUB,XMTEXT,XMY,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK Q
 ;
QUE ; --- queue process starts here
 ;
 K ZTDTH
 S ZTRTN="PURGE^AJK1UBP1",ZTDESC="AJK1UB PURGE",ZTIO=""
 S (ZTSAVE("AJKAUTO"),ZTSAVE("AJK"))="" D ^%ZTLOAD
 G ABORT:'+$G(ZTSK)
 W !!,"Task #",+ZTSK," queued"
 W !,"A Message will be sent when the process completes!"
 G END
 ;
AUTO ; --* auto-purge entry point
 ;
 S AJKAUTO=1,AJK=$$PIECE^AJK1UBCP(13) S:AJK AJK=365
 ;
PURGE ; --- start purge process
 ;
 S (AJKP(1),AJKP(0))=0
 S X1=DT,X2=("-"_AJK) D C^%DTC S AJKOD=X
 S I=0 F  S I=$O(^AJK1UB("AT",I)),J=0 Q:I'>0!(X>AJKOD)  D
 .F  S J=$O(^AJK1UB("AT",I,J)) Q:J'>0  S X=$G(^AJK1UB(+J,0)) D
 ..Q:$P(X,"^",5)  ;still active
 .S K=0 F  S K=$O(^AJK1UBS("AR",J,K)) Q:K'>0  D DEL(K,0)
 .D DEL(J,1)
 ;
 ; ==> send stat message
 ;
 K TXT
 F I=1,2 S TXT(I,0)=$$MSG(I)
 S XMSUB="AJK1UB "_$S(AJKAUTO:"Auto-",1:"")_"Purge Completed"
 I '$$GRP^AJK1UBTM($$UGP^AJK1UBCP) S XMY(.5)=""
 I +$G(DUZ) S XMY(DUZ)=""
 S XMTEXT="TXT("
 D ^XMD
 ;
 ; ==> update date last run/last last run thru parameters
 ;
 S X1=AJKOD,X2=-1 D C^%DTC S AJKOD=X
 S DIE="^DIZ(580950.1,",DA=1,DR=".14///^S X=DT;.15///^S X=AJKOD"
 D ^DIE K DA,DR,DIE
 Q
 ;
MSG(N) ; --- create TXT( array for message
 ;
 S X="Number of AJK1UB "_$S(N=1:"TRANSMITALS",1:"STATUS CHANGES")
 S X=$E(X_" purged .........................................",1,60)_" "
 Q (X_$J($S(X=1:AJKP(1),1:AJKP(0)),5))
 ;
DEL(AJKI,F) ; --- remove status changes for primary record
 ;             AJKI = record to be deleted
 ;                F = 1 (transmit); 0 (status change)
 N I,J,K
 S AJKP(F)=AJKP(F)+1 ;counter
 S DIK="^AJK1UB"_$S(F:"",1:"S")_"(",DA=+AJKI D ^DIK
 K DIK Q
 ;
INTRO ; --- introduction
 ;;WARNING:  This option is used to purge collection data from the
 ;;database.  Data must be at least 365 days old, and no longer
 ;;active, in order to be considered for purge.  All Status Changes
 ;;associated with the primary bill will also be removed during this
 ;;operation.  You may, as your discretion, choose to retain records
 ;;for a longer period of time, during the questioning sequence.
