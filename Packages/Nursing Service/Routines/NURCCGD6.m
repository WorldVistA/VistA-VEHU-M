NURCCGD6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,36,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11196,0)
 ;;=[Extra Order]^3^NURSC^11^184^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11196,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11196,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11197,0)
 ;;=Defining Characteristics^2^NURSC^12^130^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11197,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11204,0)
 ;;=Infection Potential^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11204,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11204,1,1,0)
 ;;=11205^Etiology/Related and/or Risk Factors^2^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,11204,1,2,0)
 ;;=11236^Goals/Expected Outcomes^2^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,11204,1,3,0)
 ;;=11247^Nursing Intervention/Orders^2^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,11204,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11204,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11204,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11204,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,11204,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,11204,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,11205,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^151^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11205,1,0)
 ;;=^124.21PI^15^2
 ;;^UTILITY("^GMRD(124.2,",$J,11205,1,7,0)
 ;;=483^medical procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11205,1,15,0)
 ;;=2428^bypassing normal body defenses by suctioning, intubation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11205,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11210,0)
 ;;=monitor glucose levels q[specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11210,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11210,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11236,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^149^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11236,1,0)
 ;;=^124.21PI^10^4
 ;;^UTILITY("^GMRD(124.2,",$J,11236,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11236,1,8,0)
 ;;=11381^[Extra Goal]^3^NURSC^184
 ;;^UTILITY("^GMRD(124.2,",$J,11236,1,9,0)
 ;;=15514^remains free of S/S of pulmonary infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11236,1,10,0)
 ;;=15515^remains free of S/S of surgical wound infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11236,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11246,0)
 ;;=[Extra Goal]^3^NURSC^9^182^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11246,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11246,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11247,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^125^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,0)
 ;;=^124.21PI^23^6
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,18,0)
 ;;=11617^[Extra Order]^3^NURSC^189
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,19,0)
 ;;=4818^assess,monitor,document sputum color/consistancy/amount q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11247,1,20,0)
 ;;=15520^change incisional dressings q[frequency]^3^NURSC^1
