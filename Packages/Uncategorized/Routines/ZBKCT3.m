%ZBKCT3 ;GJL/SF ;13 FEB 1985@13:51;M/11+ BLOCK COUNT
 ;1.0
 O 63::0 E  S %T="The VIEW device is busy." G EXIT
 D ^%ST S %G="" F %B=1:1:$V(%ST("DIR"),-3) S %G=%G_$C($V(%ST("DIR")+%B,-3))
 S %B=$ZU(8,$V(%ST("DIRTAB"),-3,2),1,%G) G EXIT:'%B
 S %B=$V(%B,-3)*34+%ST("GFT"),%B=$V(%B+10,-3,3)
MPLGD V %B S %G="",%E=$V(2046,0,2),%O=0
 F %I=0:1 Q:%E'>%O  S %Z=$V(%O,0),%O=%O+1 S:%Z %G=%G_$C(%Z) I '%Z Q:%G=$P(X,"(",1)  S %G="",%O=%O+9
 I %G'="" S %T=0,%O=%O+6 D MPLPTDW S %B=%L,%N="" G MPLPTBK
 S %B=$V(2040,0,3) I %B G MPLGD
 G EXIT
MPLPTBK V %B S (%H,%J,%L,%O)=0,%E=$V(2046,0,2) I $V(2043,0,1)=8 G MPLDATA
MPLPTLP I %O<%E G MPLPTNT
 S %B=$V(2040,0,3) I %B=0 S %B=%L
 I %B G MPLPTBK
 G EXIT
MPLPTNT D MPLNODE I %I=2 D MPLPTDW S %O=%O+3 G MPLPTLP
 I %I=1,%L=0 D MPLPTDW
 S %B=%L G MPLPTBK
MPLPTDW S %L=$V(%O,0,3) Q
 ;
MPLDTBK V %B S %O=0,%E=$V(2046,0,2),%T=%T+1,%J=0
MPLDATA I %O<%E G MPLDTNT
 S %B=$V(2040,0,3) I %B G MPLDTBK
 G EXIT
MPLDTNT S %J=%J+1 D MPLNODE I %I=1 S:%H=0 %T=%T+1 S %H=1,%O=%E G MPLDATA ;Next BLK
 I %I=2 S %I=$V(%O,0,2),%O=%O+2+$S(%I<511:%I,%I<33024:8,%I>33024:4,1:0) G MPLDATA ;Len=(ACSII,EXP,INT,0)
 S:%J=1 %T=%T-1 G EXIT
MPLNODE S %C=$V(%O,0,1),%W=$V(%O+1,0,1),%O=%O+2,%I=%O,%K="" F %I=%I:1:%O+%W I %I<(%O+%W) S %Z=$V(%I,0,1),%K=%K_$C(%Z)
 S %O=%I,%N=$E(%N,0,%C)_%K,%F=$E(%N,$L(%G)+1,256),%M="",%I=0
MPLPROC S %I=%I+1 I %I>$L(%F) G MPLTSTN
 S %V=$A(%F,%I) I %V=0 S %M=%M_"," G MPLPROC ;Level
 I %V=1 G MPLZERO
 I %V>31 S %M=%M_$C(%V) ;ASCII and Pos
 G MPLPROC
MPLZERO S %I=%I+1,%V=$A(%F,%I) I %V=48 S %M=%M_"0" G MPLPROC
 S %S="",%V=30-%V+1
MPLNEG S %I=%I+1 I $A(%F,%I)'=255 S %S=%S_$C(105-$A(%F,%I)) G MPLNEG
 I %V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,512)
 S %M=%M_"-"_%S G MPLPROC
MPLTSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
MPLTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G MPLSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
MPLTSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G MPLTSTL
MPLSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G MPLTSTC
EXIT C 63 K %A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%V,%W,%X,%Y,%Z,%ST
