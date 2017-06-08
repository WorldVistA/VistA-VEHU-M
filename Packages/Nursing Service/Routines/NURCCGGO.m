NURCCGGO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15682,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15682,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15683,0)
 ;;=demonstrates ability to pace activity with rest periods^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15683,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15683,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15684,0)
 ;;=B/P lying [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15685,0)
 ;;=B/P sitting [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15686,0)
 ;;=B/P standing [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15687,0)
 ;;=monitor CT insertion site/integrity of drainage system q[ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15687,4)
 ;;=assess, document &
 ;;^UTILITY("^GMRD(124.2,",$J,15687,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15687,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15688,0)
 ;;=monitor color, consistency, amount of CT drainage q[ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15688,4)
 ;;=assess, document &
 ;;^UTILITY("^GMRD(124.2,",$J,15688,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15688,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15691,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^300^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15691,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15691,1,1,0)
 ;;=15693^[etiology]^3^NURSC^140
 ;;^UTILITY("^GMRD(124.2,",$J,15691,1,2,0)
 ;;=15694^[etiology]^3^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,15691,1,3,0)
 ;;=15761^[etiology]^3^NURSC^148
 ;;^UTILITY("^GMRD(124.2,",$J,15691,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15692,0)
 ;;=[etiology]^3^NURSC^^139^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15693,0)
 ;;=[etiology]^3^NURSC^^140^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15694,0)
 ;;=[etiology]^3^NURSC^^141^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15695,0)
 ;;=appetite altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15697,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^315^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,1,0)
 ;;=809^assess mobility, limitations q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,2,0)
 ;;=15698^assess function, ROM, and strength in extremeties^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,3,0)
 ;;=11608^instruct/assist with ROM [specify]^3^NURSC^56
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,4,0)
 ;;=13270^teach techniques to prevent complications^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,5,0)
 ;;=15702^instruct and assist in use of mobility aids [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15697,1,6,0)
 ;;=1006322^[Extra Order]^3^NURSC^119
 ;;^UTILITY("^GMRD(124.2,",$J,15697,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15697,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15698,0)
 ;;=assess function, ROM, and strength in extremeties^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15698,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15698,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15699,0)
 ;;=prevent complications of bleeding^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15699,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15699,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15702,0)
 ;;=instruct and assist in use of mobility aids [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15702,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15702,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15703,0)
 ;;=monitor laboratory values q[frequency]^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15703,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15703,1,1,0)
 ;;=15704^WBC^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15703,1,2,0)
 ;;=1739^sodium^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15703,1,3,0)
 ;;=1740^potassium^3^NURSC^1
