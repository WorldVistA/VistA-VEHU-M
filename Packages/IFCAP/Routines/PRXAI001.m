PRXAI001 ; ; 03-APR-1995
V ;;4.0;IFCAP;**27**;SEP 23, 1993
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(440,0,"GL")
 ;;=^PRC(440,
 ;;^DIC("B","VENDOR",440)
 ;;=
 ;;^DIC(440,"%D",0)
 ;;=^^3^3^2940218^^^^
 ;;^DIC(440,"%D",1,0)
 ;;=This file contains the listing of Vendors used by the facility. The data
 ;;^DIC(440,"%D",2,0)
 ;;=includes the name, address, contact person, contract number and FPDS data
 ;;^DIC(440,"%D",3,0)
 ;;=used when entering a request and purchase order.
 ;;^DD(440,0)
 ;;=FIELD^NL^46^78
 ;;^DD(440,0,"DT")
 ;;=2940919
 ;;^DD(440,0,"ID","Z0")
 ;;=I $D(^(3)),$P(^(3),U,2)="Y" W "   EDI VENDOR"
 ;;^DD(440,0,"ID","Z1")
 ;;=S Z9=$S('$D(^(10)):1,'$P(^(10),U,5):1,1:0) I 'Z9 W *7,"   **** THIS VENDOR IS INACTIVE, USE VENDOR NUMBER "_$S($D(^(9)):+^(9),1:"")_" ****"
 ;;^DD(440,0,"ID","Z2")
 ;;=I '$D(PRCFD("PAY")),Z9 W:$D(^(0)) "   ",$P(^(0),U,10)
 ;;^DD(440,0,"ID","Z3")
 ;;=I Z9 W:$D(Y) "NO. ",Y W:$D(^(3))&('$D(PRCFD("PAY"))) !?10,"SPECIAL FACTORS: ",$P(^(3),U,1)
 ;;^DD(440,0,"ID","Z4")
 ;;=I '$D(PRCFD("PAY")),Z9 S Z8=$S($D(^(0)):^(0),1:"") W !?10,"ORDERING ADDRESS: ",$P(Z8,U,2),!?26,"  ",$P(Z8,U,6),", ",$S($D(^DIC(5,+$P(Z8,U,7),0)):$P(^(0),U,2),1:"")," ",$P(^PRC(440,Y,0),U,8)
 ;;^DD(440,0,"ID","Z5")
 ;;=I '$D(PRCFD("PAY")),Z9 W !,$S($P(^(0),U,11)]"":"",'$D(^(2)):"Business Type is undefined",$P(^(2),U,2):"",$P(^(2),U,3)']"":"Business Type is undefined",1:"")
 ;;^DD(440,0,"ID","Z7")
 ;;=I $D(PRCFD("PAY")),Z9 S Z8=$S($D(^(7)):^(7),1:"") I Z8]"" D ADD^PRCFDADD
 ;;^DD(440,0,"ID","Z8")
 ;;=K Z8,Z9 W $E(^PRC(440,Y,0),0)
 ;;^DD(440,0,"IX","AC",440,.05)
 ;;=
 ;;^DD(440,0,"IX","AD",440,.01)
 ;;=
 ;;^DD(440,0,"IX","AE",440,31.5)
 ;;=
 ;;^DD(440,0,"IX","AF",440,18)
 ;;=
 ;;^DD(440,0,"IX","B",440,.01)
 ;;=
 ;;^DD(440,0,"IX","C",440.02,.01)
 ;;=
 ;;^DD(440,0,"IX","D",440,34)
 ;;=
 ;;^DD(440,0,"NM","VENDOR")
 ;;=
 ;;^DD(440,0,"SCR")
 ;;=X:$D(PRCHREAV) PRCHREAV
 ;;^DD(440,.001,0)
 ;;=NUMBER^NJ6,0^^ ^K:+X'=X!(X>999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(440,.001,3)
 ;;=TYPE A WHOLE NUMBER BETWEEN 1 AND 999999
 ;;^DD(440,.001,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,.001,21,1,0)
 ;;=This is the vendor number.
 ;;^DD(440,.001,23,0)
 ;;=^^1^1^2940616^
 ;;^DD(440,.001,23,1,0)
 ;;=This is the internal entry number for this vendor.
 ;;^DD(440,.001,"DT")
 ;;=2850425
 ;;^DD(440,.01,0)
 ;;=NAME^RFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>36!($L(X)<1)!'(X'?1P.E) X I $D(X) S:$D(PRCHPO) DIC("DR")="[PRCHVENDOR]"
 ;;^DD(440,.01,.1)
 ;;=
 ;;^DD(440,.01,1,0)
 ;;=^.1
 ;;^DD(440,.01,1,1,0)
 ;;=440^B
 ;;^DD(440,.01,1,1,1)
 ;;=S ^PRC(440,"B",X,DA)=""
 ;;^DD(440,.01,1,1,2)
 ;;=K ^PRC(440,"B",X,DA)
 ;;^DD(440,.01,1,2,0)
 ;;=440^AD^MUMPS
 ;;^DD(440,.01,1,2,1)
 ;;=I '$D(DIU(0)),$E(X,1,2)'="**" S:$D(DT) $P(^PRC(440,DA,10),U,1)=DT S:$D(DUZ) $P(^(10),U,2)=DUZ
 ;;^DD(440,.01,1,2,2)
 ;;=Q
 ;;^DD(440,.01,1,2,"%D",0)
 ;;=^^3^3^2930729^^
 ;;^DD(440,.01,1,2,"%D",1,0)
 ;;=This X-REF will SET both the DATE VENDOR CREATED and CREATED BY fields
 ;;^DD(440,.01,1,2,"%D",2,0)
 ;;=if the vendor is not INACTIVATED.  Inactivation is shown when the first
 ;;^DD(440,.01,1,2,"%D",3,0)
 ;;=two characters of the vendor's name are '**'.
 ;;^DD(440,.01,1,2,"DT")
 ;;=2930729
 ;;^DD(440,.01,3)
 ;;=ANSWER MUST BE 1-36 CHARACTERS IN LENGTH
 ;;^DD(440,.01,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440,.01,21,1,0)
 ;;=This is the vendor name.
 ;;^DD(440,.01,"DT")
 ;;=2930729
 ;;^DD(440,.05,0)
 ;;=SUPPLY WHSE. INDICATOR^SX^S:SUPPLY WAREHOUSE;^0;11^I $D(^PRC(440,"AC")) S Z0=+$O(^("AC","S",0)) I $D(^PRC(440,Z0,0)) W !,*7,$P(^(0),U,1)_" is already designated as the SUPPLY WAREHOUSE " K X
 ;;^DD(440,.05,1,0)
 ;;=^.1
 ;;^DD(440,.05,1,1,0)
 ;;=440^AC^MUMPS
 ;;^DD(440,.05,1,1,1)
 ;;=K ^PRC(440,"AC") S ^PRC(440,"AC",X,DA)=""
 ;;^DD(440,.05,1,1,2)
 ;;=K ^PRC(440,"AC",X,DA)
 ;;^DD(440,.05,1,1,"%D",0)
 ;;=^^5^5^2930707^^^^
 ;;^DD(440,.05,1,1,"%D",1,0)
 ;;=This X-REF is used to allow only one 'VENDOR' to be the 'SUPPLY
 ;;^DD(440,.05,1,1,"%D",2,0)
 ;;=WAREHOUSE'.
 ;;^DD(440,.05,1,1,"%D",3,0)
 ;;=The input transform for this field will allow only one vendor in
 ;;^DD(440,.05,1,1,"%D",4,0)
 ;;=this 'AC' X-REF to have a SUPPLY WHSE. INDICATOR, an 'S', in this
 ;;^DD(440,.05,1,1,"%D",5,0)
 ;;=field.
 ;;^DD(440,.05,3)
 ;;=There can only be one source designated as the SUPPLY WAREHOUSE
 ;;^DD(440,.05,21,0)
 ;;=^^2^2^2940616^^^
 ;;^DD(440,.05,21,1,0)
 ;;=This is the set of codes for supply warehouse indicator.
 ;;^DD(440,.05,21,2,0)
 ;;=Only one source can be designated as the supply warehouse.
 ;;^DD(440,.05,"DT")
 ;;=2870605
 ;;^DD(440,.06,0)
 ;;=FEDERAL SOURCE^*P420.8'X^PRCD(420.8,^2;2^S DIC("S")="I ""134590""[$E(^(0))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(440,.06,3)
 ;;=Enter only if this is Federal Source vendor and will only be used on a requisition.
