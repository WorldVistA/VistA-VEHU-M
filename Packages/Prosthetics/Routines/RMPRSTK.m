RMPRSTK ;PHX/RFM,RVD-ISSUE FROM STOCK ;8/29/1994
 ;;3.0;PROSTHETICS;**12,13,16,19,21,26,28,33,41,45,178,202**;Feb 09, 1996;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;JAH-p178-add caution msg to user if selected site not GIP flagged
 ;
 ;RMPR*3.0*202 Added line to ensure the brief description
 ;             field is populated for GIP issue processing.
 ;
 S (RMPRG,RMPRF)=""
 D HOME^%ZIS W @IOF
 I '$D(RMPR) D DIV4^RMPRSIT G:$D(X) EXIT^RMPRSTL
 ; check pre-requisites--Option won't run if DYNAMED is setup and
 ; give a single caution if GIP flag is not set.
 ;
 I $$DYNAMED() D EXIT^RMPRSTL Q
 D CAUTION($G(RMPRSITE),$G(RMPR("NAME")))
 I $D(RMPRDFN) D LINK^RMPRS
 D GETPAT^RMPRUTIL G:'$D(RMPRDFN) EXIT^RMPRSTL
VIEW N RMPRBAC1,RMDES
 S RMPRBAC1=1 D ^RMPRPAT K RMPRBAC1
 I $D(RMPRKILL)!($D(DTOUT)) W $C(7),!,"Deleted..." G EXIT^RMPRSTL
 S CK="W:$D(DUOUT) @IOF,!!!?28,$C(7),""Deleted..."" G EXIT^RMPRSTL"
 S CK1="W $C(7),!,""Timed-Out, Deleted..."" G EXIT^RMPRSTL"
 S R3("D")=""
RES ;ENTRY POINT TO ADD ADDITIONAL ITEMS FOR ISSUE FROM STOCK
 ;I RMPRG]"" D LINK^RMPRS
 Q:$G(RMPRDFN)<1
 K PRCP("ITEM"),DA,DD,DIC,PRC,X,Y,RMSO,RMQTY,RMHCPC,RMLOC,RMLACO,RMITDA,RMINVF,RMSAL
 S R1(0)=DT_U_RMPRDFN_U_DT,$P(R1(0),U,10)=RMPR("STA"),$P(R1(0),U,27)=DUZ
 S (R1(1),R3("D"),R4("D"),R1("AM"),RMPRI("AMS"),R1("D"))=""
 S DIR("?")="Enter V for VA or C for Commercial"
 S RMINVF="OTHER"
