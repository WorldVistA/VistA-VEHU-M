NURCCG9T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5158,1,3,0)
 ;;=11902^Nutrition, Alteration in:(Less Than Required)^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5158,1,4,0)
 ;;=12041^Infection Potential^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,5158,1,5,0)
 ;;=12165^[Extra Problem]^2^NURSC^28
 ;;^UTILITY("^GMRD(124.2,",$J,5159,0)
 ;;=Urinary Tract Infection^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5159,1,0)
 ;;=^124.21IP^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5159,1,1,0)
 ;;=13754^Urinary Elimination, Alteration In Pattern^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5159,1,2,0)
 ;;=13874^Pain, Acute^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,5159,1,3,0)
 ;;=13978^[Extra Problem]^2^NURSC^36
 ;;^UTILITY("^GMRD(124.2,",$J,5160,0)
 ;;=Transient Ischemic Attacks^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5160,1,0)
 ;;=^124.21IP^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5160,1,1,0)
 ;;=13164^Tissue Perfusion, Alteration In^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5160,1,2,0)
 ;;=13300^Communication Impaired^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5160,1,3,0)
 ;;=13391^[Extra Problem]^2^NURSC^33
 ;;^UTILITY("^GMRD(124.2,",$J,5161,0)
 ;;=Cellulitis^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5161,1,0)
 ;;=^124.21IP^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5161,1,1,0)
 ;;=11356^Tissue Perfusion, Alteration In^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5161,1,2,0)
 ;;=11436^Pain, Chronic^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5161,1,3,0)
 ;;=11552^Skin Integrity, Impaired ^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5161,1,4,0)
 ;;=11569^Mobility, Impaired Physical^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5161,1,5,0)
 ;;=11630^[Extra Problem]^2^NURSC^27
 ;;^UTILITY("^GMRD(124.2,",$J,5162,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^258^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,3,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,4,0)
 ;;=4722^attains,maintains resp rate,pattern & breath sounds WNL/pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,5,0)
 ;;=2694^hemodynamically stable^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,6,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,7,0)
 ;;=2713^no signs of respiratory alternans or paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,8,0)
 ;;=452^complies with treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5162,1,9,0)
 ;;=5172^[Extra Goal]^3^NURSC^263
 ;;^UTILITY("^GMRD(124.2,",$J,5162,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5163,0)
 ;;=Spinal Cord Injury (New Quadraplegia/Paraplegia)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,1,0)
 ;;=10427^Self-Care Deficit [Specify]^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,2,0)
 ;;=10680^Mobility, Impaired Physical^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,3,0)
 ;;=10754^Grieving, Dysfunctional^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,4,0)
 ;;=10805^Breathing Pattern, Ineffective^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,5,0)
 ;;=10898^[Extra Problem]^2^NURSC^25
 ;;^UTILITY("^GMRD(124.2,",$J,5163,1,6,0)
 ;;=15632^Dysreflexia, Potential For^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5164,0)
 ;;=Pulmonary Edema^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5164,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5164,1,1,0)
 ;;=15734^Airway Clearance, Ineffective^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,5164,1,2,0)
 ;;=15735^Breathing Pattern, Ineffective^2^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,5164,1,3,0)
 ;;=15736^[Extra Problem]^2^NURSC^45
 ;;^UTILITY("^GMRD(124.2,",$J,5165,0)
 ;;=Amputation (Rehabilitation)^2^NURSC^8^1^1^^T
