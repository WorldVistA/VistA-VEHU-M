RMPRLN3 ;PHX/RFM-PRINT LOAN CARD ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 D HOME^%ZIS,DIV4^RMPRSIT G:$D(X) EXIT^RMPRLN0
EN ;CALLED BY LOAN ROUTINES
 S (PER1,PER2,PER3,REC1,REC2,REC3,TEL1,TEL2,TEL3,LET1,LET2,LET3)=""
 I '$D(DFN) S DIC="^RMPR(660.1,",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: ",DIC("S")="I $P(^(0),U,9)=1"
DISP ;DISPLAY TYPE OF ITEM ON LOAN CARD
 I  S DIC("W")="W:$P(^(0),U,3)'?1N.N ?25,""AUTO ADAPTIVE LOAN"" W:$D(^RMPR(661,+$P(^(0),U,3),0)) ?25,$E($P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660.1,+Y,0),U,3),0),U),0),U,2),1,25) W ?55,$P(^DPT($P(^RMPR(660.1,+Y,0),U,2),0),U)"
 I '$D(DFN) S DIC(0)="AEQMZ" K X D ^DIC G:Y<0 EXIT^RMPRLN0 S DFN=$P(Y(0),U,2),IEN=+Y K DIC
DELE I $D(RMPRDEL) S %=2 W !,"Would you like to delete this loan card" D YN^DICN G:%<0!(%=2) EXIT^RMPRLN0 I $D(RMPRDEL),%=0 W !,"Answer `YES` or `NO`" G DELE
 I $D(RMPRDEL),%=1 S RMPRIEN=^RMPR(660.1,IEN,0) D DEL^RMPRLN4 S DIK="^RMPR(660.1,",DA=IEN D ^DIK W $C(7),!?5,"Deleted..." G EXIT^RMPRLN0
 I '$D(RMPRDAT1) S RMPRDAT1=$S($D(^RMPR(660.1,IEN,2,1,0)):$P(^RMPR(660.1,IEN,2,1,0),U),1:"")
 I '$D(RMPRDAT2) S RMPRDAT2=$S($D(^RMPR(660.1,IEN,2,2,0)):$P(^RMPR(660.1,IEN,2,2,0),U),1:"")
 I '$D(RMPRDAT3) S RMPRDAT3=$S($D(^RMPR(660.1,IEN,2,3,0)):$P(^RMPR(660.1,IEN,2,3,0),U),1:"")
 I +RMPRDAT1 S Y=RMPRDAT1 X ^DD("DD") S RMPRDAT1=Y
 I +RMPRDAT2 S Y=RMPRDAT2 X ^DD("DD") S RMPRDAT2=Y
 I +RMPRDAT3 S Y=RMPRDAT3 X ^DD("DD") S RMPRDAT3=Y
 I $D(RMPRFOLL),'$D(^RMPR(660.1,IEN,2,1,0)) G FOL
 D SETTYP^RMPRLN2
