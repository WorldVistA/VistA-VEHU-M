 D ^%ZIS
TRAN ;
 S J=0
 F K=0:0 S J=$N(^PSTRAN(J)) Q:J=6000  D DRUG
 Q
DRUG ;
 U IO W:$D(^PSDRUG(J,0)) !,"PSTRAN("_J_",0)",?25,"matches",?50,"PSDRUG("_J_",0)"
 U IO W:'$D(^PSDRUG(J,0)) !,"PSTRAN("_J_",0)",?25,"not in",?50,"PSDRUG("_J_",0)"
 Q
 Q
