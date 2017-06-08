NURCCGDT ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,4,0)
 ;;=12126^inadequate primary defenses:^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,5,0)
 ;;=12134^inadequate secondary defenses:^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,6,0)
 ;;=482^malnutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,7,0)
 ;;=483^medical procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,10,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,11,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,12,0)
 ;;=486^oxygen flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,13,0)
 ;;=487^mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,14,0)
 ;;=488^impaired cough mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,15,0)
 ;;=2428^bypassing normal body defenses by suctioning, intubation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,16,0)
 ;;=489^use of antibiotics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12114,1,17,0)
 ;;=12149^inability to breathe deeply^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,12114,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,0)
 ;;=inadequate primary defenses:^2^NURSC^^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,1,0)
 ;;=538^broken skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,2,0)
 ;;=539^traumatized tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,3,0)
 ;;=540^decrease of ciliary action^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,4,0)
 ;;=541^stasis of body fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,5,0)
 ;;=542^change in pH secretions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,1,6,0)
 ;;=543^altered peristalsis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12126,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,12126,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12127,0)
 ;;=[Extra Order]^3^NURSC^11^195^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12127,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12127,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12134,0)
 ;;=inadequate secondary defenses:^2^NURSC^^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12134,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12134,1,1,0)
 ;;=545^decreased hemoglobin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12134,1,2,0)
 ;;=546^leukopenia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12134,1,3,0)
 ;;=547^suppressed inflammatory response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12134,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,12134,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12149,0)
 ;;=inability to breathe deeply^2^NURSC^^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12149,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12149,1,1,0)
 ;;=2430^weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12149,1,2,0)
 ;;=2431^chest pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12149,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12149,5)
 ;;=due to:
 ;;^UTILITY("^GMRD(124.2,",$J,12149,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12153,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^162^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12153,1,0)
 ;;=^124.21PI^9^3
 ;;^UTILITY("^GMRD(124.2,",$J,12153,1,2,0)
 ;;=12155^verbalizes knowledge of transmission/spread of infection^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,12153,1,8,0)
 ;;=12451^[Extra Goal]^3^NURSC^200
 ;;^UTILITY("^GMRD(124.2,",$J,12153,1,9,0)
 ;;=1169^remains free of S/S of infection^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12153,7)
 ;;=D EN4^NURCCPU1
