NURCCGAW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,6,0)
 ;;=1792^demonstrates dressing change(s)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,7,0)
 ;;=1794^describes healing process and health care precautions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,8,0)
 ;;=1696^does not smoke^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,9,0)
 ;;=1795^does not use drugs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,10,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,11,0)
 ;;=7275^[Extra Goal]^3^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,6960,1,12,0)
 ;;=834^maintains normal skin color and temperature^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6960,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6974,0)
 ;;=[Extra Goal]^3^NURSC^9^134^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6974,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6974,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6975,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^84^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6975,1,0)
 ;;=^124.21PI^17^4
 ;;^UTILITY("^GMRD(124.2,",$J,6975,1,14,0)
 ;;=7007^[Extra Order]^3^NURSC^137
 ;;^UTILITY("^GMRD(124.2,",$J,6975,1,15,0)
 ;;=839^perform skin assessment q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6975,1,16,0)
 ;;=848^encourage adequate food and fluid intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6975,1,17,0)
 ;;=851^teach how to maintain skin integrity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6975,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6975,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7007,0)
 ;;=[Extra Order]^3^NURSC^11^137^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7007,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7007,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7008,0)
 ;;=Defining Characteristics^2^NURSC^12^89^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7008,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,7008,1,1,0)
 ;;=4303^damaged or destroyed tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7008,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7010,0)
 ;;=[Extra Problem]^2^NURSC^2^17^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7010,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7010,1,1,0)
 ;;=7011^Etiology/Related and/or Risk Factors^2^NURSC^261
 ;;^UTILITY("^GMRD(124.2,",$J,7010,1,2,0)
 ;;=7015^Goals/Expected Outcomes^2^NURSC^272
 ;;^UTILITY("^GMRD(124.2,",$J,7010,1,3,0)
 ;;=7019^Nursing Intervention/Orders^2^NURSC^274
 ;;^UTILITY("^GMRD(124.2,",$J,7010,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7010,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7010,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7011,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^261^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7011,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7011,1,1,0)
 ;;=7013^[etiology]^3^NURSC^30
 ;;^UTILITY("^GMRD(124.2,",$J,7011,1,2,0)
 ;;=7014^[etiology]^3^NURSC^35
 ;;^UTILITY("^GMRD(124.2,",$J,7011,1,3,0)
 ;;=7232^[etiology]^3^NURSC^87
 ;;^UTILITY("^GMRD(124.2,",$J,7011,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7012,0)
 ;;=[etiology]^3^NURSC^^36^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7013,0)
 ;;=[etiology]^3^NURSC^^30^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7014,0)
 ;;=[etiology]^3^NURSC^^35^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7015,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^272^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7015,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7015,1,1,0)
 ;;=7016^[Extra Goal]^3^NURSC^332
 ;;^UTILITY("^GMRD(124.2,",$J,7015,1,2,0)
 ;;=7017^[Extra Goal]^3^NURSC^333
 ;;^UTILITY("^GMRD(124.2,",$J,7015,1,3,0)
 ;;=7018^[Extra Goal]^3^NURSC^334
 ;;^UTILITY("^GMRD(124.2,",$J,7015,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7016,0)
 ;;=[Extra Goal]^3^NURSC^9^332^^^T
