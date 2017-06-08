NURCCG45 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1542,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1542,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1543,0)
 ;;=limit fluids to [amount]cc q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1543,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1543,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1544,0)
 ;;=B/P in [ ] extremity q[ ]hrs.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1544,4)
 ;;=assess, monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1544,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1544,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1545,0)
 ;;=passive/active ROM q[frequency]hrs.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1545,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1545,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1546,0)
 ;;=abdominal girth q[ ]hrs. and document^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1546,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1546,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1546,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1547,0)
 ;;=elevate feet while sitting^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1547,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1547,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1548,0)
 ;;=oral hygiene following meals, using soft brush^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1548,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1548,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1549,0)
 ;;=nails cleaned and cut^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1549,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1549,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1550,0)
 ;;=provide support to edematous areas^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1550,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1550,1,1,0)
 ;;=1551^pillow under arms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1550,1,2,0)
 ;;=1552^scrotal support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1550,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,1550,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1550,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1550,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1551,0)
 ;;=pillow under arms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1552,0)
 ;;=scrotal support^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1553,0)
 ;;=provide K+ rich fluids and increased protein/calories^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1553,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1553,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1554,0)
 ;;=restrict sodium intake to [specify]mg daily^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1554,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1554,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1555,0)
 ;;=reassure weight/fluid will decrease with therapy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1555,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1555,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1556,0)
 ;;=be accepting of patient's behavior^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1556,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1556,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1557,0)
 ;;=teach patient^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,1,0)
 ;;=1558^S/S of fluid overload^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,2,0)
 ;;=1559^taking and recording blood pressure as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,3,0)
 ;;=1560^sodium/protein restrictions; salt substitutes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,4,0)
 ;;=1561^shift of body weight q 15-30 minutes^3^NURSC^1^0
