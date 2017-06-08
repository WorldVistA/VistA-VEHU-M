NURCCG8R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4655,1,1,0)
 ;;=4659^Etiology/Related and/or Risk Factors^2^NURSC^216
 ;;^UTILITY("^GMRD(124.2,",$J,4655,1,2,0)
 ;;=4665^Goals/Expected Outcomes^2^NURSC^221
 ;;^UTILITY("^GMRD(124.2,",$J,4655,1,3,0)
 ;;=4671^Nursing Intervention/Orders^2^NURSC^220
 ;;^UTILITY("^GMRD(124.2,",$J,4655,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4655,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4655,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4656,0)
 ;;=[Extra Goal]^3^NURSC^9^275^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4656,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4656,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4657,0)
 ;;=[Extra Goal]^3^NURSC^9^276^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4657,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4657,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4658,0)
 ;;=[Extra Goal]^3^NURSC^9^277^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4658,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4658,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4659,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^216^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4659,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4659,1,1,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4659,1,2,0)
 ;;=1761^altered circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4659,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4660,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^220^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4660,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4660,1,1,0)
 ;;=4464^maintains nutritional intake to meet metabolic requirements^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4660,1,2,0)
 ;;=4669^[Extra Goal]^3^NURSC^213
 ;;^UTILITY("^GMRD(124.2,",$J,4660,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4661,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^219^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4661,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4661,1,1,0)
 ;;=4664^[Extra Order]^3^NURSC^282
 ;;^UTILITY("^GMRD(124.2,",$J,4661,1,2,0)
 ;;=4666^[Extra Order]^3^NURSC^283
 ;;^UTILITY("^GMRD(124.2,",$J,4661,1,3,0)
 ;;=4668^[Extra Order]^3^NURSC^284
 ;;^UTILITY("^GMRD(124.2,",$J,4661,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4661,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4664,0)
 ;;=[Extra Order]^3^NURSC^11^282^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4664,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4664,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4665,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^221^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4665,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4665,1,1,0)
 ;;=4667^incision free of redness, edema, drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4665,1,2,0)
 ;;=4670^wound edges approximated with no drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4665,1,3,0)
 ;;=4837^[Extra Goal]^3^NURSC^17
 ;;^UTILITY("^GMRD(124.2,",$J,4665,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4666,0)
 ;;=[Extra Order]^3^NURSC^11^283^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4666,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4666,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4667,0)
 ;;=incision free of redness, edema, drainage^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4667,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4667,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4668,0)
 ;;=[Extra Order]^3^NURSC^11^284^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4668,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4668,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4669,0)
 ;;=[Extra Goal]^3^NURSC^9^213^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4669,9)
 ;;=D EN5^NURCCPU0
