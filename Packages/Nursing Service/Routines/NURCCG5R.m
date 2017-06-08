NURCCG5R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,7,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,8,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,9,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,10,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,11,0)
 ;;=1919^Spiritual Distress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2298,0)
 ;;=absence of anticipatory grieving^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2299,0)
 ;;=actual or perceived object loss (broadest sense) such as:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,1,0)
 ;;=2300^people^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,2,0)
 ;;=2301^possessions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,3,0)
 ;;=2302^job status^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,4,0)
 ;;=2303^home^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,5,0)
 ;;=2305^ideals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2299,1,6,0)
 ;;=2306^parts and processes of the body^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2299,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2300,0)
 ;;=people^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2301,0)
 ;;=possessions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2302,0)
 ;;=job status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2303,0)
 ;;=home^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2304,0)
 ;;=ask what is going on with him at this time^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2304,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2304,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2305,0)
 ;;=ideals^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2306,0)
 ;;=parts and processes of the body^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2307,0)
 ;;=chronic fatal illness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2308,0)
 ;;=interrupt hallucinations; involve reality based activities ^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2308,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2308,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2309,0)
 ;;=lack of resolutions of previous grieving response^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2310,0)
 ;;=loss of personal possessions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2311,0)
 ;;=assist pt. in identifying anxiety/its relation to behavior^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2311,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2311,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2312,0)
 ;;=loss of psycho-physiological well-being^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2313,0)
 ;;=loss of significant others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2314,0)
 ;;=determine amount of control pt. has over hallucinations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2314,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2314,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2315,0)
 ;;=develop plan with pt. to report impulsive behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2315,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2315,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2316,0)
 ;;=assign 1:1 as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2316,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2316,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2317,0)
 ;;=offer PRN medication when indicated^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2317,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2317,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2318,0)
 ;;=expresses two feelings related to loss^3^NURSC^9^1^^^T
