DGRPXX12 ; COMPILED XREF FOR FILE #2 ; 06/24/93
 ; 
 S DIKZK=1
 S DIKZ(0)=$S($D(^DPT(DA,0))#2:^(0),1:"")
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DPT("B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" X ^DD(2,.01,1,2,1)
 S X=$P(DIKZ(0),U,1)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DPT("ASX",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DPT("C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^DPT("ADOB",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X=DIV S X="1" X ^DD(2,.03,1,2,1.4)
 S X=$P(DIKZ(0),U,3)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(0),U,20)
 I X'="" S ^DPT("ANEW",DA)=""
 S X=$P(DIKZ(0),U,9)
 I X'="" S ^DPT("BS",$E(X,6,9),DA)=""
 S X=$P(DIKZ(0),U,9)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X=DIV S X="1" X ^DD(2,.09,1,2,1.4)
 S X=$P(DIKZ(0),U,9)
 I X'="" S ^DPT("BS5",$E(^DPT(DA,0),1)_$E(X,6,9),DA)=""
 S X=$P(DIKZ(0),U,9)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(0),U,9)
 I X'="" S ^DPT("SSN",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,9)
 I X'="" S VADFN=DA D SET^VADPT6 K VADFN
 S X=$P(DIKZ(0),U,9)
 I X'="" I $T(^A1AYFMX)'="" D SNSSN^A1AYFMX
 S DIKZ(.1)=$S($D(^DPT(DA,.1))#2:^(.1),1:"")
 S X=$E(DIKZ(.1),1,30)
 I X'="" D CN^DGPMDDCN
 S X=$E(DIKZ(.1),1,30)
 I X'="" S ^DPT("ACN",$E(X,1,30),DA)=""
 S X=$E(DIKZ(.1),1,30)
 I X'="" S %X=X,X="NURSCPL" X ^%ZOSF("TEST") S X=%X D:$T EN1^NURSCPL
 S DIKZ(.101)=$S($D(^DPT(DA,.101))#2:^(.101),1:"")
 S X=$P(DIKZ(.101),U,1)
 I X'="" S ^DPT("RM",$E(X,1,30),DA)=""
 S DIKZ(.103)=$S($D(^DPT(DA,.103))#2:^(.103),1:"")
 S X=$P(DIKZ(.103),U,1)
 I X'="" S ^DPT("ATR",$E(X,1,30),DA)=""
 S DIKZ(.104)=$S($D(^DPT(DA,.104))#2:^(.104),1:"")
 S X=$P(DIKZ(.104),U,1)
 I X'="" S ^DPT("APR",$E(X,1,30),DA)=""
 S DIKZ(.1041)=$S($D(^DPT(DA,.1041))#2:^(.1041),1:"")
 S X=$P(DIKZ(.1041),U,1)
 I X'="" S ^DPT("AAP",$E(X,1,30),DA)=""
 S DIKZ(.105)=$S($D(^DPT(DA,.105))#2:^(.105),1:"")
 S X=$P(DIKZ(.105),U,1)
 I X'="" S ^DPT("ACA",$E(X,1,30),DA)=""
 S DIKZ(.107)=$S($D(^DPT(DA,.107))#2:^(.107),1:"")
 S X=$P(DIKZ(.107),U,1)
 I X'="" D LD^DGPMDDLD
 S DIKZ(.11)=$S($D(^DPT(DA,.11))#2:^(.11),1:"")
 S X=$P(DIKZ(.11),U,1)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,2)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,3)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,4)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,5)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,6)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,7)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S DIKZ(.121)=$S($D(^DPT(DA,.121))#2:^(.121),1:"")
 S X=$P(DIKZ(.121),U,9)
 I X'="" X ^DD(2,.12105,1,7,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.121)):^(.121),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X="" X ^DD(2,.12105,1,7,1.4)
 S X=$P(DIKZ(.121),U,9)
 I X'="" X ^DD(2,.12105,1,8,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.121)):^(.121),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(2,.12105,1,8,1.4)
 S X=$P(DIKZ(0),U,14)
 I X'="" S ^DPT("ACS",$E(X,1,30),DA)=""
 S DIKZ(.15)=$S($D(^DPT(DA,.15))#2:^(.15),1:"")
 S X=$P(DIKZ(.15),U,2)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,10) S DIU=X K Y X ^DD(2,.152,1,1,1.1) X ^DD(2,.152,1,1,1.4)
 S DIKZ(.25)=$S($D(^DPT(DA,.25))#2:^(.25),1:"")
 S X=$P(DIKZ(.25),U,15)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I "^3^9^"[("^"_$P(^DPT(DA,.25),"^",15)_"^") I X S X=DIV S Y(1)=$S($D(^DPT(D0,.25)):^(.25),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.2515,1,1,1.4)
 S DIKZ(.3)=$S($D(^DPT(DA,.3))#2:^(.3),1:"")
 S X=$P(DIKZ(.3),U,1)
 I X'="" X ^DD(2,.301,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,1,1.4)
 S X=$P(DIKZ(.3),U,11)
END G ^DGRPXX13
