RJPTFXMP ;RJ WILM DE; PRINTOUT CODE SHEETS FOR XM MESSAGE; OCT 21 86
 ;;4.0
 S:'$D(DTIME) DTIME=300 K IOP D ^%ZIS Q:POP  S A=""
1 U IO(0) S DIC(0)="QEAM",DIC="^XMB(3.9," W ! D ^DIC G:Y<1 X S DA=+Y
 D H F I=1:1 Q:'$D(^XMB(3.9,DA,2,I,0))  W !,$E(^(0),2,80) I $Y>(IOSL-2) D H1 Q:A["^"
 G:A'["^" 1
X X ^%ZIS("C") K DIC,DA,A Q
H U IO W @IOF,!,"Mailman Message: ",$P(Y,"^",2) W:$D(^XMB(3.9,DA,2,1,0)) !,$E(^XMB(3.9,DA,2,1,0),1) F I=2:1:80 W:$E(I,2)="0" ?(I-2),$E(I,1)
 W ! F I=2:1:80 S X=I S:$L(X)=1 X="0"_X W $E(X,2)
 W ! F I=1:1:79 W "-"
 Q
H1 S A="" I IO=IO(0) W !,"Press RETURN to continue, ""^"" to exit." R A:DTIME S:'$T A="^"
 Q:A["^"  D H Q
