NURCCGDF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11569,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11569,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11569,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11569,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,11569,"TD",1,0)
 ;;=A state in which the individual experiences a limitation of ability
 ;;^UTILITY("^GMRD(124.2,",$J,11569,"TD",2,0)
 ;;=for independent physical movement.
 ;;^UTILITY("^GMRD(124.2,",$J,11570,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^156^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,1,0)
 ;;=803^intolerance to activity; decreased strength and endurance^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,2,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,4,0)
 ;;=795^pain and discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,5,0)
 ;;=796^perceptual or cognitive^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,6,0)
 ;;=1038^reduced consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,7,0)
 ;;=1039^perceptual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,8,0)
 ;;=1040^psychological impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,9,0)
 ;;=1041^visual impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,10,0)
 ;;=1042^paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,11,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,12,0)
 ;;=1044^restrictive devices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,13,0)
 ;;=1045^pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,14,0)
 ;;=1046^decrease strength and endurance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,15,0)
 ;;=1047^age^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,16,0)
 ;;=1048^nutritionally deprived^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,17,0)
 ;;=798^medical protocols^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,18,0)
 ;;=207^depression, severe anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,1,19,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11570,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11590,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^154^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11590,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11590,1,1,0)
 ;;=10702^avoids complications of immobility^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11590,1,2,0)
 ;;=11592^demonstrates correct use of assistive devices [specify]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11590,1,3,0)
 ;;=11593^demonstrates measures to maintain/improve circulation^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11590,1,4,0)
 ;;=11732^[Extra Goal]^3^NURSC^188
 ;;^UTILITY("^GMRD(124.2,",$J,11590,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11592,0)
 ;;=demonstrates correct use of assistive devices [specify]^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11592,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11592,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11593,0)
 ;;=demonstrates measures to maintain/improve circulation^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11593,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11593,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11594,0)
 ;;=[Extra Goal]^3^NURSC^9^186^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11594,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11594,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11595,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^128^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11595,1,0)
 ;;=^124.21PI^15^5
 ;;^UTILITY("^GMRD(124.2,",$J,11595,1,9,0)
 ;;=11604^assess tissue tolerance^3^NURSC^4
