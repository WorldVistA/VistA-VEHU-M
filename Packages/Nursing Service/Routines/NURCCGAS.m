NURCCGAS ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6668,1,10,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6668,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,0)
 ;;=Defining Characteristics^2^NURSC^12^87^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6679,1,1,0)
 ;;=4057^apprehension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,1,2,0)
 ;;=4058^increased tension/helplessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,1,3,0)
 ;;=4060^uncertainty^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,1,4,0)
 ;;=4063^extraneous movement ie., foot shuffling, hand/arm movements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,1,5,0)
 ;;=4067^sympathetic stimulation-cardiovascular excitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6679,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6697,0)
 ;;=performs bathing with [min/mod/max] assistance [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6697,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6697,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6766,0)
 ;;=[Extra Problem]^2^NURSC^2^16^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,6766,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6766,1,1,0)
 ;;=6767^Etiology/Related and/or Risk Factors^2^NURSC^260
 ;;^UTILITY("^GMRD(124.2,",$J,6766,1,2,0)
 ;;=6771^Goals/Expected Outcomes^2^NURSC^271
 ;;^UTILITY("^GMRD(124.2,",$J,6766,1,3,0)
 ;;=6775^Nursing Intervention/Orders^2^NURSC^273
 ;;^UTILITY("^GMRD(124.2,",$J,6766,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6766,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6766,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6767,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^260^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6767,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6767,1,1,0)
 ;;=6769^[etiology]^3^NURSC^71
 ;;^UTILITY("^GMRD(124.2,",$J,6767,1,2,0)
 ;;=6770^[etiology]^3^NURSC^72
 ;;^UTILITY("^GMRD(124.2,",$J,6767,1,3,0)
 ;;=7012^[etiology]^3^NURSC^36
 ;;^UTILITY("^GMRD(124.2,",$J,6767,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6768,0)
 ;;=[etiology]^3^NURSC^^70^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6769,0)
 ;;=[etiology]^3^NURSC^^71^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6770,0)
 ;;=[etiology]^3^NURSC^^72^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6771,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^271^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6771,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6771,1,1,0)
 ;;=6772^[Extra Goal]^3^NURSC^329
 ;;^UTILITY("^GMRD(124.2,",$J,6771,1,2,0)
 ;;=6773^[Extra Goal]^3^NURSC^330
 ;;^UTILITY("^GMRD(124.2,",$J,6771,1,3,0)
 ;;=6774^[Extra Goal]^3^NURSC^331
 ;;^UTILITY("^GMRD(124.2,",$J,6771,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6772,0)
 ;;=[Extra Goal]^3^NURSC^9^329^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6772,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6772,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6773,0)
 ;;=[Extra Goal]^3^NURSC^9^330^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6773,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6773,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6774,0)
 ;;=[Extra Goal]^3^NURSC^9^331^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6774,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6774,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6775,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^273^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6775,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6775,1,1,0)
 ;;=6776^[Extra Order]^3^NURSC^336
 ;;^UTILITY("^GMRD(124.2,",$J,6775,1,2,0)
 ;;=6778^[Extra Order]^3^NURSC^337
 ;;^UTILITY("^GMRD(124.2,",$J,6775,1,3,0)
 ;;=6779^[Extra Order]^3^NURSC^338
 ;;^UTILITY("^GMRD(124.2,",$J,6775,7)
 ;;=D EN4^NURCCPU1
