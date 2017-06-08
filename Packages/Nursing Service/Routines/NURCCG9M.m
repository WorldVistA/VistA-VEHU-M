NURCCG9M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5051,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5064,0)
 ;;=[Extra Order]^3^NURSC^11^35^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5064,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5064,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5081,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^247^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5081,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5081,1,1,0)
 ;;=5083^[etiology]^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,5081,1,2,0)
 ;;=5084^[etiology]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,5081,1,3,0)
 ;;=5127^[etiology]^3^NURSC^32
 ;;^UTILITY("^GMRD(124.2,",$J,5081,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5082,0)
 ;;=[etiology]^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5083,0)
 ;;=[etiology]^3^NURSC^^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5084,0)
 ;;=[etiology]^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5085,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^254^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5085,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5085,1,1,0)
 ;;=5123^[Extra Goal]^3^NURSC^302
 ;;^UTILITY("^GMRD(124.2,",$J,5085,1,2,0)
 ;;=5125^[Extra Goal]^3^NURSC^303
 ;;^UTILITY("^GMRD(124.2,",$J,5085,1,3,0)
 ;;=5126^[Extra Goal]^3^NURSC^304
 ;;^UTILITY("^GMRD(124.2,",$J,5085,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5086,0)
 ;;=Nutrition,Alteration in (less than required)^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5086,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5086,1,1,0)
 ;;=5087^Etiology/Related and/or Risk Factors^2^NURSC^248
 ;;^UTILITY("^GMRD(124.2,",$J,5086,1,2,0)
 ;;=5090^Goals/Expected Outcomes^2^NURSC^255
 ;;^UTILITY("^GMRD(124.2,",$J,5086,1,3,0)
 ;;=5097^Nursing Intervention/Orders^2^NURSC^255
 ;;^UTILITY("^GMRD(124.2,",$J,5086,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5086,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5086,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5087,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^248^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5087,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,5087,1,1,0)
 ;;=2544^inability to digest/absorb nutrients due to biologic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5087,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5090,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^255^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5090,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5090,1,1,0)
 ;;=5091^maintain nutritional intake to meet metabolic requirements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5090,1,2,0)
 ;;=473^maintains optimal weight [specify lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5090,1,3,0)
 ;;=5093^maintain adequate intake and output^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5090,1,4,0)
 ;;=5780^[Extra Goal]^3^NURSC^22
 ;;^UTILITY("^GMRD(124.2,",$J,5090,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5091,0)
 ;;=maintain nutritional intake to meet metabolic requirements^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5091,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5091,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5093,0)
 ;;=maintain adequate intake and output^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5093,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5093,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5094,0)
 ;;=[Extra Goal]^3^NURSC^9^40^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5094,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5094,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5095,0)
 ;;=Transurethral Resection/Benign Prostatic Hypertrophy^2^NURSC^8^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5095,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,5095,1,2,0)
 ;;=5347^Urinary Elimination, Alteration In Pattern^2^NURSC^3
