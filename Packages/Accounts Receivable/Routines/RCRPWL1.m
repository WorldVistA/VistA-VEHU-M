RCRPWL1 ;EDE/YMG - REPAYMENT PLAN WORKLIST ACTIONS; 07/15/2021
 ;;4.5;Accounts Receivable;**389,423**;Mar 20, 1995;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; List Manager actions for RCRP APPROVAL WORKLIST option
 ;
 Q
 ;
AB ; add bills
 N RPIEN,SEL,Z
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S RPIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'RPIEN W !!,"Invalid selection." Q
 .I $$GET36^RCRPWLUT(RPIEN)'=1 W !!,"You can only add bills to an approved repayment plan." Q 
 .D EN1^RCRPADD(RPIEN)
 .Q
 S VALMBCK="R"
 Q
 ;
AP ; account profile
 N DBTR,RPIEN,SEL
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S RPIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'RPIEN W !!,"Invalid selection." Q
 .S DBTR=$P(^RCRP(340.5,RPIEN,0),U,2)
 .D EN1^PRCAAPR(DBTR)
 .Q
 S VALMBCK="R"
 Q
 ;
CV ; change view
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 S VALMBCK="R"
 D CLEAR^VALM1
 I SUPER D
 .S DIR("A")="Select (A)pproved plans, (D)enied plans, or plans that (R)equire review: "
 .S DIR(0)="SA^A:Approved plans;D:Denied plans;R:Plans that require review"
 .Q
 I 'SUPER D
 .S DIR("A")="Select (A)pproved plans or (D)enied plans: "
 .S DIR(0)="SA^A:Approved plans;D:Denied plans"
 .Q
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S VIEW=$S(Y="R":0,Y="A":1,1:2)
 S VALMBG=1 D HDR^RCRPWL,BLD^RCRPWL
 Q
 ;
ED ; edit terms
 N RPIEN,SEL
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S RPIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'RPIEN W !!,"Invalid selection." Q
 .I $$GET36^RCRPWLUT(RPIEN)'=2 W !!,"You can only edit terms of a denied repayment plan." Q
 .D EDITPLAN^RCRPENTR(RPIEN)
 .Q
 S VALMBCK="R"
 Q
 ;
EX ; export to Excel
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 S VALMBCK="R"
 D FULL^VALM1
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued output
 .S ZTDESC="Repayment Plan Worklist Export",ZTRTN="EXPORT^RCRPWL1"
 .S ZTSAVE("VIEW")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Export has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 .Q
 D EXPORT
 D HOME^%ZIS
 Q
 ;
EXPORT ; actual Excel export, called from tag EX
 N AMNT,BAL,EXTDT,LN,N0,RPIEN,TERM
 S EXTDT=$$FMTE^XLFDT(DT)
 U IO
 W !,"Repayment Plan Worklist Export",U,EXTDT,U,$S('VIEW:"Plans that require review",VIEW=1:"Approved plans",1:"Denied plans")
 W !,"RPP ID^Debtor^Term Length^Monthly Payment^Current Balance"
 I '$D(@VALMAR@("IDX")) W !,"No repayment plans found." G EXPORTX
 S LN=0 F  S LN=$O(@VALMAR@("IDX",LN)) Q:'LN  D
 .S RPIEN=@VALMAR@("IDX",LN,LN)
 .S N0=$G(^RCRP(340.5,RPIEN,0))
 .S AMNT=+$P(N0,U,6),BAL=$$CBAL^RCRPU3(RPIEN,$P(N0,U,11)),TERM=$$REMPMNTS^RCRPU3(RPIEN,AMNT)  ; PRCA*4.5*423
 .W !,$P(N0,U),U,$$EXTERNAL^DILFD(340.5,.02,,$P(N0,U,2)),U,TERM,U,$FN(AMNT,"",2),U,$FN(BAL,"",2)  ; PRCA*4.5*423
 .Q
EXPORTX ; exit point
 U 0 I '$D(ZTQUEUED) D GOON^VALM1
 Q
 ;
IN ; RPP inquiry
 N RPIEN,SEL
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S RPIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'RPIEN W !!,"Invalid selection." Q
 .D EN1^RCRPINQ(RPIEN)
 .Q
 S VALMBCK="R"
 Q
 ;
RV ; review plan
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 N CURFLG,FLG,RPIEN,SEL
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S RPIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'RPIEN W !!,"Invalid selection." Q
 .S DIR("A")="Please (A)pprove or (D)eny this repayment plan: "
 .S DIR(0)="SA^A:Approve;D:Deny"
 .D ^DIR
 .I $D(DTOUT)!$D(DUOUT) Q
 .S FLG=$S(Y="A":1,Y="D":2,1:"")
 .S CURFLG=$$GET36^RCRPWLUT(RPIEN)
 .I FLG>0 D
 ..I FLG=CURFLG W !!,"This plan has already been ",$S(CURFLG=1:"approved",1:"denied"),"." D GOON^VALM1 Q
 ..I CURFLG>0 Q:'$$RVCONF(FLG)
 ..D UPDFLG36^RCRPU1(RPIEN,FLG)
 ..D UPDAUDIT^RCRPU2(RPIEN,DT,"E",$S(FLG=1:"SM",1:"SD"),"")
 ..D:FLG=2 MSGDEN^RCRPWLUT(RPIEN)
 ..D CLEAR^VALM1,BLD^RCRPWL
 ..Q
 .Q
 S VALMBCK="R"
 Q
 ;
RVCONF(RVFLG) ; prompt to confirm supervisor approval/denial
 ;
 ; RVFLG - 1 for approval, 2 for denial
 ;
 ; returns 1 if user confirms, 0 otherwise
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I RVFLG'>0 Q
 S DIR(0)="Y"
 S DIR("A")="This plan has been "_$S(RVFLG=1:"denied",1:"approved")_".  Do you wish to continue with "_$S(RVFLG=2:"denial",1:"approval")_"? (Y/N)"
 D ^DIR
 Q $S(+Y<1:0,1:1)
