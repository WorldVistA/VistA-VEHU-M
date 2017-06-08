DIRCR ; SF/GFT - DELETE THIS LINE AND SAVE AS '%RCR'*** ;11/29/90  10:59 AM
 ;;19.0;VA FileMan;;Jul 14, 1992
%RCR ;GFT/SF
 ;
NEW ;
 K %K S %K="KILL"
STORLIST ;
 N %A,%C,%E
 D INIT I $D(%K),%K="KILL" S ^(1,0)=%K
O S %D=$N(%RCR(%D)) G CALL:%D<0
 I $D(@%D)#2 S @(%E_")="_%D) G K:$D(@%D)=1
 S %X=%D_"(" D %XY
K K:%K="KILL" @%D G O
 ;
CALL S %E=%RCR K %K,%RCR,%X,%Y D @%E
 S %E="^UTILITY(""%RCR"",$J,"_^UTILITY("%RCR",$J)_",%D",^($J)=^($J)-1,%D=0,%X=%E_","
G S %D=$N(@(%E_")")) I %D<0 K %D,%E,%X,%Y,^($J,^UTILITY("%RCR",$J)+1) Q
 K:$D(^(0)) @%D I $D(^(%D))#2 S @%D=^(%D) G G:$D(^(%D))=1
 S %Y=%D_"(" D %XY G G
 ;
%XY ;
 S %Z=1,%A="",%C(0)=0
S S %B=-1
N S %B=$N(@(%X_%A_"%B)")),%C(%Z)=%C(%Z-1)
 I %B["," F %C=0:0 S %C=$F(%B,",",%C) Q:'%C  S %C(%Z)=%C(%Z)+1
 I %B=-1 G Q:%Z=1 S %Z=%Z-1,@("%B="_$P(%A,",",%Z+%C(%Z-1),%Z+%C(%Z))),%A=$P(%A,",",1,%Z-1+%C(%Z-1))_$E(",",%Z>1) G N
 I $D(@(%X_%A_"%B)"))#10=1 S @(%Y_%A_"%B)="_%X_%A_"%B)")
 I $D(@(%X_%A_"%B)"))<9 G N
 I $E(%B)'=0,%B?1.N G DOWN
 F %C=0:0 S %C=$F(%B,"""",%C) Q:'%C  S %B=$E(%B,1,%C-1)_""""_$E(%B,%C,999),%C=%C+1
 S %B=""""_%B_""""
DOWN S %A=%A_%B_",",%Z=%Z+1 G S
 ;
Q K %A,%B,%C,%Z Q
 ;
INIT I $D(^UTILITY("%RCR",$J))[0 S ^UTILITY("%RCR",$J)=0
 S ^($J)=^($J)+1,%D="%Z",%E="^UTILITY(""%RCR"",$J,"_^($J)_",%D",%Y=%E_","
 K ^($J,^($J)) S:'$D(%K) %K=""
 Q
OS ;
 S $P(^%ZOSF("OS"),"^",2)=DITZS
 K DITZS S ZTREQ="@"
 Q
