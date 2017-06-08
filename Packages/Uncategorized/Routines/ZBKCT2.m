%ZBKCT2 ;GJL/SF ;15 FEB 1985@9:55;M/11 BLOCK COUNT
 ;4.3
 O 63::0 E  S %T="The VIEW device is busy." G EXIT
 S %D=$V(44),%O=$V(149,$J)-1*18+$V(%D+12),%B=$V(%O+4)#256*65536+$V(%O+2)
M11GD V %B S %G="",%E=$V(1022,0),%O=0
 F %I=0:1 Q:%E'>%O  S %Z=$V(%O,0)#256,%G=%G_$C(%Z\2),%O=%O+1 I '(%Z#2) Q:%G=$P(X,"(",1)  S %G="",%O=%O+8
 I %G'="" S %T=0,%O=%O+5 D M11PTDW S %B=%L,%N="" G M11PTBK
 S %B=$V(1016,0)#256*65536+$V(1014,0) I %B G M11GD
 G EXIT
M11PTBK V %B S (%H,%J,%L,%O)=0,%E=$V(1022,0) I ($V(1021,0)#256)=8 G M11DATA
M11PTLP I %O<%E G M11PTNT
 S %B=$V(1020,0)#256*65536+$V(1018,0) I %B=0 S %B=%L
 I %B G M11PTBK
 G EXIT
M11PTNT D M11NODE I %I=2 D M11PTDW S %O=%O+3 G M11PTLP
 I %I=1,%L=0 D M11PTDW
 S %B=%L G M11PTBK
M11PTDW S %L=$V(%O+2,0)#256*65536+($V(%O+1,0)#256*256)+($V(%O,0)#256)
 Q
M11DTBK V %B S %O=0,%E=$V(1022,0),%T=%T+1,%J=0
M11DATA I %O<%E G M11DTNT
 S %B=$V(1020,0)#256*65536+$V(1018,0) I %B G M11DTBK
 G EXIT
M11DTNT S %J=%J+1 D M11NODE I %I=1 S:%H=0 %T=%T+1 S %H=1,%O=%E G M11DATA ;Next BLK
 I %I=2 S %I=$V(%O,0)#256,%O=%O+%I+1 G M11DATA
 S:%J=1 %T=%T-1 G EXIT
M11NODE S %C=$V(%O,0)#256,%W=$V(%O+1,0)#256,%O=%O+2
 S %K="" F %O=%O:1:%O+%W-1 S %K=%K_$C($V(%O,0)#256)
 S %O=%O+1,%N=$E(%N,0,%C)_%K,%F=$E(%N,$L(%G)+1,256),%M="",%I=0
M11PROC S %I=%I+1 I %I>$L(%F) G M11TSTN
 S %M=%M_",",%V=$A(%F,%I) I %V=0 S %M=%M_"" G M11PROC ;Null
 I %V=1 G M11ZERO
 I (%V\2)<32 S %I=%I+1,%V=$A(%F,%I) ;Pos
M11ASCI S %M=%M_$C(%V\2) I %V#2 S %I=%I+1,%V=$A(%F,%I) G M11ASCI
 G M11PROC
M11ZERO S %I=%I+1,%V=$A(%F,%I)\2 I %V=48 S %M=%M_"0" G M11PROC
 S %S="",%V=30-%V+1
M11NEG S %I=%I+1 I $A(%F,%I)'=128 S %S=%S_$C(105-($A(%F,%I)\2)) G M11NEG
 I %V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,255)
 S %M=%M_"-"_%S G M11PROC
M11TSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
M11TSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G M11STR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
M11TSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G M11TSTL
M11STR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G M11TSTC
EXIT C 63 K %A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%V,%W,%X,%Y,%Z
