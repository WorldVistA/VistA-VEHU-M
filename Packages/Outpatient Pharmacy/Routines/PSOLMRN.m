PSOLMRN ;ISC-BHAM/SAB - displays renewal rxs ;04/21/1995
 ;;7.0;OUTPATIENT PHARMACY;**11,46,84,225,386,700**;DEC 1997;Build 261
EN ; -- main entry point for PSO LM RENEW LIST
 S VALMCNT=PSOPF,PSOLM=1
 D EN^VALM("PSO LM RENEW LIST")
 Q
 ;
HDR ; -- header code
 K ^TMP("PSOHDR",$J) D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=PSOPF,PSOLM=1
 I $G(ORD),$$GET1^DIQ(52.41,ORD,102,"I") S VALM("TITLE")="FL-"_VALM("TITLE")
 I $G(PSOVLMBG)>3 S VALMBG=PSOVLMBG-2
 D RV^PSONFI Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 I $G(Y)=-1!($G(Y)="Q") S PSOQUIT=1
 I $G(Y)="Q",$P($G(Y(1)),"^",3)="QU" S PSOQQ=1
 K FLAGLINE D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
