PRCSEC ;SF-ISC/LJP/SAW/KMB-CPA EDITS CON'T ;1/22/93  12:00 PM
V ;;4.0;IFCAP;;9/23/93
A ;APPROVE REQUESTS
 W !!,"Use the 'Requests Ready For Approval' option to review the",!,"requests ready for approval for your control point.",!!
 N PPMFLG1 S PPMFLG1=1,PRCSOUT="" D STA^PRCSUT G W2:'$D(PRC("SITE")) G EXIT:'PRC("SITE")
 D CP^PRCSEC1 G EXIT:Y<0 D SIG G EXIT:MESSAGE'=1 Q:$D(PRCSQ1)  S PRCSVAR=PRC("SITE")_"-"_+PRC("CP") D:'$D(DT) DT^DICRW S PRCSQT=$E(DT,4,5),PRCSQT(1)=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",PRCSQT)
 D CAP^PRCSEC2(.XX) G:XX=1 ASK1 G:XX=2 EXIT
ASK S %=1 W !,"Do you want to loop through all transactions" D YN^DICN D:%=0 W3 G EXIT:%=-1,ASK:%=0,LOOP:%=1
ASK1 W !!,"Enter the last four digits, i.e., '0094' of the transaction number.",!
LOOK S PRCSID=1,DIC="^PRCS(410,",DIC(0)="AEQ",DIC("S")="I +^(0)=PRC(""SITE""),+$P(^(0),""-"",4)=+PRC(""CP""),$D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))",D="F1"
 S DIC("A")="Select TRANSACTION: " D ^PRCSDIC G:Y<0 EXIT K DIC("S"),DIC("A") S (PRCSDA,DA)=+Y D CHECK G LOOK
LOOP S PRCSLP="0-0-0"
 F PRCSI=0:0 S PRCSLP=$O(^PRCS(410,"F",PRCSVAR_"-"_$P(PRCSLP,"-",3))) Q:$P(PRCSVAR,"-",1,2)'=$P(PRCSLP,"-",1,2)!(PRCSLP="")  Q:PRCSOUT=-1  S PRCSDA=$O(^PRCS(410,"F",PRCSLP,0)) Q:PRCSDA'>0  I $D(^PRCS(410,PRCSDA,0)) D CHECK
 G EXIT
CHECK ;
 Q:+$P(^PRCS(410,PRCSDA,0),U)'=PRC("SITE")!(+$P($P(^(0),"-",4),U)'=+PRC("CP"))
 S DA=PRCSDA,DIC="^PRCS(410," D LOCK^PRCSUT Q:PRCSL=0
 S D0=PRCSDA W @IOF D ^PRCST5
 S DA=PRCSDA I $D(^PRCS(410,DA,7)),$P(^(7),U,6)'="" W $C(7),"   **This transaction has already been approved!**  " D W5^PRCSEB G CONT
 S:'$D(^PRCS(410,DA,11)) ^(11)="" I '$P(^(11),U,3) D W5^PRCSEB W $C(7),!,"  **This transaction is not ready for approval**  " G CONT
 I '$D(^PRCS(410,DA,4)) W $C(7),!,"  **Requests without committed/estimated cost cannot be approved!**" G CONT
EN S PRCSN=^PRCS(410,DA,0),PRCHQ=$P(PRCSN,"^",4),PRC("FY")=$P(PRCSN,"-",2),PRC("QTR")=$P(PRCSN,"-",3)
 S PRCST1=$S($D(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),0)):$P(^(0),U,PRC("QTR")+1),1:0),PRCST=$S($D(^PRCS(410,DA,4)):$P(^(4),U,8),1:0)
 I '$D(PRCSQ1) W !,"Current control point balance: $ ",$J(PRCST1,0,2),!,"Estimated cost of this request: $ ",$J(PRCST,0,2)
 I PRCST>PRCST1 D OCCK^PRCSEC1 I $D(PRCSOCK) G CONT
 I $P(PRCSN,"^",4)="" W !!,"A form type is required before this request can be approved." H 2 G CONT
 I $P(PRCSN,"^",4)>1,'$D(^PRCS(410,DA,"IT",0)) W !!,"Item(s) must be entered before this request can be approved." H 2 G CONT
ASK2 G:$D(PRCSQ1) ASK4 S %=0 W !,"Requests need to be reviewed prior to approval.",!,"Have you reviewed this request" D YN^DICN D:%=0 W3 G EX:%=-1,ASK4:%=1,ASK2:%=0
ASK3 W !,"Would you like to review the entire request" S %=2 D YN^DICN D W3:%=0 G EX:%=-1,ASK3:%=0 W:%=2 "  Request not approved." I %=1 S PRCS=DA,TRNODE(0)="" D NODE^PRCS58OB(DA,.TRNODE) D:PRCHQ=1 ^PRCE58P0 D:PRCHQ'=1 ^PRCSD12 S DA=PRCS G ASK4
 Q
ASK4 W:$P(PRCSN,"^",4)=.5 !,"Are you sure you want to approve this request" W:$P(PRCSN,"^",4)'=.5 !,"Is this request ready for transmission to A&MM/Fiscal" S %=2 D YN^DICN D W3:%=0 G EX:%=-1,ASK4:%=0 I %=2 G W6
SGN I $D(PRCSQ1) D SIG Q:MESSAGE'=1
 D ^PRCSEC1 D:$D(SPCP) OK^PRCSEC2 Q
SIG ;
SIG1 S MESSAGE="" D ESIG^PRCUESIG(DUZ,.MESSAGE)
 Q
W1 W !!,"An electronic signature code and signature block name are required to use this",!,"option.  Contact your ADP Site Manager." R X:8 Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W3 W !?2,"Enter 'Y' for YES or 'N' for NO" Q
W5 W $C(7),!!,"None to approve." G EXIT
W6 I $P(PRCSN,U,4)'=.5 W !,"Is this request ready for approval" S %=2 D YN^DICN G:%=0 W6 D:%=2 W5^PRCSEB D:%=1 W51^PRCSEB
 L  Q
CONT L  R !!,"Press return to continue: ",X:DTIME I X["^" S PRCSOUT=-1
 Q
EX L  S PRCSOUT=% Q
EXIT K %,%DT,C,DA,DIC,DIE,DR,PRCS,PRCSCP,PRCSI,PRCSID,PRCSJ,PRCSL,PRCSLP,PRCSRQ,PRCSN,PRCSOUT,PRCSQT,PRCSTT,PRCSVAR,PRCHQ,PRCST,PRCST1,SPCP,X,XX,Y,TRNODE Q
