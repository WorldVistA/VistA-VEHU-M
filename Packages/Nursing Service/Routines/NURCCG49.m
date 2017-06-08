NURCCG49 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1594,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1594,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1594,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1595,0)
 ;;=B/P lying and standing q[frequency]hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1595,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1595,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1595,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1596,0)
 ;;=laboratory data q [frequency]^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1596,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1596,1,1,0)
 ;;=1597^CBC^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1596,1,2,0)
 ;;=1598^electrolytes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1596,1,3,0)
 ;;=1599^total serum protein^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1596,1,4,0)
 ;;=1600^urine specific gravity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1596,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1596,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1596,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1596,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1596,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1597,0)
 ;;=CBC^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1598,0)
 ;;=electrolytes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1599,0)
 ;;=total serum protein^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1600,0)
 ;;=urine specific gravity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1601,0)
 ;;=encourage fluid intake of [amt]cc/24hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1601,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1601,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1602,0)
 ;;=limit foods acting as diuretics (sugar, alcohol,caffeine)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1602,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1602,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1603,0)
 ;;=maintain activity level commensurate with health state^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1603,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1603,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1604,0)
 ;;=give verbal/written directions for desired fluid amts.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1604,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1604,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1605,0)
 ;;=include patient and S/O in recording I/O^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1605,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1605,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1606,0)
 ;;=normal saline irrigation to gastric tube q[ ]hrs.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1606,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1606,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1607,0)
 ;;=offer mouth swabs if NPO or on gastric tube q [ ] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1607,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1607,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1608,0)
 ;;=weigh dressings to record wound loss^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1608,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1608,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1609,0)
 ;;=replace fluids [ ]cc for [ ]cc drainage q[ ]hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1609,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1609,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1610,0)
 ;;=initiate febrile protocol^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1610,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1610,1,1,0)
 ;;=1611^cooling blanket if temperature exceeds [ ] degrees F^3^NURSC^1^0