PRINT1 W:$E(IOST)="C" @IOF S:$E(IOST)'="C" IOM=80 W "INVENTORY CARD-PROSTHETIC LOAN ITEM",?65,$S($P(^RMPR(660.1,IEN,0),U,9)=1:"ON LOAN",$P(^(0),U,9)=2:"**RETURN**",1:"")
 W ! F I=1:1:79 W "-"
 W !,"Name of Item",?29,"Value of Item",?44,"Purchase Date",?59,"Asset Expiration Date"
 W ! F I=1:1:79 W "-"
 S RMPRA=$S($P(^RMPR(660.1,IEN,0),U,3):1,1:0)
 I RMPRA W !,$E($P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660.1,IEN,0),U,3),0),U),0),U,2),1,28),?29,"|",?30,$J($FN($P(^RMPR(660.1,IEN,0),U,5),"P",2),10),?43,"|"
 I 'RMPRA W !,$E($P(^RMPR(667.1,$P(^RMPR(660.1,IEN,0),U,21),0),U),1,28),?29,"|",?30,$J($FN($P(^RMPR(660.1,IEN,0),U,5),"P",2),10),?43,"|"
 S RMPRPDAT=$P(^RMPR(660.1,IEN,0),U,7) I RMPRPDAT S Y=RMPRPDAT X ^DD("DD") W ?45,$S(Y=-1:"",1:Y)
 W ?60,"|"
 S RMPREDAT=$P(^RMPR(660.1,IEN,0),U,8) I RMPREDAT S Y=RMPREDAT X ^DD("DD") W ?63,$S(Y=-1:"",1:Y)
 W ! F I=1:1:79 W "-"
 D DEM^VADPT,ADD^VADPT
 W !,"NAME AND ADDRESS OF VETERAN",?29,"|",?44,"FOLLOWUP ACTIVITY"
 W ! F I=1:1:79 W "-"
 W !,$P(VADM(1),",",2)_" "_$P(VADM(1),","),?29,"|TYPE OF CONTACT",?44,"|6 MO",?50,"|12 MO",?56,"|24 MO|",?65,"FOLLOWUP DATE"
 W !,VAPA(1),?29,"|---------------|----|-----|-----|----------------"
 I VAPA(2)'="" W !,VAPA(2),?29,"|PERSONAL",?45,"|",?46,PER1,?50,"|",?52,PER2,?56,"|",?58,PER3,?62,"|   6 MONTHS"
 E  W !,VAPA(4)_", "_$P(VAPA(5),"^",2)_" "_VAPA(6),?29,"|PERSONAL",?45,"|",?46,PER1,?50,"|",?52,PER2,?56,"|",?58,PER3,?62,"|   6 MONTHS"
 W !,?29,"|---------------|----|-----|-----|",?66,RMPRDAT1
 W !,?29,"|RECORD REVIEW",?45,"|",?46,REC1,?50,"|",?52,REC2,?56,"|",?58,REC3,?62,"|-----------------"
 W !,?29,"|---------------|----|-----|-----|   12 MONTHS"
 W !,"----------------------------",?29,"|TELEPHONE",?45,"|",?46,TEL1,?50,"|",?52,TEL2,?56,"|",?58,TEL3,?62,"|",?66,RMPRDAT2
 W !,?4,"SSN",?12,"|",?13,"TELEPHONE NO.",?29,"|---------------|----|-----|-----|----------------"
 W !,$P(VADM(2),"^",2),?12,"|",?14,VAPA(8),?29,"|LETTER",?45,"|",?46,LET1,?50,"|",?52,LET2,?56,"|",?58,LET3,?62,"|   24 MONTHS"
 W ! F I=1:1:62 W "-"
 W "|",?66,RMPRDAT3
 S Y=$P(^RMPR(660.1,IEN,0),U,10) X ^DD("DD") W !,"DATE OF LOAN: ",Y,?29,"| DATE OF RETURN: " S Y=$P(^RMPR(660.1,IEN,0),U,11) X ^DD("DD") W Y,?62,"|"
 W ! F I=1:1:79 W "-"
 W !,"COMMENTS: " I $D(^RMPR(660.1,IEN,1,0)) S WD=0 F  S WD=$O(^RMPR(660.1,IEN,1,WD)) Q:WD'>0  W !,$P(^RMPR(660.1,IEN,1,WD,0),U)
 Q:$D(RMPREDT9)
 I $E(IOST)'="C" G EXIT^RMPRLN0
ASKP Q:$D(FL)
 S %=2 W !,"Would you like to print this loan card" D YN^DICN G PRIN:%=1
 I %=0 W !,"Answer `YES` or `NO`" G ASKP
 I $D(DTOUT),$D(RMPRA) G DEL1^RMPRLN0A
 G:$D(RMPRFL) EXIT^RMPRLN0 G:RMPRA ASK1^RMPRLN0A G:'RMPRA ASK1^RMPRLN0B
FOL W @IOF D DEM^VADPT W !,$P(VADM(1),",",2)_" "_$P(VADM(1),",",1)_"  "_$P(VADM(2),U,2)
 W $C(7),!!,"Followup dates are not on file.!"
 G EXIT^RMPRLN0
PRIN S %ZIS="QM" D ^%ZIS G:POP EXIT^RMPRLN0
 I '$D(IO("Q")) U IO G PRINT1
 F I="PER1","PER2","PER3","REC1","REC2","REC3","TEL1","TEL2","TEL3","LET1","LET2","LET3","DFN","RMPRDAT1","RMPRDAT2","RMPRDAT3","RMPRPDAT","RMPREDAT","IEN" S ZTSAVE(I)=""
 S ZTIO=ION,ZTRTN="PRINT1^RMPRLN3",ZTDTH=$H,ZTDESC="Print Loan Card" D ^%ZTLOAD G EXIT^RMPRLN0
