A1BMCRP ;ALB/AAS - SCAN FILE 2 FOR NUMERICS IN 1ST PIECE ^(0) - 17-NOV-89
 ;;1.00
 ;
% S U="^",A1BMCNT=0
 W !!,"SCAN PATIENT FILE FOR NUMBERS IN NAME FIELD" S %=2 D YN^DICN G:%=2!(%=-1) END1
 I '% W !!?4,"Enter 'YES' to scan the entire patient file",!?4,"or 'NO' to abort" G %
 ;
 S DGPGM="START^A1BMCRP",DGVAR="U" D ZIS^DGUTQ K ZTSK G:POP END1
 ;
START ;Scan patient file for corruption
 U IO S A1BMCNT=0 D HDR
 S DFN=0 F I=0:0 S DFN=$O(^DPT(DFN)) Q:DFN<1  D CHK W:'$D(ZTSK) "."
 G END
 ;
CHK I '$D(^DPT(DFN,0)) W !,"Entry number ",DFN," in the patient file is missing the zeroth node",! Q
 S DGMES="",DGMES1="",DGNODE=^DPT(DFN,0) I +DGNODE>0 S DGMES="(NAME) "
 I $P(DGNODE,"^",22,29)'="" S DGMES=DGMES_"(TOO MANY PIECES) " 
 I $D(^DPT(DFN,1)) S DGMES1=DGMES1_"(EXTRA NODE) "
 S X=$P(DGNODE,"^") I X="" S DGMES=DGMES_"(NULL NAME) "
 I X]"",(X'?1U.ANP)!(X'[",")!('$D(^DPT("B",X,DFN))) S DGMES=DGMES_"(NAME FORMAT) "
 S X=$P(DGNODE,"^",2) I X]"",$L(X)>1!("MF"'[X) S DGMES=DGMES_"(BAD SEX) "
 S X=$P(DGNODE,"^",3) I X=""!(X'?7N) S DGMES=DGMES_"(DOB) "
 S X=$P(DGNODE,"^",4) I X]"",$L(X)>1!("EURDS"'[X) S DGMES=DGMES_"(*EMPOYMENT STATUS) "
 S X=$P(DGNODE,"^",5) I X]"",'$D(^DIC(11,X,0)) S DGMES=DGMES_"(MARITAL STATUS) "
 S X=$P(DGNODE,"^",6) I X]"",'$D(^DIC(10,X,0)) S DGMES=DGMES_"(RACE) "
 S X=$P(DGNODE,"^",8) I X]"",'$D(^DIC(13,X,0)) S DGMES=DGMES_"(RELIGIOUS PREF.) "
 S X=$P(DGNODE,"^",9) I X=""!($L(X)>10)!($L(X)<9)!(X'?9N."P") S DGMES=DGMES_"(SSN) "
 D:DGMES]"" WRT D:DGMES1]"" WRT1
 Q
WRT D:$Y>(IOSL-5) HDR1 W !,"Entry number ",DFN," in the patient file may have corrupt node - ",!?4,DGMES," ",DGMES1,!,"^DPT(",DFN,",0) = ",^DPT(DFN,0),!
 S A1BMCNT=A1BMCNT+1 Q
WRT1 D:$Y>(IOSL-5) HDR1 W !,"Entry number ",DFN," in the patient file has an unexpected ^(1) node",!,"^DPT(",DFN,",1) = ",$S($D(^DPT(DFN,1))#2:^(1),1:"Undetermined descendents"),! S:DGMES="" A1BMCNT=A1BMCNT+1
 Q
HDR S X="NOW",%DT="T" D ^%DT X ^DD("DD") S DGDATE=Y,DGPAGE=0
HDR1 S DGPAGE=DGPAGE+1 W @IOF,!,"CORRUPT PATIENT GLOBAL LISTING",?50,DGDATE,?70,"PAGE: ",DGPAGE
 W ! F J=1:1:IOM-1 W "-"
 W ! Q
END I A1BMCNT>0 W !!,"------------------------------------",!,"Total corrupt errors = ",A1BMCNT
 I A1BMCNT<1 W !!,"------------------------------------",!,"No corrupt nodes detected"
END1 W !! K A1BMCNT,DGPAGE,DGDATE,DFN,I,J,X K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK
