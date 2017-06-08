NURCCGDR ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12042,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12042,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12043,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^163^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,1,0)
 ;;=477^chronic disease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,3,0)
 ;;=93^inadequate support system^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,4,0)
 ;;=12053^inadequate primary defenses:^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,5,0)
 ;;=12061^inadequate secondary defenses:^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,6,0)
 ;;=482^malnutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,7,0)
 ;;=483^medical procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,10,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,11,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,12,0)
 ;;=486^oxygen flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,13,0)
 ;;=487^mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,14,0)
 ;;=488^impaired cough mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,15,0)
 ;;=2428^bypassing normal body defenses by suctioning, intubation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,16,0)
 ;;=489^use of antibiotics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12043,1,17,0)
 ;;=12076^inability to breathe deeply^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,12043,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,0)
 ;;=Defining Characteristics^2^NURSC^12^141^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12044,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,0)
 ;;=inadequate primary defenses:^2^NURSC^^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,1,0)
 ;;=538^broken skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,2,0)
 ;;=539^traumatized tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,3,0)
 ;;=540^decrease of ciliary action^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,4,0)
 ;;=541^stasis of body fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,5,0)
 ;;=542^change in pH secretions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,1,6,0)
 ;;=543^altered peristalsis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12053,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,12053,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12061,0)
 ;;=inadequate secondary defenses:^2^NURSC^^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12061,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12061,1,1,0)
 ;;=545^decreased hemoglobin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12061,1,2,0)
 ;;=546^leukopenia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12061,1,3,0)
 ;;=547^suppressed inflammatory response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12061,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,12061,7)
 ;;=D EN4^NURCCPU1
