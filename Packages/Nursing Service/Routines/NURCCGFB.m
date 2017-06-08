NURCCGFB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,8,0)
 ;;=2101^provide education/instruction within [ ]days of admission^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,9,0)
 ;;=2102^provide physical sequelae within [ ] days of admission^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,10,0)
 ;;=3073^assist to identify desired goal^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,11,0)
 ;;=2104^encourage pt to list areas adversely affected within [ ]days^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,12,0)
 ;;=2105^give patient positive reinforcement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,13,0)
 ;;=2106^encourage patient to ventilate feelings ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,14,0)
 ;;=2107^establish an after care follow-up plan before discharge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,15,0)
 ;;=14320^assist to identify triggers to substance use/abuse [specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,16,0)
 ;;=2109^reinforce need for follow-up care or support^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,17,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,18,0)
 ;;=14327^teach coping strategies^2^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,19,0)
 ;;=14795^[Extra Order]^3^NURSC^255
 ;;^UTILITY("^GMRD(124.2,",$J,14288,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14293,0)
 ;;=consider/discuss preventive measures^2^NURSC^^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,1,0)
 ;;=409^annual flu shot^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,2,0)
 ;;=410^pneumococcus vaccine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,3,0)
 ;;=411^avoid others who have infections^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,4,0)
 ;;=412^eliminate inhaled irritants^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,5,0)
 ;;=413^compliance with prescribed treatment program^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,1,6,0)
 ;;=414^avoidance of allergens specific to [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14293,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,14293,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14294,0)
 ;;=assess ability to identify nonproductive behaviors^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14294,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14294,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14301,0)
 ;;=assist to identify resources for substance free lifestyle^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14301,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14301,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14307,0)
 ;;=assess ability to identify impact of behavior on others^3^NURSC^11^10^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14307,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14307,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14308,0)
 ;;=respiratory pattern q [frequency]^2^NURSC^11^27^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14308,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,14308,1,1,0)
 ;;=2697^respiratory altenans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14308,1,2,0)
 ;;=2698^paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14308,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,14308,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14308,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14308,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14315,0)
 ;;=refer for appropriate consults^2^NURSC^11^77^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14315,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
