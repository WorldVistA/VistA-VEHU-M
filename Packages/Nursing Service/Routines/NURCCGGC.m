NURCCGGC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15412,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^307^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15412,1,0)
 ;;=^124.21PI^6^2
 ;;^UTILITY("^GMRD(124.2,",$J,15412,1,3,0)
 ;;=15413^maintain fluid/electrolytes WNL for patient^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,15412,1,6,0)
 ;;=15420^[Extra Goal]^3^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,15412,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,0)
 ;;=maintain fluid/electrolytes WNL for patient^2^NURSC^9^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15413,1,1,0)
 ;;=4393^electrolytes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,1,2,0)
 ;;=4394^BUN [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,1,3,0)
 ;;=4395^creatinine [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,1,4,0)
 ;;=4396^enzymes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15413,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15413,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15420,0)
 ;;=[Extra Goal]^3^NURSC^9^141^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15420,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15420,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15422,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^309^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15422,1,0)
 ;;=^124.21PI^12^5
 ;;^UTILITY("^GMRD(124.2,",$J,15422,1,6,0)
 ;;=15428^[Extra Order]^3^NURSC^43
 ;;^UTILITY("^GMRD(124.2,",$J,15422,1,7,0)
 ;;=816^reposition/turn q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15422,1,8,0)
 ;;=4959^administer medications as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15422,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15422,1,12,0)
 ;;=15491^monitor laboratory values:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15422,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15422,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15428,0)
 ;;=[Extra Order]^3^NURSC^11^43^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15428,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15428,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15429,0)
 ;;=albumin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15430,0)
 ;;=Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^2^4^1^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,15430,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,15430,1,1,0)
 ;;=15431^Etiology/Related and/or Risk Factors^2^NURSC^295
 ;;^UTILITY("^GMRD(124.2,",$J,15430,1,2,0)
 ;;=15439^Goals/Expected Outcomes^2^NURSC^308
 ;;^UTILITY("^GMRD(124.2,",$J,15430,1,4,0)
 ;;=15459^Nursing Intervention/Orders^2^NURSC^310
 ;;^UTILITY("^GMRD(124.2,",$J,15430,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15430,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15430,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15431,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^295^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15431,1,0)
 ;;=^124.21PI^7^3
 ;;^UTILITY("^GMRD(124.2,",$J,15431,1,2,0)
 ;;=4368^alteration in preload/afterload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15431,1,3,0)
 ;;=15434^altered myocardial contractility^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15431,1,7,0)
 ;;=15438^altered inotropic changes in the heart^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15431,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15434,0)
 ;;=altered myocardial contractility^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15438,0)
 ;;=altered inotropic changes in the heart^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15439,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^308^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15439,1,0)
 ;;=^124.21PI^6^3
