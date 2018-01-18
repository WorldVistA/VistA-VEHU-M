A3FBNO ;PTD/BHAM ISC-Print Stations that have Submitted NO Applicants for a Batch ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !,"This option will show stations that have not submitted",!,"applicant names for a selected batch number.",!!,"The most recent batch numbers are:",!
 S CNT=0 F ID=0:0 S ID=$O(^DIZ(131001,"AINV",ID)) Q:'ID  S CNT=CNT+1 F B=0:0 S B=$O(^DIZ(131001,"AINV",ID,B)) Q:'B!(CNT>10)  I $D(^DIZ(131001,"ATYPE","R",B)) D SHODT
 W ! S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("S")="I $P(^(0),U,3)=""R""",DIC("A")="Select BATCH number: " D ^DIC K DIC G:Y<0 END S BATCH=+Y
 I '$O(^DIZ(131000,"ABATCH",(BATCH-1))) W !,"No entries have been submitted by ANY station for this batch number.",! G END
 S BDT=$P(^DIZ(131001,BATCH,0),"^"),EDT=$P(^(0),"^",2)
BATCH F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA)) Q:'PHYDA  F ST=0:0 S ST=$O(^DIZ(131000,"ABATCH",BATCH,PHYDA,ST)) Q:'ST  S LOC(ST)=""
 K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO W @IOF W !?19,"STATIONS WITH NO FSMB APPLICANTS SUBMITTED",!!,"Batch number: ",BATCH S Y=DT D D^DIQ W ?54,"Date printed: ",Y,!,"Date range from " S Y=$P(BDT,".") D D^DIQ W Y,!,"through " S Y=$P(EDT,".") D D^DIQ W Y,! F J=1:1:80 W "-"
 F J=1:1:21 I '$D(LOC(J)) W !,$P(^DIZ(1300002,J,0),"^")
 W:$E(IOST)'="C" @IOF X ^%ZIS("C") G END
 ;
END K %,B,BDT,BATCH,CNT,EDT,FMDT,ID,J,LOC,PHYDA,POP,ST,TODT,X,Y
 Q
 ;
SHODT S FMDT=$P($P(^DIZ(131001,B,0),"^"),".") S TODT=$P($P(^DIZ(131001,B,0),"^",2),".")
 W !,"Batch #: ",B,?15,"From: " S Y=FMDT D D^DIQ W Y,?40,"To: " S Y=TODT D D^DIQ W Y
 Q
 ;
