NURCCG5C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,6,0)
 ;;=2126^writes lifestyle goals prior to discharge^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,7,0)
 ;;=2127^develops written plan to overcome inadequacies by D/C^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,8,0)
 ;;=2689^writes list of support persons/agencies before discharge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,9,0)
 ;;=2690^makes contact with support person/agency prior to D/C^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,10,0)
 ;;=2920^[Extra Goal]^3^NURSC^101^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2121,0)
 ;;=free of S/S of substance withdrawl within [# of days] days^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2121,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2121,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2122,0)
 ;;=verbalizes no anxiety towards being drug free by [date]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2122,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2122,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2123,0)
 ;;=verbalizes 3 changes in lifestyle^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2123,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2123,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2124,0)
 ;;=identifies 3 past behaviors which lead to drug abuse^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2124,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2124,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2125,0)
 ;;=discusses feelings of loss re: giving up drugs by [date]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2125,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2125,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2126,0)
 ;;=writes lifestyle goals prior to discharge^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,1,0)
 ;;=904^physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,2,0)
 ;;=2140^mental^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,3,0)
 ;;=2141^social^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,4,0)
 ;;=2142^spiritual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,5,0)
 ;;=2143^financial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,1,6,0)
 ;;=1566^family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,5)
 ;;=concerning:
 ;;^UTILITY("^GMRD(124.2,",$J,2126,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2126,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2126,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2127,0)
 ;;=develops written plan to overcome inadequacies by D/C^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2127,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2127,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2128,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^51^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,0)
 ;;=^124.21PI^21^21
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,1,0)
 ;;=2129^monitor fluid and food intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,2,0)
 ;;=2130^administer medication as ordered for S/S of withdrawal^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,3,0)
 ;;=2131^assign 1:1 relationship with nursing staff^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,4,0)
 ;;=2132^remind patient that withdrawl is a temporary condition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,5,0)
 ;;=2133^build trust and rapport^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,6,0)
 ;;=2134^allow patient to ventilate fears^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,7,0)
 ;;=2135^assist pt. to identify need for lifestyle change^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,8,0)
 ;;=2136^teach simple stress reduction techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2128,1,9,0)
 ;;=2137^assist in identifying consequences of negative behavior^3^NURSC^1^0
