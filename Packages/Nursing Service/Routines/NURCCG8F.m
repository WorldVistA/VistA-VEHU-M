NURCCG8F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4476,1,2,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4476,1,3,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4476,1,4,0)
 ;;=4480^administer anticoagulants per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4476,1,5,0)
 ;;=4715^[Extra Order]^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4476,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4476,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4477,0)
 ;;=assess level of consciousness q[frequency]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4477,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4477,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4480,0)
 ;;=administer anticoagulants per protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4480,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4480,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4482,0)
 ;;=[Extra Goal]^3^NURSC^9^48^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4482,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4482,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4483,0)
 ;;=[Extra Order]^3^NURSC^11^42^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4483,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4483,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4484,0)
 ;;=[etiology]^3^NURSC^^21^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4485,0)
 ;;=[Extra Problem]^2^NURSC^2^11^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4485,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,4485,1,4,0)
 ;;=4497^Etiology/Related and/or Risk Factors^2^NURSC^208
 ;;^UTILITY("^GMRD(124.2,",$J,4485,1,5,0)
 ;;=4504^Goals/Expected Outcomes^2^NURSC^208
 ;;^UTILITY("^GMRD(124.2,",$J,4485,1,6,0)
 ;;=4508^Nursing Intervention/Orders^2^NURSC^209
 ;;^UTILITY("^GMRD(124.2,",$J,4485,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4485,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4485,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4486,0)
 ;;=[etiology]^3^NURSC^^25^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4487,0)
 ;;=[etiology]^3^NURSC^^26^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4488,0)
 ;;=[Extra Goal]^3^NURSC^9^266^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4488,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4488,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4489,0)
 ;;=[Extra Goal]^3^NURSC^9^267^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4489,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4489,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4490,0)
 ;;=[etiology]^3^NURSC^^121^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4491,0)
 ;;=[Extra Goal]^3^NURSC^9^268^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4491,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4491,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4494,0)
 ;;=[Extra Order]^3^NURSC^11^273^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4494,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4494,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4495,0)
 ;;=[Extra Order]^3^NURSC^11^274^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4495,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4495,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4496,0)
 ;;=[Extra Order]^3^NURSC^11^275^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4496,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4496,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4497,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^208^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4497,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4497,1,1,0)
 ;;=4499^[etiology]^3^NURSC^122
 ;;^UTILITY("^GMRD(124.2,",$J,4497,1,2,0)
 ;;=4501^[etiology]^3^NURSC^123
 ;;^UTILITY("^GMRD(124.2,",$J,4497,1,3,0)
 ;;=4546^[etiology]^3^NURSC^46
