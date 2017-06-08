NURCCG5A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2086,0)
 ;;=grief^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2087,0)
 ;;=survivor guilt^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2088,0)
 ;;=administer medication as ordered for S/S of withdrawal^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2088,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2088,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2089,0)
 ;;=develops 3 alternative coping methods prior to D/C^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2089,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2089,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2090,0)
 ;;=verbalizes existence of flashbacks^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2090,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2090,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2091,0)
 ;;=verbalizes intrusive thoughts^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2091,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2091,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2092,0)
 ;;=verbalizes nightmares^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2092,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2092,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2093,0)
 ;;=verbalizes repetitive dreams^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2093,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2093,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2094,0)
 ;;=verbalizes emotional numbness^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2094,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2094,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2095,0)
 ;;=verbalizes social isolation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2095,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2095,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2096,0)
 ;;=verbalizes other stress related symptoms: [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2096,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2096,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2097,0)
 ;;=encourage balanced nutritional intake each meal^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2097,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2097,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2098,0)
 ;;=check sensorium q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2098,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2098,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2099,0)
 ;;=reassure patient at onset that symptoms are temporary^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2099,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2099,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2100,0)
 ;;=provide quiet environment to decrease stimuli^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2100,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2100,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2101,0)
 ;;=provide education/instruction within [ ]days of admission^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2101,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2101,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2102,0)
 ;;=provide physical sequelae within [ ] days of admission^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2102,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2102,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2103,0)
 ;;=be available for patient's questions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2103,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2103,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2104,0)
 ;;=encourage pt to list areas adversely affected within [ ]days^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2104,9)
 ;;=D EN2^NURCCPU2
