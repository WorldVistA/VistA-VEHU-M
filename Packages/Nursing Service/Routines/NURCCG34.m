NURCCG34 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1037,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1037,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1037,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1037,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1038,0)
 ;;=reduced consciousness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1039,0)
 ;;=perceptual impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1040,0)
 ;;=psychological impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1041,0)
 ;;=visual impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1042,0)
 ;;=paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1043,0)
 ;;=injury^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1044,0)
 ;;=restrictive devices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1045,0)
 ;;=pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1046,0)
 ;;=decrease strength and endurance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1047,0)
 ;;=age^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1048,0)
 ;;=nutritionally deprived^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1049,0)
 ;;=Injury, Potential For^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1049,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1049,1,1,0)
 ;;=1118^Etiology/Related and/or Risk Factors^2^NURSC^28^0
 ;;^UTILITY("^GMRD(124.2,",$J,1049,1,2,0)
 ;;=1298^Goals/Expected Outcomes^2^NURSC^31^0
 ;;^UTILITY("^GMRD(124.2,",$J,1049,1,3,0)
 ;;=1299^Nursing Intervention/Orders^2^NURSC^28^0
 ;;^UTILITY("^GMRD(124.2,",$J,1049,1,4,0)
 ;;=1300^Related Problems^2^NURSC^25^0
 ;;^UTILITY("^GMRD(124.2,",$J,1049,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1049,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1049,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1050,0)
 ;;=myocardial ischemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1051,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^25^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1051,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1051,1,1,0)
 ;;=1078^chronic physical/psychosocial disability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1051,1,2,0)
 ;;=1342^tissue injury^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1051,1,3,0)
 ;;=1348^altered tissue perfusion, too much (e.g. migraine, shunting)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1051,1,4,0)
 ;;=1349^altered tissue perfusion, too little (ischemia, etc.)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1051,1,5,0)
 ;;=1350^abnormal pain perception^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1051,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1052,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^24^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1052,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1052,1,1,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1052,1,2,0)
 ;;=1061^demonstrates maximal functional ability ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1052,1,3,0)
 ;;=1062^has a relaxed facial expression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1052,1,4,0)
 ;;=2889^[Extra Goal]^3^NURSC^66^0
 ;;^UTILITY("^GMRD(124.2,",$J,1052,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1053,0)
 ;;=LDH1 - LDH2^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1054,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^21^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,1,0)
 ;;=1063^assess level, location and severity of pain q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,2,0)
 ;;=1065^provide appropriate medical treatment per protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,3,0)
 ;;=1068^support pain management^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,4,0)
 ;;=1071^arrange activities for psychological support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,5,0)
 ;;=1072^teach appropriate drug use and timing for pain management^3^NURSC^1^0