1 ;ENTRY POINT TO EDIT ITEM ON ISSUE FROM STOCK
 K RMPRGIP,PRCP("ITEM"),RMPRIP,RMITFLG S RMPREVHC=$P(R1(1),U,4)
 S DIR(0)="SBO^V:VA;C:COMMERCIAL",DIR("A")="Select VA or COMMERCIAL SOURCE" S:$P(R3("D"),U,14)?.A&($P(R3("D"),U,14)'="") DIR("B")=$P(R3("D"),U,14)
 W @IOF,!?30,RMPRNAM,! D ^DIR I $P(R3("D"),U,14)?1A.A&($D(DUOUT)) G LIST^RMPRSTL
 I $D(DTOUT) X CK1 Q
 G:X="" ^RMPRSTK G:$D(DUOUT) ^RMPRSTK I $D(DIRUT) X CK Q
 S $P(R1(0),U,14)=Y,RMSO=Y K DIR I Y["V" S $P(R1(0),U,16)=0
 S $P(R3("D"),U,14)=$S(Y="C":"COMMERCIAL",Y="V":"VA",1:"")
TRAN ;TYPE OF TRANSACTION
 W ! S DIR(0)="660,2" S:$P(R1(0),U,4)?.E&($P(R3("D"),U,4)'="") DIR("B")=$P(R3("D"),U,4) D ^DIR I $P(R3("D"),U,4)'=""&($D(DUOUT)) G LIST^RMPRSTL
 I $D(DTOUT) X CK1 Q
 I $D(DIRUT) X CK Q
 S $P(R1(0),U,4)=Y K DIR
 S $P(R3("D"),U,4)=$S(Y="I":"INITIAL ISSUE",Y="X":"REPAIR",Y="R":"REPLACE",Y="S":"SPARE",1:"")
 ;
PCAT S DIR(0)="660,62" S:$P(R1("AM"),U,3)?1N.N DIR("B")=$P(R4("D"),U,3) D ^DIR I $P(R1("AM"),U,3)'=""&($D(DUOUT)) G LIST^RMPRSTL
 I $D(DTOUT) X CK1 Q
 I $D(DIRUT) X CK Q
 S $P(R1("AM"),U,3)=Y,$P(R4("D"),U,3)=$S(Y=1:"SC/OP",Y=2:"SC/IP",Y=3:"NSC/IP",Y=4:"NSC/OP",1:"") K DIR
 I Y<4 S $P(R1("AM"),U,4)="",$P(R4("D"),U,4)="" G 2
SPE I Y=4 S DIR(0)="660,63" S:$P(R1("AM"),U,4)?1N.N DIR("B")=$P(R4("D"),U,4) D ^DIR I $D(DTOUT) X CK1 Q
 G:$D(DIRUT) 2
 I $P(R1("AM"),U,3)=4 S $P(R1("AM"),U,4)=Y,$P(R4("D"),U,4)=$S(Y=1:"SPECIAL LEGISLATION",Y=2:"A&A",Y=3:"PHC",Y=4:"ELIGIBILITY REFORM",1:"")
 ;
2 S DIC(0)="AEQM",DIC=661 S:$P(R1(0),U,6) DIC("B")=$P(^RMPR(661,$P(R1(0),U,6),0),U) S DIC("A")="ITEM: "
 K DIC("S") D ^DIC
 I $P(R3("D"),U,6)&$D(DUOUT) G LIST^RMPRSTL
 I $D(DUOUT) X CK Q
 I $D(DTOUT) X CK1 Q
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G 2
 S $P(R1(0),U,6)=+Y,$P(R3("D"),U,6)=$P(Y,U,2) K DIC,Y,X
HCPCS ;HCPCS code
 K DIC
 S DIC(0)="AEQM",DIC="^RMPR(661.1,",DIC("A")="PSAS HCPCS: " S:$P(R1(1),U,4) DIC("B")=$P(R1(1),U,4) D ^DIC I $P(R1(1),U,4)'=""&($D(DUOUT)) G LIST^RMPRSTL
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) X CK Q
 I Y=-1 W !,"HCPCS CODE IS MANDATORY!" G HCPCS
 I +Y>0 G:$P(^RMPR(661.1,+Y,0),U,5)'=1 HCPCS S RMHCPC=+Y
 S RDA=RMHCPC_"^"_$P(R1(0),U,4)_"^"_$P(R1(0),U,14)_"^"_660
 D:$D(RMCPT) CHK^RMPRED5
 W:$G(REDIT) !,"OLD CPT MODIFIER: ",$P(R1(1),U,6)
 I RMPREVHC'=RMHCPC D CPT^RMPRCPTU(RDA) G:$D(DUOUT)!$D(DTOUT) LIST^RMPRSTL S $P(R1(1),U,6)=$G(RMCPT) W:$G(REDIT) !,"NEW CPT MODIFIER: ",$G(RMCPT)
 I RMPREVHC'="",(RMPREVHC=RMHCPC),$G(REDIT) D
 .S DIR(0)="Y",DIR("A")="Would you like to Edit CPT MODIFIER Entry  ",DIR("B")="N" D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .I $G(Y) D CPT^RMPRCPTU(RDA) Q:$D(DTOUT)!$D(DUOUT)  S $P(R1(1),U,6)=$G(RMCPT) W !,"NEW CPT MODIFIER: ",$G(RMCPT)
 ;
LOCDIC I $P(^RMPR(661.1,RMHCPC,0),U,9)'=1 S RMINVF="OTHER" K RMLOC,RMITDA
 I $P(^RMPR(661.1,RMHCPC,0),U,9)=1 D ITEMLOC^RMPR5NU1
 I $P(R1(1),U,4)'="",$D(DUOUT),$G(RMITFLG) G LIST^RMPRSTL
 I $P(R1(1),U,4)="",$D(DUOUT) X CK Q
 I $G(RMLOC),'($G(RMHCDA)&$G(RMITDA)) W !,"PSAS Item was not selected!!" G LOCDIC
 K DIC
 G:'$D(RMLOC) GI
 S RMPRGIP=0 W ! G:RMLOC VEN0
 ;
GI I $P(^RMPR(669.9,RMPRSITE,0),U,3),'$D(^PRCP(445,"AD",DUZ)) W $C(7),!,"You are not an authorized user of any Inventory Point, please see your ADPAC." H 2 G EXIT^RMPRSTL
 S RMPRGIP=$P(^RMPR(669.9,RMPRSITE,0),U,3),RMPRF=$S(+RMPRGIP=0:"11",+RMPRGIP=1:"12"),$P(R1(0),U,13)=RMPRF I RMPRGIP S PRCPPRIV=1 G INV
 ;
VEN K DIC("S"),DIC("B")
 S X=" ",DIC=440,DIC(0)="ZM" D ^DIC S:+Y>0 DIC("B")=$P(^PRC(440,+Y,0),U,1)
 S RO=0 I $O(^PRC(441,$P(R3("D"),U,6),2,RO))'=""&($P(R1(0),U,9)="") S DIC("B")=$O(^PRC(441,$P(R3("D"),U,6),2,RO))
 ;
VEN0 ;set HCPCS when PSAS required fields are set
 S $P(R1(1),U,4)=RMHCPC,$P(R1(0),U,22)=$P(^RMPR(661.1,RMHCPC,0),U,4)
 I $P(R3("D"),U,9)'=""&$G(RMITFLG) G LIST^RMPRSTL
 I $G(RMITFLG) X CK Q
 I $D(RMLOC),$D(RMVEN),'$D(DIC("B")) S DIC("B")=RMVEN
 S DIC(0)="AEQM",DIC=440,DIC("A")="VENDOR: " S:$P(R1(0),U,9) DIC("B")=$P(R1(0),U,9) D ^DIC I $P(R3("D"),U,9)'=""&$D(DUOUT) G LIST^RMPRSTL
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) X CK Q
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G VEN
 S $P(R1(0),U,9)=+Y,$P(R3("D"),U,9)=$P(Y,U,2) K DIC,Y,X
 G ^RMPRSTL
 ;
INV S DIC="^PRCP(445,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=""Y"",$D(^PRCP(445,+Y,4,DUZ,0))" S:$D(RMPRIP) DIC("B")=RMPRIP
INDIC D ^DIC I $G(REDIT),$D(DUOUT) G LIST^RMPRSTL
 I $D(DUOUT) X CK Q
 I $D(DTOUT) X CK1 Q
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G INDIC
 S (PRCP("I"),RMPRIP)=+Y,PRCP("ITEM")=$P(R3("D"),U,6)
INVITEM I $D(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0)) G GIP
 W !!,"*** ITEM IS NOT IN GIP......."
 K DIC W ! S DIC="^RMPR(661,"
 S DIC("S")="S PRCP(""ITEM"")=$P(^(0),U,1) I $D(^PRCP(445,PRCP(""I""),1,PRCP(""ITEM""),0))"
 S DIC(0)="AEQM",DIC("A")="ITEM: "
