SDACS0 ;ALB/BOK - EXTERNAL PACKAGE CALL TO ADD CODES ;3/18/92  14:23
 ;;5.3;Scheduling;;Aug 13, 1993
 ;;MAS VERSION 5.1;;**7**;
 ;Parameter check - continues to SDACS1 for update
SET D DT^DICRW S SDERR=1,(SDCPTCT,SDCTR,SDSCCT)=0,SDMSG=$S($D(ZTQUEUED):0,'$D(SDMSG):0,1:SDMSG) K SDSD
 I "0SCB"'[SDMSG S SDMSG=0
SETERR I $S('$D(DUZ):1,'DUZ:1,'$D(DFN):1,'$D(SDIV):1,'$D(SDC):1,'$D(SDATE):1,'$D(SDCTYPE):1,1:0) S SDEMSG="All necessary parameters are not defined - nothing " D ERR:SDMSG'=0 G CLEAN
 S VAINDT=SDATE D ADM^VADPT2 K VAINDT G:VADMVT CLEAN
 I "SCB"'[SDCTYPE S SDEMSG="Invalid Stop Code Type - nothing " D ERR:SDMSG'=0 G CLEAN
 I "CB"[SDCTYPE,$D(SDCPT)'>9 S SDEMSG="Procedure array not defined - nothing " D ERR:SDMSG'=0 G CLEAN
 I '$O(^DG(40.8,"AD",SDIV,0)) S SDERR=1,SDIV=-1
 E  S SDIV=$O(^DG(40.8,"AD",SDIV,0))
 I SDIV=-1 S SDEMSG="Invalid Division - No credits " D ERR:SDMSG'=0 G CLEAN
 I SDATE>DT S SDEMSG="Stop Codes can not be entered for future dates - nothing " D ERR:SDMSG'=0 G CLEAN
 I '$D(^DPT(DFN,0)) S SDEMSG="Invalid patient - No credits " D ERR:SDMSG'=0 G CLEAN
 I $D(^SDV("ADT",DFN,$P(SDATE,"."))) S DA(1)=+^SDV("ADT",DFN,$P(SDATE,".")),IX=0 F IJ=0:1 S IX=$O(^SDV(DA(1),"CS","B",IX)) Q:IX'>0!(IJ=15)
 I $D(IJ),IJ S SDSCCT=IJ I SDSCCT'<15 D EXCESS G CLEAN
APPT ;set appt type - appt type 10=COMPUTER GENERATED
 ;check if any comp & pen appts exits for date and patient. 
 S SDCOMP=0,X1=SDATE,X2="-3" D C^%DTC S SDD1=X,SDD=SDD1-.1 K X,%H,X1,X2 ;search last 3 days + Today
 I $D(^SDV("C",DFN)) F  S SDD=$O(^SDV("C",DFN,SDD)) Q:SDD'>0!($P(SDD,".")>SDATE)!(SDCOMP)  S SDI=0 F  S SDI=$O(^SDV(SDD,"CS",SDI)) Q:SDI'>0!(SDCOMP)  S SDNODE=$P($G(^(SDI,0)),U,5) S:SDNODE=1 SDCOMP=1
 I 'SDCOMP,$D(^DPT(DFN,"S")) S SDD=SDD1-.1 F  S SDD=$O(^DPT(DFN,"S",SDD)) Q:SDD'>0!(SDCOMP)!($P(SDD,".")>SDATE)  S SDNODE=$P($G(^(SDD,0)),U,16) S:SDNODE=1 SDCOMP=1
 K SDD,SDD1,SDI,SDNODE I SDCOMP S SDAPTYP=10 G ^SDACS1
 ;if no comp and pen appts, try to determine based on eligibility
 S SDAPTYP=0 D ELIG^VADPT I VAERR!'$D(VAEL(1)) S SDAPTYP=10 G ^SDACS1
 S SDFLAG=$S(+VAEL(1)=9:8,+VAEL(1)=13:7,+VAEL(1)=14:4,1:0) I $D(VAEL(1))=11 I $D(VAEL(1,9))!($D(VAEL(1,13)))!($D(VAEL(1,14)))!(SDFLAG) S SDAPTYP=10 G ^SDACS1
 S SDAPTYP=$S($D(VAEL(1))=1&(SDFLAG):SDFLAG,1:9)
 G ^SDACS1 ;Continue
CLEAN K SDA,SDAPTYP,SDB,SDCOMP,SDCPTCT,SDCTR,SDEMSG,SDF,SDFDT,SDFLAG,SDP,SDSCCT,DA,DIC,DIE,DR,IJ,IX,VADMVT,VAEL,VAERR,Y K:SDMSG=0 SDMSG Q
ERR W !,*7,SDEMSG,"recorded in Scheduling module" Q
EXCESS S SDEMSG="Fifteen Stop Codes for this date on record - no more can be " D ERR:SDMSG'=0 Q
