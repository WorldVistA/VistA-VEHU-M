NURCCG9S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5149,1,2,0)
 ;;=5186^Sleep Pattern, Disturbance^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5149,1,3,0)
 ;;=5339^[Extra Problem]^2^NURSC^48
 ;;^UTILITY("^GMRD(124.2,",$J,5150,0)
 ;;=[Extra Order]^3^NURSC^11^310^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5150,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5150,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5151,0)
 ;;=[Extra Order]^3^NURSC^11^311^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5151,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5151,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5152,0)
 ;;=Parkinsons Disease^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5152,1,0)
 ;;=^124.21IP^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5152,1,1,0)
 ;;=13578^Mobility, Impaired Physical^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,5152,1,2,0)
 ;;=13639^Communication Impaired^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5152,1,3,0)
 ;;=13684^[Extra Problem]^2^NURSC^34
 ;;^UTILITY("^GMRD(124.2,",$J,5153,0)
 ;;=Seizure Disorder^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5153,1,0)
 ;;=^124.21IP^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5153,1,1,0)
 ;;=12671^Airway Clearance, Ineffective^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5153,1,2,0)
 ;;=12824^Injury Potential^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5153,1,3,0)
 ;;=12896^Self Concept, Disturbance In^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5153,1,4,0)
 ;;=12970^Knowledge Deficit^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,5153,1,5,0)
 ;;=13059^[Extra Problem]^2^NURSC^32
 ;;^UTILITY("^GMRD(124.2,",$J,5154,0)
 ;;=Cerebrovascular Accident (Right Hemiplegia/Paresis)^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5154,1,0)
 ;;=^124.21IP^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,5154,1,1,0)
 ;;=12209^Self-Care Deficit [Specify]^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5154,1,2,0)
 ;;=12399^Mobility, Impaired Physical^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5154,1,4,0)
 ;;=12610^[Extra Problem]^2^NURSC^29
 ;;^UTILITY("^GMRD(124.2,",$J,5154,1,5,0)
 ;;=5781^Communication Impaired^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5155,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^15^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5155,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5155,1,1,0)
 ;;=5157^Etiology/Related and/or Risk Factors^2^NURSC^250
 ;;^UTILITY("^GMRD(124.2,",$J,5155,1,2,0)
 ;;=5162^Goals/Expected Outcomes^2^NURSC^258
 ;;^UTILITY("^GMRD(124.2,",$J,5155,1,3,0)
 ;;=5173^Nursing Intervention/Orders^2^NURSC^259
 ;;^UTILITY("^GMRD(124.2,",$J,5155,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5155,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5155,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5156,0)
 ;;=Defining Characteristics^2^NURSC^12^60^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5156,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5156,1,1,0)
 ;;=5175^Expectation of daily bowel movement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5156,1,2,0)
 ;;=5177^overuse of laxatives, enemas, suppositories^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5156,1,3,0)
 ;;=5179^expected passage of stool at same time daily^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5156,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5157,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^250^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5157,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,5157,1,1,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5157,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5158,0)
 ;;=Pressure Ulcer^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5158,1,0)
 ;;=^124.21IP^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5158,1,1,0)
 ;;=11643^Skin Integrity, Impairment Of (Actual)^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5158,1,2,0)
 ;;=11787^Mobility, Impaired Physical^2^NURSC^5
