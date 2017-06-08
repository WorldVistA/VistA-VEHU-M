DGPM50 ;ALB/MIR - CONVERSION PROCESS, CONTINUED ; 2 FEB 91
 ;;MAS VERSION 5.0;
END ;get end time, record times, fire bulletin if necessary
 D NOW^%DTC S DGPM5END=% K %
 S $P(^DG5(1,"T",DGPME,0),"^",3)=DGPM5END
 I "^4^5^6^"'[("^"_DGPME_"^") G Q ;don't fire bulletin if not 4,5 or 6
BULL ; -- bulletins to user running conversion
 K ^UTILITY("DGPM5",$J,"TEXT")
 S XMSUB=$S(DGPME=4:"Conversions of inpatients since recalc date",DGPME=5:"Recalculation",1:"Conversion of remaining inpatient data")_" has completed"
 S XMY(DUZ)="",XMTEXT="^UTILITY(""DGPM5"",$J,""TEXT"",",DGPMLINE=0,XMDUZ=.5
 S DGPML="The "_$S(DGPME=4:"conversion of patients in-house since your initialization date",DGPME=5:"recalculation of you G&L statistics",1:"conversion of all remaining inpatient data")_" is complete."
 D SET S DGPML=" " D SET
 S VADAT("W")=DGPM5BEG D ^VADATE S DGPML="       Step started  :  "_VADATE("E") D SET
 S VADAT("W")=DGPM5END D ^VADATE S DGPML="       Step completed:  "_VADATE("E") D SET
 S DGPML=" " D SET
 I "^4^6^"[("^"_DGPME_"^") S DGPML="There are now "_$P(^DGPM(0),"^",4)_" entries in your PATIENT MOVEMENT file." D SET
 S DGPML=" " D SET
 S DGPML=" " D SET,SET
 S DGPML=$S(DGPME=4:"The recalulation of your G&L statistics has started.",DGPME=5:"The conversion of your remaining inpatient data has started.",1:"You have now completed the conversion process!") D SET S DGPML=" " D SET
 D ^XMD K XMDUZ
BULLQ K DGPML,DGPMLINE,XMY,XMSUB,XMTEXT D KVAR^VADATE
Q K DGPM5BEG,DGPM5END
 Q
 ;
SET ; -- set line in xmtext array
 S DGPMLINE=DGPMLINE+1
 S ^UTILITY("DGPM5",$J,"TEXT",DGPMLINE,0)=DGPML
 Q
 ;
 ;
 ;
 ;
 ;
RESET ;make sure C405 nodes are cleaned up
 I '$D(^DPT("C405")) Q
 W !!,"The following patients were in the process of being moved:"
 F DFN=0:0 S DFN=$O(^DPT("C405",DFN)) Q:'DFN  W !?5,"DFN = ",DFN,?18,"Name [Last 4]::  ",$S($D(^DPT(DFN,0)):$P(^(0),"^",1)_" ["_$E($P(^(0),"^",9)_"]",6,9),1:"")
 W !!,"Cleaning up ""C405"" nodes for these patients" F I=0:0 S I=$O(^DPT("C405",I)) Q:'I  K ^DPT(I,"C405") W "."
 W !!,"Killing temporary ""C405"" cross-reference." K ^DPT("C405")
 W !!,"Clean-up complete..."
 Q
 ;
 ;
QUEUE ;queue off part 2 (pts since recalc, recalc, remaining pts)
 W !,"You are about to ",$S(DGPME'=4:"re",$D(^DG5(1,"T",4)):"re",1:""),"start part II of the conversion process."
 W !!,"The following will be queued to run:"
 I DGPME=4 W !?3,"Movement of inpatient data for patients in house since " S Y=+^DG5(1,"P") X ^DD("DD") W Y
 I DGPME'=6 W !?3,"Recalculation of G&L statistics from " S Y=+^DG5(1,"P") X ^DD("DD") W Y
 W !?3,"Conversion of all remaining inpatient data"
 D NOW^%DTC
 S ZTDESC="MAS V5 CONVERSION - PART II",ZTRTN=DGPME_"^DGPM5",ZTDTH=%,ZTIO="" D ^%ZTLOAD
 W !!,"To monitor, please watch task ",ZTSK,!!
 W !,"NOTE:  A message will appear in your 'IN' basket upon completion of each step."
 K ZTDESC,ZTRTN,ZTIO,ZTDTH,X,Y
 Q
 ;
RECALC ; code to call recalc
 S DGZTSK=ZTSK
 S RC=+^DG5(1,"P"),X1=DT,X2=-1 D C^%DTC S (X1,RD)=X,X2=-1 D C^%DTC S PD=X,(REM,GL,BS)=0
 D GO^DGPMBSAR
 S ZTSK=DGZTSK K DGZTSK
 D ENA ;re-enable the G&L options
 Q
 ;
 ;
DIS ; -- disable options
 N DGDR
 S DGDR="2////MAS V5 CONVERSION IN PROGRESS...OPTION IS NOT AVAILABLE"
 D SETOPT
 Q
 ;
ENA ; -- enable options
 N DGDR
 S DGDR="2////@"
 D SETOPT
 Q
 ;
SETOPT ; -- scan options and call DIE
 N DGI,X K DA
 F DGI=1:1 S X=$P($T(OPT+DGI),";",3) Q:X="$END"  S DA=+$O(^DIC(19,"B",X,0)) I $D(^DIC(19,DA,0)) S DR=DGDR,DIE="^DIC(19," D ^DIE K DA,DR,DIE,DQ,DE
 Q
 ;
OPT ; -- option list
 ;;DG G&L RECALC
 ;;DG G&L RECALCULATION AUTO
 ;;DG G&L SHEET
 ;;$END
