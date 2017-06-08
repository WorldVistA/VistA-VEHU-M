NURCCGDC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11437,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11437,1,1,0)
 ;;=1078^chronic physical/psychosocial disability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11437,1,2,0)
 ;;=11439^tissue injury^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11437,1,3,0)
 ;;=1348^altered tissue perfusion, too much (e.g. migraine, shunting)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11437,1,4,0)
 ;;=1349^altered tissue perfusion, too little (ischemia, etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11437,1,5,0)
 ;;=11449^abnormal pain perception^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11437,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,0)
 ;;=tissue injury^2^NURSC^^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,1,0)
 ;;=1343^inflammation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,2,0)
 ;;=1344^infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,3,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,4,0)
 ;;=1345^surgical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,5,0)
 ;;=1346^chemotherapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,6,0)
 ;;=1347^alcohol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,1,7,0)
 ;;=827^radiation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11439,5)
 ;;=due to
 ;;^UTILITY("^GMRD(124.2,",$J,11439,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11449,0)
 ;;=abnormal pain perception^2^NURSC^^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11449,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11449,1,1,0)
 ;;=1351^phantom limb pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11449,1,2,0)
 ;;=1352^central pain syndrome^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11449,1,3,0)
 ;;=1353^defferentation pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11449,1,4,0)
 ;;=1354^peripheral pain syndrome^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11449,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,11449,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11454,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^152^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11454,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11454,1,1,0)
 ;;=11455^demonstrates correct dressing change technique^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11454,1,2,0)
 ;;=11456^verbalizes knowledge of pain relief measures^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11454,1,3,0)
 ;;=11457^verbalizes decreased pain^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11454,1,4,0)
 ;;=11594^[Extra Goal]^3^NURSC^186
 ;;^UTILITY("^GMRD(124.2,",$J,11454,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11455,0)
 ;;=demonstrates correct dressing change technique^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11455,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11455,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11456,0)
 ;;=verbalizes knowledge of pain relief measures^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11456,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11456,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11457,0)
 ;;=verbalizes decreased pain^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11457,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11457,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11458,0)
 ;;=[Extra Goal]^3^NURSC^9^185^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11458,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11458,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11459,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^126^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11459,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,11459,1,1,0)
 ;;=11460^teach patient to avoid prolonged sitting/standing^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11459,1,2,0)
 ;;=11461^teach techniques to reduce pain during dressing changes^3^NURSC^3
