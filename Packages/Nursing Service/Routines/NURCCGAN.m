NURCCGAN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6526,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6526,1,1,0)
 ;;=6527^Etiology/Related and/or Risk Factors^2^NURSC^258
 ;;^UTILITY("^GMRD(124.2,",$J,6526,1,2,0)
 ;;=6531^Goals/Expected Outcomes^2^NURSC^269
 ;;^UTILITY("^GMRD(124.2,",$J,6526,1,3,0)
 ;;=6535^Nursing Intervention/Orders^2^NURSC^271
 ;;^UTILITY("^GMRD(124.2,",$J,6526,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6526,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6526,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6527,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^258^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6527,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6527,1,1,0)
 ;;=6529^[etiology]^3^NURSC^76
 ;;^UTILITY("^GMRD(124.2,",$J,6527,1,2,0)
 ;;=6530^[etiology]^3^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,6527,1,3,0)
 ;;=6768^[etiology]^3^NURSC^70
 ;;^UTILITY("^GMRD(124.2,",$J,6527,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6528,0)
 ;;=[etiology]^3^NURSC^^77^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6529,0)
 ;;=[etiology]^3^NURSC^^76^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6530,0)
 ;;=[etiology]^3^NURSC^^78^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6531,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^269^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6531,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6531,1,1,0)
 ;;=6532^[Extra Goal]^3^NURSC^326
 ;;^UTILITY("^GMRD(124.2,",$J,6531,1,2,0)
 ;;=6533^[Extra Goal]^3^NURSC^327
 ;;^UTILITY("^GMRD(124.2,",$J,6531,1,3,0)
 ;;=6534^[Extra Goal]^3^NURSC^328
 ;;^UTILITY("^GMRD(124.2,",$J,6531,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6532,0)
 ;;=[Extra Goal]^3^NURSC^9^326^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6532,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6532,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6533,0)
 ;;=[Extra Goal]^3^NURSC^9^327^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6533,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6533,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6534,0)
 ;;=[Extra Goal]^3^NURSC^9^328^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6534,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6534,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6535,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^271^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6535,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6535,1,1,0)
 ;;=6536^[Extra Order]^3^NURSC^333
 ;;^UTILITY("^GMRD(124.2,",$J,6535,1,2,0)
 ;;=6537^[Extra Order]^3^NURSC^334
 ;;^UTILITY("^GMRD(124.2,",$J,6535,1,3,0)
 ;;=6538^[Extra Order]^3^NURSC^335
 ;;^UTILITY("^GMRD(124.2,",$J,6535,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6535,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6536,0)
 ;;=[Extra Order]^3^NURSC^11^333^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6536,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6536,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6537,0)
 ;;=[Extra Order]^3^NURSC^11^334^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6537,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6537,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6538,0)
 ;;=[Extra Order]^3^NURSC^11^335^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6538,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6538,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6539,0)
 ;;=Fluid Volume Deficit (Actual)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6539,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6539,1,1,0)
 ;;=6540^Etiology/Related and/or Risk Factors^2^NURSC^92
 ;;^UTILITY("^GMRD(124.2,",$J,6539,1,2,0)
 ;;=6551^Related Problems^2^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,6539,1,3,0)
 ;;=6558^Goals/Expected Outcomes^2^NURSC^91
 ;;^UTILITY("^GMRD(124.2,",$J,6539,1,4,0)
 ;;=6571^Nursing Intervention/Orders^2^NURSC^79
