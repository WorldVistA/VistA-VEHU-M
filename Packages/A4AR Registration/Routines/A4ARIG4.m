A4ARIG4 ;HINES CIOFO/JJM-IG REPORTS ; 12/8/98 11:15
V ;;1.0;CLASS III REPORTS OCTOBER 15,1998
 I $D(ACCRUED) D BSRPT4 Q
PRPTS ; PRINT ALL REPORTS
 D:'$G(^XTMP("A4ARIG",$J,"BILL",0)) EN1^A4ARIG
 D NOW^%DTC
 D OPEN
 W @IOF
 D BSRPTS
 D CLOSE
 D EOR
 QUIT
BSRPTS ; PRINT BILL STATUS REPORTS
 F ACCRUED=0:1:1 D BSRPT4
 QUIT
BSRPT4 ;
 ; GET DATE/TIME OF DATA EXTRACT
 S DATE=^XTMP("A4ARIG",$J,"BILL","DATE/TIME",0)
 S SITE=$$SITE^RCMSITE()
 W @IOF
 W !!,?32,"BILL DATA REPORT - BY REVENUE SOURCE CODE"
 W !,?42,DATE,!,?40,SITE," JOB NUMBER: ",$J,!
 ; SCNT - STATUS COUNTER
 ; CCNT - CATEGORY COUNTER
 ; FCNT - FUND COUNTER
 ; RCNT - RSC COUNTER
INIT ;
 N CNT,SCNT,CCNT,FCNT,RCNT
 S (CNT,SCNT,CCNT,FCNT,RCNT)=0
 S (STOTAL,CTOTAL,FTOTAL,GTOTAL,RTOTAL,RTOTAL1,RTOTAL2,RTOTAL3,RTOTAL4,RTOTAL5,RTOTAL6)=0,STAT=""
 D NOW^%DTC
 S STAT="",SCNT=0,STOTAL=0
 F  S STAT=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT)) Q:STAT=""  D
    . S (RTOTAL,RTOTAL1,RTOTAL2,RTOTAL3,RTOTAL4,RTOTAL5,RTOTAL6)=0
    . W !!,?36,$S(ACCRUED=0:"NON-ACCRUED/",ACCRUED=1:"ACCRUED/",1:" "),$P($G(^PRCA(430.3,STAT,0)),U,1)," RSC REPORT - 4",!
    . W !,"CATEGORY/FUND/RSC ",?40,"COUNT",?52,"TOTAL ",?60,"PRINCIPAL ",?76,"INT ",?85,"ADMIN ",?92,"MRSHL ",?102,"CRT ",!
    . S CAT="",CNT=1,CCNT=0,FCNT=0,RCNT=0,CTOTAL=0
    . F  S CAT=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT)) Q:CAT=""  D
      .. D:CNT=0
         ... W !!,?25,$S(ACCRUED=0:"NON-ACCRUED ",ACCRUED=1:"ACCRUED ",1:" "),$P($G(^PRCA(430.3,STAT,0)),U,1)," FUND REPORT - 4",!
         ... S CNT=1
      .. S CCNT=CCNT+1
      .. S FUND="",FCNT=0,RCNT=0,FTOTAL=0
      .. F  S FUND=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND)) Q:FUND=""  D
         ... D:CNT=0
             .... S CNT=1
             .... W !!,?25,$S(ACCRUED=0:"NON-ACCRUED ",ACCRUED=1:"ACCRUED/",1:"/"),$P($G(^PRCA(430.3,STAT,0)),U,1)," FUND REPORT - 4",!
         ... S FCNT=FCNT+1
         ... S RSC="",RCNT=0
         ... F  S RSC=$O(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC)) Q:RSC=""  D
            .... S RCNT=RCNT+1
            .... ; W !,SCNT,"  ",CCNT,"  ",FCNT,"  ",RCNT,"  ",CNT
            .... W !,$P($G(^PRCA(430.2,CAT,0)),U,1),"/",FUND,"/",RSC,?35,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,6),10)
            .... W ?45,$J(^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,0),12,2),$J(^(1),12,2),$J(^(2),10,2),$J(^(3),10,2),$J(^(4),8,2),$J(^(5),8,2)
            .... S RTOTAL=RTOTAL+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,0)
            .... S RTOTAL1=RTOTAL1+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,1)
            .... S RTOTAL2=RTOTAL2+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,2)
            .... S RTOTAL3=RTOTAL3+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,3)
            .... S RTOTAL4=RTOTAL4+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,4)
            .... S RTOTAL5=RTOTAL5+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,5)
            .... S RTOTAL6=RTOTAL6+^XTMP("A4ARIG",$J,"ACCRUED",ACCRUED,"STATUS",STAT,"CATEGORY",CAT,"FUND",FUND,"RSC",RSC,6)
            .... S CNT=CNT+1
            .... ; D:CNT>30 TOTALS
      ...  ; I (FCNT>1)!(RCNT>5)!(CNT>15) D TOTALS S FCNT=0,RCNT=0
   . D TOTALS S CCNT=0,FCNT=0
 ; D:CNT>2 TOTALS
 QUIT
TOTALS ;
 W !,"TOTALS:",?35,$J(RTOTAL6,10),?45,$J(RTOTAL,12,2),$J(RTOTAL1,12,2),$J(RTOTAL2,10,2),$J(RTOTAL3,10,2),$J(RTOTAL4,8,2),$J(RTOTAL5,8,2)
 S GTOTAL=GTOTAL+RTOTAL
 S FTOTAL=FTOTAL+RTOTAL
 S CTOTAL=CTOTAL+RTOTAL
 S STOTAL=STOTAL+RTOTAL
CLRDATA S (RTOTAL,RTOTAL1,RTOTAL2,RTOTAL3,RTOTAL4,RTOTAL5)=0,CNT=0
 QUIT
OPEN ; SELECT OUTPUT DEVICE
 S %ZIS="M" D ^%ZIS U IO
 QUIT
CLOSE ; CLOSE OUTPUT DEVICE
 D ^%ZISC
 QUIT
EOR ; END OF ROUTINE
 K CAT,FUND,RSC,RTOTAL,STAT,TT,SITE
 K ACCRUED,AMT,AMT1,AMT2,AMT3,AMT4,AMT5,CAT,FUND,RSC,STAT
 K RTOTAL,RTOTAL1,RTOTAL2,RTOTAL3,RTOTAL4,RTOTAL5
 K TAMT,TAMT1,TAMT2,TAMT3,TAMT4,TAMT5
