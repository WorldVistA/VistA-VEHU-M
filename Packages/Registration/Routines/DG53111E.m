DG53111E ;ALB/ABR - Environment check for DG*5.3*111 ; 1/24/97
 ;;5.3;Registration;**111**;Aug 13, 1993
 ;
 ;  This is an environment check for the presence of 
 ;  patch DI*21*15
 ;
 ;  (copied from SCMCENV routine.)
EN ;
 N DGRT,DGROUT,DGCOMM,DG2CHECK,DG2LINE
 D DGRT
 I $D(XPDABORT) W !,">>> DG*53*111 Aborted in Environment Checker" Q
 W !!,">>> Environment is OK"
 Q
 ;
DGRT S DGRT=$P($T(ROUTINE+1),";;",2)
 S DGROUT=$P(DGRT,U,1)
 S DGCOMM="S DG2LINE=$P($T(+2"_U_DGROUT_"),"";;"",2)"
 X DGCOMM
 S DG2CHECK=$P(DGRT,U,2,99)
 IF '$L(DG2LINE) D  Q
 .W "Missing VA FILEMAN routine DIFROMSS"
 .S XPDABORT=2
 IF $P(DG2LINE,";",1)>$P(DG2CHECK,U,1) D  Q
 .W !?10,"Version of ",$P(DG2LINE,";",2)," is greater than standard - No patch checks done"
 IF $P(DG2LINE,";",1)<$P(DG2CHECK,U,1) D  Q
 .W !?10,"Version of ",$P(DG2LINE,";",2)," is less than required"
 .S XPDABORT=2
 IF $P(DG2LINE,";",3)'[$P(DG2CHECK,U,3) D  Q
 .W !?10,"Missing Patch  DI*21*15"
 .S XPDABORT=2
 Q
 ;
ROUTINE ;
 ;;DIFROMSS^21.0^VA FileMan^15^Dec 28, 1994
