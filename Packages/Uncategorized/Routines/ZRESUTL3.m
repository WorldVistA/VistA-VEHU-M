ZRESUTL3 ;NLI UTILITY PROGRAMS
 ;Copyright Aspire Technology 1997  All rights reserved
 ;FIND bad ssns
SSNCHK ;
 N SSN,DFN
 S SSN="",DFN=0
 w !,"SSN Analysis....",!
LPDFN ;
 F  S DFN=$O(^DPT(DFN)) Q:DFN=""  D  ;
 .;I $G(^DPT(DFN,0))="" W " No record...",!
 .S SSN=$P($G(^DPT(DFN,0)),"^",9)
 .I SSN="" D BADSSN
 .I SSN["0000000" D BADSSN
 .I SSN["P" D BADSSN
BADSSN ;
 S NAME=$P($G(^DPT(DFN,0)),"^",1)
 W "Bad SSN:"_SSN,?24,"Name:",NAME,?55," DFN="_DFN,!
 Q
DUPSSN ;FIND DUPLICATE SSN'S
 N DFN,X
 S DFN=0,CNT=0 K ^TMP($J)
 F  S DFN=$O(^DPT(DFN)) Q:DFN=""  D  ;
 .S CNT=CNT+1
 .S X=$P($G(^DPT(DFN,0)),"^",9)
 .I X="" Q
 .I $D(^TMP($J,X))>0 W !,"Duplicate SSN:",X," DFN=",$G(^TMP($J,X)),! Q
 .I (CNT#10000)=0 W "Entries check:",CNT,!
 .S ^TMP($J,X)=DFN
 K ^TMP($J) ;CLEANUP
 Q
