A3FHIRE ;PTD/BHAM ISC-Enter Date Applicant Hired by Station ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
STN W ! S DIC="^DIZ(1300002,",DIC(0)="QEAM",DIC("A")="Select Station: " D ^DIC K DIC S STPTR=+Y G:Y<0 END
NAME W ! S DIC="^DIZ(131000,",DIC(0)="QEAM",DIC("A")="Select Applicant Name: " D ^DIC K DIC S PHYDA=+Y G:Y<0 AGAIN
 I '$D(^DIZ(131000,PHYDA,3,STPTR)) W !!?5,"Station did not submit this name.",!! K PHYDA G NAME
 S LOC=^DIZ(131000,PHYDA,1) W !,"Date sent to FSMB: " S Y=$S($P(LOC,"^")'="":$P(LOC,"^"),1:"NOT ENTERED") D:Y'="NOT ENTERED" D^DIQ W Y,!,"Date returned from FSMB: "
 S Y=$S($P(LOC,"^",2)'="":$P(LOC,"^",2),1:"NOT ENTERED") D:Y'="NOT ENTERED" D^DIQ W Y
 W !,"FSMB Status: " S ST=$P(LOC,"^",3) S:ST'="" EXP=$P($P(";"_$P(^DD(131000,8,0),"^",3),";"_ST_":",2),";") W $S(ST="":"NOT ENTERED",1:EXP)
DATE W ! S DIE="^DIZ(131000,PHYDA,3,",DA=STPTR,DA(1)=PHYDA,DR="3" D ^DIE K DIE
 G NAME
 ;
AGAIN ;ASK USER IF ANOTHER STATION'S DATA NEEDS TO BE INPUT
 R !!,"Do you wish to enter data for another station? YES// ",ANS:DTIME S:ANS="" ANS="Y" G:'$T!("^Nn"[$E(ANS)) END
 I "YyNn"'[$E(ANS) W *7,!?5,"Answer ""yes"" or <return> to process another station.",!?5,"Answer ""no"" to quit." G AGAIN
 I "Yy"[$E(ANS) K STPTR,PHYDA,LOC,ST,EXP,X,Y,ANS G STN
END K STPTR,PHYDA,LOC,ST,EXP,X,Y,ANS,DIC,DIE,DA,DR
 Q
 ;
