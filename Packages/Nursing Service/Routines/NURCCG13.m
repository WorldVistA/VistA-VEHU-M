NURCCG13 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,371,1,1,0)
 ;;=1316^Etiology/Related and/or Risk Factors^2^NURSC^35^0
 ;;^UTILITY("^GMRD(124.2,",$J,371,1,2,0)
 ;;=1317^Goals/Expected Outcomes^2^NURSC^34^0
 ;;^UTILITY("^GMRD(124.2,",$J,371,1,3,0)
 ;;=1318^Nursing Intervention/Orders^2^NURSC^31^0
 ;;^UTILITY("^GMRD(124.2,",$J,371,1,4,0)
 ;;=4152^Defining Characteristics^2^NURSC^23
 ;;^UTILITY("^GMRD(124.2,",$J,371,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,371,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,371,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,371,"TD",0)
 ;;=^^3^3^2890302^^
 ;;^UTILITY("^GMRD(124.2,",$J,371,"TD",1,0)
 ;;=A state in which an individual experiences a change in the amount of
 ;;^UTILITY("^GMRD(124.2,",$J,371,"TD",2,0)
 ;;=patterning of incoming stimuli accompanied by a diminished, exaggerated,
 ;;^UTILITY("^GMRD(124.2,",$J,371,"TD",3,0)
 ;;=distorted or impaired response to such stimuli.
 ;;^UTILITY("^GMRD(124.2,",$J,372,0)
 ;;=Sleep Pattern Disturbance^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,372,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,372,1,1,0)
 ;;=855^Etiology/Related and/or Risk Factors^2^NURSC^20^0
 ;;^UTILITY("^GMRD(124.2,",$J,372,1,2,0)
 ;;=857^Goals/Expected Outcomes^2^NURSC^19^0
 ;;^UTILITY("^GMRD(124.2,",$J,372,1,3,0)
 ;;=858^Nursing Intervention/Orders^2^NURSC^16^0
 ;;^UTILITY("^GMRD(124.2,",$J,372,1,4,0)
 ;;=856^Related Problems^2^NURSC^16^0
 ;;^UTILITY("^GMRD(124.2,",$J,372,1,5,0)
 ;;=4241^Defining Characteristics^2^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,372,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,372,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,372,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,372,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,372,"TD",1,0)
 ;;=Disruption of sleep time which causes patient discomfort or interferes 
 ;;^UTILITY("^GMRD(124.2,",$J,372,"TD",2,0)
 ;;=with the patient's desired life-style.
 ;;^UTILITY("^GMRD(124.2,",$J,373,0)
 ;;=toileting deficit interventions^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,0)
 ;;=^124.21PI^23^23
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,1,0)
 ;;=374^assess bowel history^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,2,0)
 ;;=375^determine a method for communicating the need for toileting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,3,0)
 ;;=376^maintain records to determine bowel patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,4,0)
 ;;=377^promote elimination by encouraging appropriate activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,5,0)
 ;;=378^allow sufficient time to toilet^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,6,0)
 ;;=379^avoid using indwelling and condom catheters^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,7,0)
 ;;=380^provide for safe, clear pathway to toilet area^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,8,0)
 ;;=381^provide for privacy as well as safety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,9,0)
 ;;=382^provide for continual practice at specified intervals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,10,0)
 ;;=383^provide for adaptive equipment as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,11,0)
 ;;=2716^assess bladder history^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,12,0)
 ;;=1279^call light within reach^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,13,0)
 ;;=2717^maintains records to determine bladder patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,14,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,15,0)
 ;;=3027^[Extra Order]^3^NURSC^113^0
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,16,0)
 ;;=15375^assess and utilize support systems [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,17,0)
 ;;=15372^assess function, routine, and amt. of assistance needed^3^NURSC^1^1
