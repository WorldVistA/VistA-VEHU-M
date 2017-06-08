NURCCGAJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6348,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^270^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6348,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6348,1,1,0)
 ;;=6349^[Extra Order]^3^NURSC^330
 ;;^UTILITY("^GMRD(124.2,",$J,6348,1,2,0)
 ;;=6350^[Extra Order]^3^NURSC^331
 ;;^UTILITY("^GMRD(124.2,",$J,6348,1,3,0)
 ;;=6351^[Extra Order]^3^NURSC^332
 ;;^UTILITY("^GMRD(124.2,",$J,6348,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6348,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6349,0)
 ;;=[Extra Order]^3^NURSC^11^330^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6349,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6349,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6350,0)
 ;;=[Extra Order]^3^NURSC^11^331^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6350,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6350,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6351,0)
 ;;=[Extra Order]^3^NURSC^11^332^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6351,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6351,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6352,0)
 ;;=Skin Integrity, Impairment Of (Actual)^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6352,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6352,1,1,0)
 ;;=6353^Etiology/Related and/or Risk Factors^2^NURSC^89
 ;;^UTILITY("^GMRD(124.2,",$J,6352,1,2,0)
 ;;=6371^Goals/Expected Outcomes^2^NURSC^88
 ;;^UTILITY("^GMRD(124.2,",$J,6352,1,3,0)
 ;;=6381^Nursing Intervention/Orders^2^NURSC^175
 ;;^UTILITY("^GMRD(124.2,",$J,6352,1,4,0)
 ;;=6410^Related Problems^2^NURSC^76
 ;;^UTILITY("^GMRD(124.2,",$J,6352,1,5,0)
 ;;=6414^Defining Characteristics^2^NURSC^83
 ;;^UTILITY("^GMRD(124.2,",$J,6352,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6352,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6352,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6352,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,6352,"TD",1,0)
 ;;=A state in which the individual's skin is adversely altered.
 ;;^UTILITY("^GMRD(124.2,",$J,6353,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^89^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,0)
 ;;=^124.21PI^16^9
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,2,0)
 ;;=1768^hyperthermia or hypothermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,3,0)
 ;;=825^mechanical factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,8,0)
 ;;=1776^alteration in skin turgor (change in elasticity)^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,9,0)
 ;;=1778^altered nutritional state (e.g. obesity,emaciation)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,10,0)
 ;;=1780^altered metabolic state^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,11,0)
 ;;=1781^edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,12,0)
 ;;=1783^excretions/secretions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,14,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,1,16,0)
 ;;=1788^psychogenic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6353,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6371,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^88^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6371,1,0)
 ;;=^124.21PI^9^2
 ;;^UTILITY("^GMRD(124.2,",$J,6371,1,2,0)
 ;;=6373^achieves wound healing^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6371,1,9,0)
 ;;=6491^[Extra Goal]^3^NURSC^127
 ;;^UTILITY("^GMRD(124.2,",$J,6371,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6373,0)
 ;;=achieves wound healing^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6373,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6373,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6380,0)
 ;;=[Extra Goal]^3^NURSC^9^126^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6380,9)
 ;;=D EN5^NURCCPU0
