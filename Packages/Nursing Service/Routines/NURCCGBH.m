NURCCGBH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7983,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7983,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8025,0)
 ;;=involve in 1:1 and groups discussing consequences use/abuse^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8025,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8025,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8043,0)
 ;;=Defining Characteristics^2^NURSC^12^98^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8043,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8043,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8043,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8043,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8043,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8043,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8043,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8044,0)
 ;;=Coping, Ineffective Individual^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8044,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8044,1,1,0)
 ;;=8046^Etiology/Related and/or Risk Factors^2^NURSC^112
 ;;^UTILITY("^GMRD(124.2,",$J,8044,1,2,0)
 ;;=8064^Goals/Expected Outcomes^2^NURSC^110
 ;;^UTILITY("^GMRD(124.2,",$J,8044,1,3,0)
 ;;=8076^Nursing Intervention/Orders^2^NURSC^94
 ;;^UTILITY("^GMRD(124.2,",$J,8044,1,4,0)
 ;;=8092^Related Problems^2^NURSC^95
 ;;^UTILITY("^GMRD(124.2,",$J,8044,1,5,0)
 ;;=8102^Defining Characteristics^2^NURSC^99
 ;;^UTILITY("^GMRD(124.2,",$J,8044,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8044,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8044,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8044,"TD",0)
 ;;=^^2^2^2890306^^^
 ;;^UTILITY("^GMRD(124.2,",$J,8044,"TD",1,0)
 ;;=Ineffective coping is the impairment of adaptive behaviors and problem
 ;;^UTILITY("^GMRD(124.2,",$J,8044,"TD",2,0)
 ;;=solving abilities of a person in meeting life's demands and roles.
 ;;^UTILITY("^GMRD(124.2,",$J,8046,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^112^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,0)
 ;;=^124.21PI^12^7
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,3,0)
 ;;=1844^inadequate support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,6,0)
 ;;=1848^multiple life changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,7,0)
 ;;=1849^personal vulnerability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,8,0)
 ;;=1850^poor nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,9,0)
 ;;=1851^situational crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,11,0)
 ;;=1853^unmet expectations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,1,12,0)
 ;;=1854^unrealistic perceptions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8046,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^110^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,1,0)
 ;;=1859^communicates [# of] feelings about present situation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,2,0)
 ;;=1861^identifies two factors contributing to ineffective coping^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,3,0)
 ;;=1862^identifies three alternative methods of managing stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,4,0)
 ;;=1863^identifies and develops plan to meet role expectations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,5,0)
 ;;=1864^establishes written routine to meet basic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,6,0)
 ;;=1865^expresses feeling of greater control over stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,7,0)
 ;;=8071^demonstrates problem solving skills such as:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8064,1,8,0)
 ;;=8142^[Extra Goal]^3^NURSC^228
