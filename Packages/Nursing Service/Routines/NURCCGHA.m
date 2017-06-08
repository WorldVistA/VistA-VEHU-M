NURCCGHA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15980,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15981,0)
 ;;=IV remains patent while in place^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15981,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15981,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15982,0)
 ;;=[Extra Goal]^3^NURSC^9^32^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15982,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15982,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15983,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^332^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15983,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15983,1,1,0)
 ;;=15984^assess IV q [frequency] for signs of infection/infiltration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15983,1,2,0)
 ;;=15985^change IV site and tubing per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15983,1,3,0)
 ;;=15986^[Extra Order]^3^NURSC^22
 ;;^UTILITY("^GMRD(124.2,",$J,15983,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15983,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15984,0)
 ;;=assess IV q [frequency] for signs of infection/infiltration^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15984,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15984,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15985,0)
 ;;=change IV site and tubing per protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15985,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15985,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15986,0)
 ;;=[Extra Order]^3^NURSC^11^22^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15986,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15986,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15987,0)
 ;;=[Extra Problem]^2^NURSC^2^31^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15987,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15987,1,1,0)
 ;;=15988^Etiology/Related and/or Risk Factors^2^NURSC^94
 ;;^UTILITY("^GMRD(124.2,",$J,15987,1,2,0)
 ;;=15992^Goals/Expected Outcomes^2^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,15987,1,3,0)
 ;;=15996^Nursing Intervention/Orders^2^NURSC^78
 ;;^UTILITY("^GMRD(124.2,",$J,15987,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15987,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15987,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15988,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^94^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15988,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15988,1,1,0)
 ;;=15989^[etiology]^3^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,15988,1,2,0)
 ;;=15990^[etiology]^3^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,15988,1,3,0)
 ;;=15991^[etiology]^3^NURSC^156
 ;;^UTILITY("^GMRD(124.2,",$J,15988,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15989,0)
 ;;=[etiology]^3^NURSC^^154^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15990,0)
 ;;=[etiology]^3^NURSC^^155^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15991,0)
 ;;=[etiology]^3^NURSC^^156^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15992,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^93^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15992,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15992,1,1,0)
 ;;=15993^[Extra Goal]^3^NURSC^419
 ;;^UTILITY("^GMRD(124.2,",$J,15992,1,2,0)
 ;;=15994^[Extra Goal]^3^NURSC^420
 ;;^UTILITY("^GMRD(124.2,",$J,15992,1,3,0)
 ;;=15995^[Extra Goal]^3^NURSC^421
 ;;^UTILITY("^GMRD(124.2,",$J,15992,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15993,0)
 ;;=[Extra Goal]^3^NURSC^9^419^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15993,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15993,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15994,0)
 ;;=[Extra Goal]^3^NURSC^9^420^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15994,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15994,10)
 ;;=D EN2^NURCCPU1
