NURCCGEM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13396,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^292^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13396,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13396,1,1,0)
 ;;=13397^[Extra Goal]^3^NURSC^377
 ;;^UTILITY("^GMRD(124.2,",$J,13396,1,2,0)
 ;;=13398^[Extra Goal]^3^NURSC^378
 ;;^UTILITY("^GMRD(124.2,",$J,13396,1,3,0)
 ;;=13399^[Extra Goal]^3^NURSC^379
 ;;^UTILITY("^GMRD(124.2,",$J,13396,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13397,0)
 ;;=[Extra Goal]^3^NURSC^9^377^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13397,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13397,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13398,0)
 ;;=[Extra Goal]^3^NURSC^9^378^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13398,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13398,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13399,0)
 ;;=[Extra Goal]^3^NURSC^9^379^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13399,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13399,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13400,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^296^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13400,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13400,1,1,0)
 ;;=13401^[Extra Order]^3^NURSC^384
 ;;^UTILITY("^GMRD(124.2,",$J,13400,1,2,0)
 ;;=13402^[Extra Order]^3^NURSC^385
 ;;^UTILITY("^GMRD(124.2,",$J,13400,1,3,0)
 ;;=13403^[Extra Order]^3^NURSC^386
 ;;^UTILITY("^GMRD(124.2,",$J,13400,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13400,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13401,0)
 ;;=[Extra Order]^3^NURSC^11^384^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13401,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13401,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13402,0)
 ;;=[Extra Order]^3^NURSC^11^385^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13402,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13402,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13403,0)
 ;;=[Extra Order]^3^NURSC^11^386^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13403,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13403,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13405,0)
 ;;=avoid touching,squeezing or rubbing eye^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13430,0)
 ;;=[Extra Goal]^3^NURSC^9^233^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13430,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13430,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13475,0)
 ;;=[Extra Order]^3^NURSC^11^239^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13475,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13475,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13484,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13484,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13484,1,1,0)
 ;;=13485^Etiology/Related and/or Risk Factors^2^NURSC^180
 ;;^UTILITY("^GMRD(124.2,",$J,13484,1,2,0)
 ;;=13494^Related Problems^2^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,13484,1,3,0)
 ;;=13499^Goals/Expected Outcomes^2^NURSC^178
 ;;^UTILITY("^GMRD(124.2,",$J,13484,1,4,0)
 ;;=13512^Nursing Intervention/Orders^2^NURSC^197
 ;;^UTILITY("^GMRD(124.2,",$J,13484,1,5,0)
 ;;=13571^Defining Characteristics^2^NURSC^157
 ;;^UTILITY("^GMRD(124.2,",$J,13484,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13484,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13484,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13484,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,13484,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,13484,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
