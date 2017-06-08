DGRPXX14 ; COMPILED XREF FOR FILE #2 ; 06/24/93
 ; 
 I X'="" X ^DD(2,.323,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,"ODS")):^("ODS"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y X ^DD(2,.323,1,2,1.1) X ^DD(2,.323,1,2,1.4)
 S X=$P(DIKZ(.32),U,5)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ(.32),U,19)
 I X'="" I X'="Y" S DGXRF=.3285 D ^DGDDC Q
 S X=$P(DIKZ(.32),U,19)
 I X'="" X ^DD(2,.3285,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.32)):^(.32),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X=DIV S X="N" X ^DD(2,.3285,1,2,1.4)
 S X=$P(DIKZ(.32),U,20)
 I X'="" I X'="Y" S DGXRF=.32945 D ^DGDDC Q
 S DIKZ(.35)=$S($D(^DPT(DA,.35))#2:^(.35),1:"")
 S X=$P(DIKZ(.35),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,10) S DIU=X K Y X ^DD(2,.351,1,1,1.1) X ^DD(2,.351,1,1,1.4)
 S X=$P(DIKZ(.35),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.35)):^(.35),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(2,.351,1,2,1.1) X ^DD(2,.351,1,2,1.4)
 S X=$P(DIKZ(.35),U,1)
 I X'="" S %X=X,X="DGDEATH" X ^%ZOSF("TEST") S X=%X I $T S DFN=DA D XFR^DGDEATH
 S X=$P(DIKZ(.35),U,1)
 I X'="" S ^DPT("AEXP1",$E(X,1,30),DA)=""
 S X=$P(DIKZ(.35),U,1)
 I X'="" D DEATH^DGOERNOT
 S X=$P(DIKZ(.35),U,1)
 I X'="" S XX=X,X="PSJADT" X ^%ZOSF("TEST") S X=XX K XX I  D END^PSJADT
 S DIKZ(.36)=$S($D(^DPT(DA,.36))#2:^(.36),1:"")
 S X=$P(DIKZ(.36),U,11)
 I X'="" S ^DPT("ACOL",+X,DA)=""
 S X=$P(DIKZ(.36),U,1)
 I X'="" S DFN=DA D EN^DGMTR K DGREQF
 S X=$P(DIKZ(.36),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 X ^DD(2,.361,1,2,89.4) S Y(102)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$S('$D(^DIC(8,+$P(Y(102),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D1=I(1,0) S DIU=X K Y S X=DIV S X=DIV,X=X X ^DD(2,.361,1,2,1.4)
 S X=$P(DIKZ(.36),U,1)
 I X'="" S ^DPT("AEL",DA,+X)=""
 S DIKZ(.361)=$S($D(^DPT(DA,.361))#2:^(.361),1:"")
 S X=$P(DIKZ(.361),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y X ^DD(2,.3611,1,1,1.1) X ^DD(2,.3611,1,1,1.4)
 S X=$P(DIKZ(.361),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DT X ^DD(2,.3611,1,2,1.4)
 S X=$P(DIKZ(.361),U,2)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=$S(($D(DUZ)#2):DUZ,1:"") X ^DD(2,.3612,1,1,1.4)
 S X=$P(DIKZ(.36),U,2)
 I X'="" S DFN=DA D EN^DGMTR K DGREQF
 S DIKZ(.362)=$S($D(^DPT(DA,.362))#2:^(.362),1:"")
 S X=$P(DIKZ(.362),U,12)
 I X'="" X ^DD(2,.36205,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,1,1.4)
 S X=$P(DIKZ(.362),U,12)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(.362),U,13)
 I X'="" X ^DD(2,.36215,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,1,1.4)
 S X=$P(DIKZ(.362),U,13)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(.362),U,15)
 I X'="" X ^DD(2,.36225,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.36225,1,1,1.4)
 S X=$P(DIKZ(.362),U,14)
 I X'="" X ^DD(2,.36235,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,1,1.4)
 S X=$P(DIKZ(.362),U,14)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(.362),U,16)
 I X'="" X ^DD(2,.36255,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(2,.36255,1,1,1.4)
 S X=$P(DIKZ(.362),U,17)
 I X'="" X ^DD(2,.36265,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(2,.36265,1,1,1.4)
 S DIKZ(.38)=$S($D(^DPT(DA,.38))#2:^(.38),1:"")
 S X=$P(DIKZ(.38),U,1)
 I X'="" S DFN=DA D EN^DGMTR K DGREQF
END G ^DGRPXX15
