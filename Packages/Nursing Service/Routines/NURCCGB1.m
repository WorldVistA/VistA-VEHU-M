NURCCGB1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7397,0)
 ;;=[Extra Goal]^3^NURSC^9^338^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7397,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7397,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7398,0)
 ;;=[Extra Goal]^3^NURSC^9^339^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7398,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7398,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7399,0)
 ;;=[Extra Goal]^3^NURSC^9^340^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7399,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7399,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7400,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^276^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7400,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7400,1,1,0)
 ;;=7401^[Extra Order]^3^NURSC^345
 ;;^UTILITY("^GMRD(124.2,",$J,7400,1,2,0)
 ;;=7402^[Extra Order]^3^NURSC^346
 ;;^UTILITY("^GMRD(124.2,",$J,7400,1,3,0)
 ;;=7403^[Extra Order]^3^NURSC^347
 ;;^UTILITY("^GMRD(124.2,",$J,7400,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7400,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7401,0)
 ;;=[Extra Order]^3^NURSC^11^345^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7401,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7401,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7402,0)
 ;;=[Extra Order]^3^NURSC^11^346^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7402,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7402,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7403,0)
 ;;=[Extra Order]^3^NURSC^11^347^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7403,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7403,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7404,0)
 ;;=performs toilet transfer with [min/mod/max] assistance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7404,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7404,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7405,0)
 ;;=performs independent toilet transfer^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7405,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7405,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7406,0)
 ;;=performs toileting hygiene with [min/mod/max] assistance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7406,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7406,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7407,0)
 ;;=wound care/drsg change(s) of [specify area] q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7407,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7407,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7408,0)
 ;;=performs toileting hygiene independently^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7408,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7408,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7409,0)
 ;;=demonstrates use of adaptive devices [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7409,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7409,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7411,0)
 ;;=instruct patient & S/O^2^NURSC^11^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7411,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7411,1,1,0)
 ;;=7412^on activity restrictions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7411,1,2,0)
 ;;=7245^dietary recommendations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7411,1,3,0)
 ;;=7414^S/S requiring medical evaluation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7411,1,4,0)
 ;;=7314^wound care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7411,1,5,0)
 ;;=7416^[Extra Order]^3^NURSC^67
 ;;^UTILITY("^GMRD(124.2,",$J,7411,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7411,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7411,10)
 ;;=D EN1^NURCCPU3
