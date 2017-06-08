NURCCG7J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3179,0)
 ;;=teach medication self-administration^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3179,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3179,1,1,0)
 ;;=3174^knowledge of reason for taking^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3179,1,2,0)
 ;;=3175^tactile/visual identification^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3179,1,3,0)
 ;;=3177^knowledge of schedule^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3179,1,4,0)
 ;;=3176^knowledge of side effects^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3179,1,5,0)
 ;;=3180^administration techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3179,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3179,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3179,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3180,0)
 ;;=administration techniques^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3181,0)
 ;;=support use of devices to facilitate mobility^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3181,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3181,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3182,0)
 ;;=limit activities as identified by medical evaluation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3182,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3182,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3183,0)
 ;;=maintain/increase mobility by [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3183,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3183,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3184,0)
 ;;=support patient/family in process of viewing limitations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3184,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3184,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3185,0)
 ;;=teach patient safe transfers from bed to W/C to commode^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3185,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3185,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3186,0)
 ;;=encourage participation in Blind Rehabilitation Program^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3186,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3186,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3187,0)
 ;;=teach healthy food choices/preparation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3187,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3187,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3188,0)
 ;;=teach diabetic management^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3188,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3188,1,1,0)
 ;;=3189^teach techniques for obtaining blood/urine samples^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3188,1,2,0)
 ;;=3190^teach testing of glucose/ketone levels^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3188,1,3,0)
 ;;=3191^teach foot care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3188,1,4,0)
 ;;=3192^teach management of diabetes during illness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3188,1,5,0)
 ;;=3193^teach signs/symptoms of complications [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3188,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3188,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3188,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3189,0)
 ;;=teach techniques for obtaining blood/urine samples^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3190,0)
 ;;=teach testing of glucose/ketone levels^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3191,0)
 ;;=teach foot care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3192,0)
 ;;=teach management of diabetes during illness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3193,0)
 ;;=teach signs/symptoms of complications [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3194,0)
 ;;=Disuse Syndrome, Potential For^2^NURSC^2^1^1^^T
