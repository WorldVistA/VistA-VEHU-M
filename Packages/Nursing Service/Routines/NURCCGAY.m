NURCCGAY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7231,1,2,0)
 ;;=7234^[etiology]^3^NURSC^86
 ;;^UTILITY("^GMRD(124.2,",$J,7231,1,3,0)
 ;;=7393^[etiology]^3^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,7231,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7232,0)
 ;;=[etiology]^3^NURSC^^87^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7233,0)
 ;;=[etiology]^3^NURSC^^85^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7234,0)
 ;;=[etiology]^3^NURSC^^86^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7235,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^273^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7235,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7235,1,1,0)
 ;;=7236^[Extra Goal]^3^NURSC^335
 ;;^UTILITY("^GMRD(124.2,",$J,7235,1,2,0)
 ;;=7237^[Extra Goal]^3^NURSC^336
 ;;^UTILITY("^GMRD(124.2,",$J,7235,1,3,0)
 ;;=7238^[Extra Goal]^3^NURSC^337
 ;;^UTILITY("^GMRD(124.2,",$J,7235,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7236,0)
 ;;=[Extra Goal]^3^NURSC^9^335^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7236,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7236,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7237,0)
 ;;=[Extra Goal]^3^NURSC^9^336^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7237,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7237,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7238,0)
 ;;=[Extra Goal]^3^NURSC^9^337^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7238,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7238,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7239,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^275^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7239,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7239,1,1,0)
 ;;=7240^[Extra Order]^3^NURSC^342
 ;;^UTILITY("^GMRD(124.2,",$J,7239,1,2,0)
 ;;=7241^[Extra Order]^3^NURSC^343
 ;;^UTILITY("^GMRD(124.2,",$J,7239,1,3,0)
 ;;=7242^[Extra Order]^3^NURSC^344
 ;;^UTILITY("^GMRD(124.2,",$J,7239,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7239,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7240,0)
 ;;=[Extra Order]^3^NURSC^11^342^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7240,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7240,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7241,0)
 ;;=[Extra Order]^3^NURSC^11^343^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7241,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7241,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7242,0)
 ;;=[Extra Order]^3^NURSC^11^344^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7242,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7242,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7244,0)
 ;;=activity restrictions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7245,0)
 ;;=dietary recommendations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7246,0)
 ;;=symptoms requiring medical evaluations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7247,0)
 ;;=Pain, Acute^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7247,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7247,1,1,0)
 ;;=7248^Etiology/Related and/or Risk Factors^2^NURSC^102
 ;;^UTILITY("^GMRD(124.2,",$J,7247,1,2,0)
 ;;=7266^Goals/Expected Outcomes^2^NURSC^101
 ;;^UTILITY("^GMRD(124.2,",$J,7247,1,3,0)
 ;;=7276^Nursing Intervention/Orders^2^NURSC^180
 ;;^UTILITY("^GMRD(124.2,",$J,7247,1,4,0)
 ;;=7293^Related Problems^2^NURSC^86
 ;;^UTILITY("^GMRD(124.2,",$J,7247,1,5,0)
 ;;=7304^Defining Characteristics^2^NURSC^92
 ;;^UTILITY("^GMRD(124.2,",$J,7247,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7247,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7247,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7247,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,7247,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
