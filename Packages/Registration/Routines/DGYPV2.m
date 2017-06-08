DGYPV2 ;ALB/MTC - Pre MAS v5.3 Routine Cont ;22 APR 93
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 ;
HEAD ;-- write header for report
 S DGPG=DGPG+1
 W @IOF,"Inconsistent Pointers from the ",$O(^DD(FILE,0,"NM",""))_" File #",FILE
 W " to file #6 or #16.",?IOM-10,"Page :",DGPG,!!
 S DGCNT=2
 Q
 ;
NOERR ;-- Message to indicate no errors were found
 W !,"No inconsistent pointers found."
 Q
 ;
HDCHK ;-- check if header should be printed
 I DGCNT>(IOSL-4) D
 . I DGPG>0,$P(IOST,"-")="C" S DIR(0)="E" D ^DIR K DIR I 'Y S DGFLAG=1 Q
 . D HEAD
 Q
 ;
IN200(PROV) ; This function will determine if there is a corresponding
 ; pointer for the entry PROV from the Provider File (#6) in the
 ; New Person File (#200). If the is no entry the record will be printed.
 ;
 N ENTRY,Y,DATE
 G:PROV="" IN200Q
 S ENTRY=$G(^DIC(16,PROV,"A3"))
 I ENTRY="" S NOERR=0 D HDCHK G:DGFLAG IN200Q D
 . I FILE=2 D DPT  Q
 . I FILE=405 D DGPM  Q
 . I FILE=392 D DGBT  Q
 . I FILE=41.1 D DGS  Q
 . I FILE=45 D DGPT  Q
 . I FILE=44 D SC  Q
 . I FILE=45.7 D DIC457  Q
IN200Q ;
 Q
 ;
DGPM ;-- Print Routine for file #405
 N Y,DATE
 S Y=$P($G(^DGPM(RECNUM,0)),U) X ^DD("DD") S DATE=Y
 S Y="Patient Movement for :"_DATE_" ("_RECNUM_") "
 S Y=Y_$S(PIE=8:"PRIMARY CARE PHY fld (.08)",1:"ATTENDING PHY fld (.19)")_" contains :"_$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")_" ("_PROV_")"
 S DGCNT=DGCNT+1 W !,Y
 Q
 ;
DPT ;-- Print Routine for file #2
 W !,"Patient :",$P($G(^DPT(RECNUM,0)),U)," (",RECNUM,") ",$S(NODE=.104:"PROVIDER field (.104)",1:"ATTENDING PHYSICIAN field (.1041)")," contains :",$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")," (",PROV,")" S DGCNT=DGCNT+1
 Q
 ;
DGBT ;-- Print Routine for file #392
 N Y,DATE
 S Y=$P($G(^DGBT(392,RECNUM,0)),U) X ^DD("DD") S DATE=Y
 S Y="Claim DATE/TIME "_DATE_" AUTHORIZING PERSON field (41) contains "_$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")_" ("_PROV_")"
 S DGCNT=DGCNT+1 W !,Y
 Q
 ;
DGS ;-- Print Routine for file #41.1
 W !,"Scheduled Admission for Patient :",$P($G(^DPT(+$P($G(^DGS(41.1,RECNUM,0)),U),0)),U)," (",RECNUM,") PROVIDER field (5) contains ",$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")," (",PROV,")" S DGCNT=DGCNT+1
 Q
 ;
DGPT ;-- Print Routine for file #45
 N Y
 S Y="PTF Patient :"_$P($G(^DPT(+$P($G(^DGPT(RECNUM,0)),U),0)),U)_" ("_RECNUM_")"
 I NODE=70 S Y=Y_" PROVIDER field (79.1) contains "
 I NODE="P" S Y=Y_" in Movement #"_SEQ_" PROVIDER field (24) contains "
 S Y=Y_$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")_" ("_PROV_")"
 S DGCNT=DGCNT+1 W !,Y
 Q
 ;
SC ;-- Print Routine for file #44
 W !,"Hospital Location :",$P($G(^SC(RECNUM,0)),U)," (",RECNUM,") DEFAULT PROVIDER field (16) contains ",$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")," (",PROV,")" S DGCNT=DGCNT+1
 Q
 ;
DIC457 ;-- Print Routine for file #45.7
 W !,"Facility Treating Specialty :",$P($G(^DIC(45.7,RECNUM,0)),U)," (",RECNUM,") PROVIDERS field (10) contains ",$S($G(^DIC(16,PROV,0))'="":$P(^(0),U),1:"<UNKNOWN>")," (",PROV,")" S DGCNT=DGCNT+1
 Q
 ;
