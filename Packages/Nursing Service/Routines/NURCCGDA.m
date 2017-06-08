NURCCGDA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11362,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11362,1,1,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11362,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11362,1,3,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11362,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11366,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^151^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,0)
 ;;=^124.21PI^10^6
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,1,0)
 ;;=1834^demonstrates progressive tolerance to increased activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,2,0)
 ;;=11368^verbalizes plan to maintain circulatory improvement^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,3,0)
 ;;=11369^identifies reportable signs/symptoms^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,4,0)
 ;;=11370^decreased peripheral edema^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,9,0)
 ;;=11380^reports decreased numbness & tingling in extremity^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11366,1,10,0)
 ;;=11559^[Extra Goal]^3^NURSC^229
 ;;^UTILITY("^GMRD(124.2,",$J,11366,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11368,0)
 ;;=verbalizes plan to maintain circulatory improvement^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11368,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11368,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11369,0)
 ;;=identifies reportable signs/symptoms^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11369,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11369,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11370,0)
 ;;=decreased peripheral edema^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11370,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11370,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11380,0)
 ;;=reports decreased numbness & tingling in extremity^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11380,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11380,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11381,0)
 ;;=[Extra Goal]^3^NURSC^9^184^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11381,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11381,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11382,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^193^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,0)
 ;;=^124.21PI^26^9
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,2,0)
 ;;=1846^peripheral pulses q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,9,0)
 ;;=11391^monitor size, color, temperature of affected extremity^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,12,0)
 ;;=11394^apply lotion/ointment to skin as indicated/ordered^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,15,0)
 ;;=11397^emphasize avoidance of:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,17,0)
 ;;=11402^use mild cleansing agent for bathing^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,23,0)
 ;;=11426^inspect at risk areas of skin for breakdown q[specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,24,0)
 ;;=11742^[Extra Order]^3^NURSC^191
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,25,0)
 ;;=1074^apply anti-embolic stockings as prescribed^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11382,1,26,0)
 ;;=11608^instruct/assist with ROM [specify]^3^NURSC^56
 ;;^UTILITY("^GMRD(124.2,",$J,11382,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11382,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11391,0)
 ;;=monitor size, color, temperature of affected extremity^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11391,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11391,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11394,0)
 ;;=apply lotion/ointment to skin as indicated/ordered^3^NURSC^11^3^^^T
