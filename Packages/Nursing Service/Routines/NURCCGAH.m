NURCCGAH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6276,1,3,0)
 ;;=6305^Nursing Intervention/Orders^2^NURSC^174
 ;;^UTILITY("^GMRD(124.2,",$J,6276,1,4,0)
 ;;=6322^Related Problems^2^NURSC^75
 ;;^UTILITY("^GMRD(124.2,",$J,6276,1,5,0)
 ;;=6333^Defining Characteristics^2^NURSC^82
 ;;^UTILITY("^GMRD(124.2,",$J,6276,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6276,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6276,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6276,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,6276,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,6276,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,6277,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^88^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,0)
 ;;=^124.21PI^16^14
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,1,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,2,0)
 ;;=2777^immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,3,0)
 ;;=2778^inflammation injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,4,0)
 ;;=2779^ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,5,0)
 ;;=2780^muscle spasms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,6,0)
 ;;=2781^muscle tension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,8,0)
 ;;=2783^physical activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,9,0)
 ;;=2784^procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,10,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,12,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,13,0)
 ;;=2152^fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,14,0)
 ;;=2403^depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,1,16,0)
 ;;=972^stress and anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6277,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6295,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^87^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6295,1,0)
 ;;=^124.21PI^9^3
 ;;^UTILITY("^GMRD(124.2,",$J,6295,1,1,0)
 ;;=2789^verbalizes when in pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6295,1,8,0)
 ;;=2796^verbalizes comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6295,1,9,0)
 ;;=6380^[Extra Goal]^3^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,6295,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6304,0)
 ;;=[Extra Goal]^3^NURSC^9^125^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6304,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6304,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6305,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^174^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6305,1,0)
 ;;=^124.21PI^16^4
 ;;^UTILITY("^GMRD(124.2,",$J,6305,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6305,1,7,0)
 ;;=2805^teach splinting of the incision to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6305,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6305,1,16,0)
 ;;=6321^[Extra Order]^3^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,6305,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6305,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6321,0)
 ;;=[Extra Order]^3^NURSC^11^130^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6321,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6321,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6322,0)
 ;;=Related Problems^2^NURSC^7^75^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6322,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
