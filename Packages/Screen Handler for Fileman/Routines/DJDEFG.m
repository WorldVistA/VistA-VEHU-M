DJDEFG ;JA/WASH;DEFINE SCREEN ; 30 Jul 86  9:58 AM
 ;VERSION 1.36
 Q:'$D(DJDN)!(DJDNM="")  S V(1)=DJDNM,(DA,W(1))=DJDN K V(20),V(21)
 S DJA=^DJR(DJDN,0) S:$P(DJA,U,2)="" $P(^DJR(DJDN,0),U,2)=15
 S V(5)=$P(DJA,U,6) S:$D(^DIC(V(5),0,"WR"))>0 $P(^DJR(DJDN,0),U,4)=^DIC(V(5),0,"WR")
 S:$P(DJA,U,8)="" $P(^DJR(DJDN,0),U,8)=1
 S V(2)=$P(DJA,U,7),V(3)=$P(DJA,U,3),V(4)=$P(DJA,U,5) D EN Q
EN ;
 S DJI="",DJSW2=1,DJFR=0,DJ01=1,DJLNM=0,DJLSTN=0,DJW=0
 I $D(^DJR(DJDN,1,0))<1 S ^(0)="^2000.07A^^" S DJSW2=0 S:V(3)="" DJ01=0
 S DJX1=2,DJXL=-2
 I $P(^(0),U,3)=""!($P(^(0),U,3)=0) S DJSW2=0,DJ01=0
 S DJ11=$P(^DJR(DJDN,0),U,8) S:DJ11="" DJ11=1 S DJX1=DJ11+1
 G:DJSW2'=1 ST S DJ=0,DJ3=0,DJ5=0 F DJK=1:1 S DJ=$N(^DJR(DJDN,1,DJ)) S:DJLNM<DJ DJLNM=DJ Q:DJ'=+DJ  S DJ1=+$P($P(^DJR(DJDN,1,DJ,0),"^",4),"DY=",2),DJ4=+$P($P(^DJR(DJDN,1,DJ,0),"^",4),"DX=",2) D S
 G T
S I (DJ1>DJ3!(DJ1=DJ3)) S:DJ1>DJ3 DJ2=DJ,DJ3=DJ1,DJ5=DJ4 S:DJ1=DJ3&(DJ4>DJ5) DJ2=DJ,DJ5=DJ4
 Q
T S DJX1=+$P($P(^DJR(DJDN,1,DJ2,0),U,4),"DY=",2),DJXL=+$P($P(^DJR(DJDN,1,DJ2,0),U,4),"DX=",2)+$P(^DJR(DJDN,1,DJ2,0),U,3)+2 G:DJXL<75 ST S DJX1=DJX1+1,DJXL=-2
 I %=1 D EN1^DJDEFG1
