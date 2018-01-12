DJDEFE ;JA/WASH;MODIFY SCREEN ITEMS ; 05 Dec 86  9:23 AM
 ;VERSION 1.36
 S W(1)=DJDN
B K V S V(1)=DJDNM,V(2)=$P(^DJR(W(1),0),U,7),V(3)=$P(^(0),U,3),V(4)=$P(^(0),U,5),V(5)=$P(^(0),U,6)
 S DA(1)=W(1),DA(0)=1,DIC(0)="QMZE",DJNM="DJ.DEF2" D ^DJDPLS S Y=DIC_0_")" I $D(@Y)=0 X DJCL W @DJHIN,"SCREEN NOT SET UP PROPERLY",@DJLIN,*7 H 2 Q
A S V=6,DIC="^DJR(DA(1),1," S @$P(DJJ(V),U,2) X XY D ^DJRD Q:X=""!(X="^")
 I X="^C" D FUNC2^DJINQ G A
 I X="^L"!(X?1"?".E) D DJDIC^DJINJG G A
 I X?1"^".E G ER
 S D="A" X DJCP W ! D EN^DIC K D
 I $Y>23 R !,"To <CR> to continue :",DJX:DTIME D EN^DJDPLS S V=6
 I Y<0 G E
 S DA=+Y,DJDN=DA(1),V(11)=$P(Y(0),U,13),V(6)=$P(Y,U,2)
 S V(8)=$P(Y(0),U,3),V(9)=$P(Y(0),U,7),V(7)=$P(Y(0),U,13),V(12)=$P(Y(0),U,12)
 I $D(^DJR(DA(1),1,DA,3)) S V(13)=^(3)
 E  S V(13)=""
 I $D(^DJR(DA(1),1,DA,2)) S V(10)=^(2)
 E  S V(10)=""
E X DJCP X DJCL W "??",*7 G P
 I $D(^DJR(DA(1),1,DA,1)) S V(11)=^(1)
 E  S V(11)=""
 S DJFF=1 D ^DJDPLS S V=6,DJW=1,DJDA=DA,DJW1=1 D EN^DJINJG Q:X="^"  S DJFF=1 G B
 Q
ER X DJCP X DJCL W "Illegal name or command. Type ^C to see a list of legal commands",*7
P S @$P(DJJ(V),U,2) X XY W @DJHIN X XY S $P(DJDB,".",DJJ(V))="." W DJDB,@DJLIN K DJDB X XY G A
P1 X DJCP W "Choose from any of the following data elements:" K DJX
 S DJK=0 F DJI=0:0 S DJK=$O(^DD(V(5),DJK)) Q:+DJK=""!(DJK?1U.U)  D R Q:DJX[U  W !,DJK,?10,$P(^DD(V(5),DJK,0),U,1)," " W $S($E($P(^(0),U,2),1)?1N:"(Multiple/Word Proc)",1:"")
 Q
R S DJX=0 I $Y=(IOSL-2) W !,"Type <CR> to continue or uparrow <^> to stop:" R DJX:DTIME S:'$T DJX=U Q:DJX[U  X DJCP Q
 Q
