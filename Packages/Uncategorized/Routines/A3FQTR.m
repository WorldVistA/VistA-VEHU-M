A3FQTR ;PTD/BHAM ISC-Print Quarterly VACO Report ; 07/12/89 8:15
 ;;CLASS III RD3 SOFTWARE V1.0;
 W !!,"This option will print data for the Quarterly VACO Report.",!!,"Select the batch numbers to be searched to determine the",!,"total number of physicians screened.",!!
DIC S DIC="^DIZ(131001,",DIC(0)="QEAN",DIC("A")="Include batch number: " D ^DIC K DIC G:Y<0 DATES S BATCH(+Y)="" G DIC
DATES I '$O(BATCH(0)) W !,"NO BATCH SELECTED!",! G END
BDT W !!,"Select the date range to be used to determine the",!,"total number of FSMB screens employed.",!! S %DT="AEX",%DT("A")="Enter beginning date: " D ^%DT K %DT G:Y<0 END S BDT=Y W !
EDT S %DT="AEX",%DT("A")="Enter ending date: " D ^%DT K %DT G:Y<0 END S EDT=Y
SCREEN S (TOT,NDAF,YDAF,FRR,UNMK)=0 F B=0:0 S B=$O(BATCH(B)) Q:'B  F PHYDA=0:0 S PHYDA=$O(^DIZ(131000,"ABATCH",B,PHYDA)) Q:'PHYDA  D CALC
EMPLOY S EMP=0 F L=(BDT-.1):0 S L=$O(^DIZ(131000,"AHRDT",L)) Q:'L!(L>EDT)  F M=0:0 S M=$O(^DIZ(131000,"AHRDT",L,M)) Q:'M  F N=0:0 S N=$O(^DIZ(131000,"AHRDT",L,M,N)) Q:'N  D HIRE
DEV W !! K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO
RPT W @IOF S Y=DT D D^DIQ W !?50,"DATE PRINTED: ",Y
 W !!?25,"DATA FOR VACO QUARTERLY REPORT",!?25,"PHYSICIAN SCREENING AND HIRING",! F J=1:1:80 W "-"
 W !!?30,"PHYSICIANS SCREENED",!?33,"BATCH NUMBERS:",!?30 F J=0:0 S J=$O(BATCH(J)) Q:'J  W J W:$O(BATCH(J)) ", "
 W !?20 F J=1:1:20 W "- "
 W !!?15,"# with 'No Disciplinary Action Found': ",?60,$J(NDAF,3),!?15,"# with 'Disciplinary Action Found': ",?60,$J(YDAF,3),!?15,"# with 'Further Review Required': ",?60,$J(FRR,3),!?15,"# with 'FSMB Status' null (unmarked): ",?60,$J(UNMK,3)
 W !?57 F J=1:1:9 W "="
 W !!?15,"TOTAL PHYSICIANS SCREENED =====> ",?60,$J(TOT,3)
 I $O(DISP(0)) W !!!?25,"DISCIPLINARY ACTION FOUND ON:" F J=0:0 S J=$O(DISP(J)) Q:'J  W !?20,$P(^DIZ(131000,J,0),"^")
 I $O(REV(0)) W !!!?26,"FURTHER REVIEW REQUIRED ON:" F J=0:0 S J=$O(REV(J)) Q:'J  W !?20,$P(^DIZ(131000,J,0),"^")
 I $O(HIT(0)) W !!!?32,"'HITS' EMPLOYED:" F J=0:0 S J=$O(HIT(J)) Q:'J  F K=0:0 S K=$O(HIT(J,K)) Q:'K  W !?20,$P(^DIZ(131000,J,0),"^"),"     -     ",($P(^DIZ(1300002,K,0),"^"))
 I $O(HRVL(0)) W !!!?21,"'HIRE DATE' COMES BEFORE FSMB RESULTS:" F J=0:0 S J=$O(HRVL(J)) Q:'J  F K=0:0 S K=$O(HRVL(J,K)) Q:'K  W !?20,$P(^DIZ(131000,J,0),"^"),"     -     ",($P(^DIZ(1300002,K,0),"^"))
 W @IOF,!!!?22,"TOTAL FSMB SCREENS EMPLOYED ==> ",?55,$J(EMP,3),! S Y=BDT D D^DIQ W ?23,"FROM: ",Y S Y=EDT D D^DIQ W " TO: ",Y,! F J=1:1:80 W "-"
 S CNT=0,LIT="" F I=0:0 S LIT=$O(HIRE(LIT)) Q:LIT=""  S CNT=CNT+1,STN=$P(LIT,"*"),NAM=$P(LIT,"*",2),EMPDT=$P(LIT,"*",3) W:$Y>(IOSL-6) @IOF W !,CNT,".",?5,STN,?20,NAM S Y=EMPDT D D^DIQ W ?55,Y
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
END K B,BATCH,BDT,CNT,DISP,EDT,EMP,EMPDT,FRR,HIRE,HIT,HRVL,I,INFO,J,K,L,LIT,LOC,M,N,NAM,NDAF,PHYDA,POP,REV,ST,STN,TOT,UNMK,X,Y,YDAF
 Q
 ;
CALC S LOC=^DIZ(131000,PHYDA,1),ST=$P(LOC,"^",3) Q:$P(LOC,"^",2)=""  Q:$P(LOC,"^",2)<$P(LOC,"^")
 S:ST="" UNMK=UNMK+1 S:ST=0 NDAF=NDAF+1 S:ST=1 YDAF=YDAF+1,DISP(PHYDA)="" S:ST=2 FRR=FRR+1,REV(PHYDA)="" S TOT=TOT+1
 Q
 ;
HIRE S EMP=EMP+1,INFO=^DIZ(131000,M,1) S:($P(INFO,"^",3))=1 HIT(M,N)="" S:L<($P(INFO,"^",2)) HRVL(M,N)="" S HIRE($P(^DIZ(1300002,N,0),"^")_"*"_$P(^DIZ(131000,M,0),"^")_"*"_L)=""
 Q
 ;
