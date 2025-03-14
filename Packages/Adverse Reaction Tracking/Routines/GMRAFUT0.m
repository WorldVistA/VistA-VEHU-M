GMRAFUT0 ;HIRMFO/YMP,RFM,WAA-ALLERGY/ADVERSE REACTION FILE UTILITIES ;3/14/05  12:21
 ;;4.0;Adverse Reaction Tracking;**23,62**;Mar 29, 1996;Build 2
EN1 ; Entry for GMRA LOCAL ALLERGIES EDIT option
 D PROCESS Q  ;23
 K DR,DIC,DLAYGO,X,Y,DA,GMRAIEN
 W ! S DLAYGO=120.82,DIC="^GMRD(120.82,",DIC("A")="Select a LOCAL ALLERGY/ADVERSE REACTION: ",DIC(0)="AEQML",DIC("DR")="1" D ^DIC K DIC,DLAYGO G:+Y'>0 EXIT S (DA,GMRAIEN)=+Y
 L +^GMRD(120.82,GMRAIEN):1 I '$T W !,"THIS ENTRY IS BEING EDITED BY SOMEONE ELSE",$C(7) D EXIT Q
 N GMRALN,DIE,GMRACT
 S GMRALN=$G(^GMRD(120.82,GMRAIEN,0))
 S DIE="^GMRD(120.82,",DR="",GMRACT=1
 I +$P(GMRALN,U,3) S DR(1,120.82,1)="@1;W !!,$C(7),""CANNOT EDIT NAME FIELD OF A NATIONAL ALLERGY."",!;3;"
 E  D
 .   S DR(1,120.82,1)=".01;3;"
 .   S DR(1,120.82,2)="S (GMRAY,GMRAX)=$P(GMRALN,U,2) D EDTTYPE^GMRAUTL(.GMRAX);"
 .   S DR(1,120.82,3)="S:GMRAX=GMRAY!(""^^""[GMRAX) X=GMRAX,Y=$S(""^^""[GMRAX:""@3"",1:""@4"");1///^S X=GMRAX;@4;4;5;@3;"
 .   Q
 D ^DIE K DIE,DA,DR,DLAYGO,GMRAX,GMRAY
 L -^GMRD(120.82,GMRAIEN)
 G:'$D(Y) EN1
 D EXIT Q
EN2 ; Entry for GMRA LOCAL REACTIONS EDIT option
 D PROCESS Q  ;23
 W ! S DLAYGO=120.83,DIC="^GMRD(120.83,",DIC("A")="Select a LOCAL SIGN/SYMPTOM: ",DIC(0)="AEQML",DIC("DR")="" D ^DIC K DIC,DLAYGO G:+Y'>0 EXIT S (DA,GMRAY)=+Y
 L +^GMRD(120.83,GMRAY):1 I '$T W !,"THIS ENTRY IS BEING EDITED BY SOMEONE ELSE",$C(7) D EXIT Q
 S DIE="^GMRD(120.83,",DR="S Y=""@""_+$P($G(^GMRD(120.83,DA,0)),U,2);@0;.01;S Y=""@2"";@1;W !,""NAME: ""_$P($G(^GMRD(120.83,DA,0)),U)_""  (no editing)"";@2;2" D ^DIE K DA,DIE,DR
 L -^GMRD(120.83,GMRAY)
 G:'$D(Y) EN2
 D EXIT Q
EN3 ; Entry for GMRA SITE FILE EDIT option
 S DLAYGO=120.84,DIC="^GMRD(120.84,",DIC(0)="AEQL" D ^DIC K DIC,DLAYGO G:+Y'>0 EXIT S GMRASITE=+Y
 L +^GMRD(120.84,GMRASITE):1 I '$T W !,"THIS ENTRY IS BEING EDITED BY SOMEONE ELSE",$C(7) D EXIT Q
 I $P(Y,"^",2)="HOSPITAL" W !,"NAME: HOSPITAL// (No editing)"
 E  S DA=GMRASITE,DIE="^GMRD(120.84,",DR=".01" D ^DIE I $D(Y) L -^GMRD(120.84,GMRASITE) G EXIT
 I '$D(^GMRD(120.84,GMRASITE,0)) L -^GMRD(120.84,GMRASITE) G EN3
 S DA=GMRASITE,DIE="^GMRD(120.84,",DR=6 D ^DIE I $D(Y) L -^GMRD(120.84,GMRASITE) G EXIT
RE10 S (GMRACTR,GMRARECN,GMRABRK,GMRAMID)=0,GMRALLER=""
 W !!,"The following are the ten most common signs/symptoms:"
 F GMRAX=1:1:5 D PRT10
RRD W !,"Enter the number of the sign/symptom that you would like to edit: "
 R GMRANS:DTIME S:'$T GMRANS="^^" I "^^"[GMRANS L:(GMRANS["^") -^GMRD(120.84,GMRASITE) G EXIT:(GMRANS["^"),EDCON
 I GMRANS'=+GMRANS!(GMRANS<1)!(GMRANS>10)!(GMRANS\1'=GMRANS) W !?4,$C(7),"ENTER THE CORRECT NUMBER (1-10) OF THE SIGN/SYMPTOM TO BE EDITED" G RRD
 S:'$D(^GMRD(120.84,GMRASITE,1,0)) ^(0)="^120.841P^^" S (GMRAX,GMRAY)=$G(^GMRD(120.84,GMRASITE,1,0)) I '$D(^GMRD(120.84,GMRASITE,1,+GMRANS,0)) S ^(0)="",$P(GMRAY,"^",3,4)=+GMRANS_"^"_($P(GMRAY,"^",4)+1)
 S DIE="^GMRD(120.84,DA(1),1,",DA(1)=GMRASITE,DA=+GMRANS,DR=".01" D ^DIE
 I $G(^GMRD(120.84,GMRASITE,1,+GMRANS,0))="" K ^(0) S GMRAY=GMRAX
 I GMRAY'=GMRAX S ^GMRD(120.84,GMRASITE,1,0)=GMRAY
 G RE10:'$D(Y) L -^GMRD(120.84,GMRASITE) G EXIT
