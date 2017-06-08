NURCCGGM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15637,0)
 ;;=will not experience dysreflexia as evidenced by normal VS^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15637,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15637,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15638,0)
 ;;=verbalizes signs/symptoms of dysreflexia^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15638,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15638,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15639,0)
 ;;=avoids complications of dysreflexia^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15639,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15639,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15640,0)
 ;;=[Extra Goal]^3^NURSC^9^261^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15640,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15640,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15641,0)
 ;;=teach signs and symptoms of dysreflexia^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15641,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15641,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15643,0)
 ;;=avoid bowel/bladder distention^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15643,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15643,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15644,0)
 ;;=implement interventions for dysreflexia:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,1,0)
 ;;=15645^raise head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,2,0)
 ;;=15646^monitor blood pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,3,0)
 ;;=15647^monitor bladder for distention & catheterize if necessary^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,4,0)
 ;;=15648^monitor bowels for distention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,5,0)
 ;;=15649^utilize anesthetic ointment before impaction removal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,6,0)
 ;;=15650^release tight clothing and dressings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,1,7,0)
 ;;=15651^notify physician if signs/symptoms persist^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15644,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15644,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15645,0)
 ;;=raise head of bed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15646,0)
 ;;=monitor blood pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15647,0)
 ;;=monitor bladder for distention & catheterize if necessary^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15648,0)
 ;;=monitor bowels for distention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15649,0)
 ;;=utilize anesthetic ointment before impaction removal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15650,0)
 ;;=release tight clothing and dressings^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15651,0)
 ;;=notify physician if signs/symptoms persist^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15652,0)
 ;;=[Extra Order]^3^NURSC^11^264^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15652,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15652,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15653,0)
 ;;=verbalization of feelings of loss motor/sensory functions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15654,0)
 ;;=verbalization of effects of injury on life^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15655,0)
 ;;=particpation in treatment plan and self-care activities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15656,0)
 ;;=utilization of available support systems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15657,0)
 ;;=verbalization of integration of limitations into lifestyle^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15658,0)
 ;;=allowing time for the grief process^3^NURSC^^1^^^T
