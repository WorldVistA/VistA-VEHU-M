IBXSC618 ; ;04/17/02
 S X=DE(6),DIC=DIE
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGCR(399,D0,"RC",D1,0)):^(0),1:"") S X=$P(Y(1),U,11),X=X S DIU=X K Y S X="" X ^DD(399.042,.1,1,1,2.4)
 S X=DE(6),DIC=DIE
 X ^DD(399.042,.1,1,2,2.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"RC",D1,0)):^(0),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X="" S DIH=$G(^DGCR(399,DIV(0),"RC",DIV(1),0)),DIV=X S $P(^(0),U,15)=DIV,DIH=399.042,DIG=.15 D ^DICR