EDCON S DIE="^GMRD(120.84,",DA=GMRASITE,DR="2;3;3.5;4;7;7.1;7.2;7.3SEND CHART MARK BULLETIN FOR NEW ADMISSIONS;10;10.1ENABLE COMMENTS FIELD FOR REACTIONS THAT ARE ENTERED IN ERROR" D ^DIE
 I $D(Y) L -^GMRD(120.84,GMRASITE) G EXIT
 S X=$G(^GMRD(120.84,GMRASITE,"RPT"))
 W !!,"REPORTER NAME: ",$P(X,U),!?6,"ADDRESS: ",$P(X,U,2) W:$L($P(X,U,3)) !?15,$P(X,U,3) W:$L($P(X,U,4)) !?15,$P(X,U,4) W !?9,"CITY: ",$P(X,U,5),!?8,"STATE: ",$P($G(^DIC(5,+$P(X,U,6),0)),U),!?10,"ZIP: ",$P(X,U,7),!?8,"PHONE: ",$P(X,U,8)
 W !,?3,"OCCUPATION: ",$P(X,U,11)
 F  S %=2 W !,"Do you want to edit Reporter Information shown above" D YN^DICN S:%=-1 %=2 Q:%  W !?3,"ENTER YES TO CHANGE/ADD THE SITE'S DEFAULT REPORTER INFORMATION",!?3,"THAT WILL APPEAR ON THE FDA ADR REPORTS, ELSE ANSWER NO."
 I %'=1 L -^GMRD(120.84,GMRASITE) G EXIT
 S DIE="^GMRD(120.84,",DA=GMRASITE,DR="11:19" D ^DIE
 L -^GMRD(120.84,GMRASITE)
EXIT ;
 D KILL^XUSCLEAN
 Q
PRT10 ;
 S GMRAY=$S($D(^GMRD(120.84,GMRASITE,1,GMRAX,0)):+^(0),1:0),GMRAZ=$S($D(^GMRD(120.84,GMRASITE,1,GMRAX+5,0)):+^(0),1:0)
 W !,$J(GMRAX,2),".",?4,$S($D(^GMRD(120.83,GMRAY,0)):$P(^(0),"^"),1:""),?35,$J(GMRAX+5,2),".",?39,$S($D(^GMRD(120.83,GMRAZ,0)):$P(^(0),"^"),1:"")
 Q
EN4 ; ENTRY FROM INPUT TRANSFORM FOR FIELDS .01 AND 22 OF FILE
 ; 120.85, WHERE GMRA=FIELD NUMBER, X IS DATA TO BE TRANSFORMED.
 S %DT="ETX",%DT(0)="-NOW" D ^%DT S X=Y I Y<1 W !?5,"DATE MUST BE IN THE PAST, AND TIME IS NOT A REQUIRED RESPONSE." G K4
 S GMRA(0)=$G(^GMR(120.85,+$G(DA),0)),GMRA("HELP")="DATE MUST BE "_$P("GREATER THAN DATE/TIME OBSERVED^LESS THAN DATE/TIME MD NOTIFIED","^",GMRA=.01+1),%DT(0)=+($E("-",GMRA=.01)_$P(GMRA(0),U,$E(12,1,GMRA=.01+1)))
 G:%DT(0)=0 Q4 S %DT="TX" D ^%DT S X=Y W:Y<1 !?5,GMRA("HELP") G:Y>0 Q4
K4 K X
Q4 K %DT,GMRA
 Q
 ;PROCESS section added with patch 23
PROCESS ;Additions to 120.82 and 120.83 are no longer allowed
 ;GMRA*4.0*62 Put NTRT message in this routine for display instead
 ;of calling the HDI routine
 ;I $L($T(NTRTMSG^HDISVAP)) D NTRTMSG^HDISVAP() Q
 ;New Term Rapid Turnaround (NTRT) Message
 N HDISLNE,HDISTXT
 F HDISLNE=1:1 S HDISTXT=$P($T(MSG+HDISLNE),";;",2) Q:HDISTXT="END"  W !?3,HDISTXT
 Q
 ;GMRA*4.0*62 comment out unnecessary code - NTRT message will always display now
 ;W !!,"The addition of local reactants and sign/symptoms are no longer"
 ;W !,"allowed.  Requests for new terms/concepts should be made through"
 ;W !,"the New Term Rapid Turn-around (NTRT) process.",!
 Q
MSG ;NTRT message text
 ;;
 ;;In support of national standardization of the contents of this file,
 ;;local site addition and modification functions are no longer available.
 ;;If you wish to contact Standards & Terminology Services (STS), request
 ;;a new term, or modify an existing term, please refer to the New
 ;;Term Rapid Turnaround (NTRT) web site located at
 ;;https://vaww.vashare.vha.domain.ext/sites/ntrt/SitePages/Home.aspx
 ;;
 ;;END
