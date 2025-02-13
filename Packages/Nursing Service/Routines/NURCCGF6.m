NURCCGF6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14194,0)
 ;;=[Extra Problem]^2^NURSC^2^38^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,14194,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14194,1,1,0)
 ;;=14195^Etiology/Related and/or Risk Factors^2^NURSC^286
 ;;^UTILITY("^GMRD(124.2,",$J,14194,1,2,0)
 ;;=14199^Goals/Expected Outcomes^2^NURSC^298
 ;;^UTILITY("^GMRD(124.2,",$J,14194,1,3,0)
 ;;=14203^Nursing Intervention/Orders^2^NURSC^302
 ;;^UTILITY("^GMRD(124.2,",$J,14194,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14194,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14194,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14195,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^286^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14195,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14195,1,1,0)
 ;;=14197^[etiology]^3^NURSC^112
 ;;^UTILITY("^GMRD(124.2,",$J,14195,1,2,0)
 ;;=14198^[etiology]^3^NURSC^113
 ;;^UTILITY("^GMRD(124.2,",$J,14195,1,3,0)
 ;;=14418^[etiology]^3^NURSC^67
 ;;^UTILITY("^GMRD(124.2,",$J,14195,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14196,0)
 ;;=[etiology]^3^NURSC^^114^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14197,0)
 ;;=[etiology]^3^NURSC^^112^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14198,0)
 ;;=[etiology]^3^NURSC^^113^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14199,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^298^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14199,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14199,1,1,0)
 ;;=14200^[Extra Goal]^3^NURSC^392
 ;;^UTILITY("^GMRD(124.2,",$J,14199,1,2,0)
 ;;=14201^[Extra Goal]^3^NURSC^393
 ;;^UTILITY("^GMRD(124.2,",$J,14199,1,3,0)
 ;;=14202^[Extra Goal]^3^NURSC^394
 ;;^UTILITY("^GMRD(124.2,",$J,14199,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14200,0)
 ;;=[Extra Goal]^3^NURSC^9^392^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14200,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14200,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14201,0)
 ;;=[Extra Goal]^3^NURSC^9^393^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14201,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14201,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14202,0)
 ;;=[Extra Goal]^3^NURSC^9^394^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14202,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14202,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14203,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^302^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14203,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14203,1,1,0)
 ;;=14204^[Extra Order]^3^NURSC^399
 ;;^UTILITY("^GMRD(124.2,",$J,14203,1,2,0)
 ;;=14205^[Extra Order]^3^NURSC^400
 ;;^UTILITY("^GMRD(124.2,",$J,14203,1,3,0)
 ;;=14206^[Extra Order]^3^NURSC^401
 ;;^UTILITY("^GMRD(124.2,",$J,14203,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14203,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14204,0)
 ;;=[Extra Order]^3^NURSC^11^399^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14204,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14204,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14205,0)
 ;;=[Extra Order]^3^NURSC^11^400^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14205,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14205,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14206,0)
 ;;=[Extra Order]^3^NURSC^11^401^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14206,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14206,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14207,0)
 ;;=Airway Clearance, Ineffective^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14207,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,14207,1,1,0)
 ;;=14208^Related Problems^2^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,14207,1,2,0)
 ;;=14213^Etiology/Related and/or Risk Factors^2^NURSC^190
