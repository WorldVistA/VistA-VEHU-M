NURCCG4O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1793,0)
 ;;=maintains intact tissue surrounding lesion^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1793,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1793,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1794,0)
 ;;=describes healing process and health care precautions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1794,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1794,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1795,0)
 ;;=does not use drugs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1795,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1795,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1796,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^43^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,1,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,2,0)
 ;;=1799^pulse q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,3,0)
 ;;=427^respiratory pattern q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,4,0)
 ;;=1638^electrolytes q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,5,0)
 ;;=1800^skin turgor q [frequency] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,6,0)
 ;;=1801^assess status of healing wound q [frequency] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,7,0)
 ;;=1803^passive ROM as tolerated q [frequency] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,8,0)
 ;;=1804^active exercises encouraged (if indicated) [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,9,0)
 ;;=1807^provide hi-protein diet^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,10,0)
 ;;=1811^provide adequate fluids [ ]cc/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,11,0)
 ;;=1813^use aseptic technique when changing dressing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,12,0)
 ;;=1814^teach patient^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,13,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,1,14,0)
 ;;=2997^[Extra Order]^3^NURSC^82^0
 ;;^UTILITY("^GMRD(124.2,",$J,1796,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1796,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1797,0)
 ;;=achieves intact skin^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1797,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1797,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1798,0)
 ;;=develops granulation tissue at wound edges^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1798,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1798,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1799,0)
 ;;=pulse q[frequency]hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1799,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1799,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1800,0)
 ;;=skin turgor q [frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1800,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1800,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1800,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1801,0)
 ;;=assess status of healing wound q [frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1801,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1801,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1801,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1802,0)
 ;;=perform skin assessment & document findings related to:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,1,0)
 ;;=1805^area(s) in question [location] q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,2,0)
 ;;=1806^color q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1802,1,3,0)
 ;;=1808^size q[frequency]^3^NURSC^1^0
