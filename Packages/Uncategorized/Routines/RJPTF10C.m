RJPTF10C ;RJ WILM DE -MAKE C101 PTF CARD; 12-12-85
 ;;4.0
 S D="",Z=$P(RJPAT,"^",1),Y=$E($P(Z,",",1),1,12),X=11 D S,LJ S RJN101=Y,X=1,Y=$E($P(Z,",",2),1)_$E($P($P(Z,",",2)," ",2),1) D S,LJ S RJN101=RJN101_Y
 S RJ101=^DGPT(I,101),Z=$P(RJ101,"^",1),D=$P(RJ101,"^",5)
 S RJN101=RJN101_$P(^DIC(45.1,Z,0),"^",1),X=5,Y="" S:D'="" Y=D_$P(RJ101,"^",6) D LJ S RJN101=RJN101_Y_" "
 S RJN101=RJN101_$S($P(^DPT(RJ,.52),"^",5)="Y":$P(^DPT(RJ,.52),"^",6)+3,$P(^DPT(RJ,.52),"^",5)="N":1,1:3)_$P(^DIC(11,$P(RJPAT,"^",5),0),"^",3)
 S Z=$P(RJPAT,"^",3),RJN101=RJN101_$P(RJPAT,"^",2)_$E(Z,4,7)_(17+$E(Z,1))_$E(Z,2,3)
 S D=$P(^DIC(45.82,$P(RJ101,"^",4),0),"^",1),RJN101=RJN101_D
 I D=6 S RJN101=RJN101_$S($P(^DPT(RJ,.321),"^",1)="N":1,$P(^DPT(RJ,.321),"^",2)="N":2,$P(^DPT(RJ,.321),"^",2)="Y":3,1:4)
 I D'=6 S RJN101=RJN101_" "
 I (D>1)&(D<8) S L=$P(^DPT(RJ,.321),"^",12),Y=$P(^DPT(RJ,.321),"^",3),RJN101=RJN101_$S(Y="N":1,L="N":2,L="T":3,L="B":4,1:" ")
 I D<2!(D>7) S RJN101=RJN101_" "
 S Z=^DPT(RJ,.11),RJN101=RJN101_$S($L($P(Z,"^",5))=1:0_$P(Z,"^",5),1:$P(Z,"^",5))_$P(^DIC(5,$P(Z,"^",5),1,$P(Z,"^",7),0),"^",3)_$P(Z,"^",6)
 S Z=$P(^DGPT(I,0),"^",10) 
 S RJN101="C101"_RJCON_RJN101_Z S Y=RJN101,X=80 D LJ S RJN101=Y K RJ101,D,J,L,X,Y,Z Q
LJ F J=$L(Y):1:X S Y=Y_" "
 Q
S S L="" F J=1:1:$L(Y) S:$E(Y,J)'=" "&($E(Y,J)'=".") L=L_$E(Y,J)
 S Y=L Q
