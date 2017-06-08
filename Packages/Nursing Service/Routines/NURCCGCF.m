NURCCGCF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9732,1,2,0)
 ;;=9737^reported food intake under RDA^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9732,1,3,0)
 ;;=9738^reported/observed lack of food^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9732,1,4,0)
 ;;=9740^sore/inflammed bucal cavity^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9732,1,5,0)
 ;;=9741^lack of interest in food^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9732,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9735,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9737,0)
 ;;=reported food intake under RDA^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9738,0)
 ;;=reported/observed lack of food^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9740,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9741,0)
 ;;=lack of interest in food^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9745,0)
 ;;=[Extra Order]^3^NURSC^11^165^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9745,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9745,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9746,0)
 ;;=Related Problems^2^NURSC^7^113^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,1,0)
 ;;=78^communication, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,2,0)
 ;;=79^coping, family: potential for growth^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,3,0)
 ;;=80^family process, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,4,0)
 ;;=81^grieving^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,5,0)
 ;;=82^health maintenance, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,6,0)
 ;;=83^home management, maintenance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,7,0)
 ;;=84^parenting, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,8,0)
 ;;=85^sexual dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,9,0)
 ;;=86^sexual pattern, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,10,0)
 ;;=87^social interaction, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,11,0)
 ;;=88^social isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,1,12,0)
 ;;=89^spiritual distress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9746,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,9746,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,0)
 ;;=Defining Characteristics^2^NURSC^12^115^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,1,0)
 ;;=4285^client concerned about S/O's response to health problems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,2,0)
 ;;=4286^S/O preoccupied with personal reaction to client's illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,3,0)
 ;;=4295^S/O's lack of understanding illness affects assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,4,0)
 ;;=4305^S/O doting behavior affects client's autonomy/abilities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,5,0)
 ;;=4309^S/O is withdrawn from patient at time of need^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,6,0)
 ;;=4310^S/O attempts assistance with less than satisfactory results^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,7,0)
 ;;=4315^abandonment, desertion, intolerance or rejection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,8,0)
 ;;=4317^distortion of reality to client's illness ie., denial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,1,9,0)
 ;;=4318^S/O assumes clients signs of illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9759,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9769,0)
 ;;=Infection Potential^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9769,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9769,1,1,0)
 ;;=9770^Etiology/Related and/or Risk Factors^2^NURSC^133
 ;;^UTILITY("^GMRD(124.2,",$J,9769,1,2,0)
 ;;=9800^Goals/Expected Outcomes^2^NURSC^131
