NURCCGAD ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6068,0)
 ;;=[Extra Goal]^3^NURSC^9^322^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6068,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6068,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6069,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^269^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6069,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6069,1,1,0)
 ;;=6070^[Extra Order]^3^NURSC^327
 ;;^UTILITY("^GMRD(124.2,",$J,6069,1,2,0)
 ;;=6071^[Extra Order]^3^NURSC^328
 ;;^UTILITY("^GMRD(124.2,",$J,6069,1,3,0)
 ;;=6072^[Extra Order]^3^NURSC^329
 ;;^UTILITY("^GMRD(124.2,",$J,6069,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6069,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6070,0)
 ;;=[Extra Order]^3^NURSC^11^327^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6070,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6070,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6071,0)
 ;;=[Extra Order]^3^NURSC^11^328^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6071,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6071,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6072,0)
 ;;=[Extra Order]^3^NURSC^11^329^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6072,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6072,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6073,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6073,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6073,1,1,0)
 ;;=6074^Etiology/Related and/or Risk Factors^2^NURSC^85
 ;;^UTILITY("^GMRD(124.2,",$J,6073,1,2,0)
 ;;=6083^Related Problems^2^NURSC^73
 ;;^UTILITY("^GMRD(124.2,",$J,6073,1,3,0)
 ;;=6088^Goals/Expected Outcomes^2^NURSC^84
 ;;^UTILITY("^GMRD(124.2,",$J,6073,1,4,0)
 ;;=6100^Nursing Intervention/Orders^2^NURSC^172
 ;;^UTILITY("^GMRD(124.2,",$J,6073,1,5,0)
 ;;=6159^Defining Characteristics^2^NURSC^79
 ;;^UTILITY("^GMRD(124.2,",$J,6073,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6073,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6073,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6073,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,6073,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,6073,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,6074,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^85^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6074,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,6074,1,1,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6074,1,2,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6074,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6074,1,6,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6074,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6083,0)
 ;;=Related Problems^2^NURSC^7^73^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6083,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6083,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6083,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6083,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6083,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6083,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6088,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^84^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6088,1,0)
 ;;=^124.21PI^11^2
 ;;^UTILITY("^GMRD(124.2,",$J,6088,1,6,0)
 ;;=2714^no signs of paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6088,1,11,0)
 ;;=6193^[Extra Goal]^3^NURSC^123
