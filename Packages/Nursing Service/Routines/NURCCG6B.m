NURCCG6B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2577,0)
 ;;=provide financial resource contact for food purchase^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2577,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2577,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2578,0)
 ;;=initiate consult(s)^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2578,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2578,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2578,1,2,0)
 ;;=2579^Social Work Service^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2578,1,3,0)
 ;;=2580^VNA^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2578,1,4,0)
 ;;=1928^Occupational Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2578,5)
 ;;=to:
 ;;^UTILITY("^GMRD(124.2,",$J,2578,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2578,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2578,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2579,0)
 ;;=Social Work Service^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2580,0)
 ;;=VNA^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2581,0)
 ;;=teach suppression of vomiting reflex^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2581,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2581,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2582,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^69^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2582,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2582,1,1,0)
 ;;=2583^excessive intake in relation to metabolic needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2582,1,2,0)
 ;;=2584^dysfunctional psychologic conditioning related to food^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2582,1,3,0)
 ;;=2585^hereditary disposition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2582,1,4,0)
 ;;=2586^frequent closely spaced pregnancies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2582,1,5,0)
 ;;=2587^socioeconomic factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2582,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2583,0)
 ;;=excessive intake in relation to metabolic needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2584,0)
 ;;=dysfunctional psychologic conditioning related to food^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2585,0)
 ;;=hereditary disposition^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2586,0)
 ;;=frequent closely spaced pregnancies^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2587,0)
 ;;=socioeconomic factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2588,0)
 ;;=Related Problems^2^NURSC^7^57^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2588,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2588,1,1,0)
 ;;=2548^Appetite, Altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2588,1,2,0)
 ;;=1987^Depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2588,1,3,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2588,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2588,1,5,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2588,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,2588,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2589,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^69^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,1,0)
 ;;=2590^maintains metabolic needs that meet metabolic requirments^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,2,0)
 ;;=2593^decreases food intake while increasing/maintaining activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,3,0)
 ;;=2594^expresses eating patterns that contribute to weight gain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,4,0)
 ;;=2595^describes activity level in relation to weight^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2589,1,5,0)
 ;;=2596^selects menu within dietary restrictions^3^NURSC^2^0
