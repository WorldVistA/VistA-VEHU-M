PSOEPVER ;BIRM/VRN - ePCS VERSION CHECK ; 5/28/21 13:56
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;
GUICHK(RESULTS,DUMMY) ;
 ;
 ; RPC : ePCS VERSION CHECK
 ;
 K RESULTS
 N PSOCURR,PSOPREV,PSOCNT
 S PSOCURR="2.2.0.*"
 S PSOPREV="",PSOCNT=0
 S PSOCNT=PSOCNT+1
 S RESULTS(PSOCNT)=PSOCURR_U_PSOPREV
 S RESULTS(0)=PSOCNT
 Q
 ;
