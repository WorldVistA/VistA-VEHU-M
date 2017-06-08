NURCCGDV ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12175,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12175,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12175,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12177,0)
 ;;=[Extra Goal]^3^NURSC^9^365^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12177,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12177,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12179,0)
 ;;=[Extra Goal]^3^NURSC^9^366^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12179,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12179,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12181,0)
 ;;=[Extra Goal]^3^NURSC^9^367^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12181,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12181,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12183,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^291^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12183,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12183,1,1,0)
 ;;=12186^[Extra Order]^3^NURSC^372
 ;;^UTILITY("^GMRD(124.2,",$J,12183,1,2,0)
 ;;=12188^[Extra Order]^3^NURSC^373
 ;;^UTILITY("^GMRD(124.2,",$J,12183,1,3,0)
 ;;=12190^[Extra Order]^3^NURSC^374
 ;;^UTILITY("^GMRD(124.2,",$J,12183,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12183,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12186,0)
 ;;=[Extra Order]^3^NURSC^11^372^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12186,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12186,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12188,0)
 ;;=[Extra Order]^3^NURSC^11^373^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12188,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12188,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12190,0)
 ;;=[Extra Order]^3^NURSC^11^374^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12190,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12190,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12208,0)
 ;;=[Extra Order]^3^NURSC^11^196^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12208,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12208,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12209,0)
 ;;=Self-Care Deficit [Specify]^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12209,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12209,1,1,0)
 ;;=12210^Etiology/Related and/or Risk Factors^2^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,12209,1,2,0)
 ;;=12217^Goals/Expected Outcomes^2^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,12209,1,3,0)
 ;;=12255^Nursing Intervention/Orders^2^NURSC^137
 ;;^UTILITY("^GMRD(124.2,",$J,12209,1,4,0)
 ;;=12360^Related Problems^2^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,12209,1,5,0)
 ;;=12367^Defining Characteristics^2^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,12209,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12209,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12209,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12209,"TD",0)
 ;;=^^3^3^2910905^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,12209,"TD",1,0)
 ;;=A state in which the individual experiences an impaired ability to
 ;;^UTILITY("^GMRD(124.2,",$J,12209,"TD",2,0)
 ;;=perform or complete feeding, bathing, toileting, dressing, and 
 ;;^UTILITY("^GMRD(124.2,",$J,12209,"TD",3,0)
 ;;=grooming activities for oneself.
 ;;^UTILITY("^GMRD(124.2,",$J,12210,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^165^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,1,0)
 ;;=207^depression, severe anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,2,0)
 ;;=208^intolerance to activity; decreased strength and endurance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,3,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12210,1,4,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
