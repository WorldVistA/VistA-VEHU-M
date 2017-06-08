DGYJPR ;ALB/MTC - DGYJ PRE-INIT  ; 3/18/93
 ;;5.2;REGISTRATION;**24**;JUL 29,1992
 ;
CLEXCD ;-- delete PTF EXANDED CODE (#45.89) file
 ;   This had to done because FM had trouble resolving a variable ptr.
 N I
 W !!,"Cleaning up entries in the PTF EXPANDED CODE file (#45.89)..."
 S I=0 F  S I=$O(^DIC(45.89,I)) Q:'I  K ^DIC(45.89,I)
 K ^DIC(45.89,"B"),^DIC(45.89,"ASPL")
 Q
 ;
