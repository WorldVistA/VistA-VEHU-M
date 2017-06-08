NURCCG0P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,11,0)
 ;;=905^evacuates soft, formed stool q[ ]days without pain/strain^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,12,0)
 ;;=5358^re-establishes control over urination^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,13,0)
 ;;=7404^performs toilet transfer with [min/mod/max] assistance^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,14,0)
 ;;=7405^performs independent toilet transfer^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,1,15,0)
 ;;=15351^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^4^1
 ;;^UTILITY("^GMRD(124.2,",$J,269,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,270,0)
 ;;=demonstrates increased ability to toilet self^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,270,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,270,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,271,0)
 ;;=demonstrates increased ability to cope with assistance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,271,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,271,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,272,0)
 ;;=verbalizes positive feelings related to continency^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,272,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,272,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,273,0)
 ;;=identifies causative factors related to toileting deficit^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,273,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,273,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,274,0)
 ;;=demonstrates use of adaptive devices to facilitate toileting^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,274,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,274,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,275,0)
 ;;=verbalizes/demonstrates decreased fatigue with activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,275,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,275,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,276,0)
 ;;=demonstrates increased control of dyspnea with activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,276,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,276,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,277,0)
 ;;=demonstrates increased independence for self-care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,277,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,277,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,278,0)
 ;;=hemodynamically stable during activity^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,278,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,278,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,278,1,2,0)
 ;;=280^B/P^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,278,1,3,0)
 ;;=281^skin color and temperature WNL for pt^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,278,1,4,0)
 ;;=2647^ear oximetry indicates oxygen saturation of 90% or greater^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,278,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,278,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,278,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,278,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,279,0)
 ;;=appropriate pulse rate for pt [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,280,0)
 ;;=B/P^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,281,0)
 ;;=skin color and temperature WNL for pt^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,282,0)
 ;;=assess for signs of fatigue and weakness^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,282,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,282,1,1,0)
 ;;=291^exertional dyspnea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,282,1,2,0)
 ;;=292^inability to be independent for self-care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,282,1,3,0)
 ;;=293^weight loss or gain^3^NURSC^1^0
