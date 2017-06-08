ENXIIEN ;(WIRMFO)/DH- ENVIRONMENTAL CHECK ;11/29/95
 ;;7.0;ENGINEERING;**29**;Aug 17, 1993
 W !!,"Performing Environmental Check..."
 I DUZ(0)'["@" W !,"  Please set DUZ(0)=""@"" and re-run this Init." K DIFQ
 I $P($G(^DIC(6910,1,0)),U,2)'?3N.2UN W !,"  STATION NUMBER in Eng Init Parameters File (#6910) is not in order." K DIFQ
 I '$$FIND1^DIC(2101.1,"","X","FIXED ASSETS","B") D  K DIFQ
 . W !,"  Batch Type FIXED ASSETS not found. No action taken."
 . W !,"    Generic Code Sheet patch GEC*2*8 must be installed prior to"
 . W !,"    installation of this patch. Patch GEC*2*8 will create Batch"
 . W !,"    Type FIXED ASSETS in file #2101.1. Please rerun this"
 . W !,"    installation program (ENXIINIT) after installing patch GEC*2*8."
 W !,"Environmental Check Completed",!
 I '$D(DIFQ) W $C(7),!,"Can't proceed. Database unchanged."
 Q
 ;ENXIIEN
