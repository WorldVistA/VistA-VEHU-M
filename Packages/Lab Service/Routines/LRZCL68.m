LRZCL68 ;A-CIOFO;MJB;1  ; Compiled 01/08/99 10:24PM for M/WNT
 ; Clean up the test multiple in file 68
 ;
 ;This routine prompts the user for an accession area,date and number
 ;then it will check that global for a bad entry in the test multiple.
 ;
 ;
INIT K MJBAA,MJBAD,MJBAN
 W !,"This option will assist you in cleaning up file 68"
 W !
 ;
MJBAA ;
 S DIC="^LRO(68,",DIC(0)="AEMNZ" D ^DIC Q:Y<1  S MJBAA=$P(Y,"^",1)  D
 .R !,"PLEASE ENTER THE DATE: ",MJBAD Q:MJBAD["^"!MJBAD=""
 .S DIC="^LRO(68,MJBAA,1,MJBAD,",DIC(0)="MNZ"  D ^DIC Q:Y<1  W !,Y
