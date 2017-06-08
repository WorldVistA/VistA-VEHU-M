NURCCG5E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,2,0)
 ;;=904^physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,3,0)
 ;;=2141^social^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,4,0)
 ;;=2142^spiritual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,5,0)
 ;;=2143^financial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2139,1,6,0)
 ;;=1566^family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2139,5)
 ;;=in six major areas of life
 ;;^UTILITY("^GMRD(124.2,",$J,2139,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2139,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2139,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2140,0)
 ;;=mental^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2141,0)
 ;;=social^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2142,0)
 ;;=spiritual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2143,0)
 ;;=financial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2144,0)
 ;;=states presenting S/S to coorect stress response^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2144,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2144,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2145,0)
 ;;=reports absence/significant decrease in stress symptoms^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2145,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2145,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2146,0)
 ;;=develops written plan for achieving major life goals^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2146,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2146,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2147,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^52^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,1,0)
 ;;=2148^assess for S/S of additional patient problems^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,2,0)
 ;;=2153^build trust and rapport^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,3,0)
 ;;=2158^encourage participation in self help groups [specify] ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,4,0)
 ;;=2139^encourage pt. to have written goals by discharge^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,5,0)
 ;;=2159^teach^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2147,1,6,0)
 ;;=3007^[Extra Order]^3^NURSC^93^0
 ;;^UTILITY("^GMRD(124.2,",$J,2147,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2147,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2148,0)
 ;;=assess for S/S of additional patient problems^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,1,0)
 ;;=207^depression, severe anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,2,0)
 ;;=2149^potential for violence [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,3,0)
 ;;=2150^sleep pattern disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,4,0)
 ;;=2151^strees response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,5,0)
 ;;=2152^fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2148,1,6,0)
 ;;=88^social isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2148,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,2148,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2148,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2148,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2149,0)
 ;;=potential for violence [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2150,0)
 ;;=sleep pattern disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2151,0)
 ;;=strees response^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2152,0)
 ;;=fear^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2153,0)
 ;;=build trust and rapport^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2153,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2153,1,1,0)
 ;;=2154^making frequent intermittent contacts to offer support^3^NURSC^1^0
