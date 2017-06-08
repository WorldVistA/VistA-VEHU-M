NURCCG8U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4699,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4700,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^218^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4700,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4700,1,1,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4700,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4701,0)
 ;;=[Extra Goal]^3^NURSC^9^16^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4701,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4701,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^223^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,0)
 ;;=^124.21PI^12^9
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,1,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,4,0)
 ;;=9245^vital signs WNL or returns to baseline^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,6,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,7,0)
 ;;=4722^attains,maintains resp rate,pattern & breath sounds WNL/pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,8,0)
 ;;=4725^normal respiratory rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,9,0)
 ;;=2694^hemodynamically stable^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,10,0)
 ;;=4736^attains,maintains patency of airway^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,11,0)
 ;;=4864^[Extra Goal]^3^NURSC^21
 ;;^UTILITY("^GMRD(124.2,",$J,4702,1,12,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4702,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4703,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^219^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4703,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4703,1,1,0)
 ;;=506^electrophysiological disturbances in impulse formation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4703,1,2,0)
 ;;=507^electrophysiological disturbances in cardiac conduction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4703,1,3,0)
 ;;=4368^alteration in preload/afterload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4703,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^223^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,1,0)
 ;;=4707^restrict Na intake to [ ]mg per day^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,2,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,3,0)
 ;;=4709^initiates consults to [specify] service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,4,0)
 ;;=2524^assess dietary habits^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,5,0)
 ;;=4712^monitor electrolytes as available^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,6,0)
 ;;=4713^implement health teaching protocol^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4705,1,7,0)
 ;;=4823^[Extra Order]^3^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,4705,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4705,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4706,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^224^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4706,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4706,1,1,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4706,1,2,0)
 ;;=1458^myocardial oxygen demand is minimized^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4706,1,3,0)
 ;;=4708^maintains baseline sinus rhythm^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4706,1,4,0)
 ;;=4711^[Extra Goal]^3^NURSC^119
 ;;^UTILITY("^GMRD(124.2,",$J,4706,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4707,0)
 ;;=restrict Na intake to [ ]mg per day^3^NURSC^11^1^^^T
