NURCCGCS ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10343,1,3,0)
 ;;=10351^[Extra Goal]^3^NURSC^352
 ;;^UTILITY("^GMRD(124.2,",$J,10343,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10347,0)
 ;;=[Extra Goal]^3^NURSC^9^350^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10347,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10347,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10349,0)
 ;;=[Extra Goal]^3^NURSC^9^351^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10349,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10349,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10351,0)
 ;;=[Extra Goal]^3^NURSC^9^352^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10351,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10351,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10354,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^285^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10354,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10354,1,1,0)
 ;;=10355^[Extra Order]^3^NURSC^357
 ;;^UTILITY("^GMRD(124.2,",$J,10354,1,2,0)
 ;;=10356^[Extra Order]^3^NURSC^358
 ;;^UTILITY("^GMRD(124.2,",$J,10354,1,3,0)
 ;;=10359^[Extra Order]^3^NURSC^359
 ;;^UTILITY("^GMRD(124.2,",$J,10354,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10354,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10355,0)
 ;;=[Extra Order]^3^NURSC^11^357^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10355,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10355,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10356,0)
 ;;=[Extra Order]^3^NURSC^11^358^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10356,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10356,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10359,0)
 ;;=[Extra Order]^3^NURSC^11^359^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10359,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10359,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10378,0)
 ;;=[Extra Order]^3^NURSC^11^173^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10378,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10378,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10427,0)
 ;;=Self-Care Deficit [Specify]^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10427,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10427,1,1,0)
 ;;=10429^Etiology/Related and/or Risk Factors^2^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,10427,1,2,0)
 ;;=10443^Goals/Expected Outcomes^2^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,10427,1,3,0)
 ;;=10488^Nursing Intervention/Orders^2^NURSC^119
 ;;^UTILITY("^GMRD(124.2,",$J,10427,1,4,0)
 ;;=10672^Related Problems^2^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,10427,1,5,0)
 ;;=10675^Defining Characteristics^2^NURSC^123
 ;;^UTILITY("^GMRD(124.2,",$J,10427,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10427,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10427,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10427,"TD",0)
 ;;=^^3^3^2900117^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,10427,"TD",1,0)
 ;;=A state in which the individual experiences an impaired ability to
 ;;^UTILITY("^GMRD(124.2,",$J,10427,"TD",2,0)
 ;;=perform or complete feeding, bathing, toileting, dressing, and 
 ;;^UTILITY("^GMRD(124.2,",$J,10427,"TD",3,0)
 ;;=grooming activities for oneself.
 ;;^UTILITY("^GMRD(124.2,",$J,10429,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^143^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,1,0)
 ;;=207^depression, severe anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,2,0)
 ;;=208^intolerance to activity; decreased strength and endurance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,3,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,4,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
