A3FEDIT ;PTD/BHAM ISC-Change FSMB Results from FRR to NDAF or DAF - Print Station Letters ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC; 7/27/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !!,"This option allows you to edit FSMB results",!,"for selected applicant names.  It also generates the letter",!,"to be sent to individual stations."
NAME W !! S DIC="^DIZ(131000,",DIC(0)="QEAM",DIC("A")="Select Applicant Name: " D ^DIC K DIC G:Y<0 DEV S PHYDA=+Y
 I $P(^DIZ(131000,PHYDA,1),"^",3)'="2" W !!,"Sorry, you may not edit this applicant.",!,"The 'FSBM Status' is not marked 'Further Review Required'." G NAME
STATION S CNT=0 F J=0:0 S J=$O(^DIZ(131000,PHYDA,3,J)) Q:'J  S CNT=CNT+1
 I CNT>1 S DIC="^DIZ(131000,PHYDA,3,",DIC(0)="QEAM",DIC("A")="Select Submitting Station: " D ^DIC K DIC G:Y<0 NAME S STPTR=+Y
 I CNT=1 S STPTR=$O(^DIZ(131000,PHYDA,3,0))
 S ORGDT=$P(^DIZ(131000,PHYDA,1),"^",2) I ORGDT="" W !!,"This entry contains no 'Date From FSBM'.",!,"You must edit using the 'Enter/Edit FSMB Entries' option.",!! G NAME
 W !!,"FSMB Status may be changed to:",!!?5,"(1) No Disciplinary Action Found",!?20,"OR",!?5,"(2) Disciplinary Action Found"
STATUS R !!,"Select ""1"" or ""2"": ",ST:DTIME G:'$T!("^"[ST) NAME I ST'?1N!(ST<1)!(ST>2) W !!,*7,"You MUST answer by selecting ""1"" or ""2""." G STATUS
 ;RESET 'DATE FROM FSMB' AND 'FSMB STATUS' & CREATE LOCAL LETTER ARRAY
 S $P(^DIZ(131000,PHYDA,1),"^",2)=DT,$P(^(1),"^",3)=$S(ST=2:1,1:0) S LTR(STPTR,PHYDA,ORGDT,ST)="" W !!,"FSMB Status Code Edited!",! K PHYDA,STPTR,ORGDT,ST G NAME
 ;
DEV G:'$O(LTR(0)) END K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO S Y=DT D D^DIQ S TODAY=Y
 F S=0:0 S S=$O(LTR(S)) Q:'S  F P=0:0 S P=$O(LTR(S,P)) Q:'P  F ODT=0:0 S ODT=$O(LTR(S,P,ODT)) Q:'ODT  F ST=0:0 S ST=$O(LTR(S,P,ODT,ST)) Q:'ST  D LETTER
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
END K CNT,I,J,LTR,ODT,ORGDT,P,PHYDA,POP,S,ST,STPTR,TODAY,U,X,Y
 Q
 ;
LETTER ;PRINT LETTER CHANGING STATUS FROM FURTHER REVIEW TO DISC. ACTION OR NO DISC. ACTION
 W @IOF W !!!!!!!!!!!!?15,TODAY,!!!?15,"Director (00)",!?15,"VA Medical Center",!?15,$P(^DIZ(1300002,S,0),"^",6),", ",$P(^DIC(5,($P(^DIZ(1300002,S,3),"^")),0),"^",2),"  ",$P(^DIZ(1300002,S,3),"^",2)
ONE W !!?15,"SUBJ:  Licensure Screening for Physician Applicants",!!?15,"1.  On " S Y=ODT D D^DIQ W Y," we notified you that the FSMB",!?15,"required additional time to do further screening on",!?15,"the following physician applicant:"
 W !!?25,$P(^DIZ(131000,P,0),"^"),!!
 I ST=1 W ?15,"The FSMB has informed us that no disciplinary action",!?15,"has been noted on this applicant."
 I ST=2 W ?15,"The FSMB has informed us that disciplinary action has",!?15,"been noted on this applicant.  A copy of their report",!?15,"is enclosed."
TWO W !!?15,"2.  The FSMB reports only those disciplinary actions resulting",!?15,"from actions taken by medical licensing and disciplinary",!?15,"boards or similar official sources.  Therefore, you are"
 W !?15,"reminded that screening applicants with the Federation of",!?15,"State Medical Boards does not abrogate the Chief of Staff's",!?15,"responsibility to verify with State licensing boards all"
 W !?15,"medical licenses held by physician applicants prior to",!?15,"appointment (see DM&S Circular 10-86-23)."
 W !!!!!?15,$P(^DIZ(1100001,FSMBR,0),U,3),!?15,"Associate Deputy Regional Director" I ST=2 W !!?15,"Enclosure"
 Q
 ;
