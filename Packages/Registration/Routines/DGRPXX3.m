DGRPXX3 ; COMPILED XREF FOR FILE #2 ; 06/24/93
 ; 
 I X'="" X ^DD(2,.36265,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(2,.36265,1,1,2.4)
 S DIKZ("DAC")=$S($D(^DPT(DA,"DAC"))#2:^("DAC"),1:"")
 S X=$P(DIKZ("DAC"),U,1)
 I X'="" K ^DPT("AS",$E(X,1,30),DA)
 S X=$P(DIKZ("DAC"),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,"DAC")):^("DAC"),1:"") S X=$P(Y(1),U,2) S DIU=X K Y S X=DIV S X="" X ^DD(2,401.3,1,2,2.4)
 S X=$P(DIKZ("DAC"),U,1)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S DIKZ(1010.15)=$S($D(^DPT(DA,1010.15))#2:^(1010.15),1:"")
 S X=$P(DIKZ(1010.15),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DPT(D0,1010.15)):^(1010.15),1:"") S X=$P(Y(1),U,1)="" I X S X=DIV S Y(1)=$S($D(^DPT(D0,1010.15)):^(1010.15),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,1010.151,1,1,2.4)
 S X=$P(DIKZ(1010.15),U,1)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DPT(D0,1010.15)):^(1010.15),1:"") S X=$P(Y(1),U,1)="" I X S X=DIV S Y(1)=$S($D(^DPT(D0,1010.15)):^(1010.15),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,1010.151,1,2,2.4)
 S X=$P(DIKZ(1010.15),U,3)
 I X'="" K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DPT(D0,1010.15)):^(1010.15),1:"") S X=$P(Y(1),U,3)="" I X S X=DIV S Y(1)=$S($D(^DPT(D0,1010.15)):^(1010.15),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(2,1010.153,1,1,2.4)
 S DIKZ("VET")=$S($D(^DPT(DA,"VET"))#2:^("VET"),1:"")
 S X=$P(DIKZ("VET"),U,1)
 I X'="" S DFN=DA D EN^DGMTCOR K DGMTCOR
 S DIKZ("ODS")=$S($D(^DPT(DA,"ODS"))#2:^("ODS"),1:"")
 S X=$P(DIKZ("ODS"),U,2)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
 S X=$P(DIKZ("ODS"),U,3)
 I X'="" S A1B2TAG="PAT" D ^A1B2XFR
END G ^DGRPXX4
