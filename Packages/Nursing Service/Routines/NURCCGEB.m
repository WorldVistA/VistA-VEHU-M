NURCCGEB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,1,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,2,0)
 ;;=1987^Depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,3,0)
 ;;=1988^Non-compliance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,5,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,6,0)
 ;;=1918^Social Isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,7,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,8,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12912,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^171^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12912,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,12912,1,2,0)
 ;;=12914^verbalizes increased sense of self esteem^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12912,1,4,0)
 ;;=12921^identifies feelings/methods of coping with perceptions^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12912,1,6,0)
 ;;=13189^[Extra Goal]^3^NURSC^230
 ;;^UTILITY("^GMRD(124.2,",$J,12912,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12914,0)
 ;;=verbalizes increased sense of self esteem^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12914,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12914,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12921,0)
 ;;=identifies feelings/methods of coping with perceptions^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12921,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12921,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12923,0)
 ;;=[Extra Goal]^3^NURSC^9^206^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12923,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12923,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12924,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^145^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,0)
 ;;=^124.21PI^10^6
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,1,0)
 ;;=12925^avoid over protection of patient^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,3,0)
 ;;=12927^encourage activities providing supervision as indicated^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,4,0)
 ;;=12936^encourage patient/SO to express feelings/concerns^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,6,0)
 ;;=12945^stress importance of staff/SO remaining calm during seizure^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,9,0)
 ;;=12953^promote acceptance of disease^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12924,1,10,0)
 ;;=13378^[Extra Order]^3^NURSC^238
 ;;^UTILITY("^GMRD(124.2,",$J,12924,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12924,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12925,0)
 ;;=avoid over protection of patient^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12925,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12925,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12927,0)
 ;;=encourage activities providing supervision as indicated^3^NURSC^11^2^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,12927,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12927,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12936,0)
 ;;=encourage patient/SO to express feelings/concerns^3^NURSC^11^2^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,12936,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12936,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12945,0)
 ;;=stress importance of staff/SO remaining calm during seizure^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12945,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12945,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12953,0)
 ;;=promote acceptance of disease^3^NURSC^11^5^^^T^
