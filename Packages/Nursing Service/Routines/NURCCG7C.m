NURCCG7C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,13,0)
 ;;=3105^teach coping skills [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,14,0)
 ;;=3106^teach ways to develop social networks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,15,0)
 ;;=16550^[Extra Order]^3^NURSC^430
 ;;^UTILITY("^GMRD(124.2,",$J,3092,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3093,0)
 ;;=attainment of desired goal [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3093,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3093,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3094,0)
 ;;=competency in management of situation [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3094,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3094,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3095,0)
 ;;=maintenance of self-esteem^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3095,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3095,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3096,0)
 ;;=realistic appraisal of event, demands, coping resources^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3096,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3096,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3097,0)
 ;;=verbalization of a sense of personal integrity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3097,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3097,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3098,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^74^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,1,0)
 ;;=3093^attainment of desired goal [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,2,0)
 ;;=3094^competency in management of situation [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,3,0)
 ;;=3095^maintenance of self-esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,4,0)
 ;;=3096^realistic appraisal of event, demands, coping resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,5,0)
 ;;=3097^verbalization of a sense of personal integrity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3098,1,6,0)
 ;;=16551^[Extra Goal]^3^NURSC^422
 ;;^UTILITY("^GMRD(124.2,",$J,3098,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3099,0)
 ;;=assess patient perception of stressful event^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3099,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3099,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3100,0)
 ;;=acknowledge goal related achievements^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3100,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3100,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3101,0)
 ;;=assist to identify strategies for achieving goals^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3101,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3101,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3102,0)
 ;;=assist to identify desired goal^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3102,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3102,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3103,0)
 ;;=clarify misconceptions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3103,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3103,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3104,0)
 ;;=confront ineffective behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3104,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3104,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3105,0)
 ;;=teach coping skills [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3105,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3105,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3106,0)
 ;;=teach ways to develop social networks^3^NURSC^11^1^^^T
