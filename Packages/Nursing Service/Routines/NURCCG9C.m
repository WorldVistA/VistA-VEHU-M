NURCCG9C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4918,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4918,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4919,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^243^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4919,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4919,1,1,0)
 ;;=4957^[Extra Order]^3^NURSC^297
 ;;^UTILITY("^GMRD(124.2,",$J,4919,1,2,0)
 ;;=4960^[Extra Order]^3^NURSC^298
 ;;^UTILITY("^GMRD(124.2,",$J,4919,1,3,0)
 ;;=4962^[Extra Order]^3^NURSC^299
 ;;^UTILITY("^GMRD(124.2,",$J,4919,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4919,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4920,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^244^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4920,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4920,1,1,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4920,1,2,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4920,1,3,0)
 ;;=1610^initiate febrile protocol^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4920,1,4,0)
 ;;=4967^[Extra Order]^3^NURSC^225
 ;;^UTILITY("^GMRD(124.2,",$J,4920,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4920,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4921,0)
 ;;=interrupt psychotic process;involve reality based activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4921,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4921,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4922,0)
 ;;=[Extra Order]^3^NURSC^11^294^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4922,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4922,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4923,0)
 ;;=[Extra Order]^3^NURSC^11^295^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4923,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4923,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4924,0)
 ;;=[Extra Order]^3^NURSC^11^296^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4924,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4924,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4925,0)
 ;;=[Extra Order]^3^NURSC^11^223^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4925,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4925,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4926,0)
 ;;=observe for S/S of psychotic thought processes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4926,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4926,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4927,0)
 ;;=Gastroenteritis/Gastritis^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4927,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4927,1,1,0)
 ;;=4615^Fluid Volume Deficit^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4927,1,2,0)
 ;;=4653^Nutrition, Alteration in:(Less Than Required)^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4927,1,3,0)
 ;;=4979^Pain, Acute^2^NURSC^17
 ;;^UTILITY("^GMRD(124.2,",$J,4927,1,4,0)
 ;;=5010^[Extra Problem]^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,4928,0)
 ;;=Pain, Acute^2^NURSC^2^16^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4928,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4928,1,1,0)
 ;;=4930^Etiology/Related and/or Risk Factors^2^NURSC^239
 ;;^UTILITY("^GMRD(124.2,",$J,4928,1,2,0)
 ;;=4938^Goals/Expected Outcomes^2^NURSC^244
 ;;^UTILITY("^GMRD(124.2,",$J,4928,1,3,0)
 ;;=4952^Nursing Intervention/Orders^2^NURSC^245
 ;;^UTILITY("^GMRD(124.2,",$J,4928,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4928,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4928,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4929,0)
 ;;=relate psychotic thought content to level of anxiety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4929,9)
 ;;=D EN2^NURCCPU2
