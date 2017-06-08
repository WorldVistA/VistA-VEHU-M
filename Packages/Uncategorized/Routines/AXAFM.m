AXAFM ;WPB/JLTP ; PROGRAMMING WITH FILEMAN CALLS ; 11-AUG-98
 ;;1.0;;;11-AUG-1998;Build 2
DIC(F,VAR,V,L,S,A,D,SCR) ;------ Standard DIC Call ------
 ;
 ; F = File Number (Required)
 ; VAR = Returned Variable - Pass by Reference (Required)
 ; V = The value to use if lookup is non-interactive (i.e. X)
 ; L = 1 or 0 - Laygo Allowed? Default = no (A yes here sets DLAYGO=F)
 ; S = Other Switches used for DIC(0) Default = AEMQZ
 ; A = The DIC("A") prompt Default = FileMan's Default
 ; D = The DIC("B") default answer  Default = None
 ;
 ; The result of the call will be 1 if successful, 0 if not
 N D0,DA,DD,DIC,DO,DTOUT,DLAYGO,FLAGS,LVL,S,X,Y
 S F=$G(F),FLAGS=$P(F,U,2),F=+F
 S LVL=0 F  Q:'$D(^DD(F,0,"UP"))  D
 .S LVL=LVL+1,F(LVL)=F,F=^("UP"),SS=$O(^DD(F,"SB",F(LVL),0))
 .S SS(LVL)=+$P($G(^DD(F,SS,0)),U,4)
 S DIC=$G(^DIC(+F,0,"GL")) I DIC="" Q 0
 S LVL="" F  S LVL=$O(F(LVL),-1) Q:'LVL  D
 .S DIC=DIC_+$G(DA(LVL))_","_SS(LVL)_","
 I $L($G(V)) S X=V
 S:'$L($G(S)) S=$S($D(X):"MZ",1:"AEMQZ") S DIC(0)=S
 I $G(L) S DLAYGO=F,DIC(0)=DIC(0)_"L"
 I $L($G(A)) S DIC("A")=A
 I $L($G(D)) S DIC("B")=D
 I $L($G(SCR)) S DIC("S")=SCR
 D ^DIC
 M VAR=Y S VAR=$S(FLAGS=1:+Y,FLAGS=2:$P(Y,U,2),1:Y)
 Q Y>0
DIR(S,VAR,A,B,SCR,H1,H2) ;------ Standard DIR Call ------
 ; Input Variables
 ;
 ; S = Switches for DIC(0) - (required)
 ; VAR = Info returned - (required, pass by reference)
 ; A & B = DIR("A") & DIR("B")
 ; SCR = DIR("S")
 ;
 ; Returns 1 if successful, 0 if not
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=S M:$G(A)]"" DIR("A")=A S:$G(B)]"" DIR("B")=B
 S:$G(SCR)]"" DIR("S")=SCR
 S:$G(H1)]"" DIR("?")=H1 S:$G(H2)]"" DIR("??")=H2
 D ^DIR M VAR=Y
 Q ($D(DTOUT)+$D(DUOUT)=0)
DIE(DIE,DA,DR) ;
 N D,D0,DB,DC,DD,DE,DF,DG,DH,DI,DIA,DIC,DIFLD,DIIX,DIK,DIV
 N DJ,DK,DL,DM,DN,DO,DP,DQ,DU,DV,DW,DX,DY,DZ,I,L,X,Y
 S:DIE=+DIE DIE=$G(^DIC(DIE,0,"GL")) Q:DIE=""
 D ^DIE
 Q
DIV(VAR,M) ;------ Select Division(s) ------
 ; VAR = Return Value (Pass by refrence)
 ; M = Multiple selections allowed
 F  D  Q:$D(DIRUT)  Q:'M
 .S DIR(0)="PO^4:AEMQ",DIR("A")="Select Division"
 .S DIR("S")="I $D(^VA(200,DUZ,2,+Y,0))"
 .D ^DIR Q:$D(DIRUT)
 .S VAR(+Y)=$P(Y,U,2)
 Q ($D(DTOUT)+$D(DUOUT)=0)
