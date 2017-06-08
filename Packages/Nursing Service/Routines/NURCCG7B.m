NURCCG7B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3080,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3080,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3080,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3081,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^74^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,1,0)
 ;;=3082^support systems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,2,0)
 ;;=3083^previous experiences^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,3,0)
 ;;=3084^cognitive appraisal of event^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,4,0)
 ;;=3085^level of self-esteem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,5,0)
 ;;=3086^self-concept^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,6,0)
 ;;=3087^concurrent events^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,1,7,0)
 ;;=3088^nature, characteristics and demands of event^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3081,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3082,0)
 ;;=support systems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3083,0)
 ;;=previous experiences^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3084,0)
 ;;=cognitive appraisal of event^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3085,0)
 ;;=level of self-esteem^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3086,0)
 ;;=self-concept^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3087,0)
 ;;=concurrent events^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3088,0)
 ;;=nature, characteristics and demands of event^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3089,0)
 ;;=Related Problems^2^NURSC^7^62^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,1,0)
 ;;=3034^Adjustment Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,2,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,3,0)
 ;;=3090^Denial, Ineffective^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,4,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,5,0)
 ;;=2078^Hopelessness ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,6,0)
 ;;=3091^Self-esteem Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,1,7,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3089,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3090,0)
 ;;=Denial, Ineffective^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3091,0)
 ;;=Self-esteem Disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3092,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^67^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,1,0)
 ;;=3093^attainment of desired goal [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,2,0)
 ;;=3094^competency in management of situation [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,3,0)
 ;;=3095^maintenance of self-esteem^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,4,0)
 ;;=3096^realistic appraisal of event, demands, coping resources^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,5,0)
 ;;=3097^verbalization of a sense of personal integrity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,6,0)
 ;;=3098^Goals/Expected Outcomes^2^NURSC^74^1
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,7,0)
 ;;=3099^assess patient perception of stressful event^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,8,0)
 ;;=3100^acknowledge goal related achievements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,9,0)
 ;;=3101^assist to identify strategies for achieving goals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,10,0)
 ;;=3102^assist to identify desired goal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,11,0)
 ;;=3103^clarify misconceptions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3092,1,12,0)
 ;;=3104^confront ineffective behaviors^3^NURSC^1^0
