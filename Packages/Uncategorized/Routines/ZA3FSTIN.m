A3FSTIN1 ;PTD/BHAM ISC-VAMC Inputs Data for FSMB Requests ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
 ;VARIABLES: VAMC is designated in USER FILE as: VAMC,CHIEF OF STAFF; STNO - Station number; STPTR - Station pointer number; FSMBDT - Today's date as stored in 'DT'; EDT - End date for batch; BDT - Beginning date for batch; BATCH - batch number.
 ;NM - Applicant's name; ONM - Other name used by applicant, i.e. maiden name; DOB - Date of birth; SSN - Social security number; MS - Medical school attended by applicant; YR - Year applicant graduated from medical school; STNM - Station name.
 I '$D(^DIZ(133201,DUZ,0)) G BAD
INTRO W !!,"Greetings ",$P($P(^DIC(3,DUZ,0),"^"),","),":",!
 S STNO=$P(^DIZ(133201,DUZ,0),"^",2),STPTR=$O(^DIZ(1300002,"C",STNO,0)),FSMBDT=DT,STNM=$P(^DIZ(1300002,STPTR,0),"^")
 I '$O(^DIZ(131001,"AEND",FSMBDT)) W !,"Batch numbers for this date range have not been set up yet.",!,"Contact Elona Kisala at the RD's office - FTS 947-6888." G END
 S EDT=$O(^DIZ(131001,"AEND",FSMBDT)),BATCH=$O(^DIZ(131001,"AEND",EDT,0)),BDT=$P(^DIZ(131001,BATCH,0),"^")
 W !!,"You will be entering data for batch number: ",BATCH,!,"The date range for this batch is",!,"from " S Y=$P(BDT,".") D D^DIQ W Y,!,"through " S Y=$P(EDT,".") D D^DIQ W Y,!!,"PLEASE enter data in ALL CAPITAL LETTERS."
 ;
NAME W !!!,"Enter name in this format: LAST<comma><space>FIRST<space>MIDDLE",! R "Enter applicant name: ",NM:DTIME I '$T!("^"[NM) W *7,!?30,"<NO NAME ENTERED>" G AGAIN
 I $L(NM)>30!($L(NM)<3) W !?5,"Name must be 3-30 characters in length." G NAME
 I NM'?1U.U1", "1U.UP." " W !?5,"Incorrect FORMAT; use UPPER CASE; try again." G NAME
 ;
OTHER R !!,"OTHER name used by applicant: ",ONM:DTIME S:ONM="" ONM="N/A" I '$T!("^"[ONM) W *7,!?30,"<ENTRY DELETED>" G AGAIN
 I $L(ONM)>30!($L(ONM)<2) W !?5,"Name must be 2-30 characters in length." G OTHER
 I ONM'="N/A" I ONM'?1U.U1", "1U.UP." " W !?5,"Use UPPER CASE!",!?5,"Format: LAST<comma><space>FIRST<space>MIDDLE" G OTHER
 ;
DOB S %DT="AEPX",%DT("A")="Enter applicant's date of birth: " D ^%DT K %DT W:Y<0 *7,!?30,"<ENTRY DELETED>" G:Y<0 AGAIN S CDT=Y X ^DD("DD") S DOB=Y
 ;
SSN W !!,"Enter SSN as 9 CONTINUOUS digits: NO dashes.",! R "Enter applicant's SSN: ",SSN:DTIME I '$T!("^"[SSN) W *7,!?30,"<ENTRY DELETED>" G AGAIN
 I SSN'?9N W !?5,"Incorrect FORMAT: enter ONLY numbers." G SSN
 ;
MEDSCH W !!,"Enter medical school attended by applicant.  Abbreviate",!,"UNIVERSITY, SCHOOL, COLLEGE, and MEDICINE if possible."
 R !,"Medical school attended: ",MS:DTIME I '$T!("^"[MS) W *7,!?30,"<ENTRY DELETED>" G AGAIN
 I $L(MS)>45!($L(MS)<2) W !?5,"Answer must be 2-45 characters in length." G MEDSCH
 ;
GRAD W !!,"Enter YEAR applicant graduated from medical school." R !,"YEAR of graduation: ",YR:DTIME I '$T!("^"[YR) W *7,!?30,"<ENTRY DELETED>" G AGAIN
 I YR'?4N W !?5,"Answer must be 4 digits only, i.e. '1973'." G GRAD
 S Y=$E(DT,1,3) X ^DD("DD") I YR>Y W !?5,"Future dates not accepted." G GRAD
 S Y=$E(CDT,1,3) X ^DD("DD") I (YR)'>Y W !?5,"Year of graduation must be greater than date of birth!" G GRAD
 ;
SHOW W !!!,"This is the data you have entered for this applicant:",!,"Name: ",NM,!,"Other names used: ",ONM,!,"Date of birth: ",DOB,!,"SSN: ",$E(SSN,1,3),"-",$E(SSN,4,5),"-",$E(SSN,6,9),!,"Med. School: ",MS,!,"Year of graduation: ",YR
 S %DT="PX",X=DOB D ^%DT K %DT S DOB=Y S %DT="",X=YR D ^%DT K %DT S YR=Y
 ;
 ;ALL VARIABLES DEFINED; READY TO CREATE ENTRY IN FSMB FILE.
 G ^A3FSTIN2
 ;
AGAIN R !!,"Do you wish to start again? ",AGN:DTIME S:'$T!("^"[AGN) AGN="N" I "YyNn"'[$E(AGN) W !!,"Answer ""yes"" to start again; ""no"" to quit." G AGAIN
 I "Yy"[$E(AGN) K NM,ONM,DOB,SSN,NS,YR G NAME
 G END
 ;
BAD W !!,"Your access code is incorrect.",!,"Please contact the RD's development staff at the Birmingham ISC -",!,"Commercial # (205) 939-2200"
END K AGN,BATCH,BDT,CDT,DA,DIC,DIE,DR,D0,DI,DQ,DOB,EDT,EDIT,FLG,FMDT,FSMBDT,LOC,MORE,MS,NM,ONM,PHYDA,SSN,STAT,STNM,STNO,STPTR,U,X,Y,YR,%
 Q
 ;
