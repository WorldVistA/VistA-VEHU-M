DGRPXX18 ; COMPILED XREF FOR FILE #2.0361 ; 06/24/93
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:$D(DA(1)) DIKLM=1 G:$D(DA(1)) 1 S DA(1)=DA,DA=0 G @DIKM1
0 ;
A S DA=$O(^DPT(DA(1),"E",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$S($D(^DPT(DA(1),"E",DA,0))#2:^(0),1:"")
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DPT(DA(1),"E","B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DPT("AEL",DA(1),+X)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" D E31^VADPT62
 S X=$P(DIKZ(0),U,1)
 I X'="" S DFN=DA(1) D EN^DGMTCOR K DGMTCOR
 S X=$P(DIKZ(0),U,3)
 I X'="" D L11^VADPT62
 S X=$P(DIKZ(0),U,3)
 I X'="" I $D(^DIC(8,DA,0)),$D(^DIC(8.2,+$P(^(0),U,10),1)) X ^(1)
 S X=$P(DIKZ(0),U,3)
 I X'="" D L31^VADPT62
 S X=$P(DIKZ(0),U,3)
 I X'="" S:$S('$D(^DIC(8,DA,0)):0,'$D(^DIC(8.2,+$P(^(0),U,10),0)):0,1:$P(^(0),U)'="VA STANDARD") ^DPT("PID",X,DA(1),DA)=""
 S X=$P(DIKZ(0),U,4)
 I X'="" D S31^VADPT62
 G:'$D(DIKLM) A Q:$D(DISET)
END G ^DGRPXX19
