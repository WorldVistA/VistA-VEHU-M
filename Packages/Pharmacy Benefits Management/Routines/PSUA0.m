PSUA0 ;BHM ISC/DEB - Select whether monthly or daily data ;10MAR92
 ;;1.0; D&PPM ;;11 May 94
 K PSUPSRX,PSUDATE,PSUDT1,PSUDT2,ERR
ASK S DIR("?",3)="If this is not the monthly report or you want a date range for the data,",DIR("?")="then answer with a 'N' for NO.",DIR("?",1)="If this is the monthly report where the data will be sent to the D&PPM"
 S DIR("?",2)="section for inclusion into the master file, answer with a 'Y' for YES."
 S DIR("A")="Is this the monthly report ",DIR(0)="Y" D ^DIR K DIR,DTOUT G ERR:Y="^" I Y=0 K PSUMNTH G DATES
 I $D(DTOUT) G ERR
 S PSUMNTH=1
MON ;Ask for the month
 S %DT(0)=2880000,%DT="AEP",%DT("A")="Select the Month and Year: " D ^%DT G ERR:Y'>0
 I Y>DT!($E(Y,1,5)=$E(DT,1,5)) W !!,"A monthly report cannot be compiled for the Outpatient package unless the month",!,"has already passed.",! K Y G MON
 S PSUDT1=$E(Y,1,5)_"01",PSUDT2=$E(Y,1,5)_$S($E(Y,4,5)="02":"29",$E(Y,4,5)="04":"30",$E(Y,4,5)="06":"30",$E(Y,4,5)="09":"30",$E(Y,4,5)="11":"30",1:31) G SETDT
 ;
DATES ;Select date range
 S %DT(0)=2880000,%DT="AE",%DT("A")="Select Start Date : " D ^%DT K %DT G ERR:+Y'>0 S PSUDT1=+Y
 S %DT(0)=2880000,%DT="AE",%DT("A")="Select End   Date : " D ^%DT K %DT G ERR:+Y'>0 S PSUDT2=+Y I PSUDT2'>PSUDT1 W !!,"The end date of the search must be greater than the start date.",! K PSUDT1,PSUDT2 G DATES
 I PSUDT1>DT!(PSUDT2>DT) W !!,"Searches cannot be executed for future dates.",! K PSUDT1,PSUDT2 G DATES
 G SETDT
 ;
SETDT S X=PSUDT1 D DATE S PSUMON1=Y,X=PSUDT2 D DATE S PSUMON2=Y,X=$E(PSUDT1,1,5)_"00" D DATE S PSUMON=Y K X,X1 Q
 ;
DATE ;Date conversion
 S Y=X X ^DD("DD") S:Y="" Y="Unknown"
 Q
 ;
ERR K X S ERR=1 Q
