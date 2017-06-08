NURCCG6R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,1,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,2,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,3,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,4,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,5,0)
 ;;=853^Substance Abuse, Alcohol^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,6,0)
 ;;=854^Substance Abuse, Drugs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2776,1,7,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2777,0)
 ;;=immobility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2778,0)
 ;;=inflammation injury^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2779,0)
 ;;=ischemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2780,0)
 ;;=muscle spasms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2781,0)
 ;;=muscle tension^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2782,0)
 ;;=contraction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2783,0)
 ;;=physical activity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2784,0)
 ;;=procedures^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2785,0)
 ;;=surgical incision^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2786,0)
 ;;=tissue damage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2787,0)
 ;;=hostility/anger^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2788,0)
 ;;=altered thought process^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2789,0)
 ;;=verbalizes when in pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2789,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2789,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2790,0)
 ;;=free of objective signs of pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2790,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2790,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2791,0)
 ;;=identifies factors that influence pain experience^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2791,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2791,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2792,0)
 ;;=identifies appropriate pain relief measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2792,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2792,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2793,0)
 ;;=demonstrates use of pain relief measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2793,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2793,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2794,0)
 ;;=patient/S.O. administers medications appropriately^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2794,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2794,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2795,0)
 ;;=verbalizes effect of pain relief interventions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2795,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2795,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2796,0)
 ;;=verbalizes comfort^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2796,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2796,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2797,0)
 ;;=assess pain episode using 0 (no) to 10 (worst) scale^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2797,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2797,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2798,0)
 ;;=assess pain (location, duration) q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2798,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2798,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2799,0)
 ;;=monitor stimulus responses to pain^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2799,9)
 ;;=D EN2^NURCCPU2
