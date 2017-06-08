NURCCG99 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,8,0)
 ;;=4921^interrupt psychotic process;involve reality based activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,9,0)
 ;;=2347^look for reality stimuli causing stress/explore factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,10,0)
 ;;=2361^monitor/assist with grooming & hygiene as necessary^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,11,0)
 ;;=4926^observe for S/S of psychotic thought processes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,12,0)
 ;;=2317^offer PRN medication when indicated^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,13,0)
 ;;=2328^recognize: pt. may be anxious about dismissing 'voices'^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,14,0)
 ;;=4929^relate psychotic thought content to level of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,15,0)
 ;;=4934^[Extra Order]^3^NURSC^17
 ;;^UTILITY("^GMRD(124.2,",$J,4878,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4879,0)
 ;;=monitor,document caloric intake q[freq]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4879,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4879,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4880,0)
 ;;=[Extra Order]^3^NURSC^11^49^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4880,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4880,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4881,0)
 ;;=Anxiety^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4881,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4881,1,2,0)
 ;;=4902^Etiology/Related and/or Risk Factors^2^NURSC^238
 ;;^UTILITY("^GMRD(124.2,",$J,4881,1,3,0)
 ;;=4907^Goals/Expected Outcomes^2^NURSC^243
 ;;^UTILITY("^GMRD(124.2,",$J,4881,1,4,0)
 ;;=4918^Nursing Intervention/Orders^2^NURSC^242
 ;;^UTILITY("^GMRD(124.2,",$J,4881,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4881,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4881,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4882,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^234^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4882,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4883,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^239^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4883,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4883,1,1,0)
 ;;=4936^identifies situations that contribute to loss of control^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4883,1,2,0)
 ;;=5036^[Extra Goal]^3^NURSC^38
 ;;^UTILITY("^GMRD(124.2,",$J,4883,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4884,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^240^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4884,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4884,1,1,0)
 ;;=4944^teach methods/skills to control/redirect angry feelings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4884,1,2,0)
 ;;=4946^[Extra Order]^3^NURSC^224
 ;;^UTILITY("^GMRD(124.2,",$J,4884,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4884,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4885,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^235^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4885,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4885,1,1,0)
 ;;=4899^[etiology]^3^NURSC^95
 ;;^UTILITY("^GMRD(124.2,",$J,4885,1,2,0)
 ;;=4900^[etiology]^3^NURSC^96
 ;;^UTILITY("^GMRD(124.2,",$J,4885,1,3,0)
 ;;=4940^[etiology]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4885,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4887,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^240^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4887,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4887,1,1,0)
 ;;=4908^[Extra Goal]^3^NURSC^287
 ;;^UTILITY("^GMRD(124.2,",$J,4887,1,2,0)
 ;;=4913^[Extra Goal]^3^NURSC^288
 ;;^UTILITY("^GMRD(124.2,",$J,4887,1,3,0)
 ;;=4917^[Extra Goal]^3^NURSC^289
