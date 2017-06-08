NPDRKILL ;6/7/88  3:36 PM
 S U="^"
 S (BX,NPC)=""
 S NPC="" F DA=0:0 S DA=$O(^PSDRUG(DA)) Q:+DA=0  I $D(^["SUP"]NPTEST("DR",DA))=0 D GETREF K ^PSDRUG("B",BX),^PSDRUG(DA) S NPC=NPC+1 W !,"Entry #",DA," is killed!"
 W !!!,"There have been ",NPC," entries killed!"
 K BX,NPC Q
GETREF ;
 S BX=$P(^PSDRUG(DA,0),U) F I=0:0 S I=$O(^PSDRUG(DA,1,I)) Q:+I=0  D KILLC
 Q
KILLC ;
 I $D(^PSDRUG(DA,1,I,0)) S CX=$P(^(0),U) K ^PSDRUG("C",CX,DA)
 Q
