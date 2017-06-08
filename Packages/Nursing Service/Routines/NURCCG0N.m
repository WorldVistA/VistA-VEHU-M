NURCCG0N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,238,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,239,0)
 ;;=identify if deficit is temporary or permanent^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,239,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,239,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,240,0)
 ;;=assess causative factors (of deficit)^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,240,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,240,1,1,0)
 ;;=243^visual deficits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,240,1,2,0)
 ;;=244^impaired functional mobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,240,1,3,0)
 ;;=245^contributory medical problems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,240,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,240,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,240,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,240,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,241,0)
 ;;=assess post discharge needs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,241,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,241,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,242,0)
 ;;=encourage patient to control timing of self-care activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,242,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,242,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,243,0)
 ;;=visual deficits^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,244,0)
 ;;=impaired functional mobility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,245,0)
 ;;=contributory medical problems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,246,0)
 ;;=identify food likes/dislikes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,246,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,246,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,247,0)
 ;;=encourage person to wear dentures/eyeglasses if applicable^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,247,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,247,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,248,0)
 ;;=determine person's usual eating pattern^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,248,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,248,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,249,0)
 ;;=position person in upright, comfortable eating position^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,249,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,249,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,250,0)
 ;;=provide assistance or adaptive devices^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,250,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,250,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,251,0)
 ;;=explain/demonstrate adaptive devices^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,251,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,251,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,252,0)
 ;;=identify deterring factors when using devices^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,252,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,252,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,253,0)
 ;;=provide bathing time and routine to encourage independence^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,253,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,253,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,254,0)
 ;;=provide adaptive equipment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,254,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,254,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,255,0)
 ;;=teach safe use of adaptive equipment [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,255,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,255,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,256,0)
 ;;=encourage patient to wear street clothing^3^NURSC^11^1^^^T
