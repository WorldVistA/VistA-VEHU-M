NURCCGCT ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,5,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10429,1,6,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10429,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^141^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,0)
 ;;=^124.21PI^11^6
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,6,0)
 ;;=15621^verblizes understanding of functional status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,7,0)
 ;;=15622^demonstrates ability to direct caregiver in ADL needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,8,0)
 ;;=15623^demonstrates safe use of adaptive equipment [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,9,0)
 ;;=3243^participates in self-care activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,10,0)
 ;;=15625^develops effective program for bowel/bladder management^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10443,1,11,0)
 ;;=10705^[Extra Goal]^3^NURSC^176
 ;;^UTILITY("^GMRD(124.2,",$J,10443,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10488,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^119^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10488,1,0)
 ;;=^124.21PI^9^4
 ;;^UTILITY("^GMRD(124.2,",$J,10488,1,6,0)
 ;;=15627^teach techniques of ADL care to patient/significant other(s)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10488,1,7,0)
 ;;=15620^teach use & care of adpative equipment^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10488,1,8,0)
 ;;=15629^evaluate effectiveness of bowel/bladder managment program^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10488,1,9,0)
 ;;=11094^[Extra Order]^3^NURSC^183
 ;;^UTILITY("^GMRD(124.2,",$J,10488,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10488,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10492,0)
 ;;=Knowledge Deficit^2^NURSC^2^11^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10492,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,10492,1,1,0)
 ;;=10495^Etiology/Related and/or Risk Factors^2^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,10492,1,2,0)
 ;;=10513^Related Problems^2^NURSC^123
 ;;^UTILITY("^GMRD(124.2,",$J,10492,1,3,0)
 ;;=10520^Goals/Expected Outcomes^2^NURSC^142
 ;;^UTILITY("^GMRD(124.2,",$J,10492,1,4,0)
 ;;=10555^Nursing Intervention/Orders^2^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,10492,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10492,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10492,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10492,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,10492,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,10495,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^144^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,0)
 ;;=^124.21PI^9^6
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,2,0)
 ;;=1669^lack of recall^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,3,0)
 ;;=160^information misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,4,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,8,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10495,1,9,0)
 ;;=164^patient's request for no information^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10495,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10513,0)
 ;;=Related Problems^2^NURSC^7^123^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10513,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,10513,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10513,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10513,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10520,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^142^1^^T
