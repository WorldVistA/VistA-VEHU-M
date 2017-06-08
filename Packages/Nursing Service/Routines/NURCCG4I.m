NURCCG4I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,5,0)
 ;;=1715^relate pathology to patient's symptoms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,6,0)
 ;;=1748^stress avoidance of crossing legs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,7,0)
 ;;=1750^stress avoidance of standing for long periods^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,8,0)
 ;;=1751^stress avoidance of restrictive clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,9,0)
 ;;=1753^elevate legs when feasible^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,10,0)
 ;;=1755^include S/O when instructing as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,11,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,12,0)
 ;;=1716^teach diagnostic and therapeutic procedures/tests^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,13,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,14,0)
 ;;=1737^teach dietary needs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,15,0)
 ;;=2995^[Extra Order]^3^NURSC^80^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1705,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1706,0)
 ;;=assess pt's knowledge base concerning his illness^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1706,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1706,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1706,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1707,0)
 ;;=identify cause of lack of knowledge^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1707,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1707,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1708,0)
 ;;=pathophysical:diabetes,periodontal disease,infection,oral CA^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1709,0)
 ;;=determine readiness/ability to learn^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1709,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1709,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1710,0)
 ;;=teach cardiac instructions based on pt's learning level^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1710,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1710,1,1,0)
 ;;=1711^basic anatomy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1710,1,2,0)
 ;;=1712^physiology of the heart^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1710,1,3,0)
 ;;=1137^congestive heart failure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1710,1,4,0)
 ;;=1713^coronary artery disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1710,1,5,0)
 ;;=1714^myocardial infarction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1710,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1710,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1710,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1710,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1711,0)
 ;;=basic anatomy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1712,0)
 ;;=physiology of the heart^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1713,0)
 ;;=coronary artery disease^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1714,0)
 ;;=myocardial infarction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1715,0)
 ;;=relate pathology to patient's symptoms^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1715,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1715,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1716,0)
 ;;=teach diagnostic and therapeutic procedures/tests^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,1,0)
 ;;=1717^central venous pressure line^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,2,0)
 ;;=1718^Swan-Ganz line^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1716,1,3,0)
 ;;=1719^arterial line^3^NURSC^1^0
