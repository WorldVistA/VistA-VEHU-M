NURCCGGS ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15751,0)
 ;;=[Extra Goal]^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15751,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15751,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15752,0)
 ;;=[Extra Order]^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15752,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15752,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15753,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^302^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15753,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,15753,1,1,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15753,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15754,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^316^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15754,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15754,1,1,0)
 ;;=15755^becomes/remains free of S/S of hypercapnia and/or hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15754,1,2,0)
 ;;=15858^[Extra Goal]^3^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,15754,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15755,0)
 ;;=becomes/remains free of S/S of hypercapnia and/or hypoxia^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15755,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15755,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15756,0)
 ;;=[Extra Goal]^3^NURSC^9^18^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15756,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15756,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15757,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^318^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15757,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15757,1,1,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15757,1,2,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15757,1,3,0)
 ;;=1006323^[Extra Order]^3^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,15757,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15757,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15758,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^303^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15758,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15758,1,1,0)
 ;;=15762^[etiology]^3^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,15758,1,2,0)
 ;;=15763^[etiology]^3^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,15758,1,3,0)
 ;;=15910^[etiology]^3^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,15758,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15759,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^317^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15759,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15759,1,1,0)
 ;;=15764^[Extra Goal]^3^NURSC^413
 ;;^UTILITY("^GMRD(124.2,",$J,15759,1,2,0)
 ;;=15765^[Extra Goal]^3^NURSC^414
 ;;^UTILITY("^GMRD(124.2,",$J,15759,1,3,0)
 ;;=15766^[Extra Goal]^3^NURSC^415
 ;;^UTILITY("^GMRD(124.2,",$J,15759,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15760,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^319^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15760,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15760,1,1,0)
 ;;=15767^[Extra Order]^3^NURSC^420
 ;;^UTILITY("^GMRD(124.2,",$J,15760,1,2,0)
 ;;=15768^[Extra Order]^3^NURSC^421
 ;;^UTILITY("^GMRD(124.2,",$J,15760,1,3,0)
 ;;=15769^[Extra Order]^3^NURSC^422
 ;;^UTILITY("^GMRD(124.2,",$J,15760,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15760,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15761,0)
 ;;=[etiology]^3^NURSC^^148^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15762,0)
 ;;=[etiology]^3^NURSC^^149^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15763,0)
 ;;=[etiology]^3^NURSC^^150^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15764,0)
 ;;=[Extra Goal]^3^NURSC^9^413^^^T
