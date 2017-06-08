NURCCG93 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4801,1,1,0)
 ;;=4813^peripheral pulses present^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4801,1,2,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4801,1,3,0)
 ;;=4825^[Extra Goal]^3^NURSC^219
 ;;^UTILITY("^GMRD(124.2,",$J,4801,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4802,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^233^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4802,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4802,1,1,0)
 ;;=1846^peripheral pulses q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4802,1,2,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4802,1,3,0)
 ;;=2711^incentive spirometry q[frequency] hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4802,1,4,0)
 ;;=4846^[Extra Order]^3^NURSC^221
 ;;^UTILITY("^GMRD(124.2,",$J,4802,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4802,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4803,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^229^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4803,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4803,1,1,0)
 ;;=4865^[etiology]^3^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,4803,1,2,0)
 ;;=4866^[etiology]^3^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,4803,1,3,0)
 ;;=4896^[etiology]^3^NURSC^94
 ;;^UTILITY("^GMRD(124.2,",$J,4803,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4804,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^233^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4804,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4804,1,1,0)
 ;;=4868^[Extra Goal]^3^NURSC^284
 ;;^UTILITY("^GMRD(124.2,",$J,4804,1,2,0)
 ;;=4869^[Extra Goal]^3^NURSC^285
 ;;^UTILITY("^GMRD(124.2,",$J,4804,1,3,0)
 ;;=4871^[Extra Goal]^3^NURSC^286
 ;;^UTILITY("^GMRD(124.2,",$J,4804,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4805,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^234^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4805,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4805,1,1,0)
 ;;=2691^has improved breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4805,1,2,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4805,1,3,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4805,1,4,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4805,1,5,0)
 ;;=4830^[Extra Goal]^3^NURSC^220
 ;;^UTILITY("^GMRD(124.2,",$J,4805,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4806,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^234^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4806,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4806,1,1,0)
 ;;=4872^[Extra Order]^3^NURSC^291
 ;;^UTILITY("^GMRD(124.2,",$J,4806,1,2,0)
 ;;=4874^[Extra Order]^3^NURSC^292
 ;;^UTILITY("^GMRD(124.2,",$J,4806,1,3,0)
 ;;=4875^[Extra Order]^3^NURSC^293
 ;;^UTILITY("^GMRD(124.2,",$J,4806,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4806,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4808,0)
 ;;=[Extra Goal]^3^NURSC^9^216^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4808,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4808,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4809,0)
 ;;=[Extra Goal]^3^NURSC^9^217^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4809,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4809,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4810,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^235^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4810,1,2,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
