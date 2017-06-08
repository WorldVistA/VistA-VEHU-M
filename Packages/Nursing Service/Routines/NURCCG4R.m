NURCCG4R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1831,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1831,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1831,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1832,0)
 ;;=Manic Behavior^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1832,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1832,1,1,0)
 ;;=2365^Etiology/Related and/or Risk Factors^2^NURSC^66^0
 ;;^UTILITY("^GMRD(124.2,",$J,1832,1,2,0)
 ;;=2373^Related Problems^2^NURSC^53^0
 ;;^UTILITY("^GMRD(124.2,",$J,1832,1,3,0)
 ;;=2379^Goals/Expected Outcomes^2^NURSC^65^0
 ;;^UTILITY("^GMRD(124.2,",$J,1832,1,4,0)
 ;;=2381^Nursing Intervention/Orders^2^NURSC^60^0
 ;;^UTILITY("^GMRD(124.2,",$J,1832,1,5,0)
 ;;=4330^Defining Characteristics^2^NURSC^53
 ;;^UTILITY("^GMRD(124.2,",$J,1832,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1832,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1832,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1833,0)
 ;;=demonstrates measures to improve circulation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1833,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1833,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1834,0)
 ;;=demonstrates progressive tolerance to increased activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1834,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1834,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1835,0)
 ;;=remains free from leg pain related to claudication^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1835,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1835,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1836,0)
 ;;=SMA-6/SMA-12, CBC, and differential WNL^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1836,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1836,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1837,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^49^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,1,0)
 ;;=1842^inadequate coping method^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,2,0)
 ;;=1843^inadequate relaxation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,3,0)
 ;;=1844^inadequate support systems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,4,0)
 ;;=1845^little or no exercise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,5,0)
 ;;=1847^maturational crises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,6,0)
 ;;=1848^multiple life changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,7,0)
 ;;=1849^personal vulnerability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,8,0)
 ;;=1850^poor nutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,9,0)
 ;;=1851^situational crises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,10,0)
 ;;=1852^too many deadlines^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,11,0)
 ;;=1853^unmet expectations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,12,0)
 ;;=1854^unrealistic perceptions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,1,13,0)
 ;;=1856^work overload^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1837,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1838,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^48^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,1,0)
 ;;=1859^communicates [# of] feelings about present situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,2,0)
 ;;=1861^identifies two factors contributing to ineffective coping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,3,0)
 ;;=1862^identifies three alternative methods of managing stressors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,4,0)
 ;;=1863^identifies and develops plan to meet role expectations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,5,0)
 ;;=1864^establishes written routine to meet basic needs^3^NURSC^1^0
