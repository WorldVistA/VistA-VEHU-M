NURCCG82 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,5,0)
 ;;=2062^low self-esteem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,6,0)
 ;;=4283^physical problems (infections, malnutrition, etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,7,0)
 ;;=4278^poor self insight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,8,0)
 ;;=4287^interpersonal difficulties^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4285,0)
 ;;=client concerned about S/O's response to health problems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4286,0)
 ;;=S/O preoccupied with personal reaction to client's illness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4287,0)
 ;;=interpersonal difficulties^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4288,0)
 ;;=reported difficulty in swallowing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4289,0)
 ;;=weakness of muscles required for swallowing or mastication^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4290,0)
 ;;=absent gag reflex^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4291,0)
 ;;=Defining Characteristics^2^NURSC^12^50^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,0)
 ;;=^124.21PI^8^7
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,1,0)
 ;;=4292^decreased ability to make decisions, problem solve, reason^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,3,0)
 ;;=4294^memory deficit or problems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,4,0)
 ;;=4296^decreased ability to abstract or conceptualize, calculate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,5,0)
 ;;=4297^delusions, ideas of reference, hallucinations, confabulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,6,0)
 ;;=4298^inappropriate affect^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,7,0)
 ;;=4299^disorientation to time, place, person, circumstances, events^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4291,1,8,0)
 ;;=4300^inaccurate interpretation of environment^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4291,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4292,0)
 ;;=decreased ability to make decisions, problem solve, reason^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4294,0)
 ;;=memory deficit or problems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4295,0)
 ;;=S/O's lack of understanding illness affects assistance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4296,0)
 ;;=decreased ability to abstract or conceptualize, calculate^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4297,0)
 ;;=delusions, ideas of reference, hallucinations, confabulation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4298,0)
 ;;=inappropriate affect^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4299,0)
 ;;=disorientation to time, place, person, circumstances, events^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4300,0)
 ;;=inaccurate interpretation of environment^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4302,0)
 ;;=Defining Characteristics^2^NURSC^12^51^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4302,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4302,1,1,0)
 ;;=4303^damaged or destroyed tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4302,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4303,0)
 ;;=damaged or destroyed tissue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4304,0)
 ;;=Defining Characteristics^2^NURSC^12^52^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,1,0)
 ;;=4306^claudication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,2,0)
 ;;=4307^diminished arterial pulsation, BP changes in extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,4,0)
 ;;=4311^skin of extremity blue or purple when dependent^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,5,0)
 ;;=4312^leg becomes pale on elevation and remains pale when lowered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,6,0)
 ;;=4313^skin quality shining and without hair^3^NURSC^1
