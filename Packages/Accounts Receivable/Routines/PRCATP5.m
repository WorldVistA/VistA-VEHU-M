PRCATP5 ; GENERATED FROM 'PRCA 3RD PROFILE' PRINT TEMPLATE (#767) ; 05/26/95 ; (FILE 430, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(767,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100) S Y=X K DIP K:DN Y S Y=X D DT
 W ?20 W " 3RD PARTY ACCOUNTS RECEIVABLE PROFILE"
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=75,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "PATIENT NAME: "
 S X=$G(^PRCA(430,D0,0)) S Y=$P(X,U,7) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "BILL #: "
 W ?0,$E($P(X,U,1),1,30)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "CURRENT STATUS: "
 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^PRCA(430.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "CATEGORY: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "CP: "
 S X=$G(^PRCA(430,D0,11)) W ?0,$E($P(X,U,1),1,15)
 D N:$X>39 Q:'DN  W ?39 W "FUND (APPROPRIATION): "
 W ?0,$E($P(X,U,17),1,6)
 D N:$X>39 Q:'DN  W ?39 W "DATE BILL PREPARED: "
 S X=$G(^PRCA(430,D0,0)) S Y=$P(X,U,10) D DT
 D N:$X>39 Q:'DN  W ?39 W "TYPE OF CARE: "
 W ?55 S X=D0 D ^DGCRAMS W ?59,$S(Y=-1:"","^249^293^"[("^"_Y_"^"):"OUTPATIENT",1:"INPATIENT") K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "DATES OF SERVICE: "
 W ?59 S X=$$SVDT^PRCADR(D0) W:+X $$FMTE^XLFDT($P(X,U,3))_" -",!,?59,$$FMTE^XLFDT($P(X,U,4)) K DIP K:DN Y
 W ?70 D EN1^PRCADR1 K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "3RD PARTY:  "
 S X=$G(^PRCA(430,D0,0)) D N:$X>12 Q:'DN  W ?12 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,27)
 W ?41 D EN4^PRCADR K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "INSURED'S NAME"
 D N:$X>25 Q:'DN  W ?25 W "S"
 D N:$X>28 Q:'DN  W ?28 W "ID NO."
 D N:$X>45 Q:'DN  W ?45 W "GROUP NAME"
 D N:$X>60 Q:'DN  W ?60 W "GROUP NO."
 S X=$G(^PRCA(430,D0,202)) D N:$X>1 Q:'DN  W ?1,$E($P(X,U,1),1,30)
 D N:$X>25 Q:'DN  W ?25 S DIP(1)=$S($D(^PRCA(430,D0,202)):^(202),1:"") S X=$P(DIP(1),U,2),X=X K DIP K:DN Y W X
 S X=$G(^PRCA(430,D0,202)) D N:$X>28 Q:'DN  W ?28,$E($P(X,U,4),1,20)
 D N:$X>45 Q:'DN  W ?45,$E($P(X,U,5),1,20)
 D N:$X>60 Q:'DN  W ?60,$E($P(X,U,6),1,10)
 D T Q:'DN  W ?2 D EN5^PRCADR Q:$D(PRCA("HALT"))  W "" K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "EMPLOYER NAME"
 D N:$X>28 Q:'DN  W ?28 W "EMPLOYEE ID"
 D N:$X>44 Q:'DN  W ?44 W "EMPLOYER LOCATION"
 S X=$G(^PRCA(430,D0,202)) D N:$X>1 Q:'DN  W ?1,$E($P(X,U,9),1,30)
 D N:$X>28 Q:'DN  W ?28,$E($P(X,U,10),1,11)
 D T Q:'DN  W ?44,$E($P(X,U,11),1,40)
 D N:$X>0 Q:'DN  W ?0 W "SECONDARY INSURANCE COMPANY: "
 S X=$G(^PRCA(430,D0,0)) W ?31 S Y=$P(X,U,19) S Y=$S(Y="":Y,$D(^DIC(36,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "TERTIARY INSUANCE COMPANY: "
 W ?29 S Y=$P(X,U,20) S Y=$S(Y="":Y,$D(^DIC(36,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 W ?61 D EN3^PRCADR K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "TRANSACTIONS: "
 W ?16 D EN2^PRCADR K DIP K:DN Y
 W ?27 Q:$D(PRCA("HALT"))  W "" K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "BILL RESULTING FROM: "
 W ?23 X DXS(1,9) K DIP K:DN Y
 W ?34 D PRCOMM^PRCAUT3 K DIP K:DN Y
 W ?45 Q:'$D(PRCA("WROFF"))  W "" K DIP K:DN Y
 W ?56 K DXS S D0=PRCA("WROFF") D ^PRCATW1 K DXS K DIP K:DN Y
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
