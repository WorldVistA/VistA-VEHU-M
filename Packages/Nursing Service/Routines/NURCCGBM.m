NURCCGBM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8266,1,1,0)
 ;;=8267^[Extra Goal]^3^NURSC^341
 ;;^UTILITY("^GMRD(124.2,",$J,8266,1,2,0)
 ;;=8268^[Extra Goal]^3^NURSC^342
 ;;^UTILITY("^GMRD(124.2,",$J,8266,1,3,0)
 ;;=8269^[Extra Goal]^3^NURSC^343
 ;;^UTILITY("^GMRD(124.2,",$J,8266,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8267,0)
 ;;=[Extra Goal]^3^NURSC^9^341^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8267,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8267,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8268,0)
 ;;=[Extra Goal]^3^NURSC^9^342^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8268,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8268,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8269,0)
 ;;=[Extra Goal]^3^NURSC^9^343^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8269,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8269,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8270,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^282^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8270,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8270,1,1,0)
 ;;=8271^[Extra Order]^3^NURSC^348
 ;;^UTILITY("^GMRD(124.2,",$J,8270,1,2,0)
 ;;=8272^[Extra Order]^3^NURSC^349
 ;;^UTILITY("^GMRD(124.2,",$J,8270,1,3,0)
 ;;=8273^[Extra Order]^3^NURSC^350
 ;;^UTILITY("^GMRD(124.2,",$J,8270,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8270,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8271,0)
 ;;=[Extra Order]^3^NURSC^11^348^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8271,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8271,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8272,0)
 ;;=[Extra Order]^3^NURSC^11^349^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8272,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8272,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8273,0)
 ;;=[Extra Order]^3^NURSC^11^350^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8273,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8273,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8274,0)
 ;;=[Extra Order]^3^NURSC^11^114^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8274,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8274,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8275,0)
 ;;=[Extra Goal]^3^NURSC^9^71^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8275,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8275,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8276,0)
 ;;=Infection Potential^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8276,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8276,1,1,0)
 ;;=8277^Etiology/Related and/or Risk Factors^2^NURSC^114
 ;;^UTILITY("^GMRD(124.2,",$J,8276,1,2,0)
 ;;=8317^Goals/Expected Outcomes^2^NURSC^112
 ;;^UTILITY("^GMRD(124.2,",$J,8276,1,3,0)
 ;;=8340^Nursing Intervention/Orders^2^NURSC^96
 ;;^UTILITY("^GMRD(124.2,",$J,8276,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8276,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8276,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8276,"TD",0)
 ;;=^^2^2^2910822^^^
 ;;^UTILITY("^GMRD(124.2,",$J,8276,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,8276,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,8277,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^114^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,0)
 ;;=^124.21PI^19^6
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,1,0)
 ;;=477^chronic disease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,6,0)
 ;;=482^malnutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8277,1,10,0)
 ;;=309^trauma^3^NURSC^1
