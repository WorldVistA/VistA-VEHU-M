NURCCG5I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2196,0)
 ;;=Related Problems^2^NURSC^7^46^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2196,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2196,1,1,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2196,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2196,1,3,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2196,1,4,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2196,1,5,0)
 ;;=2197^Thought Processes, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2196,5)
 ;;=, see:
 ;;^UTILITY("^GMRD(124.2,",$J,2196,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2197,0)
 ;;=Thought Processes, Alteration In^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2198,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^58^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,1,0)
 ;;=2199^will not destroy property during hospitalization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,2,0)
 ;;=2200^will not harm himself or others during hospitalization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,3,0)
 ;;=2201^signs a 'no-harm' contract^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,4,0)
 ;;=2202^communicates feelings of loss of control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,5,0)
 ;;=2203^identifies feelings contributing to destructive behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,6,0)
 ;;=2204^writes plan identifying coping/behavior control strategies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,7,0)
 ;;=2419^writes plan identifying impulses to harm self^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,1,8,0)
 ;;=2922^[Extra Goal]^3^NURSC^103^0
 ;;^UTILITY("^GMRD(124.2,",$J,2198,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2199,0)
 ;;=will not destroy property during hospitalization^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2199,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2199,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2200,0)
 ;;=will not harm himself or others during hospitalization^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2200,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2200,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2201,0)
 ;;=signs a 'no-harm' contract^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2201,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2201,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2202,0)
 ;;=communicates feelings of loss of control^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2202,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2202,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2203,0)
 ;;=identifies feelings contributing to destructive behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2203,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2203,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2204,0)
 ;;=writes plan identifying coping/behavior control strategies^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2204,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2204,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2205,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^54^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,1,0)
 ;;=2206^encourage pt. to identify anger and verbalize feelings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,2,0)
 ;;=2207^offer PRN medication when indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,3,0)
 ;;=2208^promote activities to increase self-esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,4,0)
 ;;=2209^include family or S/O in group therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2205,1,5,0)
 ;;=2210^praise patient for use of assertive actions^3^NURSC^1^0
