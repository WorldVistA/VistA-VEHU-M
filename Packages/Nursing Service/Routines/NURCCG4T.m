NURCCG4T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,12,0)
 ;;=1872^provide skin/foot care (bathe with warm water)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,13,0)
 ;;=1873^oral hygiene q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,14,0)
 ;;=1877^aseptic dressing change q [frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,15,0)
 ;;=1878^provide comfort measures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,16,0)
 ;;=1883^maintain comfortable room temperatures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,17,0)
 ;;=1885^provide and document results of ordered analgesics^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,18,0)
 ;;=1891^avoid pillow under knee and elevating knee gatch^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,19,0)
 ;;=1892^avoid dangling extremities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,20,0)
 ;;=1894^avoid constrictive clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,21,0)
 ;;=1896^provide patient instruction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,22,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,23,0)
 ;;=1057^PT/PTT q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,24,0)
 ;;=2999^[Extra Order]^3^NURSC^85^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1841,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1842,0)
 ;;=inadequate coping method^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1843,0)
 ;;=inadequate relaxation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1844,0)
 ;;=inadequate support systems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1845,0)
 ;;=little or no exercise^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1846,0)
 ;;=peripheral pulses q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1846,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1846,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1846,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1847,0)
 ;;=maturational crises^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1848,0)
 ;;=multiple life changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1849,0)
 ;;=personal vulnerability^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1850,0)
 ;;=poor nutrition^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1851,0)
 ;;=situational crises^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1852,0)
 ;;=too many deadlines^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1853,0)
 ;;=unmet expectations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1854,0)
 ;;=unrealistic perceptions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1855,0)
 ;;=identify status of capillary filling (and document)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1855,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1855,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1856,0)
 ;;=work overload^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1857,0)
 ;;=identify presence of pain (and document)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1857,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1857,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1858,0)
 ;;=assess motor sensory function q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1858,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1858,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1859,0)
 ;;=communicates [# of] feelings about present situation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1859,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1859,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1860,0)
 ;;=elevate affected leg(s) to promote venous return^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1860,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1860,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1861,0)
 ;;=identifies two factors contributing to ineffective coping^3^NURSC^9^1^^^T