ST S DJI="" S DJFF=1 S:'DJFR DJFF=0 D ^DJDPLS D:'DJW FUNC2^DJINQ S DJFR=1,DJW=1
DEF3 S DIC="^DD("_V(5)_",",DIC(0)="EQZM",V=6,@$P(DJJ(V),U,2) X XY D:DJ01 ^DJRD G END:X="^"!(X="")
 I X="^C" D FUNC2^DJINQ G P
 I X="^L" D DJDIC^DJINJG G P
 G:X["^" ER
 I X?1"?".E D P1^DJDEFE G P
 S V(6)=X S:'DJ01 X=.01 G END:X="^"!(X="") X DJCP D ^DIC S DJ01=1
 I $Y>23,Y<0 R !,"Type <CR> to continue:",DJX:DTIME S DJFF=0 D N^DJDPLS S V=6 D D S @$P(DJJ(6),U,2) X XY W @DJHIN,DJDB K DJDB G DEF3
 I Y<0 S @$P(DJJ(V),U,2) X XY W @DJHIN X XY W V(V),@DJLIN X XY G B
 S DA(1)=W(1),(V(6),X)=$P(Y,U,2),V(20)=+Y,DIC(0)="LEQZ",DIC="^DJR(DA(1),1," I $Y<24 S @$P(DJJ(6),U,2),DJW=1 X XY W @DJHIN,V(6),@DJLIN D D1 W DJDB K DJDB
 E  D EN^DJDPLS
 G T6:$D(^DJR(DA(1),1,"B",X)) G LG
B G ER:V(6)?1P.E I V(6)'="" X DJCP R !,"Is this a subtitle: NO// ",X:DTIME I X["Y" S V(20)=-1,V(21)="" D EN3^DJDEFG1 S V(8)=$L(V(6)) S DA(1)=W(1) G LG1
 S @$P(DJJ(V),U,2) X XY D D W DJDB K DJDB S V(6)="" G ST
LG S:V(20)=.01 V(7)=1,DJLNM=1 D:V(20)'=.01 EN3^DJDEFG1 G:'$D(V(6)) DEF3 S DJZ=^DD(+V(5),V(20),0),V(21)=$P(DJZ,U,2) I DJZ["P",'$D(^DD(+$P(DJZ,"P",2),0)) G T7
 D EN2^DJDEFG1 I V(6)["(M)",$D(^DJR(DA(1),1,"B",V(6))) S DJLNM=DJLNM-1 D EN1^DJDPLS G T6
LG1 S V(23)=DJXL+2,V(22)=DJX1
 S V(21)=V(21)_DJI,V(6)=V(6)_$S(V(21)["C":"(C)",1:"")
 S V(25)=$L(V(6))+4+V(23),DJXL=V(25)+V(8) I DJXL>79!(DJX1>15) S (DJX1,V(22))=DJX1+1,V(23)=0,V(25)=$L(V(6))+4,DJXL=V(25)+V(8) D:V(22)>15 EN^DJDEFG1 G:$D(DJS) E
 X DJCP S X=""""_V(6)_"""",DIC(0)="L",DIC="^DJR(DA(1),1," D ^DIC S (DA,DJDA)=+Y
 S V(9)="",V(24)=V(22)
 S V(10)="",V(12)="",V(11)="",V(13)=""
 I V(21)["M"&(V(20)=.01) S DJZ=V(21),V(21)="" F DJK=1:1:$L(DJZ) S DJZ1=$E(DJZ,DJK) S:DJZ1'="M" V(21)=V(21)_DJZ1
 K DJZ,DJZ1 D:V(21)["M" ^DJDEFG1
 S ^DJR(+W(1),1,DJDA,0)=V(6)_U_"DY="_V(22)_",DX="_V(23)_U_V(8)_"^DY="_V(22)_",DX="_V(25)_U_V(20)_U_V(21)_U_V(9)_U_U_U_U_U_V(12)_U_V(7)
 S ^DJR(+W(1),1,"A",V(7),DJDA)=""
 G T16
END K X,DA,DJT,DIC,DJFF,DJFR Q
T16 S DJV6=V(6),DJV8=V(8)
 S DJDN=DJDA,DA(0)=1,DIC(0)="QMZEV" S:$Y<24 DJFF=1 D ^DJDPLS S DJFF=0 X DJCP S DY=21,DX=5 X XY W @DJEOP,"Label ",V(6)," is located at COL: ",V(23),"  ROW: ",V(22)
 I V(8)=4 W *7,!,"NOTE!! Unable to determine correct field length.  Defaulting to four characters."
 S V=6 S @$P(DJJ(V),U,2) X XY
 S DJW1=1 D EN^DJINJG G:X="@" ST
E K DJV8,DJV6 F DJK=6:1:25 K V(DJK)
 K DJT,DJZ G END:X=U,ST
T6 X DJCL W "Use option 2 to modify already defined screen entries",*7 H 2 K V(6),V(21),V(20) G ST
T7 X DJCL W "Pointed to file (#",+$P(DJZ,"P",2),") does not exist. Field not entered.",*7 H 2 G E
ER X DJCP X DJCL W "Illegal name or command. Type ^C to see a list of legal commands",*7
P S @$P(DJJ(V),U,2) X XY W @DJHIN X XY D D W DJDB,@DJLIN K DJDB X XY G DEF3
D S $P(DJDB,".",DJJ(V))="." Q
D1 S $P(DJDB," ",DJJ(V))=" " Q
