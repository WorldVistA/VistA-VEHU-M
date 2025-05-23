ORQ11 ;SLC/DCM - Get patient orders in context ;May 13, 2020@10:30:45
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,27,48,72,78,99,94,148,141,177,186,190,195,215,243,295,322,350,444,515,530**;Dec 17, 1997;Build 1
 ;
 ;EPIP/RTW Modified for the Unified Action Profile 26 Oct 2016
LOOP ; -- main loop through "ACT" x-ref
 I $G(XREF)="AW" D AW Q
 I $G(FLG)=27 D EXPD^ORQ12 Q
 K ^TMP("ORGOTIT",$J)
AWIN ;Jump in here to add active orders to AW context
 N TM,TO,IFN,X0,X3,X7,X8,USTS,NOW,ACTOR,X ;195
 S NOW=+$E($$NOW^XLFDT,1,12),TM=SDATE
 F  S TM=$O(^OR(100,"ACT",PAT,TM)) Q:'TM!(TM>EDATE)  S TO=0 F  S TO=$O(^OR(100,"ACT",PAT,TM,TO)) Q:'TO  I $D(ORGRP(TO)) D
 . S IFN=0 F  S IFN=$O(^OR(100,"ACT",PAT,TM,TO,IFN)) Q:'IFN  I ('$D(^TMP("ORGOTIT",$J,IFN))!MULT),$D(^OR(100,IFN,0)),$D(^(3)) S X0=^(0),X3=^(3) D
 .. S ACTOR=0 F  S ACTOR=$O(^OR(100,"ACT",PAT,TM,TO,IFN,ACTOR)) Q:ACTOR<1  I '$D(^TMP("ORGOTIT",$J,IFN,ACTOR)),$D(^OR(100,IFN,8,ACTOR,0)),$P(^(0),U,15)'=13!(FLG=1) S X8=^(0),X7=$G(^(7)) D LP1
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
AW ; -- loop through "AW" x-ref
 K ^TMP("ORGOTIT",$J),^TMP("ORSORT",$J)
 N TM,TO,IFN,X0,X3,X7,X8,USTS,NOW,ACTOR,X ;195
 S NOW=+$E($$NOW^XLFDT,1,12),TO=0,SDATE=9999999-SDATE,EDATE=9999999-EDATE
 F  S TO=$O(^OR(100,"AW",PAT,TO)) Q:'TO  I $D(ORGRP(TO)) S TM=EDATE F  S TM=$O(^OR(100,"AW",PAT,TO,TM)) Q:'TM!(TM>SDATE)!(+TM<EDATE)  D
 . S IFN=0 F  S IFN=$O(^OR(100,"AW",PAT,TO,TM,IFN)) Q:'IFN  I ('$D(^TMP("ORGOTIT",$J,IFN))!MULT) D
 .. S ^TMP("ORSORT",$J,9999999-TM,TO,IFN)=""
 S TM=0 F  S TM=$O(^TMP("ORSORT",$J,TM)) Q:'TM  S TO=0 F  S TO=$O(^TMP("ORSORT",$J,TM,TO)) Q:'TO  D
 . S IFN=0 F  S IFN=$O(^TMP("ORSORT",$J,TM,TO,IFN)) Q:'IFN  I $D(^OR(100,IFN,0)),$D(^(3)) S X0=^(0),X3=^(3) D
 .. S ACTOR=0 F  S ACTOR=$O(^OR(100,"ACT",PAT,9999999-$P(X0,U,7),TO,IFN,ACTOR)) Q:ACTOR<1  I '$D(^TMP("ORGOTIT",$J,IFN,ACTOR)),$D(^OR(100,IFN,8,ACTOR,0)),$P(^(0),U,15)'=13 S X8=^(0),X7=$G(^(7)) D LP1
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 I +$$GET^XPAR("SYS","OR ORDER SUMMARY CONTEXT",1,"I")=2 S SDATE=9999999-SDATE,EDATE=9999999-EDATE D AWIN
 K ^TMP("ORSORT",$J),^TMP("ORGOTIT",$J)
 Q
