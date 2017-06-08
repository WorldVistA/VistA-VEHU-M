NURCCG0X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,347,"TD",0)
 ;;=^^2^2^2890313^^
 ;;^UTILITY("^GMRD(124.2,",$J,347,"TD",1,0)
 ;;=An individual perceives or experiences a change in appetite which is
 ;;^UTILITY("^GMRD(124.2,",$J,347,"TD",2,0)
 ;;=viewed as having a negative effect on their nutritional status.
 ;;^UTILITY("^GMRD(124.2,",$J,348,0)
 ;;=Nutrition, Alteration in:(Less Than Required)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,348,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,348,1,1,0)
 ;;=2543^Etiology/Related and/or Risk Factors^2^NURSC^68^0
 ;;^UTILITY("^GMRD(124.2,",$J,348,1,2,0)
 ;;=2547^Related Problems^2^NURSC^56^0
 ;;^UTILITY("^GMRD(124.2,",$J,348,1,3,0)
 ;;=2550^Goals/Expected Outcomes^2^NURSC^68^0
 ;;^UTILITY("^GMRD(124.2,",$J,348,1,4,0)
 ;;=2564^Nursing Intervention/Orders^2^NURSC^63^0
 ;;^UTILITY("^GMRD(124.2,",$J,348,1,5,0)
 ;;=5373^Defining Characteristics^2^NURSC^66
 ;;^UTILITY("^GMRD(124.2,",$J,348,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,348,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,348,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,348,"TD",0)
 ;;=^^2^2^2910821^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,348,"TD",1,0)
 ;;=The state in which an individual experiences an intake of nutrients
 ;;^UTILITY("^GMRD(124.2,",$J,348,"TD",2,0)
 ;;=insufficient to meet metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,349,0)
 ;;=Nutrition, Alteration in:(More Than Required)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,349,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,349,1,1,0)
 ;;=2582^Etiology/Related and/or Risk Factors^2^NURSC^69^0
 ;;^UTILITY("^GMRD(124.2,",$J,349,1,2,0)
 ;;=2588^Related Problems^2^NURSC^57^0
 ;;^UTILITY("^GMRD(124.2,",$J,349,1,3,0)
 ;;=2589^Goals/Expected Outcomes^2^NURSC^69^0
 ;;^UTILITY("^GMRD(124.2,",$J,349,1,4,0)
 ;;=2598^Nursing Intervention/Orders^2^NURSC^64^0
 ;;^UTILITY("^GMRD(124.2,",$J,349,1,5,0)
 ;;=5392^Defining Characteristics^2^NURSC^67
 ;;^UTILITY("^GMRD(124.2,",$J,349,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,349,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,349,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,349,"TD",0)
 ;;=^^1^1^2890803^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,349,"TD",1,0)
 ;;=Excessive intake in relationship to metabolic needs.
 ;;^UTILITY("^GMRD(124.2,",$J,350,0)
 ;;=Swallowing, Impaired^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,350,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,350,1,1,0)
 ;;=2607^Etiology/Related and/or Risk Factors^2^NURSC^70^0
 ;;^UTILITY("^GMRD(124.2,",$J,350,1,2,0)
 ;;=2613^Related Problems^2^NURSC^58^0
 ;;^UTILITY("^GMRD(124.2,",$J,350,1,3,0)
 ;;=2614^Goals/Expected Outcomes^2^NURSC^70^0
 ;;^UTILITY("^GMRD(124.2,",$J,350,1,4,0)
 ;;=2619^Nursing Intervention/Orders^2^NURSC^65^0
 ;;^UTILITY("^GMRD(124.2,",$J,350,1,5,0)
 ;;=4237^Defining Characteristics^2^NURSC^39
 ;;^UTILITY("^GMRD(124.2,",$J,350,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,350,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,350,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,350,"TD",0)
 ;;=^^2^2^2890319^^^
 ;;^UTILITY("^GMRD(124.2,",$J,350,"TD",1,0)
 ;;=The state in which an individual has decreased ability to voluntarily
 ;;^UTILITY("^GMRD(124.2,",$J,350,"TD",2,0)
 ;;=pass fluids and/or solids from the mouth to the stomach.
 ;;^UTILITY("^GMRD(124.2,",$J,351,0)
 ;;=Constipation^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,351,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,351,1,1,0)
 ;;=884^Etiology/Related and/or Risk Factors^2^NURSC^21^0
 ;;^UTILITY("^GMRD(124.2,",$J,351,1,2,0)
 ;;=885^Goals/Expected Outcomes^2^NURSC^20^0
 ;;^UTILITY("^GMRD(124.2,",$J,351,1,3,0)
 ;;=886^Nursing Intervention/Orders^2^NURSC^17^0
 ;;^UTILITY("^GMRD(124.2,",$J,351,1,4,0)
 ;;=889^Related Problems^2^NURSC^17^0
 ;;^UTILITY("^GMRD(124.2,",$J,351,1,5,0)
 ;;=4224^Defining Characteristics^2^NURSC^37
