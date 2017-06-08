RJTCT ;
 S S=0
 F I=1:1:10000 S S=$S,X(I)="LL" D CT
CT ;
 I S-$S>16 W !,S_"   "_$S_"  "_I
 ;W !,S_"   "_$S_"  "_I
 Q
