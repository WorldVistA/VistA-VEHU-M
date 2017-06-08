NURCCG0Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,282,1,4,0)
 ;;=294^deteriorating personal appearance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,282,1,5,0)
 ;;=295^sleep pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,282,5)
 ;;=; monitor and document:
 ;;^UTILITY("^GMRD(124.2,",$J,282,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,282,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,282,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,283,0)
 ;;=administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,283,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,283,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,284,0)
 ;;=administer bronchodilators as ordered^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,284,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,284,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,285,0)
 ;;=plan activities to maximize medication/treatment benefits^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,285,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,285,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,286,0)
 ;;=provide [number of] minutes of rest between activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,286,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,286,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,287,0)
 ;;=passive/active ROM q[frequency]hrs.^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,287,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,287,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,288,0)
 ;;=initiate muscle strengthening/conditioning as indiciated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,288,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,288,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,289,0)
 ;;=refer for appropriate consults^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,289,1,9,0)
 ;;=15842^Psychology Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,289,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,289,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,289,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,289,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,290,0)
 ;;=teach patient^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,1,0)
 ;;=298^use of adaptive equipment to assist with ADLs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,2,0)
 ;;=498^pacing activities, exercise, rest^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,3,0)
 ;;=299^using analgesics appropriately^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,4,0)
 ;;=300^relaxation therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,5,0)
 ;;=2650^coordinating breathing with activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,6,0)
 ;;=2651^using pursed-lip breathing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,7,0)
 ;;=2652^use of Home Oxygen Therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,1,8,0)
 ;;=2653^using oral/inhaled bronchodialators (e.g., MDIs)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,290,5)
 ;;=in
 ;;^UTILITY("^GMRD(124.2,",$J,290,7)
 ;;=D EN4^NURCCPU1
