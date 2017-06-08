NURCCGGI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15569,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^310^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15569,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,15569,1,2,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15569,1,3,0)
 ;;=15571^verbalizes knowledge of self care/discharge information^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15569,1,4,0)
 ;;=1006316^[Extra Goal]^3^NURSC^173
 ;;^UTILITY("^GMRD(124.2,",$J,15569,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,0)
 ;;=verbalizes knowledge of self care/discharge information^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,1,0)
 ;;=15585^diet: [specify]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,2,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,3,0)
 ;;=15587^purpose for dialysis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,4,0)
 ;;=15588^dialysis schedule^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,5,0)
 ;;=15589^care of dialysis vessel access^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,1,6,0)
 ;;=15590^s/s of complications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,15571,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15571,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15571,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15572,0)
 ;;=[Extra Problem]^2^NURSC^2^43^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15572,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15572,1,1,0)
 ;;=15573^Etiology/Related and/or Risk Factors^2^NURSC^298
 ;;^UTILITY("^GMRD(124.2,",$J,15572,1,2,0)
 ;;=15574^Goals/Expected Outcomes^2^NURSC^311
 ;;^UTILITY("^GMRD(124.2,",$J,15572,1,3,0)
 ;;=15575^Nursing Intervention/Orders^2^NURSC^312
 ;;^UTILITY("^GMRD(124.2,",$J,15572,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15572,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15572,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15573,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^298^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15573,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15573,1,1,0)
 ;;=15577^[etiology]^3^NURSC^53
 ;;^UTILITY("^GMRD(124.2,",$J,15573,1,2,0)
 ;;=15578^[etiology]^3^NURSC^54
 ;;^UTILITY("^GMRD(124.2,",$J,15573,1,3,0)
 ;;=15692^[etiology]^3^NURSC^139
 ;;^UTILITY("^GMRD(124.2,",$J,15573,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15574,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^311^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15574,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15574,1,1,0)
 ;;=15579^[Extra Goal]^3^NURSC^410
 ;;^UTILITY("^GMRD(124.2,",$J,15574,1,2,0)
 ;;=15580^[Extra Goal]^3^NURSC^411
 ;;^UTILITY("^GMRD(124.2,",$J,15574,1,3,0)
 ;;=15581^[Extra Goal]^3^NURSC^412
 ;;^UTILITY("^GMRD(124.2,",$J,15574,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15575,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^312^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15575,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15575,1,1,0)
 ;;=15582^[Extra Order]^3^NURSC^417
 ;;^UTILITY("^GMRD(124.2,",$J,15575,1,2,0)
 ;;=15583^[Extra Order]^3^NURSC^418
 ;;^UTILITY("^GMRD(124.2,",$J,15575,1,3,0)
 ;;=15584^[Extra Order]^3^NURSC^419
 ;;^UTILITY("^GMRD(124.2,",$J,15575,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15575,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15576,0)
 ;;=[etiology]^3^NURSC^^52^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15577,0)
 ;;=[etiology]^3^NURSC^^53^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15578,0)
 ;;=[etiology]^3^NURSC^^54^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15579,0)
 ;;=[Extra Goal]^3^NURSC^9^410^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15579,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15579,10)
 ;;=D EN2^NURCCPU1
