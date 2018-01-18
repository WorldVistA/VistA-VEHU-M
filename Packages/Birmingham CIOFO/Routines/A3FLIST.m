A3FLIST ;PTD/BHAM ISC-List Batch Applicants ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !!,"This option will print the list of applicant names",!,"for selected batch number(s).",!!,"The most recent batch numbers are:",!
 S CNT=0 F ID=0:0 S ID=$O(^DIZ(131001,"AINV",ID)) Q:'ID  S CNT=CNT+1 F B=0:0 S B=$O(^DIZ(131001,"AINV",ID,B)) Q:'B!(CNT>10)  D SHODT
DIC W ! S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("A")="Select BATCH number: " D ^DIC K DIC G:Y<0 BUILD S LIST(+Y)="" G DIC
BUILD I '$O(LIST(0)) W !,"NO BATCH SELECTED!",! G END
 F BATCH=0:0 S BATCH=$O(LIST(BATCH)) Q:'BATCH  F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA)) Q:'PHYDA  S LOC(BATCH_"*"_$P(^DIZ(131000,PHYDA,0),"^"))=PHYDA
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO S Y=DT D D^DIQ S TODAY=Y
 S (BATCH,ENT,OLD)="" F L=0:0 S ENT=$O(LOC(ENT)) Q:ENT=""  S OLD=BATCH,BATCH=+ENT,NM=$P(ENT,"*",2),PHYDA=$P(LOC(ENT),"^") S:OLD'=BATCH PG=1,NUM=1 D:OLD'=BATCH HEAD D WRTINFO
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
END K %,B,BDT,BATCH,CNT,ENT,FMDT,ID,INFO,J,L,LIST,LOC,NM,NUM,OLD,PG,PHYDA,POP,STN,SSN,TODAY,TYP,TODT,VAR,X,Y
 Q
 ;
HEAD ;HEADER FOR LIST OF APPLICANTS
 W @IOF W !!?5,TODAY,?69,"Page ",PG,!!?28,"FSMB PHYSICIAN APPLICANTS",!?34,"Batch #: ",BATCH,!?18 F J=1:1:44 W "-"
 W !! S PG=PG+1
 Q
 ;
WRTINFO ;WRITE FSMB DATA FOR ONE APPLICANT
 D:$Y+11>IOSL HEAD S VAR=^DIZ(131000,PHYDA,0),SSN=$P(VAR,"^",4)
 W !?5,NUM,".",?10,"Name:  ",NM,!?10,"Other Names Used:  ",$P(VAR,"^",2),!?10,"DOB:  " S Y=$P(VAR,"^",3) D D^DIQ W Y,!?10,"Med. School Attended:  ",$P(VAR,"^",5),!?10,"Year of Graduation:  " S Y=$P(VAR,"^",6) D D^DIQ W Y
 W !?10,"Social Security #:  ",$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9) S NUM=NUM+1
 F STN=0:0 S STN=$O(^DIZ(131000,PHYDA,3,STN)) Q:'STN  S INFO=^DIZ(131000,PHYDA,3,STN,0) Q:$P(INFO,"^",3)'=BATCH  W !?10,"Submitted by: ",$P(^DIZ(1300002,$P(INFO,"^"),0),"^") S Y=$P(INFO,"^",2) D D^DIQ W ?40,"On: ",Y,!
 Q
 ;
SHODT S FMDT=$P($P(^DIZ(131001,B,0),"^"),".") S TODT=$P($P(^DIZ(131001,B,0),"^",2),".") S TYP=$P(^DIZ(131001,B,0),"^",3)
 W !,"Batch #: ",B,?15,"From: " S Y=FMDT D D^DIQ W Y,?40,"To: " S Y=TODT D D^DIQ W Y,?62,"Type: ",TYP
 Q
 ;
