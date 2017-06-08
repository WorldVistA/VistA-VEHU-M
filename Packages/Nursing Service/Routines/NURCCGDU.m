NURCCGDU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12155,0)
 ;;=verbalizes knowledge of transmission/spread of infection^3^NURSC^9^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12155,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12155,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12163,0)
 ;;=[Extra Goal]^3^NURSC^9^193^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12163,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12163,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12164,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^136^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12164,1,0)
 ;;=^124.21PI^21^5
 ;;^UTILITY("^GMRD(124.2,",$J,12164,1,4,0)
 ;;=12173^implement appropriate isolation/infection precautions^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,12164,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12164,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12164,1,18,0)
 ;;=12779^[Extra Order]^3^NURSC^206
 ;;^UTILITY("^GMRD(124.2,",$J,12164,1,21,0)
 ;;=6891^teach prevention of infection techniques [specify]^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12164,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12164,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12165,0)
 ;;=[Extra Problem]^2^NURSC^2^28^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,12165,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12165,1,1,0)
 ;;=12166^Etiology/Related and/or Risk Factors^2^NURSC^275
 ;;^UTILITY("^GMRD(124.2,",$J,12165,1,2,0)
 ;;=12174^Goals/Expected Outcomes^2^NURSC^287
 ;;^UTILITY("^GMRD(124.2,",$J,12165,1,3,0)
 ;;=12183^Nursing Intervention/Orders^2^NURSC^291
 ;;^UTILITY("^GMRD(124.2,",$J,12165,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12165,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12165,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12166,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^275^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12166,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12166,1,1,0)
 ;;=12170^[etiology]^3^NURSC^115
 ;;^UTILITY("^GMRD(124.2,",$J,12166,1,2,0)
 ;;=12171^[etiology]^3^NURSC^116
 ;;^UTILITY("^GMRD(124.2,",$J,12166,1,3,0)
 ;;=12615^[etiology]^3^NURSC^37
 ;;^UTILITY("^GMRD(124.2,",$J,12166,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12168,0)
 ;;=[etiology]^3^NURSC^^117^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12170,0)
 ;;=[etiology]^3^NURSC^^115^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12171,0)
 ;;=[etiology]^3^NURSC^^116^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12173,0)
 ;;=implement appropriate isolation/infection precautions^3^NURSC^11^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12173,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12173,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12174,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^287^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12174,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12174,1,1,0)
 ;;=12177^[Extra Goal]^3^NURSC^365
 ;;^UTILITY("^GMRD(124.2,",$J,12174,1,2,0)
 ;;=12179^[Extra Goal]^3^NURSC^366
 ;;^UTILITY("^GMRD(124.2,",$J,12174,1,3,0)
 ;;=12181^[Extra Goal]^3^NURSC^367
 ;;^UTILITY("^GMRD(124.2,",$J,12174,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12175,0)
 ;;=demonstrates skills and verbalizes knowledge regarding:^2^NURSC^9^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12175,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12175,1,1,0)
 ;;=12290^able to administer insulin injections/oral hypoglycemics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12175,1,2,0)
 ;;=2658^diet^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12175,1,3,0)
 ;;=11838^capillary blood glucose monitoring [specify type]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12175,1,4,0)
 ;;=12533^[Extra Goal]^3^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,12175,1,5,0)
 ;;=12701^foot care^3^NURSC^2