NFN(DD) ;------ Generate Next IFN For A File ------
 N GL,ENTRY,IFN,ZN,ZNV
 S GL=$G(^DIC(DD,0,"GL")) Q:GL="" -1
 S ZN=GL_"0)"
 L +(@ZN):5 E  Q -1
 S ZNV=@ZN,IFN=$P(ZNV,U,3)+1
 F  S ENTRY=GL_IFN_",0)" Q:'$D(@ENTRY)  S IFN=IFN+1
 L -(@ZN)
 Q IFN
CFE(P1,P2,P3) ;------ Create File Entry ------
 ; P1 = DD#
 ; P2 = .01 VALUE
 ; P3 = BOOLEAN DINUM?
 N D,D0,DA,DD,DIC,DINUM,DO,GL,X,Y
 S P2=$G(P2),P3=$G(P3)
 S GL=$G(^DIC(P1,0,"GL")) Q:GL="" -1
 S DIC=GL,DIC(0)="L",X=P2,(DA,DINUM)=$$NFN(P1) I P3 S (X,P2)=DA
 Q:DA<0 -1  K DD,DO D FILE^DICN
 Q Y
DR(S,E,F,AE,DF) ; Select a Date Range
 N A,D,X
 S:$G(F)="" F="AETS" S AE=$G(AE),DF=$G(DF)
 S A=$P(AE,U) S:A="" A="Starting Date"
 S D=$P(DF,U)
 Q:'$$DIR^AXAFM("D^::"_F,.S,A,D) 0
 S A=$P(AE,U,2) S:A="" A="Ending Date"
 S D=$P(DF,U,2)
 Q:'$$DIR^AXAFM("D^::"_F,.E,A,D) 0
 I S>E S X=E,E=S,S=X
 Q 1
DTI(Y,X,F,A,D,S) ; ------ External to Internal Date ------
 N %DT
 S %DT=$G(F),X=$G(X)
 S:$G(A)]"" %DT("A")=A S:$G(D)]"" %DT("B")=D S:$G(S)]"" %DT(0)=S
 D ^%DT
 Q Y>-1
ID(F,Y) ;------ Display Identifiers ------
 N FGR,ID,REF,XID
 S F=+$G(F),Y=+$G(Y),FGR=$G(^DIC(F,0,"GL")) Q:'$L(FGR)
 S ID="" F  S ID=$O(^DD(F,0,"ID",ID)) Q:ID=""  S XID=^(ID) D
 .S @("REF="_FGR_Y_",0)") X XID
 Q
PH(X) ;------ Generic Phone Number Input Transform ------
 N I,C,Y
 S Y=X,X=""
 F I=1:1:$L(Y) S C=$E(Y,I) S:C?1N X=X_C
 S X=$S(X?7N:$E(X,1,3)_"-"_$E(X,4,7),X?10N:$E(X,1,3)_"-"_$E(X,4,6)_"-"_$E(X,7,10),X?11N:$E(X,2,4)_"-"_$E(X,5,7)_"-"_$E(X,8,11),1:Y)
 Q X
EDTI(X) ;------ External DT to Interal ------
 N %DT,Y
 S %DT="TS"
 D ^%DT
 Q Y
TIME(X,FLAGS) ;------ Extract Time From FileMan Date ------
 S FLAGS=$G(FLAGS) N H,M,S,AP S AP=""
 S X=$E($P(X,".",2)_"000000",1,$S(FLAGS["S":6,1:4))
 S H=$E(X,1,2),M=$E(X,3,4),S=$E(X,5,6)
 I FLAGS["C" S H=$J(+H,2),AP=" AM" S:H>11 AP=" PM" S:H=0 H=12 S:H>12 H=$J(H-12,2)
 S X=H_":"_M S:FLAGS["S" X=X_":"_S
 S X=X_AP
 Q X
MSEL(DD,ARY,P,SCR,IN) ; Multiple Select
 N DA,PR,Y
 K @ARY S DD=$G(DD) Q:'DD 0 S:$G(P)="" P=$O(^DD(DD,0,"NM",""))
 M:$O(IN(0)) DA=IN S SCR=$G(SCR) S:SCR="" SCR="Q"
 S PR="Select "_P
 F  Q:'$$DIR("PO^"_DD_":AEMQ",.Y,PR)  Q:Y<0  D
 .S PR="Select Another "_P
 .S @ARY@(+Y)=$P(Y,U,2)
 Q ''$O(@ARY@(0))
