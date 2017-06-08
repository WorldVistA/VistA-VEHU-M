NURCCGG4 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15240,1,4,0)
 ;;=15244^sore/inflammed bucal cavity^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15240,1,5,0)
 ;;=15245^lack of interest in food^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15240,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15241,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15242,0)
 ;;=reported food intake under RDA^3^NURSC^^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15243,0)
 ;;=reported/observed lack of food^3^NURSC^^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15244,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15245,0)
 ;;=lack of interest in food^3^NURSC^^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15246,0)
 ;;=advise patient to report severe eye pain,inflammation,etc^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15246,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15246,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15247,0)
 ;;=[Extra Problem]^2^NURSC^2^51^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15247,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15247,1,1,0)
 ;;=15248^Etiology/Related and/or Risk Factors^2^NURSC^290
 ;;^UTILITY("^GMRD(124.2,",$J,15247,1,2,0)
 ;;=15252^Goals/Expected Outcomes^2^NURSC^303
 ;;^UTILITY("^GMRD(124.2,",$J,15247,1,3,0)
 ;;=15256^Nursing Intervention/Orders^2^NURSC^306
 ;;^UTILITY("^GMRD(124.2,",$J,15247,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15247,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15247,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15248,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^290^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15248,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15248,1,1,0)
 ;;=15250^[etiology]^3^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,15248,1,2,0)
 ;;=15251^[etiology]^3^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,15248,1,3,0)
 ;;=15277^[etiology]^3^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,15248,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15249,0)
 ;;=[etiology]^3^NURSC^^144^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15250,0)
 ;;=[etiology]^3^NURSC^^142^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15251,0)
 ;;=[etiology]^3^NURSC^^143^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15252,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^303^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15252,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15252,1,1,0)
 ;;=15253^[Extra Goal]^3^NURSC^401
 ;;^UTILITY("^GMRD(124.2,",$J,15252,1,2,0)
 ;;=15254^[Extra Goal]^3^NURSC^402
 ;;^UTILITY("^GMRD(124.2,",$J,15252,1,3,0)
 ;;=15255^[Extra Goal]^3^NURSC^403
 ;;^UTILITY("^GMRD(124.2,",$J,15252,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15253,0)
 ;;=[Extra Goal]^3^NURSC^9^401^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15253,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15253,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15254,0)
 ;;=[Extra Goal]^3^NURSC^9^402^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15254,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15254,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15255,0)
 ;;=[Extra Goal]^3^NURSC^9^403^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15255,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15255,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15256,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^306^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15256,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15256,1,1,0)
 ;;=15257^[Extra Order]^3^NURSC^408
 ;;^UTILITY("^GMRD(124.2,",$J,15256,1,2,0)
 ;;=15258^[Extra Order]^3^NURSC^409
 ;;^UTILITY("^GMRD(124.2,",$J,15256,1,3,0)
 ;;=15259^[Extra Order]^3^NURSC^410
 ;;^UTILITY("^GMRD(124.2,",$J,15256,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15256,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15257,0)
 ;;=[Extra Order]^3^NURSC^11^408^^^T
