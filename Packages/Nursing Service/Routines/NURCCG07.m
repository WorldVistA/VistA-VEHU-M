NURCCG07 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,54,1,2,0)
 ;;=233^feeding deficit interventions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,54,1,3,0)
 ;;=234^bathing/hygiene deficit interventions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,54,1,4,0)
 ;;=235^dressing/grooming deficit interventions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,54,1,5,0)
 ;;=373^toileting deficit interventions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,54,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,55,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,1,0)
 ;;=71^client providing little support for SO^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,2,0)
 ;;=72^inadequate/incorrect information/understanding by a SO^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,3,0)
 ;;=73^prolonged disease/disability exhausting SO^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,4,0)
 ;;=74^situational/developmental crises the SO may be facing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,5,0)
 ;;=75^SO is unable to perceive/act effectively to client's needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,55,1,6,0)
 ;;=76^temporary family disorganization and role changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,55,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,56,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,56,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,56,1,1,0)
 ;;=58^demonstrates realistic responses to stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,56,1,2,0)
 ;;=60^effective problem solving^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,56,1,3,0)
 ;;=2491^effective decision making skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,56,1,4,0)
 ;;=59^effective client coping skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,56,1,5,0)
 ;;=2863^[Extra Goal]^3^NURSC^35^0
 ;;^UTILITY("^GMRD(124.2,",$J,56,5)
 ;;=family demonstrates
 ;;^UTILITY("^GMRD(124.2,",$J,56,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,57,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,1,0)
 ;;=61^assess family's coping response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,2,0)
 ;;=62^assist family to appraise stressors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,3,0)
 ;;=63^assist family to develop plan to cope with stressors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,4,0)
 ;;=64^teach effective coping skills^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,5,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,57,1,6,0)
 ;;=2955^[Extra Order]^3^NURSC^27^0
 ;;^UTILITY("^GMRD(124.2,",$J,57,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,57,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,58,0)
 ;;=demonstrates realistic responses to stress^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,58,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,58,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,59,0)
 ;;=effective client coping skills^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,59,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,59,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,60,0)
 ;;=effective problem solving^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,60,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,60,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,61,0)
 ;;=assess family's coping response^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,61,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,61,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,62,0)
 ;;=assist family to appraise stressors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,62,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,62,10)
 ;;=D EN1^NURCCPU3
