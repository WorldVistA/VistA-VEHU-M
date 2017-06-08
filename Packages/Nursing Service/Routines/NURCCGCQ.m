NURCCGCQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10205,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,10205,1,1,0)
 ;;=10206^Etiology/Related and/or Risk Factors^2^NURSC^140
 ;;^UTILITY("^GMRD(124.2,",$J,10205,1,2,0)
 ;;=10214^Related Problems^2^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,10205,1,5,0)
 ;;=15929^Goals/Expected Outcomes^2^NURSC^325
 ;;^UTILITY("^GMRD(124.2,",$J,10205,1,6,0)
 ;;=15934^Nursing Intervention/Orders^2^NURSC^327
 ;;^UTILITY("^GMRD(124.2,",$J,10205,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10205,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10205,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10205,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,10205,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,10206,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^140^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10206,1,0)
 ;;=^124.21PI^5^3
 ;;^UTILITY("^GMRD(124.2,",$J,10206,1,1,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10206,1,3,0)
 ;;=1670^misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10206,1,5,0)
 ;;=1671^perceptual limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10206,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10214,0)
 ;;=Related Problems^2^NURSC^7^120^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10214,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,10214,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10214,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10214,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10237,0)
 ;;=[Extra Goal]^3^NURSC^9^169^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10237,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10237,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10284,0)
 ;;=[Extra Order]^3^NURSC^11^172^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10284,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10284,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10285,0)
 ;;=Knowledge Deficit of Home Care, S/S, and Risk Factors^2^NURSC^2^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10285,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,10285,1,1,0)
 ;;=10286^Etiology/Related and/or Risk Factors^2^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,10285,1,2,0)
 ;;=10294^Related Problems^2^NURSC^121
 ;;^UTILITY("^GMRD(124.2,",$J,10285,1,4,0)
 ;;=10318^Nursing Intervention/Orders^2^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,10285,1,6,0)
 ;;=15265^Goals/Expected Outcomes^2^NURSC^304
 ;;^UTILITY("^GMRD(124.2,",$J,10285,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10285,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10285,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10285,"TD",0)
 ;;=^^1^1^2910829^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,10285,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,10286,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^141^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,1,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,2,0)
 ;;=1669^lack of recall^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,3,0)
 ;;=1670^misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,4,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,5,0)
 ;;=1671^perceptual limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10286,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10286,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10294,0)
 ;;=Related Problems^2^NURSC^7^121^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10294,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,10294,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
