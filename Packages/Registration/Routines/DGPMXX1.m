DGPMXX1 ; COMPILED XREF FOR FILE #405 ; 10/31/18
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^DGPM(DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S DGPMDDF=2 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" K ^DGPM("C",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S DGPMDDF=3 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" K ^DGPM("ADFN"_X,+^DGPM(DA,0),DA)
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPM(D0,0)):^(0),1:"") S X=$P(Y(1),U,18),X=X S DIU=X K Y S X="" S DIH=$G(^DGPM(DIV(0),0)),DIV=X S $P(^(0),U,18)=DIV,DIH=405,DIG=.18 D ^DICR
 S DIKZ(0)=$G(^DGPM(DA,0))
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I $P(^DGPM(DA,0),"^",2)=3 S A1B2TAG="ADM" D ^A1B2XFR
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S DGPMDDF=6,DGPMDDT=0 D ^DGPMDDCN
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S Y=^DGPM(DA,0) I +Y,Y<DT,X'=$P(Y,U,6) S Y=$P(Y,U,2) I Y<3 S DGOWD=$S($D(^DIC(42,+X,0)):$P(^(0),U),1:"") K DGIDX
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" S DGPMDDF=7,DGPMDDT=0 D ^DGPMDDCN
 S X=$P($G(DIKZ(0)),U,8)
 I X'="" S DGPMDDF=8,DGPMDDT=0 D ^DGPMDDCN
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S DGPMDDF=9 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S DGPMDDF=9,DGPMDDT=0 D ^DGPMDDCN
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" I $D(^DGPM(+$P(^DGPM(DA,0),"^",24),0)),($P(^(0),"^",2)=1) S A1B2TAG="ADM1" D ^A1B2XFR
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S Y=^DGPM(DA,0) I +Y,Y<DT S Y=$P(Y,U,2) I Y=6,X'=$P(Y,U,9) S DGHNYT=14 D ^DGPMGLC
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01($$GET1^DIQ(405,DA,.03,"I"))
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" S DH=405,DV=.09,DU=1 S DIIX=2 D:$G(DIK(0))'["A" AUDIT^DIK1
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" S DGPMDDF=14 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" K ^DGPM("CA",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I "^3^5^"[("^"_$P(^DGPM(DA,0),"^",2)_"^") I X S X=DIV X ^DD(405,.14,1,3,89.2) S X=$P($G(^DGPM(+$P(Y(101),U,17),0)),U) S D0=I(0,0) S DIU=X K Y S X="" X ^DD(405,.14,1,3,2.4)
 S DIKZ(0)=$G(^DGPM(DA,0))
 S X=$P($G(DIKZ(0)),U,16)
 I X'="" K ^DGPM("APTF",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,17)
 I X'="" D XREF^DGPMDDCN
 S X=$P($G(DIKZ(0)),U,18)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$S('$D(^DG(405.2,+X,0)):"",1:$P(^(0),U,1))["DEATH" I X S X=DIV X ^DD(405,.18,1,2,89.2) S X=$P(Y(101),U,1) S D0=I(0,0) S DIU=X K Y S X="" X ^DD(405,.18,1,2,2.4)
 S X=$P($G(DIKZ(0)),U,18)
 I X'="" S Y=^DGPM(DA,0) I +Y,Y<DT S Y=$P(Y,U,2) I Y<4 S DGOTY=$S($D(^DG(405.2,+X,0)):$P(^(0),U),1:"") K DGIDX
 S X=$P($G(DIKZ(0)),U,18)
 I X'="" I $P(^DGPM(DA,0),"^",2)=3 S A1B2TAG="ADM" D ^A1B2XFR
 S DIKZ(0)=$G(^DGPM(DA,0))
 S X=$P($G(DIKZ(0)),U,19)
 I X'="" S DGPMDDF=19,DGPMDDT=0 D ^DGPMDDCN
 S X=$P($G(DIKZ(0)),U,22)
 I X'="" S DGPMDDF=22 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,23)
 I X'="" S DGPMDDF=23 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,24)
 I X'="" K ^DGPM("APHY",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,27)
 I X'="" K ^DGPM("AVISIT",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,27)
 I X'="" K:$P(^DGPM(DA,0),U,3) ^DGPM("AVST",$P(^DGPM(DA,0),U,3),X,DA)
 S DIKZ("DIR")=$G(^DGPM(DA,"DIR"))
 S X=$P($G(DIKZ("DIR")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPM(D0,"DIR")):^("DIR"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" S DIH=$G(^DGPM(DIV(0),"DIR")),DIV=X S $P(^("DIR"),U,2)=DIV,DIH=405,DIG=42 D ^DICR
 S X=$P($G(DIKZ("DIR")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGPM(D0,"DIR")):^("DIR"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DGPM(DIV(0),"DIR")),DIV=X S $P(^("DIR"),U,3)=DIV,DIH=405,DIG=43 D ^DICR
 S X=$P($G(DIKZ("DIR")),U,1)
 I X'="" S DGPMDDF=41,DGPMDDT=0 D ^DGPMDDCN
 S DIKZ("ODS")=$G(^DGPM(DA,"ODS"))
 S X=$P($G(DIKZ("ODS")),U,2)
 I X'="" S A1B2TAG="ADM" D ^A1B2XFR
 S X=$P($G(DIKZ("ODS")),U,4)
 I X'="" K ^DGPM("AODSA",$E(X,1,30),DA)
 S X=$P($G(DIKZ("ODS")),U,6)
 I X'="" S A1B2TAG="ADM" D ^A1B2XFR
 S X=$P($G(DIKZ("ODS")),U,7)
 I X'="" K ^DGPM("AODSD",$E(X,1,30),DA)
 S DIKZ(0)=$G(^DGPM(DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^DGPM("B",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S DGPMDDF=1 D ^DGPMDD2
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K:$P(^DGPM(DA,0),U,3) ^DGPM("ADFN"_$P(^(0),U,3),X,DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S Y=$P(^DGPM(DA,0),U,2) I Y,Y'=4,Y'=5,X,X<DT S DGHNYT=$S(Y=1:2,Y=2:5,Y=3:8,1:14) D ^DGPMGLC
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I "^1^3^"[("^"_$P(^DGPM(DA,0),"^",2)_"^") S A1B2TAG="ADM" D ^A1B2XFR
CR1 S DIXR=1198
 K X
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,3)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2),X2(3))=""
 . K ^DGPM("AC",X(1),X(2),X(3),DA)
CR2 S DIXR=1199
 K X
 S DIKZ("USR")=$G(^DGPM(DA,"USR"))
 S X(1)=$P(DIKZ("USR"),U,2)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^DGPM("AD",$E(X,1,30),DA)
CR3 K X
END Q