LP1 ; -- main secondary loop
 N STS ;195
 N TAG
 Q:$P(X3,U,8)  Q:$P(X3,U,3)=99  S STS=$P(X3,U,3)
 I '$G(GETKID),$P(X3,U,9),'$P($G(^OR(100,$P(X3,U,9),3)),U,8),FLG'=11 Q
 I $L($P(X0,U,17)),"^10^11^"[(U_STS_U) S X=$$LAPSED^OREVNTX($P(X0,U,17))
 ;EPIP/RTW BEGIN ***UNIFIED ACTION PROFILE Modification*** 26/OCT/2016
 ; original note for DM line "DISCHARGE MEDS"
 ; original note for UAPM line "UAP MEDS"
 I $$GET1^DIQ(100.98,GROUP,.01)="DISCHARGE MEDS" D DM Q
 I $$GET1^DIQ(100.98,GROUP,.01)="PHARMACY UAP" D UAPM Q
 ;EPIP/RTW END ***UNIFIED ACTION PROFILE Modification***
 S TAG=$S(FLG=2:"CUR1",FLG=4:"COM1",FLG=5:"EXG1",FLG=7:"PEN1",FLG=8:"UVR1",FLG=9:"UVN1",FLG=10:"UVC1",FLG=12:"FLG1",FLG=13:"VP1",FLG=14:"VPU1",FLG=18:"HLD1",FLG=20:"CHT1",FLG=21:"CHTSUM",FLG=22:"LPS1",FLG=23:"AVT1",1:"ALL1")
 I TAG="ALL1" S TAG=$S(FLG=3:"DC1",FLG=28:"DC1",FLG=29:"UVR1",FLG=30:"UVN1",FLG=31:"UVC1",FLG=32:"CHT1",1:"ALL1")
 D @TAG
 Q
 ; ** FLG context specific loops:
 ;
ALL1 ; 1 -- secondary pass for All, Recent Orders, Unsigned
 D GET^ORQ12(IFN,ORLIST,DETAIL,$G(ACTOR))
 Q
 ;
CUR ; 2 -- Active/Current
 N X,X0,X1,X2,X3,X8,%H,YD,%,TM,IFN,ACTOR,NORX,OIEN,OACT
 I $G(GROUP)=$O(^ORD(100.98,"B","ALL SERVICES",0)),$G(ORWARD),$G(DGPMT)'=1 S NORX=U_$O(^ORD(100.98,"B","O RX",0))_U_$O(^ORD(100.98,"B","NON-VA MEDICATIONS",0))_U
 S X2=+$$GET^XPAR("SYS","ORPF ACTIVE ORDERS CONTEXT HRS",1,"I"),X=$H,X=+X*24+($P(X,",",2)/3600),X1=X-X2,X3=X1#24,X1=X1\24,X2=$J(X3*3600,0,0),%H=X1_","_X2 D YMD^%DTC S YD=+(X_%)
 S TM=SDATE F  S TM=$O(^OR(100,"AC",PAT,TM)) Q:TM<1!(TM>EDATE)  S IFN=0 F  S IFN=$O(^OR(100,"AC",PAT,TM,IFN)) Q:IFN<1  I $D(^OR(100,IFN,0)),$D(^(3)) S X0=^(0),X3=^(3) D
 . Q:'$D(ORGRP($P(X0,U,11)))  S ACTOR=0
 . F  S ACTOR=$O(^OR(100,"AC",PAT,TM,IFN,ACTOR)) Q:ACTOR<1  I $D(^OR(100,IFN,8,ACTOR,0)) S X8=^(0) D
 .. I "^10^12^"[(U_$P(X8,U,15)_U) K ^OR(100,"AC",PAT,TM,IFN,ACTOR) Q
 .. I $P(X8,U,15)=13,$P(X8,U)<YD K ^OR(100,"AC",PAT,TM,IFN,ACTOR) Q
 .. I $P(X8,U,15)="",ACTOR'=$P(X3,U,7) K ^OR(100,"AC",PAT,TM,IFN,ACTOR) Q
 .. ;AGP waiting for approval change to remove duplicate orders for DC reason
 .. ;I ACTOR>0,$P($G(^OR(100,IFN,8,ACTOR,0)),U,2)="DC" S OIEN=IFN,OACT=ACTOR
 .. ;I OIEN=IFN,OACT>ACTOR K ^OR(100,"AC",PAT,TM,IFN,ACTOR) Q
 .. D LP1
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
CUR1 ; 2 -- secondary pass for Active/Current
 N STOP S STOP=$P(X0,U,9)
 I STS=10 K ^OR(100,"AC",PAT,TM,IFN) Q  ;no delayed orders
 N EVNT S EVNT=$P(X0,U,17)
 I STS=13,EVNT,'$D(^ORE(100.2,EVNT,1)) Q  ;DJE/VM *322 no cancelled orders linked to unreleased delay
 I $P(X8,U,4)=2,$P(X8,U,15)=11 G CURX ;incl all unsig/unrel actions
 I '$D(YD),"^1^2^7^12^13^14^"[(U_STS_U) K ^OR(100,"AC",PAT,TM,IFN) Q
 I $D(YD),"^1^2^7^12^13^14^"[(U_STS_U),STOP<YD K ^OR(100,"AC",PAT,TM,IFN) Q
 I $G(NORX)[(U_$P(X0,U,11)_U) Q  ;skip Rx for inpatients
CURX D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
DC1 ; 3 -- secondary pass for DC
 I FLG=28 D GETEIE^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 I STS=1!(STS=13)!(STS=12) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
COM1 ; 4 -- secondary pass for Completed/Expired
 N STOP S STOP=$P(X0,U,9)
 I STS=2!(STS=7)!($L(STOP)&(STOP<NOW)&(STS'=1)&(STS'=13)&(STS'=12)) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
EXG ; 5 -- Expiring
 N ORNG,ORDT,ORDW,ORHOL,X,Y,%DT,DIC,TMW,NOW ;195
 F ORNG=1:1 D  I ORHOL=0,ORDW=0 Q
 . S ORDT=$$FMADD^XLFDT(DT,ORNG),ORDW=$S($H-4+ORNG#7>4:1,1:0)
 . S DIC="^HOLIDAY(",X=$P(ORDT,".")
 . D ^DIC S ORHOL=$S(+$G(Y)>0:1,1:0)
 S %DT="",X="T+"_ORNG D ^%DT
 S TMW=Y_".9999",NOW=+$E($$NOW^XLFDT,1,12)
 D CUR ;D LOOP
 Q
EXG1 ; 5 -- secondary pass for Expiring
 N STOP S STOP=$P(X0,U,9)
 I STS'=1,STS'=2,STS'=7,STS'>9,STOP>NOW,STOP'>TMW D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
ACT ; 6 -- Recent Activity (Order Summary)
 ;N ORLSIGN S ORLSIGN=$$GET^XPAR("ALL","OR ORDER REVIEW DT","`"_+PAT,"Q")
 N TM,IFN,X0,X3,ACTOR,X8
 S TM=SDATE F  S TM=$O(^OR(100,"AR",PAT,TM)) Q:TM<1!(TM>EDATE)  D
 . S IFN=0 F  S IFN=$O(^OR(100,"AR",PAT,TM,IFN)) Q:IFN<1  S X0=$G(^OR(100,IFN,0)),X3=$G(^(3)) I $D(ORGRP(+$P(X0,U,11))) D
 .. S ACTOR=0 F  S ACTOR=$O(^OR(100,"AR",PAT,TM,IFN,ACTOR)) Q:ACTOR<1  I $D(^OR(100,IFN,8,ACTOR,0)),$P(^(0),U,15)'=13 S X8=^(0) D LP1
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
 ;
PEN1 ; 7 -- secondary pass for Pending
 I STS=5 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
UVR1 ; 8 -- secondary pass for Unverified; 29 for Outpatient
 ;      Include if: unverified, released, inpt, not repl/canc/lapsed
 I '$P(X8,U,9),'$P(X8,U,11),$P(X8,U,15)="",$S(FLG=8:$$INPT,FLG=29:$$OUTPT,1:0),"^12^13^14^"'[(U_STS_U) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
UVN1 ; 9 -- secondary pass for Unverified/Nurse; 30 for Outpatient
 ;      Include if: unverified, released, inpt, not repl/canc/lapsed
 I '$P(X8,U,9),$P(X8,U,15)="",$S(FLG=9:$$INPT,FLG=30:$$OUTPT,1:0),"^12^13^14^"'[(U_STS_U) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
UVC1 ; 10 -- secondary pass for Unverified/Clerk; 31 for Outpatient
 ;       Include if: unverified, released, inpt, not repl/canc/lapsed
 I '$P(X8,U,11),$P(X8,U,15)="",$S(FLG=10:$$INPT,FLG=31:$$OUTPT,1:0),"^12^13^14^"'[(U_STS_U) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
INPT() ; -- Returns 1 or 0, if inpt order using X0=^OR(100,IFN,0)
 I $$CLNOR() Q 1  ;p*515
 I $P(X0,U,12)="O" Q 0  ;p*515
 I $P(X0,U,11)=$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS","")) Q 0  ;p*515
 I ($P(X0,U,12)="I")!($$TYPE^OREVNTX($P(X0,U,17))="D") Q 1
 I $P($G(^SC(+$P(X0,U,10),0)),U,3)="W" Q 1 ;UNCOMMENTED IN *295
 Q 0
 ;
OUTPT() ; -- Returns 1 or 0, if outpt order using X0=^OR(100,IFN,0) ;P*515
 I $P(X0,U,11)=$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS","")) Q 0  ;exclude outpt meds
 I $P(X0,U,11)=$O(^ORD(100.98,"B","NON-VA MEDICATIONS","")) Q 0  ;exclude non-va meds
 I $P(X0,U,11)=$O(^ORD(100.98,"B","SUPPLIES/DEVICES","")) Q 0  ;exclude supplies
 I $P(X0,U,12)="O" Q 1
 I $$CLNOR() Q 1
 Q 0
 ;
CLNOR() ; -- Returns 1 or 0, if IMO clinic order ;P*515
 N ORY
 I '$G(IFN) Q 0
 D IMOOD^ORIMO(.ORY,IFN)
 Q ORY
 ;
SIG ; 11 -- Unsigned
 N TM,IFN,X0,X3,ACTOR S TM=SDATE
 F  S TM=$O(^OR(100,"AS",PAT,TM)) Q:TM<1!(TM>EDATE)  S IFN=0 F  S IFN=$O(^OR(100,"AS",PAT,TM,IFN)) Q:IFN<1  D
 . S X0=$G(^OR(100,IFN,0)),X3=$G(^(3))
 . I X0="" K ^OR(100,"AS",PAT,TM,IFN) Q  ;deleted
 . Q:'$D(ORGRP(+$P(X0,U,11)))  ;not a selected DispGrp
 . S ACTOR=0 F  S ACTOR=$O(^OR(100,"AS",PAT,TM,IFN,ACTOR)) Q:ACTOR<1  D
 .. I $P($G(^OR(100,IFN,8,ACTOR,0)),U,4)'=2 K ^OR(100,"AS",PAT,TM,IFN,ACTOR) Q  ;signed or deleted
 .. D LP1
 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
 ;
FLG1 ; 12 -- secondary pass for Flagged
 I +$G(^OR(100,IFN,8,ACTOR,3)) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
VP1 ; 13 -- secondary pass for Verbal/Phone
 N ORNATR S ORNATR=$P(X8,U,12)
 I ORNATR,"PV"[$P($G(^ORD(100.02,+ORNATR,0)),U,2) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) ;STS'=12
 Q
 ;
VPU1 ; 14 -- secondary pass for Verbal/Phone Unsigned
 N ORNATR S ORNATR=$P(X8,U,12)
 I ORNATR,"PV"[$P($G(^ORD(100.02,+ORNATR,0)),U,2),'$P(X8,U,5),$P(X8,U,4)=2 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) ;STS'=12
 Q
 ;
HLD1 ; 18 -- secondary pass for On Hold
 I STS=3 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
NEW ; 19 -- New Orders, plus other unsigned orders by current provider
 N IFN,ACTOR,TM,X0,X3,X8,ORENT,ORPAR
 S IFN=0 F  S IFN=$O(^TMP("ORNEW",$J,IFN)) Q:IFN'>0  D  ;New orders
 . S ACTOR=0 F  S ACTOR=$O(^TMP("ORNEW",$J,IFN,ACTOR)) Q:ACTOR'>0  D
 .. Q:'$D(^OR(100,IFN,0))  Q:'$D(^(8,ACTOR,0))  ;deleted
 .. D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 G:'$D(^XUSEC("ORES",DUZ)) NW1 ;ck parameter for add'l orders
 S ORENT="ALL"_$S($G(^VA(200,DUZ,5)):"^SRV.`"_+^(5),1:"")
 S ORPAR=$$GET^XPAR(ORENT,"OR UNSIGNED ORDERS ON EXIT")
 I ORPAR S TM=SDATE F  S TM=$O(^OR(100,"AS",PAT,TM)) Q:TM<1!(TM>EDATE)  D
 . S IFN=0 F  S IFN=$O(^OR(100,"AS",PAT,TM,IFN)) Q:IFN<1  D
 .. S ACTOR=0 F  S ACTOR=$O(^OR(100,"AS",PAT,TM,IFN,ACTOR)) Q:ACTOR<1  D
 ... Q:$D(^TMP("ORNEW",$J,IFN,ACTOR))  ;already included
 ... S X0=$G(^OR(100,IFN,0)),X3=$G(^(3)),X8=$G(^(8,ACTOR,0))
 ... I $S(ORPAR=1&($P(X8,U,3)=DUZ):1,ORPAR=2:1,1:0) D LP1
NW1 S ^TMP("ORR",$J,ORLIST,"TOT")=ORLST
 Q
 ;
CHT1 ; 20 -- secondary pass for Chart Review; 32 for Outpatient
 ;       Include if: unverified, released, inpt, not repl/canc/lapsed
 I '$P(X8,U,19),$P(X8,U,15)="",$S(FLG=20:$$INPT,FLG=32:$$OUTPT,1:0),"^12^13^14^"'[(U_STS_U) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
CHTSUM ; 21 -- secondary pass for Chart copy summary
 ;       Included based on Nature of Order
 N XP,NAT
 S XP=+$$GET^XPAR("SYS","OR PRINT ALL ORDERS CHART SUM",1,"I")
 I XP=2 D  Q  ;depends on Nature of Order
 . S NAT=$P($G(^OR(100,IFN,6)),U)
 . I 'NAT S NAT=$P(X8,U,12)
 . I NAT,$$CHART^ORX1(NAT) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 I XP=0 D  Q  ;If original printed, print on sum
 . I X7 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) ;XP=1 gets All orders
 Q
 ;
LPS1 ; 22 -- secondary pass for Lapsed
 I STS=14 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q
 ;
AVT1 ; 23 -- secondary pass for Active/Pending sts only
 ;I (STS=6)!(STS=5) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR)
 Q:(STS'=5)&(STS'=6)
 Q:$D(^TMP("ORGOTIT",$J,IFN))
 N TMPACT,TMPQT S TMPACT=ACTOR
 N ORCACT S ORCACT=999 F  S ORCACT=$O(^OR(100,IFN,8,ORCACT),-1) Q:(ORCACT<2)!($G(TMPQT))  D
 . Q:$P(^OR(100,IFN,8,ORCACT,0),U,2)["DC"  S TMPACT=ORCACT,TMPQT=1
 D GET^ORQ12(IFN,ORLIST,DETAIL,TMPACT)
 Q
 ;
QUIT ; -- stop
 Q
 ;EPIP/RTW ***BEGIN UNIFIED ACTION PROFILE Modification*** 26/OCT/2016
 ; UAP MEDS ACTIVE, PENDING, HOLD
UAPM ;
 N ORDTE,OREDTE,X,Y
 Q:$$GET1^DIQ(100.008,ACTOR_","_IFN_",","15")["dc/edit"
 S ORDTE=$$GET1^DIQ(100,IFN,4,"I") ;WHEN ENTERED (#4) date if defined in the order entry
 K %DT S X="T-3" D ^%DT S OREDTE=Y
 ;
 ;Hold
 I STS=3 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Pending
 I STS=5 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Active
 I STS=6 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Delayed
 ;entered within 3 days
 ;just a starting point to test with since users haven't specified
 ;what date range to actually go with
 I (STS=10)&($L(ORDTE)&(ORDTE>OREDTE)) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Unreleased/new
 I STS=11 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 Q
 ;
DM ; DISCHARGE MEDS 9-2-03 ACTIVE, PENDING, DC < 7 DAYS AND EXPIRED LESS THAN 90 DAYS
 ;J0 - 06/22/2005 changes to include more types and dates
 ;J0 - 09/08/2005 changed back to T-90 for expired meds per Tamara Olcott.
 N ORSTOP,OREXPDT,ORDCDT,X,Y,ORDC
 S ORDC=$$GET1^DIQ(100,IFN,63,"I") ;DC date if defined in the order entry
 S ORSTOP=$P(X0,U,9)
 K %DT S X="T-90" D ^%DT S OREXPDT=Y
 K %DT S X="T-7" D ^%DT S ORDCDT=Y
 ;D/C within last 7 days
 I (STS=1)&($L(ORDC)&(ORDC>ORDCDT)) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Hold
 I STS=3 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Pending
 I STS=5 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Active
 I STS=6 D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 ;Expired within last 90 days
 I (STS=7)&($L(ORSTOP)&(ORSTOP>OREXPDT)) D GET^ORQ12(IFN,ORLIST,DETAIL,ACTOR) Q
 Q
 ;EPIP/RTW ***END UNIFIED ACTION PROFILE Modification*** 26/OCT/2016
