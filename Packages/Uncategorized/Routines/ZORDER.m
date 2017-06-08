ZORDER ;
 ;
 S N=$ZO(^PXD(811.9))
 S M=@N
NEXT ;
 S N=$ZO(@N)
 I $P(N,",",3)=31 W !,^PXD(811.9,$P(N,",",3),0)
 G NEXT
 Q
