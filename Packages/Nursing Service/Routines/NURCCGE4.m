NURCCGE4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12610,1,1,0)
 ;;=12612^Etiology/Related and/or Risk Factors^2^NURSC^276
 ;;^UTILITY("^GMRD(124.2,",$J,12610,1,2,0)
 ;;=12621^Goals/Expected Outcomes^2^NURSC^288
 ;;^UTILITY("^GMRD(124.2,",$J,12610,1,3,0)
 ;;=12631^Nursing Intervention/Orders^2^NURSC^292
 ;;^UTILITY("^GMRD(124.2,",$J,12610,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12610,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12610,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12611,0)
 ;;=measure diarrhea/vomitus and include on I&O record  ^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12611,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12611,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12612,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^276^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12612,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12612,1,1,0)
 ;;=12617^[etiology]^3^NURSC^38
 ;;^UTILITY("^GMRD(124.2,",$J,12612,1,2,0)
 ;;=12619^[etiology]^3^NURSC^39
 ;;^UTILITY("^GMRD(124.2,",$J,12612,1,3,0)
 ;;=12851^[etiology]^3^NURSC^43
 ;;^UTILITY("^GMRD(124.2,",$J,12612,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12615,0)
 ;;=[etiology]^3^NURSC^^37^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12617,0)
 ;;=[etiology]^3^NURSC^^38^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12619,0)
 ;;=[etiology]^3^NURSC^^39^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12621,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^288^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12621,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12621,1,1,0)
 ;;=12624^[Extra Goal]^3^NURSC^368
 ;;^UTILITY("^GMRD(124.2,",$J,12621,1,2,0)
 ;;=12626^[Extra Goal]^3^NURSC^369
 ;;^UTILITY("^GMRD(124.2,",$J,12621,1,3,0)
 ;;=12628^[Extra Goal]^3^NURSC^370
 ;;^UTILITY("^GMRD(124.2,",$J,12621,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12624,0)
 ;;=[Extra Goal]^3^NURSC^9^368^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12624,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12624,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12626,0)
 ;;=[Extra Goal]^3^NURSC^9^369^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12626,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12626,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12628,0)
 ;;=[Extra Goal]^3^NURSC^9^370^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12628,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12628,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12630,0)
 ;;=eliminate diarrheal stimulating food ie.,chocolate,coffee^3^NURSC^11^35^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12630,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,12630,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12630,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12631,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^292^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12631,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12631,1,1,0)
 ;;=12633^[Extra Order]^3^NURSC^375
 ;;^UTILITY("^GMRD(124.2,",$J,12631,1,2,0)
 ;;=12636^[Extra Order]^3^NURSC^376
 ;;^UTILITY("^GMRD(124.2,",$J,12631,1,3,0)
 ;;=12638^[Extra Order]^3^NURSC^377
 ;;^UTILITY("^GMRD(124.2,",$J,12631,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12631,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12633,0)
 ;;=[Extra Order]^3^NURSC^11^375^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12633,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12633,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12636,0)
 ;;=[Extra Order]^3^NURSC^11^376^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12636,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12636,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12638,0)
 ;;=[Extra Order]^3^NURSC^11^377^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12638,9)
 ;;=D EN2^NURCCPU2
