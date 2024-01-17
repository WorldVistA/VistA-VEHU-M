PSOLMPO1 ;ISC-BHAM/SAB - complete pending orders ;03/13/1995
 ;;7.0;OUTPATIENT PHARMACY;**46,71,225,700**;DEC 1997;Build 261
  ;
EN ; -- main entry point for PSO LM COMPLETE ORDER
 D EN^VALM("PSO LM COMPLETE ORDER")
 K PSOANSQD
 Q
 ;
HDR ; -- header code
 D HDR^PSOLMUTL
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=IEN,VALM("TITLE")=$S($P(OR0,"^",23):"FL-",1:"")_"Pending OP Orders ("_$S($P($G(OR0),"^",14)="S":"STAT",$P($G(OR0),"^",14)="E":"EMERGENCY",1:"ROUTINE")_")"
 I $G(PSOVLMBG)>3 S VALMBG=PSOVLMBG-2
 D RV^PSONFI
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K FLAGLINE,PSOVLMBG D CLEAN^VALM10
 ; Variables used for formatting eRx Display
 K UNDERLN,REVLN,HIGHLN,BLINKLN,HIGUNDLN
 Q
 ;
EXPND ; -- expand code
 Q
 ;
