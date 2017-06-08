NURCCGFO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14672,1,3,0)
 ;;=14714^Nursing Intervention/Orders^2^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,14672,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14672,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14672,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14672,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,14672,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,14672,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,14673,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^195^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,1,0)
 ;;=477^chronic disease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,3,0)
 ;;=93^inadequate support system^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,4,0)
 ;;=14677^inadequate primary defenses:^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,5,0)
 ;;=14684^inadequate secondary defenses:^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,6,0)
 ;;=482^malnutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,7,0)
 ;;=483^medical procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,10,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,11,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,12,0)
 ;;=486^oxygen flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,13,0)
 ;;=487^mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,14,0)
 ;;=488^impaired cough mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,15,0)
 ;;=2428^bypassing normal body defenses by suctioning, intubation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,16,0)
 ;;=489^use of antibiotics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14673,1,17,0)
 ;;=14699^inability to breathe deeply^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,14673,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,0)
 ;;=inadequate primary defenses:^2^NURSC^^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,1,0)
 ;;=538^broken skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,2,0)
 ;;=539^traumatized tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,3,0)
 ;;=540^decrease of ciliary action^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,4,0)
 ;;=541^stasis of body fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,5,0)
 ;;=542^change in pH secretions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,1,6,0)
 ;;=543^altered peristalsis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14677,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,14677,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14684,0)
 ;;=inadequate secondary defenses:^2^NURSC^^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14684,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14684,1,1,0)
 ;;=545^decreased hemoglobin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14684,1,2,0)
 ;;=546^leukopenia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14684,1,3,0)
 ;;=547^suppressed inflammatory response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14684,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,14684,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14699,0)
 ;;=inability to breathe deeply^2^NURSC^^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14699,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14699,1,1,0)
 ;;=2430^weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14699,1,2,0)
 ;;=2431^chest pain^3^NURSC^1
