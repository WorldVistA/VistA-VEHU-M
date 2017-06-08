NURCCGAX ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7016,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7016,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7017,0)
 ;;=[Extra Goal]^3^NURSC^9^333^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7017,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7017,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7018,0)
 ;;=[Extra Goal]^3^NURSC^9^334^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7018,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7018,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7019,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^274^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7019,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7019,1,1,0)
 ;;=7020^[Extra Order]^3^NURSC^339
 ;;^UTILITY("^GMRD(124.2,",$J,7019,1,2,0)
 ;;=7021^[Extra Order]^3^NURSC^340
 ;;^UTILITY("^GMRD(124.2,",$J,7019,1,3,0)
 ;;=7022^[Extra Order]^3^NURSC^341
 ;;^UTILITY("^GMRD(124.2,",$J,7019,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7019,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7020,0)
 ;;=[Extra Order]^3^NURSC^11^339^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7020,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7020,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7021,0)
 ;;=[Extra Order]^3^NURSC^11^340^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7021,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7021,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7022,0)
 ;;=[Extra Order]^3^NURSC^11^341^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7022,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7022,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7023,0)
 ;;=verbalizes activities allowed after discharge^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7023,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7023,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7024,0)
 ;;=tolerates food ingestion without aspiration^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7024,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7024,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7091,0)
 ;;=performs feeding with [min/mod/max] assistance [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7091,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7091,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,0)
 ;;=instruct patient & significant other on:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,7229,1,1,0)
 ;;=7244^activity restrictions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,1,2,0)
 ;;=7245^dietary recommendations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,1,3,0)
 ;;=7246^symptoms requiring medical evaluations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,1,5,0)
 ;;=7314^wound care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7229,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7229,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7230,0)
 ;;=[Extra Problem]^2^NURSC^2^18^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7230,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7230,1,1,0)
 ;;=7231^Etiology/Related and/or Risk Factors^2^NURSC^262
 ;;^UTILITY("^GMRD(124.2,",$J,7230,1,2,0)
 ;;=7235^Goals/Expected Outcomes^2^NURSC^273
 ;;^UTILITY("^GMRD(124.2,",$J,7230,1,3,0)
 ;;=7239^Nursing Intervention/Orders^2^NURSC^275
 ;;^UTILITY("^GMRD(124.2,",$J,7230,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7230,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7230,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7231,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^262^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7231,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7231,1,1,0)
 ;;=7233^[etiology]^3^NURSC^85
