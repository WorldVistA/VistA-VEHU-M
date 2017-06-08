NURCCG5Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2293,0)
 ;;=encourage interactions/activities with family^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2293,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2293,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2294,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^64^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,1,0)
 ;;=2298^absence of anticipatory grieving^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,2,0)
 ;;=2299^actual or perceived object loss (broadest sense) such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,3,0)
 ;;=2307^chronic fatal illness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,4,0)
 ;;=2309^lack of resolutions of previous grieving response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,5,0)
 ;;=2310^loss of personal possessions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,6,0)
 ;;=2312^loss of psycho-physiological well-being^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,1,7,0)
 ;;=2313^loss of significant others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2294,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2295,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^63^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2295,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2295,1,1,0)
 ;;=2318^expresses two feelings related to loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2295,1,2,0)
 ;;=2319^discusses two angry feelings related to loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2295,1,3,0)
 ;;=2320^discusses two guilty feelings related to loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2295,1,4,0)
 ;;=2321^works through stages of grief process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2295,1,5,0)
 ;;=2927^[Extra Goal]^3^NURSC^108^0
 ;;^UTILITY("^GMRD(124.2,",$J,2295,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2296,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^58^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,1,0)
 ;;=2322^develop a trusting relationship with the patient^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,2,0)
 ;;=2323^encourage patient to recall experiences^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,3,0)
 ;;=2324^positively reinforce expression of feelings related to loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,4,0)
 ;;=2325^assist to identify sources of anger^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,5,0)
 ;;=2326^monitor behaviors indicative of unresolved anger^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,6,0)
 ;;=2211^praise patient for use of physical exercise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,7,0)
 ;;=2327^help identify strengths^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,8,0)
 ;;=2330^provide chance to speak to others who cope with similar loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,9,0)
 ;;=2334^teach manifestations of unresolved anger^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,10,0)
 ;;=2335^teach healthy grieving process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,1,11,0)
 ;;=3014^[Extra Order]^3^NURSC^100^0
 ;;^UTILITY("^GMRD(124.2,",$J,2296,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2296,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2297,0)
 ;;=Related Problems^2^NURSC^7^51^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,3,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,4,0)
 ;;=1389^Health Maintenance, Alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2297,1,6,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
