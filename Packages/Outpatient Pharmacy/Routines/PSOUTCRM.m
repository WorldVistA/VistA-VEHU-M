PSOUTCRM ;ORLFO/FJF/WC - PSO utilities for CRM; Mar 20, 2023@12:57:56
 ;;7.0;OUTPATIENT PHARMACY;**707**;DEC 1997;Build 18
 ; 
 ; PSO utilities for SalesForce CRM application
 ;
SWAP(INPT,THIS,THAT) ; swap this with that in a string
 N OUTP,I
 F I=1:1:$L(INPT,THIS) D
 .S $P(OUTP,THAT,I)=$P(INPT,THIS,I)
 Q OUTP
 ;
RXVAL(RXN)  ; validate Presciption number and return 0 node
 ;  INPUT:
 ;      RXN - external Presciption number
 ;
 ;  OUTPUT:
 ;      1 = valid
 ;      0 or less = invalid prescription
 ;
 ;
 N DFN,LIST,X
 S X=0,RXN=$G(RXN) Q:RXN="" 0
 S DFN=-1
 S LIST="PSOV"
 D RX^PSO52API(DFN,LIST,,RXN)
 I $O(^TMP($J,"PSOV",$O(^TMP($J,"PSOV",-2))))>0 Q 1
 Q 0
 ;
