NURCCGDL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,3,0)
 ;;=1383^Activity Intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,4,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,5,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,7,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,8,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,1,9,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11743,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11787,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11787,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11787,1,1,0)
 ;;=11790^Etiology/Related and/or Risk Factors^2^NURSC^160
 ;;^UTILITY("^GMRD(124.2,",$J,11787,1,2,0)
 ;;=11828^Goals/Expected Outcomes^2^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,11787,1,3,0)
 ;;=11840^Nursing Intervention/Orders^2^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,11787,1,4,0)
 ;;=11875^Related Problems^2^NURSC^139
 ;;^UTILITY("^GMRD(124.2,",$J,11787,1,5,0)
 ;;=11882^Defining Characteristics^2^NURSC^139
 ;;^UTILITY("^GMRD(124.2,",$J,11787,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11787,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11787,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11787,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,11787,"TD",1,0)
 ;;=A state in which the individual experiences a limitation of ability
 ;;^UTILITY("^GMRD(124.2,",$J,11787,"TD",2,0)
 ;;=for independent physical movement.
 ;;^UTILITY("^GMRD(124.2,",$J,11790,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^160^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,1,0)
 ;;=803^intolerance to activity; decreased strength and endurance^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,2,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,4,0)
 ;;=795^pain and discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,5,0)
 ;;=796^perceptual or cognitive^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,6,0)
 ;;=1038^reduced consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,7,0)
 ;;=1039^perceptual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,8,0)
 ;;=1040^psychological impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,9,0)
 ;;=1041^visual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,10,0)
 ;;=1042^paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,11,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,12,0)
 ;;=1044^restrictive devices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,13,0)
 ;;=1045^pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,14,0)
 ;;=1046^decrease strength and endurance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,15,0)
 ;;=1047^age^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,16,0)
 ;;=1048^nutritionally deprived^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,17,0)
 ;;=798^medical protocols^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,18,0)
 ;;=207^depression, severe anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,1,19,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11790,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11828,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^158^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,11828,1,1,0)
 ;;=806^free from injury^3^NURSC^1
