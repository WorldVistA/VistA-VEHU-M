NURCCG2K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,796,0)
 ;;=perceptual or cognitive^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,797,0)
 ;;=Related Problems^2^NURSC^7^13^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,797,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,797,1,1,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,797,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,797,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,798,0)
 ;;=medical protocols^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,799,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^18^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,1,0)
 ;;=803^intolerance to activity; decreased strength and endurance^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,2,0)
 ;;=804^musculoskeletal impairment^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,3,0)
 ;;=805^neuromuscular impairment^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,4,0)
 ;;=795^pain and discomfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,5,0)
 ;;=796^perceptual or cognitive^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,6,0)
 ;;=1038^reduced consciousness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,7,0)
 ;;=1039^perceptual impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,8,0)
 ;;=1040^psychological impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,9,0)
 ;;=1041^visual impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,10,0)
 ;;=1042^paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,11,0)
 ;;=1043^injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,12,0)
 ;;=1044^restrictive devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,13,0)
 ;;=1045^pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,14,0)
 ;;=1046^decrease strength and endurance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,15,0)
 ;;=1047^age^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,16,0)
 ;;=1048^nutritionally deprived^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,17,0)
 ;;=798^medical protocols^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,18,0)
 ;;=207^depression, severe anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,1,19,0)
 ;;=159^cognitive limitation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,799,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,800,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^17^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,800,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,800,1,1,0)
 ;;=806^free from injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,800,1,2,0)
 ;;=807^maintains ROM in all joints^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,800,1,3,0)
 ;;=808^maintains independent ambulation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,800,1,4,0)
 ;;=2882^[Extra Goal]^3^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,800,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,801,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^14^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,1,0)
 ;;=809^assess mobility, limitations q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,2,0)
 ;;=810^assess risks if mobile^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,3,0)
 ;;=811^protect from injury as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,4,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,5,0)
 ;;=812^prior to restraints, teach purpose^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,7,0)
 ;;=813^perimeter protection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,8,0)
 ;;=814^adjust environment as appropriate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,9,0)
 ;;=815^range of motion exercise as appropriate q[frequency]^3^NURSC^1^0
