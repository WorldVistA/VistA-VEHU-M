DGRPX74 ; ;07/06/12
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$C(59)_$P($G(^DD(2,.304,0)),U,3) S X=$P($P(Y(1),$C(59)_Y(0)_":",2),$C(59))'="Y" I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X="" X ^DD(2,.304,1,2,1.4)
