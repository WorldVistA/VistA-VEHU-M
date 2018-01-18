A3FOUT ;PTD/BHAM ISC-Outgoing FSMB Entries - Print Letter & List to FSMB ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC;7/28/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !!,"For a printout of batch applicants ONLY (without FSMB letter),",!,"use the 'List Batch Applicants' option."
 W !!,"THIS option will print the letter to send to FSMB as well as",!,"the list of applicant names for a selected batch number.",!!,"The most recent batch numbers are:",!
 S CNT=0 F ID=0:0 S ID=$O(^DIZ(131001,"AINV",ID)) Q:'ID  S CNT=CNT+1 F B=0:0 S B=$O(^DIZ(131001,"AINV",ID,B)) Q:'B!(CNT>10)  D SHODT
 W ! S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("A")="Select BATCH number: " D ^DIC K DIC G:Y<0 END S BATCH=+Y
 I '$O(^DIZ(131000,"ABATCH",(BATCH-1))) W !,"No entries have been submitted by ANY station for this batch number.",! G END
ASK W !!,"For batch #",BATCH,":",! S %DT="AEX",%DT("A")="Enter date batch SENT TO FSMB: " D ^%DT K %DT G:Y<0 END S FSMBDT=Y W !
BUILD S $P(^DIZ(131001,BATCH,0),"^",4)=DT F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA)) Q:'PHYDA  S LOC($P(^DIZ(131000,PHYDA,0),"^"))=PHYDA
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO S PG=1 S Y=DT D D^DIQ S TODAY=Y D LETTER,HEAD
 S NM="" F K=0:0 S NM=$O(LOC(NM)) Q:NM=""  S PHYDA=$P(LOC(NM),"^") D WRTINFO S DIE="^DIZ(131000,",DA=PHYDA,DR="6///"_FSMBDT D ^DIE K DIE,DA,DR
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
END K %,ANS,B,BDT,BATCH,CNT,EDT,FMDT,FSMBDT,ID,J,K,LOC,NM,PG,PHYDA,POP,ST,SSN,TODAY,TYP,TODT,VAR,X,Y
 Q
 ;
HEAD ;HEADER FOR LIST OF APPLICANTS
 W @IOF W !!?5,TODAY,?69,"Page ",PG,!!?18,"LICENSURE SCREENING FOR PHYSICIAN APPLICANTS",!?34,"Batch #: ",BATCH,!?18 F J=1:1:44 W "-"
 W !! S PG=PG+1
 Q
 ;
WRTINFO ;WRITE FSMB DATA FOR ONE APPLICANT
 D:$Y+11>IOSL HEAD S VAR=^DIZ(131000,PHYDA,0),SSN=$P(VAR,"^",4)
 W !?10,"Name:  ",NM,!?10,"Other Names Used:  ",$P(VAR,"^",2),!?10,"DOB:  " S Y=$P(VAR,"^",3) D D^DIQ W Y,!?10,"Med. School Attended:  ",$P(VAR,"^",5),!?10,"Year of Graduation:  " S Y=$P(VAR,"^",6) D D^DIQ W Y
 W !?10,"Social Security #:  ",$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9),!
 Q
 ;
SHODT S FMDT=$P($P(^DIZ(131001,B,0),"^"),".") S TODT=$P($P(^DIZ(131001,B,0),"^",2),".") S TYP=$P(^DIZ(131001,B,0),"^",3)
 W !,"Batch #: ",B,?15,"From: " S Y=FMDT D D^DIQ W Y,?40,"To: " S Y=TODT D D^DIQ W Y,?62,"Type: ",TYP
 Q
 ;
LETTER ;PRINT LETTER TO FSMB WHICH IS SENT WITH LIST OF APPLICANTS
 W @IOF W !!!!!!!!!!!!?15,TODAY,!!!?15,"Federation of State Medical Boards",!?15,"2630 W. Freeway, Suite 138",!?15,"Fort Worth, Texas 76102-7199",!!
 W ?15,"Dear Sir:",!!?15,"Enclosed are the names of physician applicants that have",!?15,"applied for employment with the Veterans Administration.",!!
 W ?15,"Please search your files and report to me any disciplinary",!?15,"information you have on any of these applicants.",!!?15,"Sincerely,",!!!!!
 W ?15,$P(^DIZ(1100001,FSMBR,0),U,3),!?15,"Associate Deputy Regional Director",!!?15,"Enclosure"
 Q
 ;
