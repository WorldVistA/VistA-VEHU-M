NURCCG5D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,10,0)
 ;;=2412^indicate inappropriate behavior to develop honesty/awareness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,11,0)
 ;;=2138^reinforce positive interaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,12,0)
 ;;=2413^through 1:1 relationship, assist in identifying problems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,13,0)
 ;;=2414^through pt. education, assist in identifying problem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,14,0)
 ;;=2415^assist to plan way to compensate for loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,15,0)
 ;;=2416^teach holistic health (activity, recreation, and rest)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,16,0)
 ;;=2139^encourage pt. to have written goals by discharge^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,17,0)
 ;;=2417^assist listing of supportive persons/agencies before D/C^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,18,0)
 ;;=2418^assist/secure contact with support ind./group before D/C^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,19,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,20,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,21,0)
 ;;=3006^[Extra Order]^3^NURSC^92^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2128,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2129,0)
 ;;=monitor fluid and food intake^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2129,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2129,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2130,0)
 ;;=administer medication as ordered for S/S of withdrawal^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2130,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2130,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2131,0)
 ;;=assign 1:1 relationship with nursing staff^3^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2131,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2131,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2132,0)
 ;;=remind patient that withdrawl is a temporary condition^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2132,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2132,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2133,0)
 ;;=build trust and rapport^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2133,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2133,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2134,0)
 ;;=allow patient to ventilate fears^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2134,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2134,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2135,0)
 ;;=assist pt. to identify need for lifestyle change^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2135,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2135,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2136,0)
 ;;=teach simple stress reduction techniques^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2136,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2136,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2137,0)
 ;;=assist in identifying consequences of negative behavior^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2137,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2137,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2138,0)
 ;;=reinforce positive interaction^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2138,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2138,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2139,0)
 ;;=encourage pt. to have written goals by discharge^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,1,0)
 ;;=2140^mental^3^NURSC^1^0
