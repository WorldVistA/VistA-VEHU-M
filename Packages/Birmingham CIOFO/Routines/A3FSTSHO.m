A3FSTSHO ;PTD/BHAM ISC-Show Applicants Submitted by VAMC by Batch ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC; 8/3/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 ;VARIABLES: VAMC is designated in USER FILE as: VAMC,CHIEF OF STAFF; STNO - Station number; STPTR - Station pointer number; EDT - End date for batch; BDT - Beginning date for batch; BATCH - batch number; STNM - Station name.
 I '$D(^DIZ(133201,DUZ,0)) G BAD
INTRO W !!,"Greetings ",$P($P(^DIC(3,DUZ,0),"^"),","),":",!
 S STNO=$P(^DIZ(133201,DUZ,0),"^",2),STPTR=$O(^DIZ(1300002,"C",STNO,0)),STNM=$P(^DIZ(1300002,STPTR,0),"^")
 W !,"This option prints a list of all FSMB applicants you have",!,"entered for a selected date range.  You will choose the date",!,"range by selecting a batch number.",!
 I $O(^DIZ(131001,"AEND",DT)) S FSMBDT=$O(^DIZ(131001,"AEND",DT)),CURBAT=$O(^DIZ(131001,"AEND",FSMBDT,0)) I CURBAT'="" W !,"The CURRENT batch number for which data is being collected is number ",CURBAT,".",!!
 S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("S")="I $P(^(0),U,3)=""R""",DIC("A")="Select BATCH number: " D ^DIC K DIC G:Y<0 END S BATCH=+Y
 I '$O(^DIZ(131000,"ABATCH",(BATCH-1))) W !,"No entries have been made for this batch number.",! G END
 S BDT=$P(^DIZ(131001,BATCH,0),"^"),EDT=$P(^(0),"^",2)
BATCH F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA)) Q:'PHYDA  F ST=0:0 S ST=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA,ST)) Q:'ST  I ST=STPTR D LOCAL
 I $O(LOC(0))="" W !!,STNM,":",!,"You have not entered any applicants names for batch number ",BATCH,".",! G END
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO W @IOF W !?20,"FSMB APPLICANTS SUBMITTED BY ",STNM,!!,"Batch number: ",BATCH,!,"Date range from " S Y=$P(BDT,".") D D^DIQ W Y,!,"through " S Y=$P(EDT,".") D D^DIQ W Y,!!
 W !,"Applicant Name:",?45,"SSN:",?60,"Date Submitted:",! F J=1:1:80 W "-"
 S NM="" F J=0:0 S NM=$O(LOC(NM)) Q:NM=""  S SSN=$P(LOC(NM),"^"),SDT=$P(LOC(NM),"^",2) W !,NM,?40,$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9) S Y=SDT D D^DIQ W ?60,Y
 W !!,"that's all..." W:$E(IOST)'="C" @IOF X ^%ZIS("C") G END
 ;
BAD W !!,"Your access code is incorrect.",!,"Please contact the RD's development staff at the Troy ISC -",!,"FTS 562-4307"
END K BATCH,BDT,CURBAT,EDT,FSMBDT,J,LOC,NM,PHYDA,POP,SDT,SSN,ST,STNM,STNO,STPTR,X,Y,%
 Q
 ;
LOCAL S NM=$P(^DIZ(131000,PHYDA,0),"^"),LOC(NM)=$P(^DIZ(131000,PHYDA,0),"^",4)_"^"_$P(^DIZ(131000,PHYDA,3,ST,0),"^",2)
 Q
 ;