ITDIC D ^DIC I $G(REDIT),$D(DUOUT) G LIST^RMPRSTL
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) X CK Q
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G ITDIC
 ;
 S $P(R1(0),U,6)=+Y,$P(R3("D"),U,6)=$P(Y,U,2)
 S PRCP("ITEM")=$P(R3("D"),U,6) K DIC("S")
GIP ;gip on
 S RMPRUCST=0 I $P(R1(0),U,14)["C" S $P(R1(0),U,16)=$P(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0),U,15),RMPRUCST=$P(R1(0),U,16) I $P(R1(0),U,7) S $P(R1(0),U,16)=$P(R1(0),U,16)*$P(R1(0),U,7)
 ;if cost is null,0, prompt for cost
 I RMPRUCST'>0 D
 .K DIR
 .S DIR(0)="667.3,3"
 .S DIR("A")="UNIT COST"
 .D ^DIR
 .K DIR
 .Q:$D(DUOUT)!($D(DTOUT))
 .S RMPRUCST=Y
 S RMINVF="GIP"
V I $P(^PRCP(445,PRCP("I"),0),U,3)="P",+$P(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0),U,12),$D(^PRC(440,+$P(^(0),U,12),0)),$P(R1(0),U,9)="" S $P(R1(0),U,9)=+$P(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0),U,12)
 I $P(^PRCP(445,PRCP("I"),0),U,3)="S" D
 .I $P(R1(0),U,9)="" K DIC S DIC="^PRCP(445,",DIC(0)="N",X=+$P(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0),U,12) D ^DIC Q:+Y<0  I $D(^PRCP(445,+Y,1,PRCP("ITEM"),0)) D
 ..S RMPRVEN=+$P(^PRCP(445,+$P(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0),U,12),1,PRCP("ITEM"),0),U,12) I $D(^PRC(440,+RMPRVEN,0)) S $P(R1(0),U,9)=RMPRVEN
 S $P(R1(1),U,2)=$P(^PRC(441,PRCP("ITEM"),0),U,2)   ;RMPR*3.0*202
 ;
