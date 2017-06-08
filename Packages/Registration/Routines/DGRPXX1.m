DGRPXX1 ; COMPILED XREF FOR FILE #2 ; 06/24/93
 ; 
 S DIKZK=2
 S DIKZ(0)=$S($D(^DPT(DA,0))#2:^(0),1:"")
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^DPT("B",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,1)
 I X'="" X ^DD(2,.01,1,2,2)
 S X=$P(DIKZ(0),U,1)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(0),U,1)
 I X'="" S DFN=DA D ^DGPATN Q
 S X=$P(DIKZ(0),U,2)
 I X'="" K ^DPT("ASX",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,2)
 I X'="" K ^DPT("C",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" K ^DPT("ADOB",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,3)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(0),U,20)
 I X'="" K ^DPT("ANEW",DA)
 S X=$P(DIKZ(0),U,9)
 I X'="" K ^DPT("BS",$E(X,6,9),DA)
 S X=$P(DIKZ(0),U,9)
 I X'="" K ^DPT("BS5",$E(^DPT(DA,0),1)_$E(X,6,9),DA)
 S X=$P(DIKZ(0),U,9)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(0),U,9)
 I X'="" K ^DPT("SSN",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,9)
 I X'="" S VADFN=DA D KILL^VADPT6 K VADFN
 S X=$P(DIKZ(0),U,9)
 I X'="" I $T(^A1AYFMX)'="" D KNSSN^A1AYFMX
 S DIKZ(.1)=$S($D(^DPT(DA,.1))#2:^(.1),1:"")
 S X=$E(DIKZ(.1),1,30)
 I X'="" K ^DPT("CN",X,DA)
 S X=$E(DIKZ(.1),1,30)
 I X'="" K ^DPT("ACN",$E(X,1,30),DA)
 S X=$E(DIKZ(.1),1,30)
 I X'="" S %X=X,X="NURSCPL" X ^%ZOSF("TEST") S X=%X D:$T EN2^NURSCPL
 S DIKZ(.101)=$S($D(^DPT(DA,.101))#2:^(.101),1:"")
 S X=$P(DIKZ(.101),U,1)
 I X'="" K ^DPT("RM",$E(X,1,30),DA)
 S DIKZ(.103)=$S($D(^DPT(DA,.103))#2:^(.103),1:"")
 S X=$P(DIKZ(.103),U,1)
 I X'="" K ^DPT("ATR",$E(X,1,30),DA)
 S DIKZ(.104)=$S($D(^DPT(DA,.104))#2:^(.104),1:"")
 S X=$P(DIKZ(.104),U,1)
 I X'="" K ^DPT("APR",$E(X,1,30),DA)
 S DIKZ(.1041)=$S($D(^DPT(DA,.1041))#2:^(.1041),1:"")
 S X=$P(DIKZ(.1041),U,1)
 I X'="" K ^DPT("AAP",$E(X,1,30),DA)
 S DIKZ(.105)=$S($D(^DPT(DA,.105))#2:^(.105),1:"")
 S X=$P(DIKZ(.105),U,1)
 I X'="" K ^DPT("ACA",$E(X,1,30),DA)
 S DIKZ(.107)=$S($D(^DPT(DA,.107))#2:^(.107),1:"")
 S X=$P(DIKZ(.107),U,1)
 I X'="" K ^DPT("LD",X,DA)
 S DIKZ(.11)=$S($D(^DPT(DA,.11))#2:^(.11),1:"")
 S X=$P(DIKZ(.11),U,1)
 I X'="" S DGXRF=.111 D ^DGDDC Q
 S X=$P(DIKZ(.11),U,1)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,2)
 I X'="" S DGXRF=.112 D ^DGDDC Q
 S X=$P(DIKZ(.11),U,2)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,3)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,4)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,5)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.11)):^(.11),1:""),Y=$P(Y(1),U,7) X:$D(^DD(2,.117,2)) ^(2) S X=Y S DIU=X K Y S X=DIV S X="" X ^DD(2,.115,1,1,2.4)
 S X=$P(DIKZ(.11),U,5)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,6)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.11),U,7)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S DIKZ(.121)=$S($D(^DPT(DA,.121))#2:^(.121),1:"")
 S X=$P(DIKZ(.121),U,9)
 I X'="" S DGXRF=.12105 D ^DGDDC Q
 S X=$P(DIKZ(.121),U,1)
 I X'="" S DGXRF=.1211 D ^DGDDC Q
 S X=$P(DIKZ(.121),U,2)
 I X'="" S DGXRF=.1212 D ^DGDDC Q
 S X=$P(DIKZ(0),U,14)
 I X'="" K ^DPT("ACS",$E(X,1,30),DA)
 S DIKZ(.15)=$S($D(^DPT(DA,.15))#2:^(.15),1:"")
 S X=$P(DIKZ(.15),U,2)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,10) S DIU=X K Y X ^DD(2,.152,1,1,2.1) X ^DD(2,.152,1,1,2.4)
 S X=$P(DIKZ(.15),U,2)
 I X'="" S DGXRF=.152 D ^DGDDC Q
 S X=$P(DIKZ(.15),U,3)
 I X'="" S DGXRF=.153 D ^DGDDC Q
 S DIKZ(.21)=$S($D(^DPT(DA,.21))#2:^(.21),1:"")
 S X=$P(DIKZ(.21),U,1)
 I X'="" S DGXRF=.211 D ^DGDDC Q
 S X=$P(DIKZ(.21),U,3)
 I X'="" S DGXRF=.213 D ^DGDDC Q
 S X=$P(DIKZ(.21),U,4)
 I X'="" S DGXRF=.214 D ^DGDDC Q
 S DIKZ(.211)=$S($D(^DPT(DA,.211))#2:^(.211),1:"")
 S X=$P(DIKZ(.211),U,1)
 I X'="" S DGXRF=.2191 D ^DGDDC Q
 S X=$P(DIKZ(.211),U,3)
 I X'="" S DGXRF=.2193 D ^DGDDC Q
 S X=$P(DIKZ(.211),U,4)
 I X'="" S DGXRF=.2194 D ^DGDDC Q
 S DIKZ(.25)=$S($D(^DPT(DA,.25))#2:^(.25),1:"")
 S X=$P(DIKZ(.25),U,1)
 I X'="" S DGXRF=.251 D ^DGDDC Q
 S X=$P(DIKZ(.25),U,15)
END G ^DGRPXX2
