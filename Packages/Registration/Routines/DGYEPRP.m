DGYEPRP ;ALB/MTC - MAIN ROUTINE FOR EXTERNAL PEER REVIEW ; 01 Nov 94 / 8:56 AM
 ;;1.0; DGYE ;**4,6,9,14,17**;28 Apr 92
 ;
EN ;--entry point for EPRP
 ; Process:
 ;   o Get Month/Year to pull records.
 ;   o Build ^TMP global containing records for EPRP.
 ;   o Generate Report.
 ;
 N DGYEDT,DGYECNT
 S U="^" D HOME^%ZIS
 W @IOF,"     External Peer Review Program.",!!
 S DGYEDT=$$GETMY I 'DGYEDT W !!,">>> No Month/Year Selected...Try again later. " G ENQ
 D PRINT(DGYEDT)
ENQ K ^TMP("DGYE",$J)
 K %,%DT,%ZIS,ADM,CORADM,COUNT,DATE,DAYS,DFN,DG1,DGPT0,DGPT70,DGT,DGYECNT,DGYEDT,DGYEPG,DGYEUSED,DIR,DIS,DPT0,DTM10,DTM3,EDATE,EFLAG,ENTRY,FLAG,GLB,GNAME,I,IDATE,INDEX,J,K,MOVE,MY,OS,PAT
 K POP,PROC,PROV,PTF,RESULT,RTOTAL,SDATE,SEQ,SUR,T,TABLE,TASK,TD,TOTAL,V1,V2,V3,V4,V5,X,X1,X2,Y,Z,ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
AUTO ; This is the entry point that should be used by the option
 ; file to queue the report.
 N DATE
 D NOW^%DTC S DATE=$E(X,1,5)-3-($E(X,4,5)<4*88)_"00",Y=DATE X ^DD("DD") S $P(DATE,U,2)=Y
 D EN^DGYEPRN,ENQ
 Q
 ;
GETREC(DATE,TOTAL) ;-- This extrinsic function will build the ^TMP global
 ; required to generate the pull list for EPRP.
 ;  INPUT : DATE - month and year in FM format to scan discharges.
 ;  OUTPUT: -^TMP global (see DGYESCAN for format).
 ;           TOTAL - value paramter returns total discharges
 ;
 K ^TMP("DGYE",$J),^TMP("DGYEML",$J)
 N I,Y,X,T,GNAME,GLB,SDATE,EDATE,PTF,SEQ
 S TOTAL=0
 ;-- build table of tasks
 D EN^DGYETBL
 S GLB="^TMP(""DGYE"",",GNAME=GLB_"$J)",SDATE=DATE,EDATE=$S($E(DATE,4,5)=12:DATE+8900,1:DATE+100)
 ;
 F I=SDATE:0 S I=$O(^DGPT("ADS",I)) Q:'I!(I>EDATE)  F PTF=0:0 S PTF=$O(^DGPT("ADS",I,PTF)) Q:'$D(^DGPT(+PTF,0))  S TOTAL=TOTAL+1 I $P(^(0),"^",6),$P(^(0),"^",11)=1 S DGYE=$P(^(0),"^",5) I $$HOSPSUFF(DGYE) D
 .D SCAN401^DGYESCAN(PTF,GLB),SCAN601^DGYESCAN(PTF,GLB) S Y=$G(^DGPT(PTF,70))  I Y]"" S X=$P($G(^ICD9(+$P(Y,U,10),0)),U) I X]"",$D(^TMP("DGYE",$J,"D",X)) D
 ..D SCAN501^DGYESCAN(PTF,GLB) S T="" F  S T=$O(^TMP("DGYE",$J,"D",X,T)) Q:T']""  I '$$CHKTSK^DGYESCAN(PTF,T) S ^(0)=$G(@GNAME@("TASK",T,0))+1,SEQ=^(0),@GNAME@("TASK",T,SEQ,PTF)=""
 Q
 ;
GETMY() ; This is an extrinsic variable that will return the date 
 ; in the following format: YYYMM00^FEB 1991 (display format)
 ; if an error occurs then a "" will be returned.
 ;   DEFAULT : CURRENT MONTH-2
STARTMY N Y,IDATE,RESULT
 S RESULT=""
 D NOW^%DTC S (Y,IDATE)=$E(X,1,5)-3-($E(X,4,5)<4*88)_"00" X ^DD("DD") S IDATE=Y
 S %DT="AEP",%DT("A")="Search DISCHARGE DATE (MONTH AND YEAR): ",%DT("B")=IDATE D ^%DT G:Y<0 GETMYQ S Y=$E(Y,1,5)_"00",RESULT=Y X ^DD("DD") S $P(RESULT,U,2)=Y
 S DIR("A")="I will search "_Y_"'s discharges, is this correct",DIR(0)="Y" D ^DIR G:'Y STARTMY
GETMYQ K DIR Q RESULT
 ;
PRINT(DATE) ;--EPRP print driver
 ; INPUT: DATE  -month/year of search
 ;
 N COUNT
 W *7,!!,"THIS REPORT REQUIRES 132 COLUMNS"
 S %ZIS="Q" D ^%ZIS I POP D ^%ZISC G PRQ
 I $D(IO("Q")) K IO("Q") S ZTDESC="External Peer Review Program",ZTSAVE("DATE")="",ZTRTN="EN^DGYEPRN" D ^%ZTLOAD,^%ZISC G PRQ
 D WAIT^DICD,EN^DGYEPRN
PRQ Q
 ;
HOSPSUFF(SUFFIX) ; return 1 if valid suffix, 0 otherwise
 ;
 ; input - suffix as found in ptf file (field 5)
 ;
 N HOSP
 S HOSP=0
 I SUFFIX="" S HOSP=1
 I $E(SUFFIX)="A",($E(SUFFIX,2)?1N) S HOSP=1
 I $E(SUFFIX)="T",($E(SUFFIX,2)?1A) S HOSP=1
 I $E(SUFFIX)="S",($E(SUFFIX,2)?1A) S HOSP=1
 I $E(SUFFIX)="B",($E(SUFFIX,2)?1A),($E(SUFFIX,2)']"T") S HOSP=1
 Q HOSP
