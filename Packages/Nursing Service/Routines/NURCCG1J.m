NURCCG1J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,532,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,532,1,1,0)
 ;;=728^Reconstructive Facial Surgery^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,532,1,2,0)
 ;;=729^Rhinoplasty^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,532,1,3,0)
 ;;=730^Septorhinoplasty^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,0)
 ;;=Psychosocial^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,1,0)
 ;;=720^Substance Abuse, Alcohol/Drug^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,2,0)
 ;;=721^Bipolar Disorder^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,3,0)
 ;;=722^Depressive Disorder^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,4,0)
 ;;=723^Paranoid Disorder^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,5,0)
 ;;=724^Post Traumatic Stress Disorder^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,6,0)
 ;;=725^Schizophrenia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,7,0)
 ;;=726^Somatoform Disorders^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,8,0)
 ;;=2761^Organic Mental Disorder^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,9,0)
 ;;=2762^Dissociative Disorders^2^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,10,0)
 ;;=2766^Borderline Personality Disorder^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,11,0)
 ;;=2767^Sexual Disorders^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,533,1,12,0)
 ;;=2768^Eating Disorders^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^13^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,1,0)
 ;;=477^chronic disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,3,0)
 ;;=93^inadequate support system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,4,0)
 ;;=537^inadequate primary defenses:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,5,0)
 ;;=544^inadequate secondary defenses:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,6,0)
 ;;=482^malnutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,7,0)
 ;;=483^medical procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,10,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,11,0)
 ;;=448^blood flow, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,12,0)
 ;;=486^oxygen flow, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,13,0)
 ;;=487^mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,14,0)
 ;;=488^impaired cough mechanism^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,15,0)
 ;;=2428^bypassing normal body defenses by suctioning, intubation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,16,0)
 ;;=489^use of antibiotics^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,1,17,0)
 ;;=2429^inability to breathe deeply^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,534,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,535,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^13^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,2,0)
 ;;=549^reduced risk of pulmonary infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,3,0)
 ;;=550^intact mucous membrane^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,4,0)
 ;;=551^optimal weight^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,5,0)
 ;;=552^optimal fluid balance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,6,0)
 ;;=553^patient demonstrates knowledge^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,535,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1^0
