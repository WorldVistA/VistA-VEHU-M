NLTIPCK ;DALIAC/FHS - PRE-INIT ENVIRONMENT CHECK FOR NLT INSTALL
 ;;5.254;NATIONAL LABORATORY TESTS;;SEP 21, 1995
EN ;
 Q:'$D(DIFQ)
 I $G(U)'="^" G DUZ
 I $S('$D(DUZ):1,'$D(^VA(200,+DUZ)):1,'$D(IO):1,1:0) G DUZ
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) G DUZ0
 W !!,"Checking NLT data version numbers.",!
 I $D(^LAM("VR")),+$G(^LAM("VR"))<5.2 W !,$C(7),"YOU MUST HAVE AT LEAST LAB V5.2 BEFORE I CAN INIT THIS VERSION ",$P($T(+2),";",3),! K DIFQ Q
 I +$G(^LAM("VR"))<5.199 W !!,"You Need to install V5.2 of the Laboratory Package.",!! K DIFQ Q
GLB ;
 I +$G(^LAM("VR"))=5.254 W !!?5,"You have have already installed this version once.",!," Do you want to continue " S %Y=2 D YN^DICN I %'=1 K DIFQ Q
 W !!?5,"Environment Check Complete",!!
 Q
MSG ;
 ;;END
 Q
DUZ W !!?10,"Please log in using access and verify codes",!!,$C(7) K DIFQ Q
DUZ0 W !!?10,"You do not have programmer access in your fileman access code",!!,$C(7) K DIFQ Q
END ;
 Q