DEF S X=" ",DIC=440,DIC(0)="ZM" D ^DIC S:+Y>0 DIC("B")=$P(^PRC(440,+Y,0),U,1)
 G VEN
 ;
HCPCG ;HCPCS code with GIP
 K DIC
 S DIC(0)="AEQM",DIC="^RMPR(661.1,",DIC("A")="PSAS HCPCS: " S:$P(R1(1),U,4) DIC("B")=$P(R1(1),U,4) D ^DIC
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) X CK Q
 I Y=-1 W !,"HCPCS CODE IS MANDATORY!" G HCPCG
 I +Y>0 G:$P(^RMPR(661.1,+Y,0),U,5)'=1 HCPCS S $P(R1(1),U,4)=+Y,$P(R1(0),U,22)=$P(^RMPR(661.1,+Y,0),U,4)
 S RMHCPC=+Y I $P(^RMPR(661.1,+Y,0),U,9)=1 D ITEMLOC^RMPR5NU1 I '$D(RMLOC) X CK Q
 Q
CAUTION(SELSITE,NAME) ; issue a caution message only once during the option
 ;                    if GIP flag is not set for this division
 Q:$G(SELSITE)'>0
 Q:+$G(^TMP($J,"RMRP CAUTION"))
 Q:+$P(^RMPR(669.9,SELSITE,0),U,3)
 ;
 W !!,"CAUTION:  This option is intended for use with GIP Inventory."
 W !,"          The Prosthetics Site Parameter [AUTOMATED INVENTORY (GIP)]"
 W !,"          is not set to 'YES' for the selected site, ",NAME,".",!
 N X S X=$$ASK(1)
 S ^TMP($J,"RMRP CAUTION")=1
 Q
DYNAMED() ; If this system is flagged as using DYNAMED for inventory,
 ; then inform user and then quit.
 ; DBIA 6394--Lookup DynaMed flag in IFCAP Sys param.  Sites using 
 ; DynaMed will continue to use Prosthetics Inventory Package (PIP)
 ; until a better solution is devised.
 ;
 N SYSINV
 S SYSINV=$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 I SYSINV&($E(IOST,1,2)="C-") D
 .  W !!,"This system is flagged as using DYNAMED Inventory."
 .  W !,"You can not use GIP for Prosthetics."
 .  W !,"Please contact your Application Coordinator.",!
 .  N X S X=$$ASK(1)
 Q +SYSINV
 ;
ASK(HOLD) ;ask user 2 continue function
 ;return true (1) if user want's 2 stop, false (0) 2 continue.
 ;If HOLD defined, use prompt 2 hold display until user hits return.
 ;If not terminal then, do nothing, return FALSE.
 ;
 N STOP S STOP=0
 I $E(IOST,1,2)="C-" D
 .;
 .N RESP,DIR S RESP=0
 .I $G(HOLD) S DIR(0)="EA",DIR("A")="Enter return to continue. "
 .E  S DIR(0)="E"
 .D ^DIR I Y="" S STOP=0
 .I $D(DIRUT) S STOP=1
 Q STOP
