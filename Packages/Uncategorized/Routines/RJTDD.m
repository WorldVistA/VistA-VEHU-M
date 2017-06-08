RJTDD ; ;[ 02/23/96  10:38 AM ]
 S F=0,G="",J="",H=""
 F I=0:0 S F=$O(^DD(F)) Q:F=""  D ONE
 Q
ONE ;
 S G=$P(^DD(F,0),"^",1),H=$L(G," "),J=H-1
 I G["SUB-FIELD" D TWO
 Q
TWO I '$D(^DD(F,0,"NM",$P(G," ",1,J))) S @$ZR="" W !,$ZR_" fixed..."
 Q
 
