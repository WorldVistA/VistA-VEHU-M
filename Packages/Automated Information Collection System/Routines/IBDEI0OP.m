IBDEI0OP ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11779,2)
 ;;=^331953
 ;;^UTILITY(U,$J,358.3,11780,0)
 ;;=310.2^^53^678^4
 ;;^UTILITY(U,$J,358.3,11780,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11780,1,2,0)
 ;;=2^310.2
 ;;^UTILITY(U,$J,358.3,11780,1,5,0)
 ;;=5^Postconcussion Syndrome
 ;;^UTILITY(U,$J,358.3,11780,2)
 ;;=^265160
 ;;^UTILITY(U,$J,358.3,11781,0)
 ;;=310.81^^53^678^5
 ;;^UTILITY(U,$J,358.3,11781,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11781,1,2,0)
 ;;=2^310.81
 ;;^UTILITY(U,$J,358.3,11781,1,5,0)
 ;;=5^Pseudobulbar Affect
 ;;^UTILITY(U,$J,358.3,11781,2)
 ;;=^340506
 ;;^UTILITY(U,$J,358.3,11782,0)
 ;;=310.89^^53^678^2
 ;;^UTILITY(U,$J,358.3,11782,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11782,1,2,0)
 ;;=2^310.89
 ;;^UTILITY(U,$J,358.3,11782,1,5,0)
 ;;=5^Mental D/O d/t Brain Damage,Oth Spec
 ;;^UTILITY(U,$J,358.3,11782,2)
 ;;=^268320
 ;;^UTILITY(U,$J,358.3,11783,0)
 ;;=98960^^54^679^13^^^^1
 ;;^UTILITY(U,$J,358.3,11783,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11783,1,1,0)
 ;;=1^98960
 ;;^UTILITY(U,$J,358.3,11783,1,2,0)
 ;;=2^Self-Mgmt Trng,Ind,per 30min
 ;;^UTILITY(U,$J,358.3,11784,0)
 ;;=98961^^54^679^11^^^^1
 ;;^UTILITY(U,$J,358.3,11784,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11784,1,1,0)
 ;;=1^98961
 ;;^UTILITY(U,$J,358.3,11784,1,2,0)
 ;;=2^Self-Mgmt Trng,2-4 Pts
 ;;^UTILITY(U,$J,358.3,11785,0)
 ;;=98962^^54^679^12^^^^1
 ;;^UTILITY(U,$J,358.3,11785,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11785,1,1,0)
 ;;=1^98962
 ;;^UTILITY(U,$J,358.3,11785,1,2,0)
 ;;=2^Self-Mgmt Trng,5-8 Pts
 ;;^UTILITY(U,$J,358.3,11786,0)
 ;;=S9445^^54^679^9^^^^1
 ;;^UTILITY(U,$J,358.3,11786,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11786,1,1,0)
 ;;=1^S9445
 ;;^UTILITY(U,$J,358.3,11786,1,2,0)
 ;;=2^Pt Educ,Non-Phys,Indiv
 ;;^UTILITY(U,$J,358.3,11787,0)
 ;;=S9452^^54^679^7^^^^1
 ;;^UTILITY(U,$J,358.3,11787,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11787,1,1,0)
 ;;=1^S9452
 ;;^UTILITY(U,$J,358.3,11787,1,2,0)
 ;;=2^Nutrition Class,Non-Phys
 ;;^UTILITY(U,$J,358.3,11788,0)
 ;;=S9470^^54^679^8^^^^1
 ;;^UTILITY(U,$J,358.3,11788,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11788,1,1,0)
 ;;=1^S9470
 ;;^UTILITY(U,$J,358.3,11788,1,2,0)
 ;;=2^Nutritional Counseling,Dietitian
 ;;^UTILITY(U,$J,358.3,11789,0)
 ;;=S9465^^54^679^1^^^^1
 ;;^UTILITY(U,$J,358.3,11789,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11789,1,1,0)
 ;;=1^S9465
 ;;^UTILITY(U,$J,358.3,11789,1,2,0)
 ;;=2^Diabetic Mgmt,Dietitian
 ;;^UTILITY(U,$J,358.3,11790,0)
 ;;=S9140^^54^679^2^^^^1
 ;;^UTILITY(U,$J,358.3,11790,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11790,1,1,0)
 ;;=1^S9140
 ;;^UTILITY(U,$J,358.3,11790,1,2,0)
 ;;=2^Diabetic Mgmt,F/U Non-Phys 
 ;;^UTILITY(U,$J,358.3,11791,0)
 ;;=S9455^^54^679^3^^^^1
 ;;^UTILITY(U,$J,358.3,11791,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11791,1,1,0)
 ;;=1^S9455
 ;;^UTILITY(U,$J,358.3,11791,1,2,0)
 ;;=2^Diabetic Mgmt,Group 
 ;;^UTILITY(U,$J,358.3,11792,0)
 ;;=S9446^^54^679^10^^^^1
 ;;^UTILITY(U,$J,358.3,11792,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11792,1,1,0)
 ;;=1^S9446
 ;;^UTILITY(U,$J,358.3,11792,1,2,0)
 ;;=2^Pt Education,Group NOS
 ;;^UTILITY(U,$J,358.3,11793,0)
 ;;=S9449^^54^679^15^^^^1
 ;;^UTILITY(U,$J,358.3,11793,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11793,1,1,0)
 ;;=1^S9449
 ;;^UTILITY(U,$J,358.3,11793,1,2,0)
 ;;=2^Weight Management Class
 ;;^UTILITY(U,$J,358.3,11794,0)
 ;;=S9451^^54^679^4^^^^1
 ;;^UTILITY(U,$J,358.3,11794,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11794,1,1,0)
 ;;=1^S9451
 ;;^UTILITY(U,$J,358.3,11794,1,2,0)
 ;;=2^Exercise Class
 ;;^UTILITY(U,$J,358.3,11795,0)
 ;;=S9454^^54^679^14^^^^1
 ;;
 ;;$END ROU IBDEI0OP
