PRXAI00J ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440.03,3,"DT")
 ;;=2860304
 ;;^DD(440.03,4,0)
 ;;=PROMPT PAYMENT TERMS DAYS^NJ2,0^^0;5^K:+X'=X!(X>60)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(440.03,4,3)
 ;;=TYPE A WHOLE NUMBER BETWEEN 1 AND 60
 ;;^DD(440.03,4,21,0)
 ;;=^^1^1^2940616^^^
 ;;^DD(440.03,4,21,1,0)
 ;;=These are the prompt payment terms number of days.
 ;;^DD(440.03,4,"DT")
 ;;=2860304
 ;;^DD(440.04,0)
 ;;=REMARKS SUB-FIELD^^.01^1
 ;;^DD(440.04,0,"NM","REMARKS")
 ;;=
 ;;^DD(440.04,0,"UP")
 ;;=440
 ;;^DD(440.04,.01,0)
 ;;=REMARKS^W^^0;1^Q
 ;;^DD(440.04,.01,21,0)
 ;;=^^2^2^2930413^
 ;;^DD(440.04,.01,21,1,0)
 ;;= 
 ;;^DD(440.04,.01,21,2,0)
 ;;=Remarks about the vendor
 ;;^DD(440.04,.01,"DT")
 ;;=2861122
 ;;^DD(440.05,0)
 ;;=SOCIOECONOMIC GROUP (FPDS) SUB-FIELD^^.01^1
 ;;^DD(440.05,0,"NM","SOCIOECONOMIC GROUP (FY89)")
 ;;=
 ;;^DD(440.05,0,"UP")
 ;;=440
 ;;^DD(440.05,.01,0)
 ;;=SOCIOECONOMIC GROUP (FPDS)^MR*P420.6'OX^PRCD(420.6,^0;1^S DIC("S")="I Y>155,$P(^(0),U,3)=1" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X S:$D(X) DINUM=X
 ;;^DD(440.05,.01,1,0)
 ;;=^.1^^0
 ;;^DD(440.05,.01,2)
 ;;=S Y(0)=Y Q:Y=""  S Y=$S($D(^PRCD(420.6,Y,0)):^(0),1:""),Y=$P(Y,U,1)_"  "_$P(Y,U,2)
 ;;^DD(440.05,.01,2.1)
 ;;=Q:Y=""  S Y=$S($D(^PRCD(420.6,Y,0)):^(0),1:""),Y=$P(Y,U,1)_"  "_$P(Y,U,2)
 ;;^DD(440.05,.01,3)
 ;;=Enter FPDS Socioeconomic Group for use in FPDS reporting for FY 1989 or later.
 ;;^DD(440.05,.01,12)
 ;;=Select N,P,Q,R,W or OO
 ;;^DD(440.05,.01,12.1)
 ;;=S DIC("S")="I Y>155,$P(^(0),U,3)=1"
 ;;^DD(440.05,.01,21,0)
 ;;=^^1^1^2940204^^
 ;;^DD(440.05,.01,21,1,0)
 ;;=This is the socioeconomic group.
 ;;^DD(440.05,.01,"DT")
 ;;=2880921
