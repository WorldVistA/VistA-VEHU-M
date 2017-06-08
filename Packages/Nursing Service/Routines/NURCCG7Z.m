NURCCG7Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4237,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4237,1,1,0)
 ;;=4240^minor evidence of aspiration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4237,1,2,0)
 ;;=4245^stasis of food in oral cavity, coughing/choking^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4237,1,3,0)
 ;;=4288^reported difficulty in swallowing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4237,1,4,0)
 ;;=4289^weakness of muscles required for swallowing or mastication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4237,1,5,0)
 ;;=4290^absent gag reflex^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4237,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4238,0)
 ;;=alteration in nutritional state (obesity, emaciation, etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4240,0)
 ;;=minor evidence of aspiration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4241,0)
 ;;=Defining Characteristics^2^NURSC^12^40^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,1,0)
 ;;=4243^increased irritability, restlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,2,0)
 ;;=2464^interrupted sleep^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,3,0)
 ;;=4246^verbal complaints of difficulty in falling asleep^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,4,0)
 ;;=4247^not feeling well rested^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,5,0)
 ;;=2460^dark circles under the eyes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,1,7,0)
 ;;=2461^frequent yawning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4241,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,0)
 ;;=Defining Characteristics^2^NURSC^12^41^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,1,0)
 ;;=4285^client concerned about S/O's response to health problems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,2,0)
 ;;=4286^S/O preoccupied with personal reaction to client's illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,3,0)
 ;;=4295^S/O's lack of understanding illness affects assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,4,0)
 ;;=4305^S/O doting behavior affects client's autonomy/abilities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,5,0)
 ;;=4309^S/O is withdrawn from patient at time of need^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,6,0)
 ;;=4310^S/O attempts assistance with less than satisfactory results^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,7,0)
 ;;=4315^abandonment, desertion, intolerance or rejection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,8,0)
 ;;=4317^distortion of reality to client's illness ie., denial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,1,9,0)
 ;;=4318^S/O assumes clients signs of illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4242,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4243,0)
 ;;=increased irritability, restlessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4245,0)
 ;;=stasis of food in oral cavity, coughing/choking^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4246,0)
 ;;=verbal complaints of difficulty in falling asleep^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4247,0)
 ;;=not feeling well rested^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4250,0)
 ;;=Defining Characteristics^2^NURSC^12^42^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4250,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4250,1,1,0)
 ;;=4251^verbalized/observed discomfort in social situations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4250,1,2,0)
 ;;=4252^inability to receive/communicate a sense of belonging^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4250,1,3,0)
 ;;=4254^dysfunctional interaction with peers, family and/or others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4250,1,4,0)
 ;;=4255^family reported a change of style or pattern of interaction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4250,1,5,0)
 ;;=4256^observed use of unsuccessful socialization behaviors^3^NURSC^1
