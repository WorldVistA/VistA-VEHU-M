PRXAI00I ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440.02,0,"NM","SYNONYM")
 ;;=
 ;;^DD(440.02,0,"UP")
 ;;=440
 ;;^DD(440.02,.01,0)
 ;;=SYNONYM^MF^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>36!($L(X)<3) X
 ;;^DD(440.02,.01,1,0)
 ;;=^.1
 ;;^DD(440.02,.01,1,1,0)
 ;;=440^C
 ;;^DD(440.02,.01,1,1,1)
 ;;=S ^PRC(440,"C",$E(X,1,30),DA(1),DA)=""
 ;;^DD(440.02,.01,1,1,2)
 ;;=K ^PRC(440,"C",$E(X,1,30),DA(1),DA)
 ;;^DD(440.02,.01,1,1,"%D",0)
 ;;=^^3^3^2930624^
 ;;^DD(440.02,.01,1,1,"%D",1,0)
 ;;=This X-REF contains the SYNONYM for each vendor.  There can be
 ;;^DD(440.02,.01,1,1,"%D",2,0)
 ;;=multiple SYNONYMS for each vendor.  There can be the same SYNONYM
 ;;^DD(440.02,.01,1,1,"%D",3,0)
 ;;=for different vendors.
 ;;^DD(440.02,.01,3)
 ;;=ANSWER MUST BE 3-36 CHARACTERS IN LENGTH
 ;;^DD(440.02,.01,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440.02,.01,21,1,0)
 ;;=This is the synonym for the vendor.
 ;;^DD(440.02,.01,"DT")
 ;;=2850727
 ;;^DD(440.03,0)
 ;;=CONTRACT NUMBER SUB-FIELD^NL^4^6
 ;;^DD(440.03,0,"DT")
 ;;=2940307
 ;;^DD(440.03,0,"ID",.5)
 ;;=W "   ",$E($P(^(0),U,3),4,5)_"-"_$E($P(^(0),U,3),6,7)_"-"_$E($P(^(0),U,3),2,3)
 ;;^DD(440.03,0,"ID",1)
 ;;=W "   EXP. DATE: ",$E($P(^(0),U,2),4,5)_"-"_$E($P(^(0),U,2),6,7)_"-"_$E($P(^(0),U,2),2,3)
 ;;^DD(440.03,0,"ID",2)
 ;;=W:$D(^(1)) "   ",$P(^(1),U,1)
 ;;^DD(440.03,0,"IX","B",440.03,.01)
 ;;=
 ;;^DD(440.03,0,"NM","CONTRACT NUMBER")
 ;;=
 ;;^DD(440.03,0,"UP")
 ;;=440
 ;;^DD(440.03,.01,0)
 ;;=CONTRACT NUMBER^MFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>19!($L(X)<7) X
 ;;^DD(440.03,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(440.03,.01,1,1,0)
 ;;=440.03^B
 ;;^DD(440.03,.01,1,1,1)
 ;;=S ^PRC(440,DA(1),4,"B",$E(X,1,30),DA)=""
 ;;^DD(440.03,.01,1,1,2)
 ;;=K ^PRC(440,DA(1),4,"B",$E(X,1,30),DA)
 ;;^DD(440.03,.01,3)
 ;;=ANSWER MUST BE 7-19 CHARACTERS IN LENGTH
 ;;^DD(440.03,.01,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440.03,.01,21,1,0)
 ;;=This is the contract number.
 ;;^DD(440.03,.01,"DT")
 ;;=2940616
 ;;^DD(440.03,.5,0)
 ;;=BEGINNING DATE^D^^0;3^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(440.03,.5,3)
 ;;=Enter the starting date for this contract.
 ;;^DD(440.03,.5,21,0)
 ;;=^^1^1^2940616^
 ;;^DD(440.03,.5,21,1,0)
 ;;=This is the starting date for this contract.
 ;;^DD(440.03,.5,"DT")
 ;;=2940307
 ;;^DD(440.03,1,0)
 ;;=EXPIRATION DATE^RD^^0;2^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(440.03,1,3)
 ;;=Enter the ending date for this vendor contract.
 ;;^DD(440.03,1,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440.03,1,21,1,0)
 ;;=This is the expiration date of this vendor contract.
 ;;^DD(440.03,1,21,2,0)
 ;;=vendor contract.
 ;;^DD(440.03,1,"DT")
 ;;=2861122
 ;;^DD(440.03,2,0)
 ;;=CONTRACT TERMS^F^^1;1^K:$L(X)>50!($L(X)<3) X
 ;;^DD(440.03,2,3)
 ;;=ANSWER MUST BE 3-50 CHARACTERS IN LENGTH
 ;;^DD(440.03,2,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440.03,2,21,1,0)
 ;;=These are the contract terms.
 ;;^DD(440.03,2,"DT")
 ;;=2860405
 ;;^DD(440.03,3,0)
 ;;=PROMPT PAYMENT TERMS %^F^^0;4^K:$L(X)>5!($L(X)<1) X
 ;;^DD(440.03,3,3)
 ;;=ANSWER MUST BE 1-5 CHARACTERS IN LENGTH
 ;;^DD(440.03,3,21,0)
 ;;=^^1^1^2940616^^
 ;;^DD(440.03,3,21,1,0)
 ;;=These are the prompt payment terms.
