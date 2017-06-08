NURCCGGB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15392,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15392,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15393,0)
 ;;=wound size decreases^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15393,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15393,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15394,0)
 ;;=Tissue Perfusion, Alteration in^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15394,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15394,1,1,0)
 ;;=15395^Etiology/Related and/or Risk Factors^2^NURSC^293
 ;;^UTILITY("^GMRD(124.2,",$J,15394,1,2,0)
 ;;=15397^Goals/Expected Outcomes^2^NURSC^306
 ;;^UTILITY("^GMRD(124.2,",$J,15394,1,3,0)
 ;;=15401^Nursing Intervention/Orders^2^NURSC^308
 ;;^UTILITY("^GMRD(124.2,",$J,15394,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15394,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15394,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15395,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^293^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15395,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,15395,1,2,0)
 ;;=1825^exchange problems - hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15395,1,3,0)
 ;;=1822^interruption of arterial flow^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15395,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15397,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^306^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15397,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,15397,1,2,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15397,1,3,0)
 ;;=15606^[Extra Goal]^3^NURSC^259
 ;;^UTILITY("^GMRD(124.2,",$J,15397,1,4,0)
 ;;=1532^maintains intact skin^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15397,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15400,0)
 ;;=[Extra Goal]^3^NURSC^9^256^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15400,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15400,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15401,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^308^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15401,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,15401,1,2,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15401,1,4,0)
 ;;=15669^[Extra Order]^3^NURSC^266
 ;;^UTILITY("^GMRD(124.2,",$J,15401,1,5,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15401,1,6,0)
 ;;=1074^apply anti-embolic stockings as prescribed^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15401,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15401,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15405,0)
 ;;=[Extra Order]^3^NURSC^11^261^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15405,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15405,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15406,0)
 ;;=Fluid Volume (Deficit/Excess)^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15406,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15406,1,1,0)
 ;;=15407^Etiology/Related and/or Risk Factors^2^NURSC^294
 ;;^UTILITY("^GMRD(124.2,",$J,15406,1,2,0)
 ;;=15412^Goals/Expected Outcomes^2^NURSC^307
 ;;^UTILITY("^GMRD(124.2,",$J,15406,1,3,0)
 ;;=15422^Nursing Intervention/Orders^2^NURSC^309
 ;;^UTILITY("^GMRD(124.2,",$J,15406,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15406,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15406,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15407,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^294^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15407,1,0)
 ;;=^124.21PI^5^1
 ;;^UTILITY("^GMRD(124.2,",$J,15407,1,5,0)
 ;;=15487^compromised respiratory mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15407,7)
 ;;=D EN4^NURCCPU1
