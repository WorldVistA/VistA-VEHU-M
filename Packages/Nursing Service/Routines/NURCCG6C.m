NURCCG6C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,6,0)
 ;;=2597^expresses satiety level within dietary restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,7,0)
 ;;=2933^[Extra Goal]^3^NURSC^114^0
 ;;^UTILITY("^GMRD(124.2,",$J,2589,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2590,0)
 ;;=maintains metabolic needs that meet metabolic requirments^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2590,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2590,1,1,0)
 ;;=2591^weight loss of [number of] lbs/kgs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2590,1,2,0)
 ;;=2556^balance between activity and caloric intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2590,1,3,0)
 ;;=2592^triceps skin fold measurements is <15 mm (men)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2590,1,4,0)
 ;;=2684^triceps skin fold measurements is <25 mm (women)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2590,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,2590,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2590,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2590,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2591,0)
 ;;=weight loss of [number of] lbs/kgs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2592,0)
 ;;=triceps skin fold measurements is <15 mm (men)^3^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2593,0)
 ;;=decreases food intake while increasing/maintaining activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2593,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2593,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2594,0)
 ;;=expresses eating patterns that contribute to weight gain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2594,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2594,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2595,0)
 ;;=describes activity level in relation to weight^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2595,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2595,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2596,0)
 ;;=selects menu within dietary restrictions^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2596,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2596,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2597,0)
 ;;=expresses satiety level within dietary restrictions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2597,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2597,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2598,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^64^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,1,0)
 ;;=2599^assess factors contributing to increased food intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,2,0)
 ;;=2524^assess dietary habits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,4,0)
 ;;=2600^record caloric intake q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,5,0)
 ;;=2601^maintain activity level commensurate with caloric intake^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,6,0)
 ;;=2577^provide financial resource contact for food purchase^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,7,0)
 ;;=2604^refer to support groups^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,8,0)
 ;;=2539^provide pt. education resources on nutrition as needed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,9,0)
 ;;=2605^teach METS activities and progression of same^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,10,0)
 ;;=2606^teach behavior modification techniques related to intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,11,0)
 ;;=2578^initiate consult(s)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,1,12,0)
 ;;=3020^[Extra Order]^3^NURSC^106^0
 ;;^UTILITY("^GMRD(124.2,",$J,2598,7)
 ;;=D EN4^NURCCPU1
