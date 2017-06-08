NURCCG5P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2279,1,2,0)
 ;;=2292^assist with grief process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2279,1,3,0)
 ;;=1974^teach problem solving skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2279,1,4,0)
 ;;=3013^[Extra Order]^3^NURSC^99^0
 ;;^UTILITY("^GMRD(124.2,",$J,2279,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2279,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2280,0)
 ;;=Related Problems^2^NURSC^7^50^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,3,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,4,0)
 ;;=1389^Health Maintenance, Alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,6,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,7,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,8,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,9,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,10,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,1,11,0)
 ;;=1919^Spiritual Distress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2280,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2281,0)
 ;;=perceived potential loss of personal possessions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2282,0)
 ;;=encourage discussion of 'here and now'^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2282,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2282,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2283,0)
 ;;=perceived potential loss of physiopsychosocial well-being^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2284,0)
 ;;=perceived potential loss of S/O^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2285,0)
 ;;=encourage verbalization of feelings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2285,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2285,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2286,0)
 ;;=give positive reinforcement^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2286,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2286,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2287,0)
 ;;=discusses three feelings about potential loss^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2287,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2287,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2288,0)
 ;;=identifies three successful coping methods^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2288,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2288,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2289,0)
 ;;=attends to own ADL^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2289,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2289,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2290,0)
 ;;=assess for dysfunctional grieving^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2290,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2290,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2291,0)
 ;;=involve the patient in activities/interactions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2291,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2291,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2292,0)
 ;;=assist with grief process^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2292,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2292,10)
 ;;=D EN1^NURCCPU3
