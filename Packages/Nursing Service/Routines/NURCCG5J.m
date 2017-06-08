NURCCG5J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,6,0)
 ;;=2211^praise patient for use of physical exercise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,7,0)
 ;;=2212^teach^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,8,0)
 ;;=2420^observe as indicated^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,9,0)
 ;;=2425^reinforce that patient can maintain control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,10,0)
 ;;=2426^staff will give examples of controlled behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,11,0)
 ;;=2427^restrain as necessary^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,12,0)
 ;;=3009^[Extra Order]^3^NURSC^95^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2205,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2206,0)
 ;;=encourage pt. to identify anger and verbalize feelings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2206,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2206,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2207,0)
 ;;=offer PRN medication when indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2207,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2207,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2208,0)
 ;;=promote activities to increase self-esteem^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2208,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2208,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2209,0)
 ;;=include family or S/O in group therapy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2209,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2209,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2210,0)
 ;;=praise patient for use of assertive actions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2210,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2210,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2211,0)
 ;;=praise patient for use of physical exercise^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2211,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2211,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2212,0)
 ;;=teach^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2212,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2212,1,1,0)
 ;;=2213^relaxation/stress reduction methods^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2212,1,2,0)
 ;;=2214^assertiveness training^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2212,1,3,0)
 ;;=2215^physical exercise as a means to cope with feelings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2212,1,4,0)
 ;;=2166^medication information^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2212,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,2212,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2212,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2212,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2213,0)
 ;;=relaxation/stress reduction methods^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2214,0)
 ;;=assertiveness training^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2215,0)
 ;;=physical exercise as a means to cope with feelings^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2216,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^60^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,1,0)
 ;;=2217^alteration in mental status^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,2,0)
 ;;=2230^altered body structure or function^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,3,0)
 ;;=2232^altered state of wellness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,4,0)
 ;;=2233^delay in accomplishing developmental tasks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,5,0)
 ;;=2234^immature interests^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2216,1,6,0)
 ;;=2235^inadequate personal resources^3^NURSC^1^0
