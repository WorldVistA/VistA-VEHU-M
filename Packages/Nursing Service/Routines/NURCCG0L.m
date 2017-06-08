NURCCG0L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,8,0)
 ;;=242^encourage patient to control timing of self-care activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,9,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,10,0)
 ;;=3026^[Extra Order]^3^NURSC^112^0
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,11,0)
 ;;=15375^assess and utilize support systems [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,12,0)
 ;;=15372^assess function, routine, and amt. of assistance needed^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,13,0)
 ;;=15377^determine communication for expressing needs [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,14,0)
 ;;=15380^divide tasks into the smallest steps possible^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,15,0)
 ;;=15373^facilitate patient control over activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,16,0)
 ;;=15362^monitor for S/S of increased intracranial pressure^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,17,0)
 ;;=15365^teach appropriate positioning for activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,1,18,0)
 ;;=255^teach safe use of adaptive equipment [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,232,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,232,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,233,0)
 ;;=feeding deficit interventions^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,1,0)
 ;;=246^identify food likes/dislikes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,2,0)
 ;;=247^encourage person to wear dentures/eyeglasses if applicable^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,3,0)
 ;;=248^determine person's usual eating pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,4,0)
 ;;=249^position person in upright, comfortable eating position^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,5,0)
 ;;=250^provide assistance or adaptive devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,6,0)
 ;;=251^explain/demonstrate adaptive devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,7,0)
 ;;=252^identify deterring factors when using devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,8,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,9,0)
 ;;=3025^[Extra Order]^3^NURSC^111^0
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,10,0)
 ;;=15375^assess and utilize support systems [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,11,0)
 ;;=15372^assess function, routine, and amt. of assistance needed^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,12,0)
 ;;=15377^determine communication for expressing needs [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,13,0)
 ;;=15380^divide tasks into the smallest steps possible^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,14,0)
 ;;=15373^facilitate patient control over activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,15,0)
 ;;=15362^monitor for S/S of increased intracranial pressure^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,16,0)
 ;;=15365^teach appropriate positioning for activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,1,17,0)
 ;;=255^teach safe use of adaptive equipment [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,233,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,233,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,234,0)
 ;;=bathing/hygiene deficit interventions^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,1,0)
 ;;=253^provide bathing time and routine to encourage independence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,2,0)
 ;;=254^provide adaptive equipment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,234,1,3,0)
 ;;=255^teach safe use of adaptive equipment [specify]^3^NURSC^1^0
