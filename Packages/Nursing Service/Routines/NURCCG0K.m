NURCCG0K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,217,1,2,0)
 ;;=220^occupational therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,217,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,217,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,217,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,217,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,218,0)
 ;;=accepts interventions to modify self-care deficits^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,218,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,218,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,219,0)
 ;;=physical therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,220,0)
 ;;=occupational therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,221,0)
 ;;=increased interest and desire to eat^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,221,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,221,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,222,0)
 ;;=causative factors for feeding deficit^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,222,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,222,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,223,0)
 ;;=use of adaptive devices^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,223,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,223,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,224,0)
 ;;=increased ability to feed self^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,224,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,224,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,225,0)
 ;;=participation in adaptive process^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,225,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,225,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,226,0)
 ;;=describes causative factors of bathing deficit [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,226,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,226,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,227,0)
 ;;=performs bathing activity at optimal level^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,227,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,227,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,228,0)
 ;;=verbalizes comfort and satisfaction with body cleanliness^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,228,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,228,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,229,0)
 ;;=increased ability to dress self^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,229,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,229,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,230,0)
 ;;=ability to request/accept assistance in dressing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,230,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,230,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,231,0)
 ;;=increased interest in appearance and dress^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,231,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,231,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,232,0)
 ;;=general self-care deficit interventions^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,1,0)
 ;;=236^assess degree of disability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,2,0)
 ;;=237^assess memory/intellectual functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,3,0)
 ;;=238^determine individual strengths and skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,4,0)
 ;;=239^identify if deficit is temporary or permanent^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,5,0)
 ;;=240^assess causative factors (of deficit)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,6,0)
 ;;=199^assess support system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,7,0)
 ;;=241^assess post discharge needs^3^NURSC^1^0
