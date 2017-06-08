NURCCG6J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,4,0)
 ;;=430^percussion q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,5,0)
 ;;=2706^effective position/pattern for coughing^2^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,6,0)
 ;;=2710^splint incision while coughing/suctioning^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,7,0)
 ;;=2711^incentive spirometry q[frequency] hrs^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,8,0)
 ;;=4766^vibrations q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,1,9,0)
 ;;=4767^cough/turn/deep breathe q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2702,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2702,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2703,0)
 ;;=administer bronchodilators as ordered^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2703,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2703,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2704,0)
 ;;=administer aerosol via large volume nebulizer^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2705,0)
 ;;=postural drainage q[specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2706,0)
 ;;=effective position/pattern for coughing^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2706,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2706,1,1,0)
 ;;=2707^cascade (staged)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2706,1,2,0)
 ;;=2708^end expiration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2706,1,3,0)
 ;;=2709^upright position^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2706,5)
 ;;=:
 ;;^UTILITY("^GMRD(124.2,",$J,2706,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2707,0)
 ;;=cascade (staged)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2708,0)
 ;;=end expiration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2709,0)
 ;;=upright position^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2710,0)
 ;;=splint incision while coughing/suctioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2711,0)
 ;;=incentive spirometry q[frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2711,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2711,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2712,0)
 ;;=tracheostomy care q[frequency]^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2713,0)
 ;;=no signs of respiratory alternans or paradoxical breathing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2713,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2713,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2714,0)
 ;;=no signs of paradoxical breathing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2714,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2714,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2715,0)
 ;;=remains free of hypercapnea^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2715,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2715,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2716,0)
 ;;=assess bladder history^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2716,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2716,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2717,0)
 ;;=maintains records to determine bladder patterns^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2717,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2717,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2718,0)
 ;;=Speech Therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2719,0)
 ;;=effective airway clearance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2720,0)
 ;;=related problems [specify] will be treated^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2720,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2720,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2721,0)
 ;;=assess causative, contributing factors^3^NURSC^11^2^^^T
