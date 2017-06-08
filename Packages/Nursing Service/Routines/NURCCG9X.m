NURCCG9X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5349,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5349,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5350,0)
 ;;=[Extra Goal]^3^NURSC^9^310^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5350,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5350,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5351,0)
 ;;=Defining Characteristics^2^NURSC^12^64^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5351,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5351,1,1,0)
 ;;=4275^verbalization of the problem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5351,1,2,0)
 ;;=5357^inaccurate follow-through^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5351,1,3,0)
 ;;=5359^inaccurate performance of skill(s)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5351,1,4,0)
 ;;=5360^inappropriate/exaggerated behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5351,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5352,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^261^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5352,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5352,1,1,0)
 ;;=5353^[Extra Order]^3^NURSC^312
 ;;^UTILITY("^GMRD(124.2,",$J,5352,1,2,0)
 ;;=5354^[Extra Order]^3^NURSC^313
 ;;^UTILITY("^GMRD(124.2,",$J,5352,1,3,0)
 ;;=5355^[Extra Order]^3^NURSC^314
 ;;^UTILITY("^GMRD(124.2,",$J,5352,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5352,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5353,0)
 ;;=[Extra Order]^3^NURSC^11^312^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5353,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5353,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5354,0)
 ;;=[Extra Order]^3^NURSC^11^313^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5354,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5354,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5355,0)
 ;;=[Extra Order]^3^NURSC^11^314^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5355,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5355,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5356,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^261^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,1,0)
 ;;=5358^re-establishes control over urination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,2,0)
 ;;=5361^demonstrates reduced retention by voiding [ ]cc per void^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,3,0)
 ;;=5364^verbalizes decrease in frequency, pain, urgency, nocturia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,4,0)
 ;;=5365^demonstrates proper catheter care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,5,0)
 ;;=5370^verbalizes relief of suprapubic discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,6,0)
 ;;=5372^verbalize reportable signs and symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,7,0)
 ;;=5374^demonstrate adaptation to change in body function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5356,1,8,0)
 ;;=6030^[Extra Goal]^3^NURSC^70
 ;;^UTILITY("^GMRD(124.2,",$J,5356,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5357,0)
 ;;=inaccurate follow-through^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5358,0)
 ;;=re-establishes control over urination^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5358,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5358,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5359,0)
 ;;=inaccurate performance of skill(s)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5360,0)
 ;;=inappropriate/exaggerated behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5361,0)
 ;;=demonstrates reduced retention by voiding [ ]cc per void^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5361,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5361,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5362,0)
 ;;=Defining Characteristics^2^NURSC^12^65^1^^T^1
