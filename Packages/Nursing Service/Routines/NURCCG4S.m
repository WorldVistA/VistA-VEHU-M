NURCCG4S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,6,0)
 ;;=1865^expresses feeling of greater control over stressors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,7,0)
 ;;=1866^demonstrates problem solving skills such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,1,8,0)
 ;;=2912^[Extra Goal]^3^NURSC^92^0
 ;;^UTILITY("^GMRD(124.2,",$J,1838,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1839,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^44^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,1,0)
 ;;=1875^encourage discussion of blocks to coping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,2,0)
 ;;=1876^assist in listing factors contributing to inadequate coping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,3,0)
 ;;=1879^assist in listing alternative methods of managing stressors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,4,0)
 ;;=1882^assist in evaluating current situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,5,0)
 ;;=1884^help identify ways of fulfilling role expectations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,6,0)
 ;;=1886^provide positive feedback for effective coping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,7,0)
 ;;=1887^involve patient in planning own care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,8,0)
 ;;=1888^teach the following:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,9,0)
 ;;=1874^encourage verbalization of feelings^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,1,10,0)
 ;;=2998^[Extra Order]^3^NURSC^84^0
 ;;^UTILITY("^GMRD(124.2,",$J,1839,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1839,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1840,0)
 ;;=Related Problems^2^NURSC^7^37^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,1,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,3,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,5,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,6,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,7,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,8,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,1,9,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1840,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1841,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^168^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,0)
 ;;=^124.21PI^24^24
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,1,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,2,0)
 ;;=1846^peripheral pulses q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,3,0)
 ;;=1855^identify status of capillary filling (and document)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,4,0)
 ;;=1857^identify presence of pain (and document)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,5,0)
 ;;=1858^assess motor sensory function q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,6,0)
 ;;=330^elevate head of bed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,7,0)
 ;;=1860^elevate affected leg(s) to promote venous return^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,8,0)
 ;;=1867^do not elevate bed; arterial & venous flow compromised^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,9,0)
 ;;=1803^passive ROM as tolerated q [frequency] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,10,0)
 ;;=1868^avoid prolonged sitting/standing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1841,1,11,0)
 ;;=1562^apply antiemboli hose q [frequency] hrs^3^NURSC^1^0
