NURCCG86 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,44,0)
 ;;=5154^Cerebrovascular Accident (Right Hemiplegia/Paresis)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,45,0)
 ;;=5158^Pressure Ulcer^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,46,0)
 ;;=5159^Urinary Tract Infection^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,47,0)
 ;;=5160^Transient Ischemic Attacks^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,48,0)
 ;;=5161^Cellulitis^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,49,0)
 ;;=5163^Spinal Cord Injury (New Quadraplegia/Paraplegia)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,50,0)
 ;;=5164^Pulmonary Edema^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,51,0)
 ;;=5165^Amputation (Rehabilitation)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,52,0)
 ;;=5166^Traumatic Brain Injury^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,53,0)
 ;;=15770^Generic Discharge Care Plan^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,54,0)
 ;;=15942^Spinal Headache^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4351,0)
 ;;=Pulmonary Embolus^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4351,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,4351,1,3,0)
 ;;=4378^Pain, Chest^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4351,1,4,0)
 ;;=4451^Breathing Pattern, Ineffective^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,4351,1,5,0)
 ;;=4470^Gas Exchange, Impaired^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4351,1,6,0)
 ;;=4485^[Extra Problem]^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,4353,0)
 ;;=anxiety/threat of death^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4354,0)
 ;;=Acute Myocardial Infarction^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4354,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4354,1,2,0)
 ;;=4359^Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4354,1,3,0)
 ;;=4377^Pain, Chest^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4354,1,4,0)
 ;;=4536^[Extra Problem]^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4355,0)
 ;;=Congestive Heart Failure^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4355,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,4355,1,1,0)
 ;;=4363^Decreased Cardiac Output, Electrical/Mechanical^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4355,1,3,0)
 ;;=4574^Fluid Volume, Excess^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4355,1,5,0)
 ;;=4630^Gas Exchange, Impaired^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,4355,1,6,0)
 ;;=4652^[Extra Problem]^2^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,4359,0)
 ;;=Cardiac Output, Decreased (Electrical/Mechanical)^2^NURSC^2^1^1^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,4359,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4359,1,1,0)
 ;;=4361^Etiology/Related and/or Risk Factors^2^NURSC^202
 ;;^UTILITY("^GMRD(124.2,",$J,4359,1,2,0)
 ;;=4373^Goals/Expected Outcomes^2^NURSC^199
 ;;^UTILITY("^GMRD(124.2,",$J,4359,1,4,0)
 ;;=4997^Nursing Intervention/Orders^2^NURSC^249
 ;;^UTILITY("^GMRD(124.2,",$J,4359,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4359,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4359,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4360,0)
 ;;=Cirrhosis^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4360,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,4360,1,3,0)
 ;;=4379^Nutrition, Alteration in:(Less Than Required) ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4360,1,4,0)
 ;;=4389^Fluid Volume, Altered: Excess^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4360,1,5,0)
 ;;=4398^Breathing Pattern, Ineffective^2^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,4360,1,6,0)
 ;;=4406^[Extra Problem]^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^202^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,1,0)
 ;;=4366^disturbance in impulse formation/conduction^3^NURSC^1
