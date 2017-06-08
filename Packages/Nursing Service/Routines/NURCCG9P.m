NURCCG9P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5108,1,0)
 ;;=^124.21IP^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,5108,1,3,0)
 ;;=6902^Knowledge Deficit [specify]^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5108,1,4,0)
 ;;=6948^Tissue Integrity, Impaired^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5108,1,5,0)
 ;;=7010^[Extra Problem]^2^NURSC^17
 ;;^UTILITY("^GMRD(124.2,",$J,5108,1,6,0)
 ;;=8131^Injury Potential^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5108,1,7,0)
 ;;=8276^Infection Potential^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5109,0)
 ;;=Gastrointestinal Hemorrhage (G.I. Bleed)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5109,1,0)
 ;;=^124.21IP^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,5109,1,1,0)
 ;;=6539^Fluid Volume Deficit (Actual)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5109,1,2,0)
 ;;=6621^Tissue Perfusion, Alteration in^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5109,1,3,0)
 ;;=6633^Anxiety^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5109,1,5,0)
 ;;=6766^[Extra Problem]^2^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,5109,1,6,0)
 ;;=344^Knowledge Deficit^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5110,0)
 ;;=Hernia Repair^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5110,1,0)
 ;;=^124.21IP^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5110,1,1,0)
 ;;=6352^Skin Integrity, Impairment Of (Actual)^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5110,1,2,0)
 ;;=6418^Knowledge Deficit [specify]^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5110,1,3,0)
 ;;=6463^Pain, Acute^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5110,1,4,0)
 ;;=6526^[Extra Problem]^2^NURSC^50
 ;;^UTILITY("^GMRD(124.2,",$J,5111,0)
 ;;=[Extra Order]^3^NURSC^11^230^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5111,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5111,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5112,0)
 ;;=Cholecystectomy ^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5112,1,0)
 ;;=^124.21IP^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5112,1,1,0)
 ;;=6073^Breathing Pattern, Ineffective^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5112,1,2,0)
 ;;=6165^Skin Integrity, Impairment Of (Actual)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5112,1,3,0)
 ;;=6231^Knowledge Deficit [specify]^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5112,1,4,0)
 ;;=6276^Pain, Acute^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5112,1,5,0)
 ;;=6339^[Extra Problem]^2^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,5113,0)
 ;;=Hepatitis^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5113,1,0)
 ;;=^124.21IP^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5113,1,1,0)
 ;;=5886^Activity Intolerance^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5113,1,2,0)
 ;;=5966^Nutrition, Alteration in:(Less Than Required)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5113,1,3,0)
 ;;=6023^Fluid Volume Deficit (Potential)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5113,1,4,0)
 ;;=6060^[Extra Problem]^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,5114,0)
 ;;=Cerebrovascular Accident (Left Hemiplegia/Paresis)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5114,1,0)
 ;;=^124.21IP^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,5114,1,3,0)
 ;;=5825^Mobility, Impaired Physical^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5114,1,4,0)
 ;;=5953^[Extra Problem]^2^NURSC^49
 ;;^UTILITY("^GMRD(124.2,",$J,5114,1,5,0)
 ;;=12488^Sensory-Perceptual, Alteration In^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5114,1,6,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5115,0)
 ;;=Abdominal Aortic Aneurysm Repair^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,0)
 ;;=^124.21IP^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,1,0)
 ;;=7632^Pain, Acute^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,2,0)
 ;;=7804^Fluid Volume (Deficit/Excess)^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,3,0)
 ;;=7885^Tissue Integrity, Impaired^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,5115,1,4,0)
 ;;=7956^Breathing Pattern, Ineffective^2^NURSC^3
