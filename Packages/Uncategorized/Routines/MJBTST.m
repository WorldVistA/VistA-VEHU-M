MJBTST ;NEW PROGRAM [ 04/28/93  8:53 AM ]
 ;
 ;
BEGIN ;
 D TOP
 S MJB=""
 F J=0:0 S MJB=$O(^LAB(60,"B",MJB))  Q:MJB=""  F MBB=0:0 S MBB=$O(^LAB(60,"B",MJB,MBB)) Q:MBB=""  I $D(^LAB(60,MBB,0))  D SHOW
 ;
 ;
SHOW ;DISPLAY RESULTS
 W !,MBB,?15,$P(^LAB(60,MBB,0),"^",1)
 Q
TOP ;
 W !,"NUM.",?15,"NAME",!
 W "+++++++++++++++++++++++++++++++++++++++++++++++++"
 Q
