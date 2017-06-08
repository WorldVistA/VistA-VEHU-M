DGV51PT1 ;ALB/RMO - DG POST-INIT FOR VERSION 5.1 CONT. (OBSOLETE TEMPLATES) ; 2 MAY 90 2:55 pm
 ;;MAS VERSION 5.1;
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
 ;;DGBTEE;I;392;
 ;;DGBTPOP;I;392;
 ;;DGBED;P;42;
 ;;QUIT
