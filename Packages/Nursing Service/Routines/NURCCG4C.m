NURCCG4C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1634,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1635,0)
 ;;=hematocrit q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1635,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1635,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1635,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1636,0)
 ;;=hemoglobin q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1636,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1636,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1636,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1637,0)
 ;;=notify MD of lab results if indicated^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1637,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1637,1,1,0)
 ;;=2949^ABGs^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1637,1,2,0)
 ;;=2950^hematocrit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1637,1,3,0)
 ;;=2951^hemoglobin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1637,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1637,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1637,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1638,0)
 ;;=electrolytes q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1638,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1638,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1639,0)
 ;;=dress patient in light-weight, single layer clothing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1639,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1639,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1640,0)
 ;;=encourage bedrest^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1640,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1640,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1641,0)
 ;;=maintain cool room temperature^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1641,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1641,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1642,0)
 ;;=give cool liquids PO q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1642,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1642,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1643,0)
 ;;=bathe patient in cool water [with/without] [alcohol/ice]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1643,5)
 ;;=as indicated
 ;;^UTILITY("^GMRD(124.2,",$J,1643,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1643,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1644,0)
 ;;=apply cooling mattress as prescribed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1644,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1644,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1645,0)
 ;;=administer antipyretics as ordered^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1645,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1645,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1646,0)
 ;;=report use of prescibed/recreational drugs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1646,5)
 ;;=that interfer with thermoregulation
 ;;^UTILITY("^GMRD(124.2,",$J,1646,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1646,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1647,0)
 ;;=aging^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1648,0)
 ;;=consumption of alcohol^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1649,0)
 ;;=decreased metabolic rate^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1650,0)
 ;;=evaporation from skin in environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1651,0)
 ;;=exposure to cool or cold environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1652,0)
 ;;=inability or decreased ability to shiver^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1653,0)
 ;;=inactivity^3^NURSC^^1^^^T
