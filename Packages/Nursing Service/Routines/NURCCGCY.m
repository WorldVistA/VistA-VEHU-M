NURCCGCY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,4,0)
 ;;=2309^lack of resolutions of previous grieving response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,5,0)
 ;;=2310^loss of personal possessions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,6,0)
 ;;=2312^loss of psycho-physiological well-being^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,7,0)
 ;;=2313^loss of significant others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10755,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,0)
 ;;=actual or perceived object loss (broadest sense) such as:^2^NURSC^^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,1,0)
 ;;=2300^people^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,2,0)
 ;;=2301^possessions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,3,0)
 ;;=2302^job status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,4,0)
 ;;=2303^home^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,5,0)
 ;;=2305^ideals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,1,6,0)
 ;;=2306^parts and processes of the body^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10757,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10769,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^144^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10769,1,0)
 ;;=^124.21PI^5^2
 ;;^UTILITY("^GMRD(124.2,",$J,10769,1,4,0)
 ;;=10773^demonstrates progression through the grieving process:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10769,1,5,0)
 ;;=10934^[Extra Goal]^3^NURSC^179
 ;;^UTILITY("^GMRD(124.2,",$J,10769,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,0)
 ;;=demonstrates progression through the grieving process:^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10773,1,1,0)
 ;;=15653^verbalization of feelings of loss motor/sensory functions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,1,2,0)
 ;;=15654^verbalization of effects of injury on life^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,1,3,0)
 ;;=15655^particpation in treatment plan and self-care activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,1,4,0)
 ;;=15656^utilization of available support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,1,5,0)
 ;;=15657^verbalization of integration of limitations into lifestyle^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10773,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10773,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10774,0)
 ;;=[Extra Goal]^3^NURSC^9^177^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10774,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10774,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10775,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^122^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,0)
 ;;=^124.21PI^12^8
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,3,0)
 ;;=10778^facilitate grieving by:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,5,0)
 ;;=10780^observe for signs of grieving^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,6,0)
 ;;=10781^assess family interactions^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,8,0)
 ;;=10783^encourage family participation in care^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,9,0)
 ;;=199^assess support system^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,10,0)
 ;;=10785^encourage questions^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,11,0)
 ;;=11277^[Extra Order]^3^NURSC^185
 ;;^UTILITY("^GMRD(124.2,",$J,10775,1,12,0)
 ;;=15661^initiate referrals to:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10775,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10775,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10778,0)
 ;;=facilitate grieving by:^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10778,1,0)
 ;;=^124.21PI^3^3
