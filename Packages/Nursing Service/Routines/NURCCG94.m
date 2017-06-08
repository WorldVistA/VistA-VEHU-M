NURCCG94 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,3,0)
 ;;=4814^obtain sputum specimens as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,4,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,5,0)
 ;;=4818^assess,monitor,document sputum color/consistancy/amount q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,6,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,7,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,8,0)
 ;;=4854^[Extra Order]^3^NURSC^222
 ;;^UTILITY("^GMRD(124.2,",$J,4810,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4810,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4811,0)
 ;;=initiate consult to dietary service^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4811,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4811,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4812,0)
 ;;=[Extra Order]^3^NURSC^11^217^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4812,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4812,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4813,0)
 ;;=peripheral pulses present^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4813,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4813,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4814,0)
 ;;=obtain sputum specimens as ordered^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4814,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4814,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4815,0)
 ;;=[Extra Goal]^3^NURSC^9^218^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4815,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4815,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4817,0)
 ;;=[Extra Order]^3^NURSC^11^19^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4817,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4817,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4818,0)
 ;;=assess,monitor,document sputum color/consistancy/amount q[]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4818,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4818,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4819,0)
 ;;=[Extra Order]^3^NURSC^11^218^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4819,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4819,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4820,0)
 ;;=reinforce dietary & fluid restrictions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4820,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4820,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4822,0)
 ;;=[Extra Order]^3^NURSC^11^219^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4822,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4822,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4823,0)
 ;;=[Extra Order]^3^NURSC^11^15^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4823,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4823,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4824,0)
 ;;=Pain, Chronic^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4824,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4824,1,1,0)
 ;;=4826^Etiology/Related and/or Risk Factors^2^NURSC^230
 ;;^UTILITY("^GMRD(124.2,",$J,4824,1,2,0)
 ;;=4834^Goals/Expected Outcomes^2^NURSC^235
 ;;^UTILITY("^GMRD(124.2,",$J,4824,1,3,0)
 ;;=4838^Nursing Intervention/Orders^2^NURSC^236
 ;;^UTILITY("^GMRD(124.2,",$J,4824,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4824,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4824,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4825,0)
 ;;=[Extra Goal]^3^NURSC^9^219^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4825,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4825,10)
 ;;=D EN2^NURCCPU1
