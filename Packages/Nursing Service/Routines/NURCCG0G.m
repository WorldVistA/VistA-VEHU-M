NURCCG0G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,173,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,174,0)
 ;;=evaluate effectiveness of teaching plan^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,174,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,174,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,175,0)
 ;;=Noncompliance/Nonadherence [specify]^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,175,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,175,1,1,0)
 ;;=182^Related Problems^2^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,175,1,2,0)
 ;;=176^Etiology/Related and/or Risk Factors^2^NURSC^7^0
 ;;^UTILITY("^GMRD(124.2,",$J,175,1,3,0)
 ;;=183^Goals/Expected Outcomes^2^NURSC^7^0
 ;;^UTILITY("^GMRD(124.2,",$J,175,1,4,0)
 ;;=192^Nursing Intervention/Orders^2^NURSC^133^0
 ;;^UTILITY("^GMRD(124.2,",$J,175,1,5,0)
 ;;=5202^Defining Characteristics^2^NURSC^63
 ;;^UTILITY("^GMRD(124.2,",$J,175,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,175,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,175,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,175,"TD",0)
 ;;=^^2^2^2900529^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,175,"TD",1,0)
 ;;=Noncompliance is a person's informed decision not to adhere to a 
 ;;^UTILITY("^GMRD(124.2,",$J,175,"TD",2,0)
 ;;=therapeutic recommendation.
 ;;^UTILITY("^GMRD(124.2,",$J,176,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,176,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,176,1,1,0)
 ;;=177^client and provider relationships^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,176,1,2,0)
 ;;=178^cultural influences^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,176,1,3,0)
 ;;=179^health benefits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,176,1,4,0)
 ;;=180^patient value system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,176,1,5,0)
 ;;=181^spiritual values^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,176,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,177,0)
 ;;=client and provider relationships^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,178,0)
 ;;=cultural influences^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,179,0)
 ;;=health benefits^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,180,0)
 ;;=patient value system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,181,0)
 ;;=spiritual values^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,182,0)
 ;;=Related Problems^2^NURSC^7^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,182,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,182,1,1,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,182,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,182,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,183,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,1,0)
 ;;=184^participates in development/implementation of treatment plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,2,0)
 ;;=185^verbalizes experiences causing alteration in prescribed plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,3,0)
 ;;=186^verbalizes accurate knowledge of disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,4,0)
 ;;=187^verbalizes accurate understanding of treatment regime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,5,0)
 ;;=188^demonstrates realistic alternatives to treatment regime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,6,0)
 ;;=189^identifies sources of dissatisfaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,7,0)
 ;;=190^participates in selection of more desirable treatment plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,8,0)
 ;;=191^verbalizes intent to adhere to realistic alternative plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,1,9,0)
 ;;=2872^[Extra Goal]^3^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,183,7)
 ;;=D EN4^NURCCPU1
