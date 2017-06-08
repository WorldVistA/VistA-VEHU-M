ZZPLKILL ;Routine to delete Pick List Range; JCK/ALB ISC; MAY 19, 1988;5/20/88  4:04 PM
 ;
 W !,"This routine will allow you to specify a starting and ending date range for old pick lists so that they can be deleted. Be certain of the dates you select      before executing this routine."
 W !!,"*** MAKE SURE YOU LEAVE AT LEAST 30 DAYS OF PICK LIST DATA IN THE SYSTEM ***"
 ;
 S X="T" D ^%DT S DT=Y
DT ;Select date range
A S FLAG=0 W !! S Y=DT D D^DIQ S %DT("A")="Select the Start Date: ",%DT="EA" D ^%DT G Q:X["^"!(X="") S START=+Y
B W ! S Y=DT D D^DIQ S %DT("A")="Select the Ending Date: ",%DT="EA" D ^%DT G Q:X["^"!(X="")  S END=+Y
 ;
FIND F PLN=0:0 S PLN=$N(^PSG("PSGPL",PLN)) Q:PLN'>0  S PLTDT=$P(^(PLN),"^",2),PLWG=$P(^(PLN),"^",1),PLDATE=$P(PLTDT,".",1) I PLDATE'<START&(PLDATE'>END) W !,"This node has been killed  ",^(PLN) D KILL
 G Q
 ;
KILL ; Kill nodes and X-REF's
 S FLAG=1 K ^PSG("PSGPL",PLN) K:$D(^PSG("PSGPL","B",PLWG,PLTDT,PLN)) ^PSG("PSGPL","B",PLWG,PLTDT,PLN) K:$D(^PSG("PSGPL","O",PLWG,PLTDT,PLN)) ^PSG("PSGPL","O",PLWG,PLTDT,PLN) Q
 ;
Q I FLAG=0 W !!,"You aborted this attempt ... nothing was deleted" Q
 I FLAG=1 W !!,"ALL DONE !!  Have a nice day !!"
 K END,FLAG,PLDATE,PLN,PLTDT,PLWG,START
 Q
