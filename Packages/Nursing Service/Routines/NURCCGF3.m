NURCCGF3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,2,0)
 ;;=2207^offer PRN medication when indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,3,0)
 ;;=2208^promote activities to increase self-esteem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,4,0)
 ;;=2209^include family or S/O in group therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,5,0)
 ;;=2210^praise patient for use of assertive actions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,6,0)
 ;;=2211^praise patient for use of physical exercise^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,7,0)
 ;;=14110^teach alternative methods to deal with anger [specify]^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,9,0)
 ;;=2425^reinforce that patient can maintain control^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,10,0)
 ;;=14135^assist to identify measures preventing destructive conduct^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,11,0)
 ;;=14137^assist in identifying self destructive thoughts/behaviors^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,12,0)
 ;;=14513^[Extra Order]^3^NURSC^252
 ;;^UTILITY("^GMRD(124.2,",$J,14097,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14098,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^186^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,0)
 ;;=^124.21PI^14^13
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,1,0)
 ;;=2082^verbalizes experience of overwhelming events by [date]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,3,0)
 ;;=2089^develops 3 alternative coping methods prior to D/C^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,4,0)
 ;;=2090^verbalizes existence of flashbacks^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,5,0)
 ;;=14117^verbalizes relationship of past trauma and present situation^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,6,0)
 ;;=14119^demonstrates alternative coping methods for stress^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,7,0)
 ;;=14120^identifies triggers to impulsive behavior^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,8,0)
 ;;=2094^verbalizes emotional numbness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,9,0)
 ;;=14124^develops strategies to improve interpersonal relationships^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,10,0)
 ;;=14125^identifies feelings,behaviors,events associated with trauma^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,11,0)
 ;;=2144^states presenting S/S to coorect stress response^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,12,0)
 ;;=2145^reports absence/significant decrease in stress symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,13,0)
 ;;=2146^develops written plan for achieving major life goals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14098,1,14,0)
 ;;=14390^[Extra Goal]^3^NURSC^245
 ;;^UTILITY("^GMRD(124.2,",$J,14098,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14110,0)
 ;;=teach alternative methods to deal with anger [specify]^3^NURSC^11^6^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,14110,1,0)
 ;;=^124.21PI^0^0
 ;;^UTILITY("^GMRD(124.2,",$J,14110,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14110,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14117,0)
 ;;=verbalizes relationship of past trauma and present situation^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14117,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14117,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14119,0)
 ;;=demonstrates alternative coping methods for stress^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14119,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14119,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14120,0)
 ;;=identifies triggers to impulsive behavior^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14120,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14120,10)
 ;;=D EN2^NURCCPU1
