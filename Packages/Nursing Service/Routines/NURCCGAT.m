NURCCGAT ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6775,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6776,0)
 ;;=[Extra Order]^3^NURSC^11^336^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6776,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6776,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6777,0)
 ;;=performs bathing independently^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6777,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6777,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6778,0)
 ;;=[Extra Order]^3^NURSC^11^337^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6778,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6778,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6779,0)
 ;;=[Extra Order]^3^NURSC^11^338^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6779,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6779,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6780,0)
 ;;=performs dressing/grooming independently^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6780,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6780,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6850,0)
 ;;=[Extra Goal]^3^NURSC^9^227^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6850,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6850,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,0)
 ;;=teach prevention of infection techniques [specify]^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,1,0)
 ;;=2749^actions to take to prevent cross-infection^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,2,0)
 ;;=1820^S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,3,0)
 ;;=2750^personal hygiene measures as indicated [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,4,0)
 ;;=2938^assess knowledge base^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,5,0)
 ;;=2939^determine ability to learn and implement plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,6,0)
 ;;=2940^decide what patient needs to know^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,7,0)
 ;;=2941^evaluate effectiveness of teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,8,0)
 ;;=2942^implement teaching plan based on readiness/ability to learn^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,9,0)
 ;;=2943^involve S/O in teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,10,0)
 ;;=15378^handwashing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,1,11,0)
 ;;=15379^disposal of contaminants^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,6891,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6891,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6891,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6902,0)
 ;;=Knowledge Deficit [specify]^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6902,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6902,1,1,0)
 ;;=6903^Etiology/Related and/or Risk Factors^2^NURSC^97
 ;;^UTILITY("^GMRD(124.2,",$J,6902,1,2,0)
 ;;=6911^Goals/Expected Outcomes^2^NURSC^96
 ;;^UTILITY("^GMRD(124.2,",$J,6902,1,3,0)
 ;;=6924^Nursing Intervention/Orders^2^NURSC^178
 ;;^UTILITY("^GMRD(124.2,",$J,6902,1,4,0)
 ;;=6941^Defining Characteristics^2^NURSC^88
 ;;^UTILITY("^GMRD(124.2,",$J,6902,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6902,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6902,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6902,"TD",0)
 ;;=^^1^1^2900529^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,6902,"TD",1,0)
 ;;=Lack of specific information
 ;;^UTILITY("^GMRD(124.2,",$J,6903,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^97^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6903,1,0)
 ;;=^124.21PI^12^5
 ;;^UTILITY("^GMRD(124.2,",$J,6903,1,8,0)
 ;;=458^disease process^3^NURSC^1
