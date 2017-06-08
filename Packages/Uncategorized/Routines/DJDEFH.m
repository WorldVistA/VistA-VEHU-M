DJDEFH ;FDJW JA/WASH;DISPLAY SCREEN ON A DEVICE; 16 JAN 85  11:51 AM ; 13 MAY 86  5:07 PM
 ;VERSION 1.36
 D ^%ZIS G Q:IO="" U IO W @IOF
 K DJ,DJD S U="^",DJ0=^DJR(DJDN,0),DJ=$P(DJ0,U,2,7),DJDD=$P(DJ0,U,6),V=$N(^(1,0)) I DJDD'=+DJDD S DIC="^DJR(DJN,1,",DJD1="Option list" G N0
 S (DJ0,DJD1)="",DJ1=DJDD F V=1:1 Q:'$D(^DD(DJ1,0,"UP"))  S DJ1=^("UP"),DJ2=$N(^("NM",0)),DJD1=U_DJ2_DJD1,DJ2=$N(^DD(DJ1,"B",DJ2,0)),DJ2=$P($P(^DD(DJ1,DJ2,0),U,4),";",1) S:DJ2'=+DJ2 DJ2=""""_DJ2_"""" S DJ0="DA("_V_"),"_DJ2_","
 S DJD1=$P(^DIC(DJ1,0),U,1)_DJD1,DIC=^(0,"GL")_DJ0
N0 W !!!,"Screen: ",DJDNM W:$P(DJ,U,6)]"" " - ",$P(DJ,U,6) W ! S DJC=$P(DJ,U,DJ0) W ?2,"Previous Screen: ",$P(DJ,U,2),?40,"Rightlinked Screen: ",$P(DJ,U,4)
 W !?4,"Data dictionary: ",DJDD," (",DJD1,")",!,?6,"Global reference: ",DIC,! S V=$N(^DJR(DJDN,1,"A",0))
N1 S DJL=$N(^DJR(DJDN,1,"A",V,0)),DJ0=^DJR(DJDN,1,DJL,0),@$P(DJ0,U,2),DJD(DY,DX)="",DJ5=$P(DJ0,U,5) W:$D(^DJR(DJDN,1,V,1))+$D(^DJR(DJDN,1,V,2))*3+$Y>55 @IOF,!!
 S DJ1=$P(DJ0,U,1) W !!,"Entry No.: ",V,?17,"Line",$J(DY,3),", Column",$J(DX,3),?40,"Label: ",DJ1 W:$L(DJ1)>21 !,?46 W:V#1 " (Subtitle)"
 I DJ5<0!$P(DJ0,U,3)!$P(DJ0,U,7)!(V#1=0) S DJD(DY,DX)=$J(V,2)_" "
 S DJD(DY,DX)=DJD(DY,DX)_$P(DJ0,U,1)_":" G N2:V#1 I $P(DJ0,U,3) S @$P(DJ0,U,4) S $P(DJDB,".",$P(DJ0,U,3))="." S DJD(DY,DX)=DJDB K DJDB W !,?17,"Line",$J(DY,3),", Column",$J(DX,3),?40,"(Data)",?47,"Field length: ",$P(DJ0,U,3)
 W !,?17,"Attribute number: ",DJ5 W:DJ5>0 " (",$S($D(^DD(DJDD,DJ5,0)):$P(^(0),U,1),1:"???"),")" W ", Type: ",$P(DJ0,U,6)
 W !,?17,"Read only: ",$S($P(DJ0,U,7)=1:"YES",1:"NO"),?40,"Default Value: ",$S($D(^DJR(DJDN,1,DJL,3)):^(3),1:"")
 I $P(DJ0,U,12)]"" W !,?17,"Multiple Screen Name: ",$P(DJ0,U,12)
 F DJ1=2,1 I $D(^DJR(DJDN,1,DJL,DJ1)),^(DJ1)]"" W !!,?17,$P("Post Action Code^Pre Action Code",U,DJ1),": " S DJ1=^(DJ1) F DJ2=1:40:$L(DJ1) W:DJ2>1 ! W ?35,$E(DJ1,DJ2,DJ2+39)
N2 S V=$N(^DJR(DJDN,1,"A",V)) G N1:V>0
 W:$Y @IOF W !!!,DJDNM W:$P(DJ,U,6)]"" " - ",$P(DJ,U,6) W !!?13 F DY=1:1:7 W DY,"    ",DY,"    "
 W !?4 F DY=5:5:79 W "    ",DY#10
 W !?3 F DJ0=1:1:80 W "-"
 F DY=0:1:15 W:DY>0 ?83,"|" W:DY#4=1&(DY>0) $J(DY-1,2) W !,$S(DY#4=0:$J(DY,2),1:"  "),"|" D:DY=0 TI I $D(DJD(DY)) F DX=-1:0 S DX=$N(DJD(DY,DX)) Q:DX<0  W ?DX+3,DJD(DY,DX)
 W !?3 F DX=1:1:80 W "-"
 S IOP=$I X ^%ZIS("C") U IO(0)
Q K DJ,DJD,DJ0,DJ1,DJD1,IOP Q
TI S DJT=$P(DJ,U,6),DJLN=80-$L(DJT)/2-5 W ?DJLN+3,DJT,"  ",$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3) Q
