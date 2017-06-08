NURCCG5N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,2,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,3,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,4,0)
 ;;=1389^Health Maintenance, Alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,5,0)
 ;;=2257^Home Maintenance Management, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,6,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,7,0)
 ;;=1936^Sexual Dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,1,8,0)
 ;;=1937^Sexual Pattern, Altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2253,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2254,0)
 ;;=development transition and/or crisis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2255,0)
 ;;=situational transition and/or crisis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2256,0)
 ;;=interacts with an assigned staff member [ ] min/shift^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2256,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2256,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2257,0)
 ;;=Home Maintenance Management, Impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2258,0)
 ;;=interacts with an assigned staff member [ ] min/day^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2258,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2258,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2259,0)
 ;;=reports effective communications among family members^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2259,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2259,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2260,0)
 ;;=interacts with another patient [ ] times per shift^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2260,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2260,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2261,0)
 ;;=interacts with another patient [ ] times per day^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2261,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2261,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2262,0)
 ;;=family demonstrates effective problem solving^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2262,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2262,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2263,0)
 ;;=reports resolution of family conflicts^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2263,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2263,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2264,0)
 ;;=attends and participates in assigned groups^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2264,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2264,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2265,0)
 ;;=family members demonstrate healthy family interactions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2265,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2265,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2266,0)
 ;;=observe family for healthy/pathological family dynamics^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2266,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2266,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2267,0)
 ;;=mediate interpersonal communications without taking sides^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2267,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2267,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2268,0)
 ;;=listen to expressions of fear of change^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2268,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2268,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2269,0)
 ;;=tasks with S/O for [ ] minutes each week^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2269,9)
 ;;=D EN5^NURCCPU0
