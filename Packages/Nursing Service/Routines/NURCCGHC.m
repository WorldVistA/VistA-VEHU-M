NURCCGHC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,16561,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,16562,0)
 ;;=compliance with prescribed treatment program^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,16562,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,16562,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,16563,0)
 ;;=cough/turn/deep breathe q[specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,16563,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,16563,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,16564,0)
 ;;=explain the reality of the present situation^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,16564,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,16564,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,16565,0)
 ;;=reduced risk of pulmonary infection^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,16565,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,16565,10)
 ;;=D EN2^NURCCPU1
