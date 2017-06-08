A3FSMBIN ;PTD/BHAM ISC-Incoming FSMB Entries - Print Station Letters/Lists ; 07/12/89 8:15
 W !!,"This option allows you to enter FSMB results",!,"for a selected batch.  It also generates letters",!,"to be sent to individual stations.",!,"Select the batch number you wish to work with."
 W !!,"The most recent batch numbers are:",! S CNT=0 F ID=0:0 S ID=$O(^DIZ(131001,"AINV",ID)) Q:'ID  S CNT=CNT+1 F B=0:0 S B=$O(^DIZ(131001,"AINV",ID,B)) Q:'B!(CNT>10)  D SHODT
 W ! S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("A")="Select BATCH number: " D ^DIC K DIC G:Y<0 END S BATCH=+Y
 I '$O(^DIZ(131000,"ABATCH",(BATCH-1))) W !,"No entries have been submitted for this batch number.",! G END
 I $P(^DIZ(131001,BATCH,0),"^",4)="" W !!,"Use 'Outgoing FSMB Entries'." G END
ASK W !!,"You wish to enter FSMB results for batch ",BATCH," now? " R ANS:DTIME S:'$T!("^"[ANS) ANS="N" I "YyNn"'[$E(ANS) W !!,"Answer ""yes"" if you wish to continue; ""no"" to quit." G ASK
 G:"Nn"[$E(ANS) END
CHOOSE ;HOW IS BATCH TO BE MARKED
 W !!,"At this time you may choose to: ",!!?5,"(1) Mark the entire batch as 'No Disciplinary Action Found'.",!!?5,"(2) Mark selected names as 'Further Review Required',",!?9,"and remaining names as 'No Disciplinary Action Found'."
 W !!?5,"(3) Mark selected names as 'Disciplinary Action Found',",!?9,"and remaining names as 'No Disciplinary Action Found'.",!!,"Select ""1"", ""2"", or ""3"": " R ST:DTIME G:'$T!("^"[ST) END
 I ST'?1N!(ST<1)!(ST>3) W !!,*7,"You MUST answer by selecting ""1"", ""2"", or ""3""." G CHOOSE
 I ST=2!(ST=3) D DIC
 F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA)) Q:'PHYDA  F STPTR=0:0 S STPTR=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA,STPTR)) Q:'STPTR  D STUFF
 S NUM=0 F J=0:0 S J=$O(LTR(J)) Q:'J  S NUM=NUM+1
 I $O(LTR(0)) W !!,$P(^DIZ(1100001,FSMBR,0),U,4),", you will need letterhead paper for ",NUM," station letter(s).",!!
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO S Y=DT D D^DIQ S TODAY=Y
 F S=0:0 S S=$O(LTR(S)) Q:'S  F P=0:0 S P=$O(LTR(S,P)) Q:'P  I LTR(S,P)'=0 S TYP(S)=LTR(S,P)
 F Z=0:0 S Z=$O(LTR(Z)) Q:'Z  D LETTER
 W @IOF F Z=0:0 S Z=$O(LTR(Z)) Q:'Z  S PG=1 F W=0:0 S W=$O(LTR(Z,W)) D:'W HEAD,LIST Q:'W  S LOC($P(^DIZ(131000,W,0),"^"))=W
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
END K ANS,B,BATCH,CNT,FMDT,ID,J,LTR,NUM,P,PHYDA,POP,RES,S,ST,STPTR,TODAY,TYP,TODT,X,Y,Z,K,LOC,NM,PG,PROV,SSN,VAR,W
 Q
 ;
SHODT S FMDT=$P($P(^DIZ(131001,B,0),"^"),".") S TODT=$P($P(^DIZ(131001,B,0),"^",2),".") S TYP=$P(^DIZ(131001,B,0),"^",3)
 W !,"Batch #: ",B,?15,"From: " S Y=FMDT D D^DIQ W Y,?40,"To: " S Y=TODT D D^DIQ W Y,?62,"Type: ",TYP
 Q
 ;
DIC ;ASK NAME OF APPLICANT TO BE MARKED AS FRR OR DAF
 S DIC="^DIZ(131000,",DIC(0)="QEAM",DIC("S")="I $D(^DIZ(131000,""ABATCH"",BATCH,Y))",DIC("A")="Select Applicant Name: " D ^DIC K DIC Q:Y<0  S DA=+Y
 W !!,"FSMB Status Code Marked!",! S $P(^DIZ(131000,DA,1),"^",2)=DT,$P(^(1),"^",3)=$S(ST=2:2,1:1)
 K DIC,DA G DIC
 ;
STUFF ;STUFF DATE AND 'FSMB STATUS'
 I $P(^DIZ(131000,PHYDA,1),"^",3)'="" S LTR(STPTR,PHYDA)=$P(^DIZ(131000,PHYDA,1),"^",3) Q
 S $P(^DIZ(131000,PHYDA,1),"^",2)=DT,$P(^DIZ(131000,PHYDA,1),"^",3)=0,LTR(STPTR,PHYDA)=0
 Q
 ;
LETTER ;DETERMINE LETTER TO PRINT
 I '$D(TYP(Z)) D ^A3FLTR1 Q
 D:ST=2 ^A3FLTR2 D:ST=3 ^A3FLTR3
 I ST=3 D ^A3FLTR3
 Q
 ;
HEAD ;HEADER FOR LIST
 W @IOF W !!?5,TODAY,?69,"Page ",PG,!!?18,"LICENSURE SCREENING FOR PHYSICIAN APPLICANTS",!?30,"Submitted by: ",$P(^DIZ(1300002,Z,0),"^",6),!?34,"Batch #:",BATCH,!?18 F J=1:1:44 W "-"
 W !! S PG=PG+1
 Q
 ;
LIST ;PRINT APPLICANT LISTING
 S NM="" F K=0:0 S NM=$O(LOC(NM)) Q:NM=""  S PROV=$P(LOC(NM),"^") D WRTINFO
 K LOC
 Q
 ;
WRTINFO ;WRITE FSMB DATA
 D:$Y+11>IOSL HEAD S VAR=^DIZ(131000,PROV,0),SSN=$P(VAR,"^",4)
 W !?15,"Name:  ",NM,!?15,"Other Names Used:  ",$P(VAR,"^",2),!?15,"DOB:  " S Y=$P(VAR,"^",3) D D^DIQ W Y,!?15,"Med. School Attended:  ",$P(VAR,"^",5),!?15,"Year of Graduation:  " S Y=$P(VAR,"^",6) D D^DIQ W Y
 W !?15,"Social Security #:  ",$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9),!
 Q
 ;
