NURCCGFF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14391,1,29,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14391,1,30,0)
 ;;=14453^refer for appropriate consults^2^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,14391,1,31,0)
 ;;=14905^[Extra Order]^3^NURSC^256
 ;;^UTILITY("^GMRD(124.2,",$J,14391,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14391,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14396,0)
 ;;=respiratory pattern q [frequency]^2^NURSC^11^28^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14396,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,14396,1,1,0)
 ;;=2697^respiratory altenans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14396,1,2,0)
 ;;=2698^paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14396,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,14396,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14396,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14396,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14413,0)
 ;;=[Extra Problem]^2^NURSC^2^39^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,14413,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14413,1,1,0)
 ;;=14416^Etiology/Related and/or Risk Factors^2^NURSC^287
 ;;^UTILITY("^GMRD(124.2,",$J,14413,1,2,0)
 ;;=14426^Goals/Expected Outcomes^2^NURSC^299
 ;;^UTILITY("^GMRD(124.2,",$J,14413,1,3,0)
 ;;=14436^Nursing Intervention/Orders^2^NURSC^303
 ;;^UTILITY("^GMRD(124.2,",$J,14413,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14413,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14413,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14416,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^287^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14416,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14416,1,1,0)
 ;;=14420^[etiology]^3^NURSC^68
 ;;^UTILITY("^GMRD(124.2,",$J,14416,1,2,0)
 ;;=14423^[etiology]^3^NURSC^69
 ;;^UTILITY("^GMRD(124.2,",$J,14416,1,3,0)
 ;;=14570^[etiology]^3^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,14416,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,0)
 ;;=assess for complications of mechanical ventilation^2^NURSC^11^14^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14417,1,1,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,1,2,0)
 ;;=439^tube displacement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,1,3,0)
 ;;=440^GI bleed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,1,4,0)
 ;;=441^pneumothorax^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,1,5,0)
 ;;=442^subcutaneous emphysema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,5)
 ;;=; monitor and document:
 ;;^UTILITY("^GMRD(124.2,",$J,14417,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14417,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14417,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14418,0)
 ;;=[etiology]^3^NURSC^^67^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14420,0)
 ;;=[etiology]^3^NURSC^^68^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14423,0)
 ;;=[etiology]^3^NURSC^^69^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14426,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^299^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14426,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14426,1,1,0)
 ;;=14429^[Extra Goal]^3^NURSC^395
 ;;^UTILITY("^GMRD(124.2,",$J,14426,1,2,0)
 ;;=14431^[Extra Goal]^3^NURSC^396
 ;;^UTILITY("^GMRD(124.2,",$J,14426,1,3,0)
 ;;=14434^[Extra Goal]^3^NURSC^397
 ;;^UTILITY("^GMRD(124.2,",$J,14426,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14429,0)
 ;;=[Extra Goal]^3^NURSC^9^395^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14429,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14429,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14431,0)
 ;;=[Extra Goal]^3^NURSC^9^396^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14431,9)
 ;;=D EN5^NURCCPU0
