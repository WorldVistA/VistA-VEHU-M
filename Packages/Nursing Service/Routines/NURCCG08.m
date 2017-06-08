NURCCG08 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,63,0)
 ;;=assist family to develop plan to cope with stressors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,63,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,63,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,64,0)
 ;;=teach effective coping skills^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,64,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,64,1,1,0)
 ;;=65^problem solving/decision making^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,64,1,2,0)
 ;;=66^assertiveness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,64,1,3,0)
 ;;=67^help-seeking^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,64,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,64,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,64,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,65,0)
 ;;=problem solving/decision making^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,66,0)
 ;;=assertiveness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,67,0)
 ;;=help-seeking^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,68,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,1,0)
 ;;=91^disease or injury of individual/family member^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,2,0)
 ;;=110^impaired cognitive functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,3,0)
 ;;=93^inadequate support system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,4,0)
 ;;=94^insufficient family planning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,5,0)
 ;;=95^insufficient finances^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,6,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,7,0)
 ;;=96^lack of role modeling^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,8,0)
 ;;=97^unfamiliarity with neighborhood resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,9,0)
 ;;=98^substance abuse^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,1,10,0)
 ;;=99^role fatigue of care giver^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,68,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,69,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,69,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,69,1,1,0)
 ;;=102^identifies factors restricting self-care and home management^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,69,1,2,0)
 ;;=103^demonstrates skills for home maintenance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,69,1,3,0)
 ;;=104^expresses satisfaction with the home situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,69,1,4,0)
 ;;=2869^[Extra Goal]^3^NURSC^44^0
 ;;^UTILITY("^GMRD(124.2,",$J,69,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,70,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,70,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,70,1,1,0)
 ;;=105^assess causative/contributing factors^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,70,1,2,0)
 ;;=106^reduce or eliminate causative/contributing factors^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,70,1,3,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,70,1,4,0)
 ;;=2956^[Extra Order]^3^NURSC^28^0
 ;;^UTILITY("^GMRD(124.2,",$J,70,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,70,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,71,0)
 ;;=client providing little support for SO^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,72,0)
 ;;=inadequate/incorrect information/understanding by a SO^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,73,0)
 ;;=prolonged disease/disability exhausting SO^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,74,0)
 ;;=situational/developmental crises the SO may be facing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,75,0)
 ;;=SO is unable to perceive/act effectively to client's needs^3^NURSC^^1^^^T
