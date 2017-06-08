DGV52PT1 ;ALB/RMO - DG POST-INIT FOR VERSION 5.2 CONT. (OBSOLETE TEMPLATES) ; 2 MAY 90 2:55 pm
 ;;5.2;REGISTRATION;;JUL 29,1992
 ;==============================================================
 ;Entry Points:
 ; PRT     -Print list of obsolete templates
 ; DEL     -Delete obsolete templates
 ;==============================================================
 ;
PRT ;Print list of obsolete templates
 ; Input  -- None Required
 ; Output -- List of obsolete templates
 W !!,">>> The following templates are considered obsolete with this release and will",!?4,"be removed from your system in the 'DG' Post-init.  They are no longer",!?4,"supported by the development ISC.",!!?4
 W !!?4,"Template",?30,"Type",?40,"File",?50,"Routine",!?4,"--------",?30,"----",?40,"----",?50,"-------"
 F DGI=1:1 S DGTEM=$P($T(TEMP+DGI),";;",2) Q:DGTEM="QUIT"  W !?4,$P(DGTEM,";",1),?30,$S($P(DGTEM,";",2)="I":"INPUT",$P(DGTEM,";",2)="S":"SORT",1:"PRINT"),?40,$P(DGTEM,";",3),?50,$P(DGTEM,";",4)
QPRT K DGI,DGTEM
 Q
 ;
DEL ;Delete obsolete templates
 ; Input  -- None Required
 ; Output -- Obsolete templates are deleted
 W !!,">>> Deleting obsolete templates:",!
 S DGTRF="B" F DGI=1:1 S DGTEM=$P($T(TEMP+DGI),";;",2) Q:DGTEM="QUIT"  D CHK
QDEL K DGI,DGTEM,DGTFL,DGTGL,DGTIFN,DGTNM,DGTRF,DGTY
 Q
 ;
CHK S DGTNM=$P(DGTEM,";"),DGTY=$P(DGTEM,";",2),DGTFL=+$P(DGTEM,";",3),DGTGL=$S(DGTY="I":"^DIE(",DGTY="S":"^DIBT(",1:"^DIPT(")
 F DGTIFN=0:0 S DGTIFN=$O(@(DGTGL_"DGTRF,DGTNM,DGTIFN)")) Q:'DGTIFN  I $D(@(DGTGL_"DGTIFN,0)")),$P(^(0),"^",4)=DGTFL D KIL
 Q
 ;
KIL W !?4,"...",$S(DGTY="I":"Input",DGTY="S":"Sort ",1:"Print")," template ",DGTNM," for file #",DGTFL
 S DA=+DGTIFN,DIK=DGTGL D ^DIK K DA,DIK W " deleted."
 Q
 ;
TEMP ; -- ;;name;type;file;routine
 ;;DGJ INC MULTI HEADING;P;393
 ;;DGJ INC ONE HEADING;P;393
 ;;DGJ INCOMPLETE BY DATE;P;393
 ;;DGJ INCOMPLETE GENERAL PRINT;P;393
 ;;DGJ INCOMPLETE SERVICE;P;393
 ;;DGJ IRT TRAILER;P;393
 ;;DGJ UNDIC MULTI HEADING;P;393
 ;;DGJ UNDIC ONE HEADING;P;393
 ;;DGJ UNDICTATED BY DATE;P;393
 ;;DGJ UNDICTATED BY PHYS ONE DIV;P;393
 ;;DGJ UNDICTATED BY PHYSICIAN;P;393
 ;;DGJ UNDICTATED GENERAL PRINT;P;393
 ;;DGJ DATE MULTI DIVISION;S;393
 ;;DGJ DATE ONE DIVISION;S;393
 ;;DGJ PATIENT MULTI DIVISION;S;393
 ;;DGJ PATIENT ONE DIVISION;S;393
 ;;DGJ PHYSICIAN MULTI DIVISION;S;393
 ;;DGJ PHYSICIAN ONE DIVISION;S;393
 ;;DGJ SERVICE MULTI DIVISION;S;393
 ;;DGJ SERVICE ONE DIVISION;S;393
 ;;DGMT;I;43
 ;;DGMT;I;2
 ;;DGMTEDIT;I;41.3 
 ;;QUIT
