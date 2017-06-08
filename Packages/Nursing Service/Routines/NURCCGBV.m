NURCCGBV ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8830,1,4,0)
 ;;=8837^increased pedal edema^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8830,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,8830,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8830,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8830,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8832,0)
 ;;=change in sputum^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8835,0)
 ;;=increasing shortness of breath^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8837,0)
 ;;=increased pedal edema^3^NURSC^^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8838,0)
 ;;=demonstrates correct use of metered dose inhaler^3^NURSC^9^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8838,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8838,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8843,0)
 ;;=[Extra Goal]^3^NURSC^9^151^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8843,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8843,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8847,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^101^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8847,1,0)
 ;;=^124.21PI^16^2
 ;;^UTILITY("^GMRD(124.2,",$J,8847,1,15,0)
 ;;=9292^[Extra Order]^3^NURSC^158
 ;;^UTILITY("^GMRD(124.2,",$J,8847,1,16,0)
 ;;=15366^assess,teach,evaluate:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8847,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8847,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8930,0)
 ;;=[Extra Order]^3^NURSC^11^154^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8930,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8930,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8931,0)
 ;;=[Extra Problem]^2^NURSC^2^21^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,8931,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8931,1,1,0)
 ;;=8932^Etiology/Related and/or Risk Factors^2^NURSC^267
 ;;^UTILITY("^GMRD(124.2,",$J,8931,1,2,0)
 ;;=8936^Goals/Expected Outcomes^2^NURSC^279
 ;;^UTILITY("^GMRD(124.2,",$J,8931,1,3,0)
 ;;=8940^Nursing Intervention/Orders^2^NURSC^283
 ;;^UTILITY("^GMRD(124.2,",$J,8931,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8931,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8931,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8932,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^267^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8932,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8932,1,1,0)
 ;;=8934^[etiology]^3^NURSC^23
 ;;^UTILITY("^GMRD(124.2,",$J,8932,1,2,0)
 ;;=8935^[etiology]^3^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,8932,1,3,0)
 ;;=9425^[etiology]^3^NURSC^108
 ;;^UTILITY("^GMRD(124.2,",$J,8932,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8933,0)
 ;;=[etiology]^3^NURSC^^22^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8934,0)
 ;;=[etiology]^3^NURSC^^23^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8935,0)
 ;;=[etiology]^3^NURSC^^24^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8936,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^279^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8936,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8936,1,1,0)
 ;;=8937^[Extra Goal]^3^NURSC^344
 ;;^UTILITY("^GMRD(124.2,",$J,8936,1,2,0)
 ;;=8938^[Extra Goal]^3^NURSC^345
 ;;^UTILITY("^GMRD(124.2,",$J,8936,1,3,0)
 ;;=8939^[Extra Goal]^3^NURSC^346
 ;;^UTILITY("^GMRD(124.2,",$J,8936,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8937,0)
 ;;=[Extra Goal]^3^NURSC^9^344^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8937,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8937,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8938,0)
 ;;=[Extra Goal]^3^NURSC^9^345^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8938,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8938,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8939,0)
 ;;=[Extra Goal]^3^NURSC^9^346^^^T
