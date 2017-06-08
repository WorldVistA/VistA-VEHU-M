NURCCGCE ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9707,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9710,0)
 ;;=[Extra Goal]^3^NURSC^9^162^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9710,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9710,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9711,0)
 ;;=monitor effects of antiemetics [specify]^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9711,4)
 ;;=assess, document &
 ;;^UTILITY("^GMRD(124.2,",$J,9711,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9711,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9712,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^111^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,1,0)
 ;;=61^assess family's coping response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,2,0)
 ;;=62^assist family to appraise stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,3,0)
 ;;=63^assist family to develop plan to cope with stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,4,0)
 ;;=9720^teach effective coping skills^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,5,0)
 ;;=9728^refer for appropriate consults^2^NURSC^37
 ;;^UTILITY("^GMRD(124.2,",$J,9712,1,6,0)
 ;;=10008^[Extra Order]^3^NURSC^169
 ;;^UTILITY("^GMRD(124.2,",$J,9712,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9712,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9714,0)
 ;;=encourage snacks of favored foods^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9714,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9714,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9720,0)
 ;;=teach effective coping skills^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9720,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9720,1,1,0)
 ;;=65^problem solving/decision making^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9720,1,2,0)
 ;;=66^assertiveness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9720,1,3,0)
 ;;=67^help-seeking^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9720,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9720,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9720,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9727,0)
 ;;=daily intake of [specify amount] calories^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9727,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9727,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9728,0)
 ;;=refer for appropriate consults^2^NURSC^11^37^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,9728,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9728,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9728,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9730,0)
 ;;=[Extra Order]^3^NURSC^11^164^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9730,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9730,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9732,0)
 ;;=Defining Characteristics^2^NURSC^12^114^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9732,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9732,1,1,0)
 ;;=9735^body weight 20% or more under ideal^3^NURSC^4
