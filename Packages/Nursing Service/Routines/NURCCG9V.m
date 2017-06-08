NURCCG9V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5185,1,6,0)
 ;;=5200^gingivitis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5185,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5186,0)
 ;;=Sleep Pattern, Disturbance^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5186,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5186,1,1,0)
 ;;=5187^Etiology/Related and/or Risk Factors^2^NURSC^251
 ;;^UTILITY("^GMRD(124.2,",$J,5186,1,2,0)
 ;;=5188^Goals/Expected Outcomes^2^NURSC^259
 ;;^UTILITY("^GMRD(124.2,",$J,5186,1,3,0)
 ;;=5201^Nursing Intervention/Orders^2^NURSC^260
 ;;^UTILITY("^GMRD(124.2,",$J,5186,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5186,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5186,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5187,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^251^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5187,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,5187,1,1,0)
 ;;=2474^apnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5187,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5188,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^259^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5188,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5188,1,1,0)
 ;;=5189^sleep disturbance signs/symptoms decrease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5188,1,2,0)
 ;;=5191^sleeps [specify length of time] before awakens^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5188,1,3,0)
 ;;=868^states feels rested after sleep^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5188,1,4,0)
 ;;=2468^verbalizes improved ability to perform activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5188,1,5,0)
 ;;=5194^[Extra Goal]^3^NURSC^264
 ;;^UTILITY("^GMRD(124.2,",$J,5188,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5189,0)
 ;;=sleep disturbance signs/symptoms decrease^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5189,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5189,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5190,0)
 ;;=oral pain/discomfort^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5191,0)
 ;;=sleeps [specify length of time] before awakens^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5191,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5191,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5192,0)
 ;;=stomatitis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5193,0)
 ;;=leukoplakia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5194,0)
 ;;=[Extra Goal]^3^NURSC^9^264^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5194,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5194,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5195,0)
 ;;=oral lesions/ulcers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5196,0)
 ;;=hyperemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5200,0)
 ;;=gingivitis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5201,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^260^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,1,0)
 ;;=870^assess length of time and time of day naps are taken^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,2,0)
 ;;=2751^assess usual sleep pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,3,0)
 ;;=5218^assist with use and care of respiratory equipment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,4,0)
 ;;=2394^medicate as prescribed by MD^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,5,0)
 ;;=872^increase daytime activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5201,1,6,0)
 ;;=5338^[Extra Order]^3^NURSC^271
 ;;^UTILITY("^GMRD(124.2,",$J,5201,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5201,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5202,0)
 ;;=Defining Characteristics^2^NURSC^12^63^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5202,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5202,1,1,0)
 ;;=5204^behavior indicative of failure to adhere^3^NURSC^1
