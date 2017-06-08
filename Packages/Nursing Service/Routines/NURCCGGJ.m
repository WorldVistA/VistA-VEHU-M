NURCCGGJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15580,0)
 ;;=[Extra Goal]^3^NURSC^9^411^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15580,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15580,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15581,0)
 ;;=[Extra Goal]^3^NURSC^9^412^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15581,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15581,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15582,0)
 ;;=[Extra Order]^3^NURSC^11^417^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15582,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15582,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15583,0)
 ;;=[Extra Order]^3^NURSC^11^418^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15583,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15583,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15584,0)
 ;;=[Extra Order]^3^NURSC^11^419^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15584,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15584,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15585,0)
 ;;=diet: [specify]^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15587,0)
 ;;=purpose for dialysis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15588,0)
 ;;=dialysis schedule^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15589,0)
 ;;=care of dialysis vessel access^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15590,0)
 ;;=s/s of complications^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15591,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^313^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,1,0)
 ;;=169^assess knowledge base^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,2,0)
 ;;=170^decide what patient needs to know^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,3,0)
 ;;=171^determine ability to learn and implement plan^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,4,0)
 ;;=15593^teach plan based on patient's readiness/ability to learn^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,5,0)
 ;;=173^involve S/O in teaching plan^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,6,0)
 ;;=174^evaluate effectiveness of teaching plan^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,7,0)
 ;;=15595^consult to dietician to teach renal diet^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,8,0)
 ;;=15596^explain purpose of dialysis and basic procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,9,0)
 ;;=15597^stress importance of compliance with diet, meds, dialysis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,10,0)
 ;;=15598^provide information in short segments with reinforcement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,11,0)
 ;;=15599^instruct on dialysis vessel access care/complications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,1,12,0)
 ;;=15726^[Extra Order]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15591,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15591,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15593,0)
 ;;=teach plan based on patient's readiness/ability to learn^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15593,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15593,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15595,0)
 ;;=consult to dietician to teach renal diet^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15595,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15595,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15596,0)
 ;;=explain purpose of dialysis and basic procedures^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15596,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15596,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15597,0)
 ;;=stress importance of compliance with diet, meds, dialysis^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15597,9)
 ;;=D EN2^NURCCPU2
