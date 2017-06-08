PRXAI002 ; ; 03-APR-1995
V ;;4.0;IFCAP;**27**;SEP 23, 1993
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,.06,12)
 ;;=ENTER THE APPROPRIATE SOURCE CODE
 ;;^DD(440,.06,12.1)
 ;;=S DIC("S")="I ""134590""[$E(^(0))"
 ;;^DD(440,.06,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,.06,21,1,0)
 ;;=This is the federal source.
 ;;^DD(440,.06,"DT")
 ;;=2940322
 ;;^DD(440,.2,0)
 ;;=EDI VENDOR?^S^Y:YES;^3;2^Q
 ;;^DD(440,.2,.1)
 ;;=
 ;;^DD(440,.2,3)
 ;;=Enter YES if this vendor can accept purchase orders electronically using EDI X12.  Do do only if directed from Austin.
 ;;^DD(440,.2,21,0)
 ;;=^^4^4^2940616^^^
 ;;^DD(440,.2,21,1,0)
 ;;=This field identifies those vendors who are prepared to receive
 ;;^DD(440,.2,21,2,0)
 ;;=purchase orders electronically through the EDI system in AUSTIN.
 ;;^DD(440,.2,21,3,0)
 ;;=Don't enter anything in this field unless directed to do so from
 ;;^DD(440,.2,21,4,0)
 ;;=the EDI group in Austin, Texas.
 ;;^DD(440,.2,"DT")
 ;;=2910801
 ;;^DD(440,.4,0)
 ;;=VENDOR ID NUMBER^FX^^3;3^K:$L(X)>12!($L(X)<5) X I $D(X) K:X'?5.12UN X
 ;;^DD(440,.4,3)
 ;;=Enter the vendor's EDI identification number.  It should be 5-12 upper case           alpha/numeric characters.
 ;;^DD(440,.4,21,0)
 ;;=^^3^3^2940616^^^
 ;;^DD(440,.4,21,1,0)
 ;;=This field uniquely identifies a vendor to the EDI system.
 ;;^DD(440,.4,21,2,0)
 ;;=Don't enter anything in this field unless directed to do so from the
 ;;^DD(440,.4,21,3,0)
 ;;=EDI group in Austin, Texas.
 ;;^DD(440,.4,"DT")
 ;;=2910726
 ;;^DD(440,1,0)
 ;;=ORDERING ADDRESS1^RF^^0;2^K:$L(X)>33!($L(X)<1) X
 ;;^DD(440,1,3)
 ;;=ANSWER MUST BE 1-33 CHARACTERS IN LENGTH
 ;;^DD(440,1,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440,1,21,1,0)
 ;;=This is the vendor ordering address line 1.
 ;;^DD(440,1,"DT")
 ;;=2860220
 ;;^DD(440,2,0)
 ;;=ORDERING ADDRESS2^F^^0;3^K:$L(X)>33!($L(X)<1) X
 ;;^DD(440,2,3)
 ;;=ANSWER MUST BE 1-33 CHARACTERS IN LENGTH
 ;;^DD(440,2,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,2,21,1,0)
 ;;=This is the vendor ordering address line 2.
 ;;^DD(440,2,"DT")
 ;;=2860220
 ;;^DD(440,3,0)
 ;;=ORDERING ADDRESS3^F^^0;4^K:$L(X)>25!($L(X)<1) X
 ;;^DD(440,3,3)
 ;;=ANSWER MUST BE 1-25 CHARACTERS IN LENGTH
 ;;^DD(440,3,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,3,21,1,0)
 ;;=This is the vendor ordering address line 3.
 ;;^DD(440,3,"DT")
 ;;=2860220
 ;;^DD(440,4,0)
 ;;=ORDERING ADDRESS4^F^^0;5^K:$L(X)>25!($L(X)<1) X
 ;;^DD(440,4,3)
 ;;=ANSWER MUST BE 1-25 CHARACTERS IN LENGTH
 ;;^DD(440,4,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,4,21,1,0)
 ;;=This is the vendor ordering address line 4.
 ;;^DD(440,4,"DT")
 ;;=2860220
 ;;^DD(440,4.2,0)
 ;;=ORDERING CITY^F^^0;6^K:$L(X)>20!($L(X)<3) X
 ;;^DD(440,4.2,3)
 ;;=ANSWER MUST BE 3-20 CHARACTERS IN LENGTH
 ;;^DD(440,4.2,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,4.2,21,1,0)
 ;;=This is the city of the vendor ordering address.
 ;;^DD(440,4.2,"DT")
 ;;=2860208
 ;;^DD(440,4.4,0)
 ;;=ORDERING STATE^P5'^DIC(5,^0;7^Q
 ;;^DD(440,4.4,3)
 ;;=enter the state that goes with this ORDERING ADDRESS.
 ;;^DD(440,4.4,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,4.4,21,1,0)
 ;;=This is the state for the vendor ordering address.
 ;;^DD(440,4.4,"DT")
 ;;=2860208
 ;;^DD(440,4.6,0)
 ;;=ORDERING ZIP CODE^FX^^0;8^K:$L(X)<5!(X'?5N.E)!($L(X)>10)!($L(X)>5&(X'?5N1"-"4N)) X
 ;;^DD(440,4.6,3)
 ;;=5 DIGIT ZIP OR A 9 DIGIT ZIP IN THIS FORMAT 12345-6789
 ;;^DD(440,4.6,21,0)
 ;;=^^1^1^2950403^^^^
 ;;^DD(440,4.6,21,1,0)
 ;;=This is the zip code of the ordering address.
 ;;^DD(440,4.6,23,0)
 ;;=^^4^4^2950403^
 ;;^DD(440,4.6,23,1,0)
 ;;=The input transform checks for a pattern of 5 numerics or
 ;;^DD(440,4.6,23,2,0)
 ;;=5 numerics followed by a dash (-) and 4 numerics.  It also
 ;;^DD(440,4.6,23,3,0)
 ;;=checks for a total length of 10, so fileman will print the
 ;;^DD(440,4.6,23,4,0)
 ;;=zip+4 in outputs.
 ;;^DD(440,4.6,"DT")
 ;;=2950403
 ;;^DD(440,4.7,0)
 ;;=COUNTY^FXO^^2;4^S Z0=$S($P(^PRC(440,D0,0),U,7)]"":$P(^(0),U,7),1:0) K:'Z0 X Q:'Z0!'$D(^DIC(5,Z0,1,0))  S DIC="^DIC(5,Z0,1,",DIC(0)="QEM" D ^DIC S X=+Y K:Y'>0 X K Z0,DIC
 ;;^DD(440,4.7,2)
 ;;=S Y(0)=Y Q:Y']""  S Z0=$S($P(^PRC(440,D0,0),U,7)]"":$P(^(0),U,7),1:0) Q:'Z0  S Y=$S($D(^DIC(5,Z0,1,Y,0)):$P(^(0),U,1),1:"") K Z0
 ;;^DD(440,4.7,2.1)
 ;;=Q:Y']""  S Z0=$S($P(^PRC(440,D0,0),U,7)]"":$P(^(0),U,7),1:0) Q:'Z0  S Y=$S($D(^DIC(5,Z0,1,Y,0)):$P(^(0),U,1),1:"") K Z0
 ;;^DD(440,4.7,3)
 ;;=Enter the appropriate county for the given state
 ;;^DD(440,4.7,4)
 ;;=S ZD=D,X="?",Z0=$S($P(^PRC(440,D0,0),U,7)]"":$P(^(0),U,7),1:0) Q:'Z0!'$D(^DIC(5,Z0,1,0))  S DIC="^DIC(5,Z0,1,",DIC(0)="QEM" D ^DIC S DIC=DIE,D=ZD K ZD,Z0
 ;;^DD(440,4.7,21,0)
 ;;=^^2^2^2910516^
 ;;^DD(440,4.7,21,1,0)
 ;;=This is the appropriate county for the given state
 ;;^DD(440,4.7,21,2,0)
 ;;=of the vendor ordering address.
