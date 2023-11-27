RCRPWL ;EDE/YMG - REPAYMENT PLAN WORKLIST; 07/14/2021
 ;;4.5;Accounts Receivable;**389,423**;Mar 20, 1995;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main screen for RCRP APPROVAL WORKLIST option
 ;
 Q
 ;
EN ; entry point
 N HASREC,SUPER,VIEW
 S SUPER=$S($D(^XUSEC("PRCA RPP SUPER",DUZ)):1,1:0)
 S VIEW=$S(SUPER:0,1:2)  ; current view - 0 for plans that require review, 1 for approved plans, 2 for denied plans
 ; load list template 
 D EN^VALM("PRCA RPP WORKLIST")
 Q
 ;
HDR ; header
 S VALMHDR(1)="Current view: "_$S('VIEW:"Plans that require review",VIEW=1:"Approved plans",1:"Denied plans")
 S VALMHDR(2)=""
 Q
 ;
INIT ; init variables and list array
 S VALMBG=1
 D BLD
 Q
 ;
HELP ; help
 D FULL^VALM1
 W @IOF
 W !,"This screen lists repayment plans with term length greater than 36 months that"
 W !,"either require supervisor's review, or have that approval denied."
 W !,"It also allows users with PRCA RPP SUPER security key to review and"
 W !,"subsequently approve / deny such plans."
 W !
 S VALMBCK="R"
 Q
 ;
EXIT ; exit point
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
BLD ; build list of RPPs for display
 N RPIEN
 D CLEAN^VALM10 S VALMCNT=0
 W !!,"Working..."
 S RPIEN=0 F  S RPIEN=$O(^RCRP(340.5,"F",VIEW,RPIEN)) Q:'RPIEN  D
 .S VALMCNT=$$BLDLN(VALMCNT,RPIEN)
 .I '(VALMCNT#10) W "."
 .Q
 S HASREC=1 I VALMCNT=0 S HASREC=0,VALMCNT=$$NOREC()
 Q
 ;
NOREC() ; show message when display list is empty
 ; returns line count in the created array
 ;
 D SET^VALM10(1,"")
 D SET^VALM10(2,"")
 D SET^VALM10(3,$$SETSTR^VALM1("No repayment plans found.","",28,25))
 Q 3
 ;
BLDLN(LNUM,RPIEN) ; build one line to display
 ; LNUM - last line number
 ; RPIEN - ien in file 340.5
 ;
 ; returns current line number
 ;
 N AMNT,BAL,DEBTOR,LINE,LN,N0,TERM
 S N0=$G(^RCRP(340.5,RPIEN,0)) I N0="" Q LNUM
 I "^6^7^8^"[(U_$P(N0,U,7)_U) Q LNUM  ; skip plans in "closed", "paid in full", and "terminated" status
 S LINE="",LN=LNUM+1
 S DEBTOR=$$EXTERNAL^DILFD(340.5,.02,,$P(N0,U,2))
 S AMNT=+$P(N0,U,6),BAL=$$CBAL^RCRPU3(RPIEN,$P(N0,U,11)),TERM=$$REMPMNTS^RCRPU3(RPIEN,AMNT)  ; PRCA*4.5*423
 S LINE=$$SETSTR^VALM1(LN,LINE,1,3)
 S LINE=$$SETFLD^VALM1($P(N0,U),LINE,"RPPID")
 S LINE=$$SETFLD^VALM1($E(DEBTOR,1,20),LINE,"DEBTOR")
 S LINE=$$SETFLD^VALM1($$CJ^XLFSTR($S(TERM>0:TERM,1:"N/A"),4),LINE,"TERM")
 S LINE=$$SETFLD^VALM1($$CJ^XLFSTR($S(AMNT>0:"$"_$FN(AMNT,"",2),1:"N/A"),9),LINE,"AMOUNT")
 S LINE=$$SETFLD^VALM1($$CJ^XLFSTR($S(BAL>0:"$"_$FN(BAL,"",2),1:"N/A"),9),LINE,"BALANCE")
 D SET^VALM10(LN,LINE,LN)
 S @VALMAR@("IDX",LN,LN)=RPIEN
 Q LN
