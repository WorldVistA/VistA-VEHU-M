IBXSC825 ; ;06/23/08
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(0)=X S X=Y(0)="SLF000" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"PRV",D1,0)):^(0),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399.0222,.05,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 D ATTREND^IBCU1(DA(1),DA,.05)
