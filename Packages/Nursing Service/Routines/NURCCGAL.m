NURCCGAL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6418,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6418,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6418,"TD",0)
 ;;=^^1^1^2900529^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,6418,"TD",1,0)
 ;;=Lack of specific information
 ;;^UTILITY("^GMRD(124.2,",$J,6419,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^90^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6419,1,0)
 ;;=^124.21PI^7^1
 ;;^UTILITY("^GMRD(124.2,",$J,6419,1,7,0)
 ;;=6426^unfamiliarity with surgical procedure/recovery^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6419,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6426,0)
 ;;=unfamiliarity with surgical procedure/recovery^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6427,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^89^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6427,1,0)
 ;;=^124.21PI^11^4
 ;;^UTILITY("^GMRD(124.2,",$J,6427,1,1,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6427,1,2,0)
 ;;=2437^expresses appropriate knowledge base for self care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6427,1,10,0)
 ;;=6570^[Extra Goal]^3^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,6427,1,11,0)
 ;;=7023^verbalizes activities allowed after discharge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6427,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6440,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^176^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6440,1,0)
 ;;=^124.21PI^9^3
 ;;^UTILITY("^GMRD(124.2,",$J,6440,1,1,0)
 ;;=169^assess knowledge base^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6440,1,8,0)
 ;;=6456^[Extra Order]^3^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,6440,1,9,0)
 ;;=7229^instruct patient & significant other on:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6440,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6440,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6456,0)
 ;;=[Extra Order]^3^NURSC^11^132^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6456,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6456,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6457,0)
 ;;=Defining Characteristics^2^NURSC^12^84^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6457,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,6457,1,1,0)
 ;;=4270^request for information^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6457,1,3,0)
 ;;=4275^verbalization of the problem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6457,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6463,0)
 ;;=Pain, Acute^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6463,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6463,1,1,0)
 ;;=6464^Etiology/Related and/or Risk Factors^2^NURSC^91
 ;;^UTILITY("^GMRD(124.2,",$J,6463,1,2,0)
 ;;=6482^Goals/Expected Outcomes^2^NURSC^90
 ;;^UTILITY("^GMRD(124.2,",$J,6463,1,3,0)
 ;;=6492^Nursing Intervention/Orders^2^NURSC^177
 ;;^UTILITY("^GMRD(124.2,",$J,6463,1,4,0)
 ;;=6509^Related Problems^2^NURSC^77
 ;;^UTILITY("^GMRD(124.2,",$J,6463,1,5,0)
 ;;=6520^Defining Characteristics^2^NURSC^85
 ;;^UTILITY("^GMRD(124.2,",$J,6463,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6463,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6463,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6463,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,6463,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,6463,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,6464,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^91^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,0)
 ;;=^124.21PI^16^10
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,1,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,3,0)
 ;;=1343^inflammation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6464,1,5,0)
 ;;=2780^muscle spasms^3^NURSC^1
