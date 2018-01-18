A3FMO ;PTD/BHAM ISC-Print Monthly VACO Report ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC; 8/3/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !!,"This option will print the Monthly VACO Report.",!
DATE S %DT="AE",%DT("A")="Select Month/Year for report: " D ^%DT K %DT G:Y<0 END S FSMBDT=Y I $E(FSMBDT,6,7)'="00" S FSMBDT=$E(FSMBDT,1,5)_"00"
DEV W !! K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO S Y=DT D D^DIQ S TODAY=Y
LETTER ;PRINT LETTER TO VACO
 S NUM=0 F J=FSMBDT:0 S J=$O(^DIZ(131000,"ATOFSMB",J)) Q:'J!(J>(FSMBDT+100))  F K=0:0 S K=$O(^DIZ(131000,"ATOFSMB",J,K)) Q:'K  S NUM=NUM+1
 W @IOF W !!!!!!!!!!!!?15,TODAY,!!!?15,"Procurement Operations Division (93A3)",!?15,"VA Central Office",!?15,"810 Vermont Avenue, NW",!?15,"Washington, DC  20420",!!?15,"ATTN:  Ms. Priscilla Lee"
 W !!?15,"SUBJ:  Services to Screen VA Physician Applicants",!?15,"with the Federation of State Medical Boards",!?15,"(Contract V101(93)P-1152)",!!
 W ?15,"1.  In response to your letter dated March 19, 1987,",!?15,"the following information is submitted.  The total",!?15,"number of applicants' names submitted to the FSMB",!?15,"during the month of "
 S Y=FSMBDT D D^DIQ W Y," was ",NUM,".",!!?15,"2.  Please contact ",$P(^DIZ(1100001,FSMBR,0),U,4),", RN, Region Nurse,",!?15,"at FTS 8-562-2846 if you have any questions regarding",!?15,"this subject."
 W !!!!!?15,$P(^DIZ(1100001,FSMBR,0),U,3),!?15,"Associate Deputy Regional Director"
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
END K FSMBDT,J,K,NUM,POP,TODAY,X,Y
 Q
 ;
