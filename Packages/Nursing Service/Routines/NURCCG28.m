NURCCG28 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,717,1,4,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,717,1,5,0)
 ;;=369^Knowledge Deficit for Cognitive-Sensory Problems^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,717,1,6,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,0)
 ;;=Spinal Cord Injury^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,0)
 ;;=^124.21PI^25^25
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,1,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,2,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,3,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,4,0)
 ;;=122^Airway Clearance, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,5,0)
 ;;=123^Breathing Pattern, Ineffective^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,6,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,7,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,8,0)
 ;;=353^Incontinence, Bowel^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,9,0)
 ;;=354^Incontinence, Urine^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,10,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,11,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,12,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,13,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,14,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,15,0)
 ;;=746^Depressive Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,16,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,17,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,18,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,19,0)
 ;;=366^Pain, Chronic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,20,0)
 ;;=344^Knowledge Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,21,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,22,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,23,0)
 ;;=744^Grieving, Dysfunctional^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,24,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,718,1,25,0)
 ;;=358^Urinary Retention^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,719,0)
 ;;=Syncope^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,719,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,719,1,1,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,719,1,2,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,719,1,3,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,719,1,4,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,0)
 ;;=Substance Abuse, Alcohol/Drug^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,1,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,2,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,3,0)
 ;;=748^Violence Potential, Directed At Others^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,4,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,5,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,6,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,7,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,8,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
