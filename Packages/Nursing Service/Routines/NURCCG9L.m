NURCCG9L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,1,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,2,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,3,0)
 ;;=1610^initiate febrile protocol^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,4,0)
 ;;=1063^assess level, location and severity of pain q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,5,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,6,0)
 ;;=4417^instruct patient to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,9,0)
 ;;=3149^assess for S/S of increased anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,10,0)
 ;;=5050^[Extra Order]^3^NURSC^228
 ;;^UTILITY("^GMRD(124.2,",$J,5039,1,11,0)
 ;;=4599^teach pain control interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5039,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5040,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^246^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5040,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5040,1,1,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5040,1,2,0)
 ;;=1078^chronic physical/psychosocial disability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5040,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5044,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^251^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5044,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5044,1,1,0)
 ;;=5045^demonstrate maximal functional ability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5044,1,2,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5044,1,3,0)
 ;;=5593^[Extra Goal]^3^NURSC^27
 ;;^UTILITY("^GMRD(124.2,",$J,5044,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5045,0)
 ;;=demonstrate maximal functional ability^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5045,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5045,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5046,0)
 ;;=[Extra Goal]^3^NURSC^9^39^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5046,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5046,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5047,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^252^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5047,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,5047,1,1,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5047,1,3,0)
 ;;=4959^administer medications as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5047,1,4,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5047,1,5,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5047,1,6,0)
 ;;=5184^[Extra Order]^3^NURSC^41
 ;;^UTILITY("^GMRD(124.2,",$J,5047,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5047,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5050,0)
 ;;=[Extra Order]^3^NURSC^11^228^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5050,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5050,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5051,0)
 ;;=[Extra Problem]^2^NURSC^2^47^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5051,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,5051,1,4,0)
 ;;=5081^Etiology/Related and/or Risk Factors^2^NURSC^247
 ;;^UTILITY("^GMRD(124.2,",$J,5051,1,5,0)
 ;;=5085^Goals/Expected Outcomes^2^NURSC^254
 ;;^UTILITY("^GMRD(124.2,",$J,5051,1,6,0)
 ;;=5128^Nursing Intervention/Orders^2^NURSC^256
 ;;^UTILITY("^GMRD(124.2,",$J,5051,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5051,9)
 ;;=D EN2^NURCCPU3
