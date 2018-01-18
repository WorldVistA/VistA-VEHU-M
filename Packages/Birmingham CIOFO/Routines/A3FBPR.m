A3FBPR ;PTD/BHAM ISC-Print a List of Batches with Corresponding Dates ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !!,"This option will print the 24 most current batch numbers",!,"with their corresponding beginning and ending dates.",!
 I '$O(^DIZ(131001,"AINV",0)) W !,"FSMB BATCH FILE CONTAINS NO ENTRIES!" G END
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO W @IOF W !?26,"FSMB BATCH NUMBERS AND DATES",!!?54,"Date printed: " S Y=DT D D^DIQ W Y,!!,"Batch",?13,"Beginning",?43,"Ending",?61,"Type",?69,"Date Batch"
 W !?2,"#",?13,"Date/Time",?42,"Date/Time",?68,"Sent to FSMB",! F J=1:1:80 W "-"
 S CNT=0 F ID=0:0 S ID=$O(^DIZ(131001,"AINV",ID)) Q:'ID  S CNT=CNT+1 F B=0:0 S B=$O(^DIZ(131001,"AINV",ID,B)) Q:'B!(CNT>24)  D SHODT
END K %,B,CNT,FMDT,FSMB,ID,J,LOC,POP,TODT,TYP,Y
 Q
 ;
SHODT S LOC=^DIZ(131001,B,0),FMDT=$P(LOC,"^"),TODT=$P(LOC,"^",2),TYP=$P(LOC,"^",3),FSMB=$P(LOC,"^",4)
 W !,B,?6,"From: " S Y=FMDT D D^DIQ W Y,?35,"To: " S Y=TODT D D^DIQ W Y,?62,TYP I FSMB'="" S Y=FSMB D D^DIQ W ?68,Y
 Q
 ;
