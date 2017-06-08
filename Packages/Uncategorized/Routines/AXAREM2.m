AXAREM2 ;WPB/CAM  use in the routine filed in file 811.9 for reminders
 ;;1.0;;8/23/99
REM31(DFN,TEST,DATE,VALUE,TEXT) ;Allergies 0=none 1=at least one
 D LIST^ORQQAL(.AA,DFN)
 S TEST=0
 I $P(AA(1),U)'="" S TEST=1
 I AA(1)="^No Known Allergies" S TEST=0
 K AA
 S DATE=DT
 Q
REM32(DFN,TEST,DATE,VALUE,TEXT) ;Problem List 0=none 1=at least one
 S STATUS="A"
 D LIST^ORQQPL(.AA,DFN,STATUS)
 S TEST=0
 I $P(AA(1),U)'="" S TEST=1
 K AA
 S DATE=DT
 Q
REM33(DFN,TEST,DATE,VALUE,TEXT) ;HBsAg positive or reactive = 1
 N SUB,SDATE,EDATE
 S SDATE=DT
 S X1=DT,X2=-7300 D C^%DTC S EDATE=X
 S SUB="CH"
 S TEST=131
 D RR^LR7OR1(DFN,,SDATE,EDATE,SUB,TEST,,1)
 S TEST=0,AA=0,BB=0
 S AA=$O(^TMP("LRRR",$J,DFN,"CH",AA)) G:AA="" REM33EN S BB=$O(^TMP("LRRR",$J,DFN,"CH",AA,BB)) S:$P($G(^TMP("LRRR",$J,DFN,"CH",AA,BB)),"^",2)="POS" TEST=1 S:$P($G(^TMP("LRRR",$J,DFN,"CH",AA,BB)),"^",2)="REACTIVE" TEST=1
REM33EN K SDATE,EDATE,SUB,^TMP("LRRR",$J)
 S DATE=DT
 Q
REM34(DFN,TEST,DATE,VALUE,TEXT) ;Last pneumovax minus DOB in days
 S B=^DPT(DFN,0)
 ;D NOW^%DTC S DT=X,X1=$S($G(^DPT(DFN,.351)):+^(.351),1:DT),X2=$P(B,U,3),X="" D:X2 ^%DTC:X1 S X=X\365.25,AGE=X S:AGE="" AGE=N
 S TEST=0,DATE=DT,VDATE=""
 F AA=0:0 S AA=$O(^AUPNVIMM("AA",DFN,AA)) Q:AA=""  D
 .Q:AA'=19
 .S BB=0 S BB=$O(^AUPNVIMM("AA",DFN,AA,BB))
 .S CC=0 S CC=$O(^AUPNVIMM("AA",DFN,AA,BB,CC))
 .S VISIT=$P(^AUPNVIMM(CC,0),"^",3)
 .S VDATE=$P(^AUPNVSIT(VISIT,0),"^")
 I VDATE'="" D
 .S X1=VDATE,X2=$P(B,U,3),X="" D ^%DTC
 .S VALUE=X,TEST=1,DATE=VDATE
 Q
REM35(DFN,TEST,DATE,VALUE,TEXT) ;Lowest CD4 Value from file 158
 ;First check to see if in file then send back value
 ;Set TEST = 0 if not foung else TEST=1 and Value= lowest CD4 value
 D ^AXAIMR  ;Create file with DFN
 S (TEST,VALUE)=0,DATE=DT,TEXT=""
 I $D(^DIBT(3009,1,DFN)) S TEST=1 D
 .S AIMR=^DIBT(3009,1,DFN) S VALUE=$P(^IMR(158,AIMR,102),"^",5)
 .S DATE=$P(^IMR(158,AIMR,102),"^",6)
 Q
