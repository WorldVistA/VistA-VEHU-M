NURCCGD2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10899,1,2,0)
 ;;=10902^[etiology]^3^NURSC^104
 ;;^UTILITY("^GMRD(124.2,",$J,10899,1,3,0)
 ;;=11344^[etiology]^3^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,10899,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10900,0)
 ;;=[etiology]^3^NURSC^^105^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10901,0)
 ;;=[etiology]^3^NURSC^^103^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10902,0)
 ;;=[etiology]^3^NURSC^^104^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10903,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^283^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10903,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10903,1,1,0)
 ;;=10904^[Extra Goal]^3^NURSC^356
 ;;^UTILITY("^GMRD(124.2,",$J,10903,1,2,0)
 ;;=10905^[Extra Goal]^3^NURSC^357
 ;;^UTILITY("^GMRD(124.2,",$J,10903,1,3,0)
 ;;=10906^[Extra Goal]^3^NURSC^358
 ;;^UTILITY("^GMRD(124.2,",$J,10903,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10904,0)
 ;;=[Extra Goal]^3^NURSC^9^356^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10904,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10904,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10905,0)
 ;;=[Extra Goal]^3^NURSC^9^357^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10905,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10905,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10906,0)
 ;;=[Extra Goal]^3^NURSC^9^358^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10906,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10906,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10907,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^287^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10907,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10907,1,1,0)
 ;;=10908^[Extra Order]^3^NURSC^363
 ;;^UTILITY("^GMRD(124.2,",$J,10907,1,2,0)
 ;;=10909^[Extra Order]^3^NURSC^364
 ;;^UTILITY("^GMRD(124.2,",$J,10907,1,3,0)
 ;;=10910^[Extra Order]^3^NURSC^365
 ;;^UTILITY("^GMRD(124.2,",$J,10907,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10907,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10908,0)
 ;;=[Extra Order]^3^NURSC^11^363^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10908,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10908,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10909,0)
 ;;=[Extra Order]^3^NURSC^11^364^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10909,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10909,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10910,0)
 ;;=[Extra Order]^3^NURSC^11^365^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10910,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10910,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10911,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10911,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,10911,1,1,0)
 ;;=10912^Related Problems^2^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,10911,1,2,0)
 ;;=10917^Etiology/Related and/or Risk Factors^2^NURSC^148
 ;;^UTILITY("^GMRD(124.2,",$J,10911,1,3,0)
 ;;=10924^Goals/Expected Outcomes^2^NURSC^146
 ;;^UTILITY("^GMRD(124.2,",$J,10911,1,4,0)
 ;;=10935^Nursing Intervention/Orders^2^NURSC^123
 ;;^UTILITY("^GMRD(124.2,",$J,10911,1,6,0)
 ;;=11002^Defining Characteristics^2^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,10911,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10911,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10911,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10911,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,10911,"TD",1,0)
 ;;=A state in which an individual is unable to clear secretions or
 ;;^UTILITY("^GMRD(124.2,",$J,10911,"TD",2,0)
 ;;=obstructions from the respiratory tract to maintain airway patency.
 ;;^UTILITY("^GMRD(124.2,",$J,10912,0)
 ;;=Related Problems^2^NURSC^7^128^1^^T^1
