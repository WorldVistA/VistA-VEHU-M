NURCCG0M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,4,0)
 ;;=1873^oral hygiene q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,5,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,6,0)
 ;;=2954^[Extra Order]^3^NURSC^26^0
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,7,0)
 ;;=15362^monitor for S/S of increased intracranial pressure^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,8,0)
 ;;=15365^teach appropriate positioning for activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,9,0)
 ;;=15372^assess function, routine, and amt. of assistance needed^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,10,0)
 ;;=15373^facilitate patient control over activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,11,0)
 ;;=15375^assess and utilize support systems [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,12,0)
 ;;=15377^determine communication for expressing needs [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,13,0)
 ;;=15380^divide tasks into the smallest steps possible^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,234,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,234,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,235,0)
 ;;=dressing/grooming deficit interventions^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,1,0)
 ;;=256^encourage patient to wear street clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,2,0)
 ;;=257^ensure easy access to all clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,3,0)
 ;;=258^lay clothing out in order for dressing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,4,0)
 ;;=259^allow sufficient time for dressing and undressing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,5,0)
 ;;=260^select appropriate clothing^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,6,0)
 ;;=261^allow person to demonstrate activity in steps^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,7,0)
 ;;=262^keep instructions simple and repeat often^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,8,0)
 ;;=263^provide dressing aids as necessary^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,9,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,10,0)
 ;;=3024^[Extra Order]^3^NURSC^110^0
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,11,0)
 ;;=15375^assess and utilize support systems [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,12,0)
 ;;=15372^assess function, routine, and amt. of assistance needed^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,13,0)
 ;;=15377^determine communication for expressing needs [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,14,0)
 ;;=15380^divide tasks into the smallest steps possible^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,15,0)
 ;;=15373^facilitate patient control over activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,16,0)
 ;;=15362^monitor for S/S of increased intracranial pressure^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,17,0)
 ;;=15365^teach appropriate positioning for activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,1,18,0)
 ;;=255^teach safe use of adaptive equipment [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,235,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,235,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,236,0)
 ;;=assess degree of disability^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,236,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,236,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,237,0)
 ;;=assess memory/intellectual functioning^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,237,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,237,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,238,0)
 ;;=determine individual strengths and skills^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,238,9)
 ;;=D EN2^NURCCPU2
