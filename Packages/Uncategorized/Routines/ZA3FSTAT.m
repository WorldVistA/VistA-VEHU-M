A3FSTAT ;PTD/BHAM ISC-Print Status of FSMB Requests by VAMC by Batch ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
 ;VARIABLES: VAMC is designated in USER FILE as: VAMC,CHIEF OF STAFF; STNO - Station number; STPTR - Station pointer number; EDT - End date for batch; BDT - Beginning date for batch; BATCH - batch number; STNM - Station name.
 I '$D(^DIZ(133201,DUZ,0)) G BAD
INTRO W !!,"Greetings ",$P($P(^DIC(3,DUZ,0),"^"),","),":",!
 S STNO=$P(^DIZ(133201,DUZ,0),"^",2),STPTR=$O(^DIZ(1300002,"C",STNO,0)),STNM=$P(^DIZ(1300002,STPTR,0),"^")
 W !,"This option prints the STATUS of all FSMB applicants you have",!,"entered for a selected date range.  You will choose the date",!,"range by selecting a batch number.",!!,"The most recent batch numbers are:",!
 S CNT=0 F ID=0:0 S ID=$O(^DIZ(131001,"AINV",ID)) Q:'ID  S CNT=CNT+1 F B=0:0 S B=$O(^DIZ(131001,"AINV",ID,B)) Q:'B!(CNT>10)  I $D(^DIZ(131001,"ATYPE","R",B)) D SHODT
 W ! S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("S")="I $P(^(0),U,3)=""R""",DIC("A")="Select BATCH number: " D ^DIC K DIC G:Y<0 END S BATCH=+Y
 I '$O(^DIZ(131000,"ABATCH",(BATCH-1))) W !,"No entries have been made for this batch number.",! G END
 S BDT=$P(^DIZ(131001,BATCH,0),"^"),EDT=$P(^(0),"^",2)
BATCH F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA)) Q:'PHYDA  F ST=0:0 S ST=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA,ST)) Q:'ST  I ST=STPTR D LOCAL
 I $O(LOC(0))="" W !!,STNM,":",!,"You have not entered any applicants names for batch number ",BATCH,".",! G END
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO W @IOF W !?15,"STATUS OF FSMB APPLICANTS SUBMITTED BY ",STNM,!!,"Batch number: ",BATCH S Y=DT D D^DIQ W ?54,"Date printed: ",Y,!,"Date range from " S Y=$P(BDT,".") D D^DIQ W Y,!,"through " S Y=$P(EDT,".") D D^DIQ W Y,!!
 W !,"Applicant Name:",?33,"SSN:",?46,"TO FSMB:",?60,"FROM FSMB:",?73,"STATUS:",! F J=1:1:80 W "-"
 S NM="" F J=0:0 S NM=$O(LOC(NM)) Q:NM=""  D WRTLN
 W !!,"Status Codes:",!,"0 ==> No disciplinary action found.",!,"1 ==> Disciplinary action found.",!,"2 ==> Further review required.",!,"Null ==> No data entered."
 W !!,"that's all..." W:$E(IOST)'="C" @IOF X ^%ZIS("C") G END
 ;
BAD W !!,"Your access code is incorrect.",!,"Please contact the RD's development staff at the Birmingham ISC -",!,"Commercial # (205) 939-2200"
END K B,BATCH,BDT,CNT,CURBAT,EDT,FMDT,FSMBDT,ID,J,LOC,NM,PHYDA,POP,SDT,SSN,ST,STAT,STNM,STNO,STPTR,TODT,VAR,X,Y,%
 Q
 ;
LOCAL S NM=$P(^DIZ(131000,PHYDA,0),"^") S VAR=$S($D(^DIZ(131000,PHYDA,1)):^(1),1:"") S LOC(NM)=$P(^DIZ(131000,PHYDA,0),"^",4)_"^"_$P(VAR,"^")_"^"_$P(VAR,"^",2)_"^"_$P(VAR,"^",3)
 Q
 ;
WRTLN S SSN=$P(LOC(NM),"^"),TODT=$P(LOC(NM),"^",2),FMDT=$P(LOC(NM),"^",3),STAT=$P(LOC(NM),"^",4) W !,NM,?33,$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 S:TODT'="" Y=TODT D:TODT'="" D^DIQ W ?46,$S(TODT'="":Y,1:"") S:FMDT'="" Y=FMDT D:FMDT'="" D^DIQ W ?60,$S(FMDT'="":Y,1:""),?76,STAT
 Q
 ;
SHODT S FMDT=$P($P(^DIZ(131001,B,0),"^"),".") S TODT=$P($P(^DIZ(131001,B,0),"^",2),".")
 W !,"Batch #:",B,?15,"From: " S Y=FMDT D D^DIQ W Y,?40,"To: " S Y=TODT D D^DIQ W Y
 Q
 ;
