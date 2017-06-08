ZZDMK ;MODIFICATION OF PRE-PACK LABEL PRINTING ROUTINE by MP
A S U="^",ZX=$P(^DIZ(608005,0),"^",4),%IS=("A")="LABEL PRINTER DEVICE NUMBER:  " D ^%ZIS I IO="" W "DEVICE BUSY, JOB ABORTED.  " Q
 R !!,"ENTER DRUG NUMBER:  ",DRNU G:DRNU="" END G:DRNU="?" HELP G:DRNU="?" A+1
 I DRNU>ZX W !!,"ILLEGAL DRUG ID NUMBER.  PLEASE CHOOSE FROM:   " D HELP G A+1
 K ZDDATA S ZDDATA=^DIZ(608005,DRNU,0)
 S A=$P(ZDDATA,"^",1),B=$P(ZDDATA,"^",2)
 S C=$P(ZDDATA,"^",3)
EXA W !!!,"DRUG NAME:  ",A,!,"CONTINUED NAME:  ",B,!,"STRENGTH:  ",C
 R !,"Is this the drug you want to print?  Y//",AD I AD="N" G A+1
 R !!,"ENTER THE CONTROL NUMBER FOR THIS PRINTING (format NN-NN): ",E G:E="^" A+1 I E'?2N1"-"2N G ERR1
 ;R !!,"ENTER EXPIRATION DATE (format MM-DD-YY):  ",F G:F="^" A+1 I F'?2N1"-"2N1"-"2N G ERR2
NUM R !!,"HOW MANY SETS (8 LABELS IN A SET) DO YOU WANT TO PRINT?  ",NU G:NU="^" A+1
 O IO U IO
 F I=1:1:NU D W
 C IO K ZPA R !!,"PRINT ANOTHER PRE-PACK LABEL?  (Y or N):  ",ZPA
I I ZPA?1"N".E G END
 I ZPA?1"Y".E G A+1
 W !,"Enter 'Y' to print another  label or 'N' to exit program" G NUM+3
END C IO Q
 ;
W W !!,A,?11,A,?22,A,?34,A,?45,A,?56,A,?67,A,?78,A,!,B,?11,B,?22,B,?34,B,?45,B,?56,B,?67,B,?78,B
 W !,C,?11,C,?22,C,?34,C,?45,C,?56,C,?67,C,?78,C,!,E,?11,E,?22,E,?34,E,?45,E,?56,E,?67,E,?78,E,!
 Q
ERR1 W !!!,*7,"Please use the prescribed format of 2 numbers followed by",!,"a dash, followed by two numbers.  Ex.12-88" G EXA+2
ERR2 ;W !!!,*7,"Please use the prescribed format 04-23-85 where 04 is the month,,",!,"23 represents the day of the month, and 85 is the year." G EXA+3
 ;
HELP W !!,"DRUG #",?10,"DRUG NAME",?35,"STRENGTH"
 F I=1:1:ZX S ZHDATA=^DIZ(608005,I,0) W !!?3,$P(ZHDATA,"^",5),?10,$P(ZHDATA,"^",1),?20,$P(ZHDATA,"^",2),?37,$P(ZHDATA,"^",3),?5,$P(ZHDATA,"^",4)
 Q
