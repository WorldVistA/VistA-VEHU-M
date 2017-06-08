RJTGS ; ;[ 02/21/96  2:53 PM ]
 S F=""
 F I=0:0 S F=$O(^DIC(F)) Q:F=""  I $D(^DIC(F,0)) S G=$P(^DIC(F,0),"^",1) D ONE
 Q
ONE ;
 I '$D(^DD(F,0,"NM",G)) S ^DD(F,0,"NM",G)="" W !,"DD"_"("_F_","_"0,NM,"_G_")"_"   added."
 Q
