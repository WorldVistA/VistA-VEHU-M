DJINJG ;JA/WASH;INPUT TO SCREEN ; 20 Jun 86  4:11 PM
 ;VERSION 1.36
EN ;
 S DJQ=0,DJP=0 G TK
EN2 S V=DJF-.01 D:'DJW FUNC^DJINQ
NXT S V=$N(DJJ(V)) G LST:V<0 G:$P(DJJ(V),U,5) NXT
TK K DJNX S:$D(DJW1)=0 DJW1=0 S @$P(DJJ(V),U,2),DJAT=$P(DJJ(V),U,3) X XY I DUZ(0)'="@" I DJAT=1!(DJAT=2) X DJCL W "You do not have programmer's access code" G NXT
 S DJ0=^DD(DJDD,DJAT,0),DJ4=$P(DJJ(V),U,4),DJ3=$P(DJJ(V),U,3)
 D HL,^DJRD Q:X="^N"  I X="^L" D DJDIC G TK
 G T1:X="" X XY S $P(DJDB," ",+DJJ(V))=" " W DJDB K DJDB
 S DJXX=$E(X,1) G U:X?1"^"&(DJAT=.01) G T4:DJXX="^"!(DJXX="<")!(DJXX=">") G Q1:X?1"?".E
 I X="@" D ^DJINK G TK:'$D(X),T3:X="@",LST
 I DJAT=1!(DJAT=2) K:$L(X)>200!($L(X)<1) X D ^DIM:$D(X) G:'$D(X) Q1 S ^DJR(DA(1),1,DA,DJAT)=X X XY S V(V)=X W @DJHIN,V(V),@DJLIN G NXT
 I DJAT=.01,$D(^DJR(DA(1),1,"B",X))!$D(^DD(V(5),"B",X)) I $P(^DD(V(5),+$P(^DJR(DA(1),1,DA,0),U,5),0),U,1)'=X X DJCL W *7,"Label already used in this screen or it exists in your data dictionary" G TK
 K DR S DJS2=0 S DJXX=X S DIE=DIC,DA=DJDA S:X["/"!(X[";") DJS1=X,DJS2=1 S:'DJS2 DR=DJ3_"///"_X S:DJS2 DR=DJ3_"///^S X=DJS1" X DJCP W ! D ^DIE D KILL G:$D(Y) Q1
 I DJ4["S",DJAT=.07 S X=DJXX
 I (V=8&(V(8)'=X))!((V=6)&(V(6)'=X)) X DJCL W "Recommend you use the SHIFT SCREEN option to check the effect of this change."
 I '$D(Y) S V(V)=$E(X,1,+DJJ(V)) S @$P(DJJ(V),U,2) X XY W @DJHIN X XY W V(V),@DJLIN G NXT
 S V(V)=$S(X="@":"",1:X)
 G:DJAT=.01&(V(V)="") OUT G T4
T1 ;
 I V(V)'="" X XY W @DJHIN X XY W V(V),@DJHIN G NXT
 I V(V)="" X XY W @DJLIN S $P(DJDB,".",DJJ(V))="." W DJDB K DJDB G NXT
 G LH
T3 S V(V)=$S(X="@":"",1:X)
 G:DJAT=.01&(V(V)="") Q G T4
Q1 D ^DJINQ G TK
 ;HI-LIGHT
HL S DJ4=$P(DJJ(V),U,4) I '$D(V(V)) S $P(DJDB,".",DJJ(V))="." W @DJHIN X XY W DJDB,@DJLIN K DJDB G HLQ
 I V(V)="" W @DJHIN X XY S $P(DJDB,".",DJJ(V))="." W DJDB,@DJLIN K DJDB G HLQ
 W @DJHIN X XY W V(V),@DJLIN
HLQ X XY Q
 ;ANS IS NULL
LH S:'$D(DJ4) DJ4=$P(DJJ(V),U,4) I DJ4["R" X DJCL W @DJHIN X XY W "DATA REQUIRED",@DJLIN,*7 S @$P(DJJ(V),U,2) X XY G TK
T4 G:'($D(DJDN)) TK S @$P(DJJ(V),U,2) X XY
 I V(V)="" W @DJLIN S $P(DJDB,".",DJJ(V))="." W DJDB K DJDB G T5
U I V(V)'="" S @$P(DJJ(V),U,2) X XY W @DJHIN X XY W V(V)
T5 G LST:X?1"^",NX:X'?1"^".N
 S DJY=$P(X,U,2) I X?1"^".N,$D(DJJ(DJY)),'$P(DJJ(DJY),U,5) S V=DJY-.01 G NXT
 E  X DJCL W *7,"Number is out of range or field is not editable." S V=V-.01 G NXT
NX G NXT:X=">" I X="<" S DJ0=V G EN2:V<2 F V=-1:0 S V=$N(DJJ(V)) I $N(DJJ(V))=DJ0 G NX:$P(DJJ(V),U,4)["C" S V=V-.001 G NXT
 G Q1
Q K DJ0,DJAT,DJ3,DJ4,DJQ Q  D ^DJDPLS G EN2
OUT K V,DJ0,DJAT,DJDN,DJ3,DJJ,DJQ,DIC,DJDD,DX,DY,DJK,DJDIC S DJFF=0 Q
LST ;OPTION LINE
 D FUNC3^DJINQ
 X DJCL W "FUNCTION: ","N","//" R X:DTIME S DJXT=$T S:'DJXT X="^" S:X="" X="N" G MOD:X?1"^"1N.N Q:X["N"&(DJW1=1)  G Q:X["N"&(DJP=0) Q:X["N"&(DJP=1)
 G:X?1"^" OUT
 G LST
MOD S V=$P(X,"^",2)-.001 G NXT
DJDIC ;
 X XY S $P(DJDB,".",+DJJ(V))="." W DJDB K DJDB
 X DJCP
 S DJZ2=0,DJZ=0 F DJK=1:1 S DJZ2=$N(^DJR(W(1),1,"A",DJZ2)) Q:DJZ2<0  S DJZ1=$O(^(DJZ2,0)) W !,$P(^DJR(W(1),1,DJZ1,0),U,13),?4,$P(^(0),U,1),?35,"LABEL AT ",$P(^(0),U,2),?60,"DATA AT ",$P(^(0),U,4) S DJZ=DJZ+1 I DJZ#6=0 D A Q:DJX=U
 K DJZ1,DJZ2,DJZ,DJK,DJX Q
A X DJCL W "Type CR to continue, uparrow to exit: " R DJX:DTIME S:'$T DJX=U X:DJX'=U DJCP S DJZ=0 Q
KILL K DB,DC,DE,DG,DH,DI,DK,DL,DM,DP,DR,DW Q
