NURCCGDH ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11632,0)
 ;;=[etiology]^3^NURSC^^60^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11633,0)
 ;;=[etiology]^3^NURSC^^58^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11634,0)
 ;;=[etiology]^3^NURSC^^59^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11635,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^286^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11635,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11635,1,1,0)
 ;;=11636^[Extra Goal]^3^NURSC^362
 ;;^UTILITY("^GMRD(124.2,",$J,11635,1,2,0)
 ;;=11637^[Extra Goal]^3^NURSC^363
 ;;^UTILITY("^GMRD(124.2,",$J,11635,1,3,0)
 ;;=11638^[Extra Goal]^3^NURSC^364
 ;;^UTILITY("^GMRD(124.2,",$J,11635,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11636,0)
 ;;=[Extra Goal]^3^NURSC^9^362^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11636,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11636,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11637,0)
 ;;=[Extra Goal]^3^NURSC^9^363^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11637,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11637,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11638,0)
 ;;=[Extra Goal]^3^NURSC^9^364^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11638,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11638,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11639,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^290^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11639,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11639,1,1,0)
 ;;=11640^[Extra Order]^3^NURSC^369
 ;;^UTILITY("^GMRD(124.2,",$J,11639,1,2,0)
 ;;=11641^[Extra Order]^3^NURSC^370
 ;;^UTILITY("^GMRD(124.2,",$J,11639,1,3,0)
 ;;=11642^[Extra Order]^3^NURSC^371
 ;;^UTILITY("^GMRD(124.2,",$J,11639,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11639,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11640,0)
 ;;=[Extra Order]^3^NURSC^11^369^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11640,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11640,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11641,0)
 ;;=[Extra Order]^3^NURSC^11^370^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11641,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11641,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11642,0)
 ;;=[Extra Order]^3^NURSC^11^371^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11642,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11642,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11643,0)
 ;;=Skin Integrity, Impairment Of (Actual)^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11643,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11643,1,1,0)
 ;;=11644^Etiology/Related and/or Risk Factors^2^NURSC^157
 ;;^UTILITY("^GMRD(124.2,",$J,11643,1,2,0)
 ;;=11662^Goals/Expected Outcomes^2^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,11643,1,3,0)
 ;;=11673^Nursing Intervention/Orders^2^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,11643,1,4,0)
 ;;=11702^Related Problems^2^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,11643,1,5,0)
 ;;=11706^Defining Characteristics^2^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,11643,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11643,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11643,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11643,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,11643,"TD",1,0)
 ;;=A state in which the individual's skin is adversely altered.
 ;;^UTILITY("^GMRD(124.2,",$J,11644,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^157^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,1,0)
 ;;=1767^chemical substance or radiation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,2,0)
 ;;=1768^hyperthermia or hypothermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,3,0)
 ;;=825^mechanical factors^3^NURSC^1
