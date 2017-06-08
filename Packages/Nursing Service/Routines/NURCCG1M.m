NURCCG1M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,4,0)
 ;;=566^no emergency resuscitation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,5,0)
 ;;=567^divorce^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,6,0)
 ;;=568^blood transfusions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,7,0)
 ;;=569^death or illness of significant other^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,8,0)
 ;;=570^hospital barriers to practicing spiritual rituals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,9,0)
 ;;=571^isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,10,0)
 ;;=572^ICU restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,11,0)
 ;;=573^surgery^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,12,0)
 ;;=459^medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,13,0)
 ;;=574^as a response^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,14,0)
 ;;=640^other [ ADDITIONAL TEXT ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,560,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^14^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,1,0)
 ;;=578^achieves personal/spiritual goals of [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,2,0)
 ;;=579^expresses satisfaction about his relationship-God/Diety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,3,0)
 ;;=580^continues spiritual practices not detrimental to health^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,4,0)
 ;;=581^expresses decreased feelings of guilt and fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,5,0)
 ;;=582^verbalizes feeling supported in health care decisions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,6,0)
 ;;=1438^verbalizes sense of hope for future^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,7,0)
 ;;=2720^related problems [specify] will be treated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,1,8,0)
 ;;=2879^[Extra Goal]^3^NURSC^56^0
 ;;^UTILITY("^GMRD(124.2,",$J,560,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,561,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,1,0)
 ;;=583^assess causative, contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,2,0)
 ;;=584^assess pt's beliefs, involvement, and spiritual practices^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,3,0)
 ;;=585^note expression of inability to find reason for living^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,4,0)
 ;;=586^assist patient/family to deal with feelings:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,5,0)
 ;;=587^help patient find reason for living^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,6,0)
 ;;=588^help patient find meaning in illness/suffering^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,7,0)
 ;;=589^assist to develope coping skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,8,0)
 ;;=590^assist patient to identify his strengths and support systems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,9,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,1,10,0)
 ;;=2966^[Extra Order]^3^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,561,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,561,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,562,0)
 ;;=Related Problems^2^NURSC^7^11^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,562,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,562,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,562,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,563,0)
 ;;=challenged belief value system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,564,0)
 ;;=beliefs opposed by family, peers, health care providers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,565,0)
 ;;=conflicts to belief system^3^NURSC^^1^^^T
