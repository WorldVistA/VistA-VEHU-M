GMRVO002 ; ; 07-SEP-1995
 ;;3.0;Vitals/Measurements;;Jan 24, 1996
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",337,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",337,20)
 ;;=Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
 ;;^UTILITY(U,$J,"PRO",337,99)
 ;;=55956,58575
 ;;^UTILITY(U,$J,"PRO",338,0)
 ;;=GMRVORHT^HEIGHT^^O^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",338,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",338,20)
 ;;=Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
 ;;^UTILITY(U,$J,"PRO",338,99)
 ;;=55956,58570
 ;;^UTILITY(U,$J,"PRO",339,0)
 ;;=GMRVORP SF511^SF511 Vitals Report^^A^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",339,1,0)
 ;;=^^2^2^2950206^^^
 ;;^UTILITY(U,$J,"PRO",339,1,1,0)
 ;;=This is the option that will create the protocol for the SF511 Patient
 ;;^UTILITY(U,$J,"PRO",339,1,2,0)
 ;;=Profile in OERR.
 ;;^UTILITY(U,$J,"PRO",339,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",339,15)
 ;;=K DFN
 ;;^UTILITY(U,$J,"PRO",339,20)
 ;;=Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  S DFN=+ORVP D EN4^GMRVSR0
 ;;^UTILITY(U,$J,"PRO",339,99)
 ;;=55956,58573
 ;;^UTILITY(U,$J,"PRO",340,0)
 ;;=GMRVORP CUM REPORT^Cumulative Vitals Report^^A^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",340,1,0)
 ;;=^^1^1^2950206^^^
 ;;^UTILITY(U,$J,"PRO",340,1,1,0)
 ;;=This option will create the protocol for the Cumulative Vitals report.
 ;;^UTILITY(U,$J,"PRO",340,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",340,15)
 ;;=K DFN
 ;;^UTILITY(U,$J,"PRO",340,20)
 ;;=Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  S DFN=+ORVP D EN2^GMRVSC0
 ;;^UTILITY(U,$J,"PRO",340,99)
 ;;=55956,58573
 ;;^UTILITY(U,$J,"PRO",341,0)
 ;;=GMRVORP DISP VITALS^Latest Vitals Display^^A^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",341,1,0)
 ;;=^^1^1^2950206^^^
 ;;^UTILITY(U,$J,"PRO",341,1,1,0)
 ;;=This option will create the protocol for the latest vitals display.
 ;;^UTILITY(U,$J,"PRO",341,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",341,15)
 ;;=K DFN
 ;;^UTILITY(U,$J,"PRO",341,20)
 ;;=Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  S DFN=+ORVP D EN3^GMRVDS0
 ;;^UTILITY(U,$J,"PRO",341,99)
 ;;=55956,58573
 ;;^UTILITY(U,$J,"PRO",342,0)
 ;;=GMRVOR DGPM^GMRV Movement Events^^X^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",342,1,0)
 ;;=^^3^3^2950522^^^^
 ;;^UTILITY(U,$J,"PRO",342,1,1,0)
 ;;=This option will become the GMRVOR DGPM protocol, and should be linked to
 ;;^UTILITY(U,$J,"PRO",342,1,2,0)
 ;;=the DGOERR TRANSFER EVENTS protocol.  This protocol will perform events that
 ;;^UTILITY(U,$J,"PRO",342,1,3,0)
 ;;=are appropriate for the GMRV pacakge.
 ;;^UTILITY(U,$J,"PRO",342,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",342,20)
 ;;=Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN4^GMRVORDG
 ;;^UTILITY(U,$J,"PRO",342,99)
 ;;=55956,58567
 ;;^UTILITY(U,$J,"PRO",343,0)
 ;;=GMRVORQ0^QUICK B/P^^O^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",343,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",343,20)
 ;;=S GMRVANSR="NOW^N+3^TID^NONE",GMRVKWIK=1 D DATE^GMRVOREQ Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
 ;;^UTILITY(U,$J,"PRO",343,99)
 ;;=55956,58574
 ;;^UTILITY(U,$J,"PRO",344,0)
 ;;=GMRVORQ1^QUICK WEIGHT^^O^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",344,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",344,20)
 ;;=S GMRVANSR="~NOW^~NOW+7^QD^NONE",GMRVKWIK=1 D DATE^GMRVOREQ Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
 ;;^UTILITY(U,$J,"PRO",344,99)
 ;;=55956,58574
 ;;^UTILITY(U,$J,"PRO",347,0)
 ;;=GMRVORQ2^QUICK TPR^^L^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",347,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",347,10,0)
 ;;=^101.01PA^3^3
 ;;^UTILITY(U,$J,"PRO",347,10,1,0)
 ;;=336^
 ;;^UTILITY(U,$J,"PRO",347,10,1,"^")
 ;;=GMRVORTEMP
 ;;^UTILITY(U,$J,"PRO",347,10,2,0)
 ;;=333^
 ;;^UTILITY(U,$J,"PRO",347,10,2,"^")
 ;;=GMRVORPULSE
 ;;^UTILITY(U,$J,"PRO",347,10,3,0)
 ;;=337^
 ;;^UTILITY(U,$J,"PRO",347,10,3,"^")
 ;;=GMRVORRESP
 ;;^UTILITY(U,$J,"PRO",347,20)
 ;;=S GMRVANSR="^^BID",GMRVKWIK=1 D DATE^GMRVOREQ Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
 ;;^UTILITY(U,$J,"PRO",347,99)
 ;;=55956,58576
 ;;^UTILITY(U,$J,"PRO",348,0)
 ;;=GMRVORQ3^QUICK PULSE^^O^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",348,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",348,20)
 ;;=S GMRVANSR="~NOW^~NOW+7^BID^NONE",GMRVKWIK=1 D DATE^GMRVOREQ Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
 ;;^UTILITY(U,$J,"PRO",348,99)
 ;;=55956,58575
 ;;^UTILITY(U,$J,"PRO",349,0)
 ;;=GMRVORQ4^QUICK HEIGHT^^O^^^^^^^^GEN. MED. REC. - VITALS
 ;;^UTILITY(U,$J,"PRO",349,5)
 ;;=
 ;;^UTILITY(U,$J,"PRO",349,20)
 ;;=S GMRVANSR="NOW^NOW+7^QD^NONE",GMRVKWIK=1 D DATE^GMRVOREQ Q:$S('$D(^ORD(100.99)):1,'$D(^PS(59.7,1,20)):1,1:^(20)<2.8)  D EN1^GMRVORE0
