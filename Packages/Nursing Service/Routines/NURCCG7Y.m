NURCCG7Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4218,0)
 ;;=passive behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4219,0)
 ;;=limitations or changes in sexual patterns^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4220,0)
 ;;=Defining Characteristics^2^NURSC^12^34^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4220,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4220,1,1,0)
 ;;=4221^increased body temperature above normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4220,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4221,0)
 ;;=increased body temperature above normal range^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4222,0)
 ;;=Defining Characteristics^2^NURSC^12^35^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,0)
 ;;=^124.21PI^8^7
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,1,0)
 ;;=4225^destruction of skin layers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,2,0)
 ;;=4226^disruption of skin surface^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,4,0)
 ;;=4238^alteration in nutritional state (obesity, emaciation, etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,5,0)
 ;;=824^alteration in skin turgor (change in elasticity)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,6,0)
 ;;=825^mechanical factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,7,0)
 ;;=826^physical immobilization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,1,8,0)
 ;;=827^radiation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4222,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4223,0)
 ;;=Defining Characteristics^2^NURSC^12^36^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4223,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4223,1,1,0)
 ;;=4228^reduction in body temperature below normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4223,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,0)
 ;;=Defining Characteristics^2^NURSC^12^37^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,1,0)
 ;;=4229^frequency less than usual pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,2,0)
 ;;=4230^hard-formed stool^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,3,0)
 ;;=4232^reported feeling of rectal fullness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,4,0)
 ;;=4233^straining at stool^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,5,0)
 ;;=4234^decreased bowel sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,1,6,0)
 ;;=4236^palpable mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4224,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4225,0)
 ;;=destruction of skin layers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4226,0)
 ;;=disruption of skin surface^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4228,0)
 ;;=reduction in body temperature below normal range^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4229,0)
 ;;=frequency less than usual pattern^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4230,0)
 ;;=hard-formed stool^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4231,0)
 ;;=Defining Characteristics^2^NURSC^12^38^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4231,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4231,1,1,0)
 ;;=4225^destruction of skin layers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4231,1,2,0)
 ;;=4226^disruption of skin surface^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4231,1,3,0)
 ;;=4235^invasion of body structures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4231,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4232,0)
 ;;=reported feeling of rectal fullness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4233,0)
 ;;=straining at stool^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4234,0)
 ;;=decreased bowel sounds^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4235,0)
 ;;=invasion of body structures^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4236,0)
 ;;=palpable mass^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4237,0)
 ;;=Defining Characteristics^2^NURSC^12^39^1^^T^1
