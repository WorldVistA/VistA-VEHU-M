RCRPWLUT ;EDE/YMG - REPAYMENT PLAN WORKLIST UTILITIES; 03/14/2022
 ;;4.5;Accounts Receivable;**389**;Mar 20, 1995;Build 36
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Utilities for RCRP APPROVAL WORKLIST option
 ;
 Q
 ;
GET36(RPIEN) ; get 36 months review flag for a given repayment plan
 ;
 ; RPIEN - file 340.5 ien
 ;
 ; returns internal value of field 340.5/1.06
 ;
 N IENS
 I RPIEN'>0 Q 0
 S IENS=RPIEN_","
 Q +$$GET1^DIQ(340.5,IENS,1.06,"I")
 ;
MSGREV ; send Mailman notification for repayment plan that needs 36 months approval
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY
 N MSGTXT,SITE
 S SITE=+$$SITE^VASITE()
 S MSGTXT(1)="Site "_SITE_": Repayment plans with term length > 36 months"
 S MSGTXT(2)="need supervisor's approval."
 S MSGTXT(3)="Please use Repayment Plan Worklist option [PRCAC RPP WORKLIST]"
 S MSGTXT(4)="to review those repayment plans."
 S XMSUB="SITE "_SITE_": AR REPAYMENT PLAN NEEDS 36 MONTHS APPROVAL",XMDUZ="AR PACKAGE"
 S XMY("G.RC REPAY SUP")="",XMTEXT="MSGTXT("
 D ^XMD
 Q
 ;
MSGDEN(RPIEN) ; send Mailman notification for repayment plan that had 36 months approval denied
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY
 N MSGTXT,N0,RPPID,SITE
 I RPIEN'>0 Q
 S N0=$G(^RCRP(340.5,RPIEN,0)) I N0="" Q
 S RPPID=$P(N0,U),SITE=+$$SITE^VASITE()
 S MSGTXT(1)="Site "_SITE_": Supervisor's approval for repayment plan"
 S MSGTXT(2)="with term length > 36 months was denied:"
 S MSGTXT(3)="Repayment plan ID: "_RPPID
 S XMSUB="SITE "_SITE_": 36 MONTHS APPROVAL FOR AR REPAYMENT PLAN WAS DENIED",XMDUZ="AR PACKAGE"
 S XMY("G.RC REPAY TECH")="",XMTEXT="MSGTXT("
 D ^XMD
 Q
