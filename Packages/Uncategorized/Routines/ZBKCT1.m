%ZBKCT1 ;GJL/SF ;13 FEB 1985@15:15;DSM BLOCK COUNT
 ;4.3
 O 63::0 E  S %T="The VIEW device is busy." G EXIT
 S %D=$P($ZU(""),",",2),%O=+$ZU(""),%A=$V(44),%S=$V(%A+12),%M=$V($V(%A+34)#256*%D+%S+2),%O=%O-1*20
 S %B=$V(%O+4,%M)#256*65536+$V(%O+2,%M),%D="S"_%D
DSMGD V %B:%D S %G="",%E=$V(1022,0),%O=0
 F %I=0:1 Q:%E'>%O  S %Z=$V(%O,0)#256,%G=%G_$C(%Z\2),%O=%O+1 I '(%Z#2) Q:%G=$P(X,"(",1)  S %G="",%O=%O+8
 I %G'="" S %T=0,%O=%O+5 D DSMPTDW S %B=%L,%N="" G DSMPTBK
 S %B=$V(1016,0)#256*65536+$V(1014,0) I %B G DSMGD
 G EXIT
DSMPTBK V %B:%D S (%H,%J,%L,%O)=0,%E=$V(1022,0) I ($V(1021,0)#128)=8 G DSMDATA
DSMPTLP I %O<%E G DSMPTNT
 S %B=$V(1020,0)#256*65536+$V(1018,0) I %B=0 S %B=%L
 I %B G DSMPTBK
 G EXIT
DSMPTNT D DSMNODE I %I=2 D DSMPTDW S %O=%O+3 G DSMPTLP
 I %I=1,%L=0 D DSMPTDW
 S %B=%L G DSMPTBK
DSMPTDW S %L=$V(%O+2,0)#256*65536+($V(%O+1,0)#256*256)+($V(%O,0)#256)
 Q
DSMDTBK V %B:%D S %O=0,%E=$V(1022,0),%T=%T+1,%J=0
DSMDATA I %O<%E G DSMDTNT
 S %B=$V(1020,0)#256*65536+$V(1018,0) I %B G DSMDTBK
 G EXIT
DSMDTNT S %J=%J+1 D DSMNODE I %I=1 S:%H=0 %T=%T+1 S %H=1,%O=%E G DSMDATA ;Next BLK
 I %I=2 S %I=$V(%O,0)#256,%O=%O+%I+1 G DSMDATA
 S:%J=1 %T=%T-1 G EXIT
DSMNODE S %C=$V(%O,0)#256,%W=$V(%O+1,0)#256,%O=%O+2
 S %I=%O,%K="" I %C=0 S %K=%G,%I=%I+$L(%G)
 F %I=%I:1:%O+%W I %I<(%O+%W) S %Z=$V(%I,0)#256,%K=%K_$C(%Z)
 S %O=%I,%N=$E(%N,0,%C)_%K,%F=$E(%N,$L(%G)+1,256),%M="",%I=0
DSMPROC S %I=%I+1 I %I>$L(%F) G DSMTSTN
 S %M=%M_",",%V=$A(%F,%I),%I=%I+1 I %V=1 G DSMNULL
 I %V<128 S %M=%M_"-" G DSMNEG
DSMASCI S %M=%M_$E(%F,%I),%I=%I+1 I $A(%F,%I) G DSMASCI ;Also zero & pos
 G DSMPROC
DSMNULL S %M=%M_"",%I=%I+1 I $A(%F,%I) G DSMNULL
 G DSMPROC
DSMNEG I $E(%F,%I)="." S %M=%M_"."
 E  S %M=%M_$C(105-$A(%F,%I))
 S %I=%I+1 I $A(%F,%I)=254 S %I=%I+1 G DSMPROC
 G DSMNEG
DSMTSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
DSMTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G DSMSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
DSMTSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G DSMTSTL
DSMSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G DSMTSTC
EXIT C 63 K %A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%V,%W,%X,%Y,%Z
