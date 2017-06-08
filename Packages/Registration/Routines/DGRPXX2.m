DGRPXX2 ; COMPILED XREF FOR FILE #2 ; 06/24/93
 ; 
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I "^3^9^"[("^"_$P(^DPT(DA,.25),"^",15)_"^") I X S X=DIV S Y(1)=$S($D(^DPT(D0,.25)):^(.25),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.2515,1,1,2.4)
 S X=$P(DIKZ(.25),U,2)
 I X'="" S DGXRF=.252 D ^DGDDC Q
 S X=$P(DIKZ(.25),U,3)
 I X'="" S DGXRF=.253 D ^DGDDC Q
 S DIKZ(.3)=$S($D(^DPT(DA,.3))#2:^(.3),1:"")
 S X=$P(DIKZ(.3),U,11)
 I X'="" X ^DD(2,.3025,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,1,2.4)
 S X=$P(DIKZ(.3),U,10)
 I X'="" K ^DPT("ACB",$E(X,1,30),DA)
 S DIKZ(.311)=$S($D(^DPT(DA,.311))#2:^(.311),1:"")
 S X=$P(DIKZ(.311),U,1)
 I X'="" S DGXRF=.3111 D ^DGDDC Q
 S X=$P(DIKZ(.311),U,15)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I "^3^9^"[$P(^DPT(DA,.311),U,15) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.311)):^(.311),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.31115,1,2,2.4)
 S X=$P(DIKZ(.311),U,3)
 I X'="" S DGXRF=.3113 D ^DGDDC Q
 S X=$P(DIKZ(.311),U,4)
 I X'="" S DGXRF=.3114 D ^DGDDC Q
 S DIKZ(.32)=$S($D(^DPT(DA,.32))#2:^(.32),1:"")
 S X=$P(DIKZ(.32),U,3)
 I X'="" K ^DPT("APOS",$E(X,1,30),DA)
 S X=$P(DIKZ(.32),U,5)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S DIKZ(.33)=$S($D(^DPT(DA,.33))#2:^(.33),1:"")
 S X=$P(DIKZ(.33),U,1)
 I X'="" S DGXRF=.331 D ^DGDDC Q
 S DIKZ(.331)=$S($D(^DPT(DA,.331))#2:^(.331),1:"")
 S X=$P(DIKZ(.331),U,1)
 I X'="" S DGXRF=.3311 D ^DGDDC Q
 S X=$P(DIKZ(.331),U,3)
 I X'="" S DGXRF=.3313 D ^DGDDC Q
 S X=$P(DIKZ(.331),U,4)
 I X'="" S DGXRF=.3314 D ^DGDDC Q
 S X=$P(DIKZ(.33),U,3)
 I X'="" S DGXRF=.333 D ^DGDDC Q
 S X=$P(DIKZ(.33),U,4)
 I X'="" S DGXRF=.334 D ^DGDDC Q
 S DIKZ(.34)=$S($D(^DPT(DA,.34))#2:^(.34),1:"")
 S X=$P(DIKZ(.34),U,1)
 I X'="" S DGXRF=.341 D ^DGDDC Q
 S X=$P(DIKZ(.34),U,3)
 I X'="" S DGXRF=.343 D ^DGDDC Q
 S X=$P(DIKZ(.34),U,4)
 I X'="" S DGXRF=.344 D ^DGDDC Q
 S DIKZ(.35)=$S($D(^DPT(DA,.35))#2:^(.35),1:"")
 S X=$P(DIKZ(.35),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P(Y(1),U,10) S DIU=X K Y X ^DD(2,.351,1,1,2.1) X ^DD(2,.351,1,1,2.4)
 S X=$P(DIKZ(.35),U,1)
 I X'="" K ^DPT("AEXP1",$E(X,1,30),DA)
 S DIKZ(.36)=$S($D(^DPT(DA,.36))#2:^(.36),1:"")
 S X=$P(DIKZ(.36),U,11)
 I X'="" K ^DPT("ACOL",+X,DA)
 S X=$P(DIKZ(.36),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 X ^DD(2,.361,1,2,2.2) I DIV(1)>0 S DIK(0)=DA,DIK="^DPT(DIV(0),""E"",",DA(1)=DIV(0),DA=DIV(1) D ^DIK S DA=DIK(0) K DIK
 S X=$P(DIKZ(.36),U,1)
 I X'="" I $S('$D(^DIC(8,+X,0)):0,$P(^(0),"^",1)["DOM":0,'$D(^DPT(DA,.36)):1,'$D(^DIC(8,+^(.36),0)):1,$P(^(0),"^",1)'["DOM":1,1:0) S DGXRF=.361 D ^DGDDC Q
 S X=$P(DIKZ(.36),U,1)
 I X'="" K ^DPT("AEL",DA,+X)
 S DIKZ(.362)=$S($D(^DPT(DA,.362))#2:^(.362),1:"")
 S X=$P(DIKZ(.362),U,12)
 I X'="" X ^DD(2,.36205,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,1,2.4)
 S X=$P(DIKZ(.362),U,12)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(.362),U,13)
 I X'="" X ^DD(2,.36215,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,1,2.4)
 S X=$P(DIKZ(.362),U,13)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(.362),U,15)
 I X'="" X ^DD(2,.36225,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.36225,1,1,2.4)
 S X=$P(DIKZ(.362),U,14)
 I X'="" X ^DD(2,.36235,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,1,2.4)
 S X=$P(DIKZ(.362),U,14)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(.362),U,16)
 I X'="" X ^DD(2,.36255,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(2,.36255,1,1,2.4)
 S X=$P(DIKZ(.362),U,17)
END G ^DGRPXX3
