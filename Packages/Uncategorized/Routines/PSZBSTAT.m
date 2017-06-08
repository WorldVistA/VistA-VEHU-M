PSZBSTAT ;do all statistic functions for bingo board module [ 04/16/96  1:15 PM ]
KILL ;entry point to kill off entire bingo board, clear display list of messages, and put statistics into file 506172 (RX READY - FILL TIME STATISTICS) for one division
 I DT'=^ZZBINGO(0) W !!,*7,"BINGO BOARD STATISTICS REPORT HAS NOT BEEN COMPLETED!,",!,"BINGO BOARD SHOULD NOT BE CLEARED UNTIL THIS REPORT FINISHES",!,"CALL EX 3665 IF YOU BELIEVE THIS IS IN ERROR",!! Q
 S ERRMIN=0
 I '$D(PSOSITE) S PSOREO=2 D ^PSOLSET
 S ERROR=0 S DIR(0)="D^::AE",DIR("A")="Clear Bingo Board thru (including) date",DIR("B")="TODAY" D ^DIR Q:X["^"  S EDT=Y
 W !!,"Calculating fill time statistics for the ",$P(^PS(59,PSOSITE,0),U,1)," division and saving them..."
 W !,"EDT: ",EDT F DATE=0:0 S DATE=$N(^PSZBINGO(506170,"AE",DATE)) Q:DATE<0!(DATE>(EDT_.9999))  W !,"DATE: ",DATE D INIT,LOOPDAY B  Q:ERRMIN  D STUFF Q:ERROR
 I ERROR!(ERRMIN) W !!,"I will stop this process so that no data is lost! Check List for incomplete orders.",*7,! G END
 W !!,"Deleting all entries for the ",$P(^PS(59,PSOSITE,0),U,1)," division..."
 ;actually am deleting any entries with a receive date before EDT_.9999
 F DA=0:0 S DA=$N(^PSZBINGO(506170,DA)) Q:DA<0!(DA]"A")  I $P(^PSZBINGO(506170,DA,0),U,3)<(EDT_.9999) S DIK="^PSZBINGO(506170," D ^DIK
 W !!,"Clearing Message Display List for the ",$P(^PS(59,PSOSITE,0),U,1)," division...",!!
 F DA=0:0 S DA=$N(^PSZBINGO(506171,"AD",PSOSITE,"Y",DA)) Q:DA<0  S DIE="^PSZBINGO(506171,",DR="5///NO" D ^DIE
END K %,DA,DATE,DIC,DIE,DIK,DIR,EDT,ERRMIN,ERROR,F,I,TREQ,TTIME,X,X1,X2,Y Q
 ;
INIT ;initialize array for fill time statistics, set total time and total patients for that day equal to 0
 S (TTIME,TREQ)=0 F I=0:1:23 S F(I)=0,P(I)=0   
 Q
 ;
LOOPDAY ;calculate statistics from file 506170 for each day
 S ERRMIN=0 F DA=0:0 S DA=$N(^PSZBINGO(506170,"AE",DATE,DA)) Q:DA<0  Q:DA>329  S X=^PSZBINGO(506170,DA,0),X1=$P(X,U,4),X=$P(X,U,3),HR=+$E(X1,9,10) D MIN Q:ERRMIN  S F(HR)=F(HR)+Y,P(HR)=P(HR)+1,TREQ=TREQ+1,TTIME=TTIME+Y
 Q
 ;
STUFF ;stuff one day of statistics into file 506172
 D NOW^%DTC S X=$P(%,".",2),X=DATE_"."_X   ;have .01 entry be the correct date with NOW's time to avoid duplicate entries due to multiple divisions
 S DIC="^PSZBINGO(506172,",DIC(0)="ELQ",DIC("DR")="1///^S X=PSOSITE;2///^S X=TTIME;3///^S X=TREQ" D ^DIC I Y<0 W !!,"ERROR WHEN STUFFING STATISTICS" S ERROR=1 Q  
 K DIC("DR"),DR S DIC="^PSZBINGO(506172,"_+Y_",1,",DIC(0)="LQ" S DA(1)=+Y I '$D(@(DIC_"0)")) S @(DIC_"0)")="^506172.05A^0^0"
 F ACE=0:1:23 I F(ACE)'=0!(P(ACE)'=0) K D0,DD S X=ACE,DIC("DR")="1///^S X=F(ACE);2///^S X=P(ACE)" D FILE^DICN 
 Q  
 ;
 ;
MIN ;calculate minutes between two dates, X1 (larger) and X. Return in Y.
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12)
 S X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S Y=X*1440+Y D:Y<0 ERRMIN K X1,X2,X Q
 ;
ERRMIN ;if Received D/T > Finished D/T  (Y is negative) then print a warning
 W !!,*7,"     Received D/T is GREATER than Finished D/T for entry # "_DA_"  of file 506170."
 W !,"     Correct these values (ask for IRM assistance) and then rerun this option!" S ERRMIN=1 Q
 ;
 ;
DAYSTAT ;print today's current statistics
 W ! S %IS="Q" D ^%ZIS Q:POP  I $D(IO("Q")),IO("Q") S ZTRTN="QDAY^PSZBSTAT",ZTSAVE("PRINT")=1,ZTIO=IO D ^%ZTLOAD Q
 D WAIT^DICD S PRINT=$S(IO'=IO(0):1,1:0) U IO
QDAY W:$D(IOF) @IOF F DATE=(DT-.0001):0 S DATE=$N(^PSZBINGO(506170,"AE",DATE)) Q:DATE<0!(DATE>DT)  D INIT,LOOPDAY
 I '$D(TTIME)!('$D(TREQ)) W !!,"No data on file for today yet...",!! Q
 S Y=DT D DD^%DT W !,"FILL TIME STATISTICS FOR TODAY, ",Y,!!?5,"Total Fill Time: ",?25,TTIME,!?5,"Total Requests: ",?25,TREQ,!?5,"Average Fill Time: ",?25,TTIME/TREQ*100\1/100,!
 W !!,?5,"HOUR",?12,"REQ.",?18,"TIME",?25,"AVG. FILL",?40,"HOUR",?47,"REQ.",?53,"TIME",?60,"AVG. FILL"
 F I=0:1:11 W !,?5,I_"-"_(I+1),?12,P(I),?18,F(I),?25,$S(F(I)'=0&(P(I)'=0):F(I)/P(I)*100\1/100,1:0),?40,(I+12)_"-"_(I+13),?47,P(I+12),?53,F(I+12),?60,$S(F(I+12)'=0&(P(I+12)'=0):F(I+12)/P(I+12)*100\1/100,1:0)
 R:'PRINT !!,"Hit any key to continue...",I X ^%ZIS("C") K DATE,F,I,TIME,TREQ,TTIME,Y Q
