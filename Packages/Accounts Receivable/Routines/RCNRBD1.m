RCNRBD1 ;Washington ISC@Altoona,Pa/TJK-BAD DEBT ALLOWANCE (NIGHTLY PROCESS) ;5/22/95  11:39 AM
V ;;4.5;Accounts Receivable;**3,4**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;1) Monthly Calculation of Bad Debt Allowance Accruals
 ;2) Monthly Bad Debt Allowance Report
 ;3) Monthly Calculation of Bad Debt Allowance Percentages
 ;4) Monthly Transmission Of Summary Documents To FMS
 ;CALLED BY PRCABJ
 D BDPER,BDEBTC,BDEBTP,BDEBTS,SUMDOC
EXIT Q
BDPER ;Queues Monthly Base Percentage Calculation
 Q:$E(DT,6,7)'=24
BDPER1 N IOP,ZTDESC,ZTASK,ZTIO,ZTRTN,ZTSAVE,%ZIS
 S ZTIO="",ZTRTN="EN1^RCNRBD",ZTDTH=$H
 S ZTDESC="Calculate Bad Debt Allowance %'s" D ^%ZTLOAD,^%ZISC
BDPERQ Q
BDEBTC ;Queues Monthly Calculation of Bad Debt Allowance
 Q:$E(DT,6,7)'=26
BDEBTC1 N IOP,ZTDESC,ZTASK,ZTIO,ZTRTN,ZTSAVE,%ZIS
 S ZTIO="",ZTRTN="EN2^RCNRBD",ZTDTH=$H
 S ZTDESC="Calculate Bad Debt Allowance" D ^%ZTLOAD,^%ZISC
BDEBTCQ Q
BDEBTP ;Queues Monthly Bad Debt Allowance Report
 N PRDT,X,IOP,ZTIO,ZTDESC,ZTASK,ZTRTN,ZTSAVE,%ZIS,ZTIO
 S X=+$E(DT,4,5),PRDT=$S(X=4:30,X=6:30,X=9:30,X=11:30,X=2:28,1:31)
 Q:$E(DT,6,7)'=PRDT
 S (PRCADEV,IOP)=$P($G(^RC(342,1,0)),U,8)
 I IOP]"" D
    .S ZTRTN="EN3^RCNRBD",ZTDTH=$H,ZTDESC="BAD DEBT ALLOWANCE REPORT"
    .S %ZIS="N0",ZTSAVE("PRCADEV")="" D ^%ZIS Q:POP
    .D ^%ZTLOAD,^%ZISC
    .Q
BDEBTPQ Q
BDEBTS ;Queues Monthly Compilation & Transmission Of Bad Debt
 ;Documents To FMS
 Q:+$E(DT,6,7)'=$$WD4
BDEBTS1 N IOP,ZTDESC,ZTASK,ZTIO,ZTRTN,ZTSAVE,%ZIS
 S ZTIO="",ZTRTN="^RCNRBD2",ZTDTH=$H
 S ZTDESC="FMS Bad Debt Documents" D ^%ZTLOAD,^%ZISC
BDEBTSQ Q
SUMDOC ;Queues Monthly Transmission Of FMS Summary Documents
 Q:+$E(DT,6,7)'=1
SUMDOC1 N IOP,ZTDESC,ZTASK,ZTIO,ZTRTN,ZTSAVE,%ZIS
 S ZTIO="",ZTRTN="^RCNRSUM",ZTDTH=$H
 S ZTDESC="FMS Summary Documents" D ^%ZTLOAD,^%ZISC
SUMDOCQ Q
WD4() ;COMPUTES 4TH WORKDAY OF MONTH
 N X,X1
 S X=$E(DT,1,5)_"01",X1=$E(DT,1,5)_"04"
 D ^XUWORKDY
 S X=$S(X=-1:4,X<3:4+(3-X),1:4)
 Q X
