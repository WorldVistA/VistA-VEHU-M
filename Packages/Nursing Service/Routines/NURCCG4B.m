NURCCG4B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,4,0)
 ;;=1631^maintains electrolytes WNL [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,5,0)
 ;;=1632^attains/maintains laboratory data WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,6,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,7,0)
 ;;=1658^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,8,0)
 ;;=2905^[Extra Goal]^3^NURSC^85^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1628,0)
 ;;=maintains pulse rate and rhythm at baseline [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1628,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1628,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1629,0)
 ;;=skin warm to touch^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1629,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1629,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1630,0)
 ;;=maintains neurological functioning at baseline^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1630,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1630,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1631,0)
 ;;=maintains electrolytes WNL [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1631,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1631,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1632,0)
 ;;=attains/maintains laboratory data WNL^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1632,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1632,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1633,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^38^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,1,0)
 ;;=1266^sensorium q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,2,0)
 ;;=1637^notify MD of lab results if indicated^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,3,0)
 ;;=453^CBC with differential q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,4,0)
 ;;=1638^electrolytes q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,5,0)
 ;;=1634^ABGs/pulse oximetry q[frequency]^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,6,0)
 ;;=1057^PT/PTT q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,7,0)
 ;;=1639^dress patient in light-weight, single layer clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,8,0)
 ;;=1640^encourage bedrest^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,9,0)
 ;;=1641^maintain cool room temperature^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,10,0)
 ;;=1147^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,11,0)
 ;;=1642^give cool liquids PO q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,12,0)
 ;;=1643^bathe patient in cool water [with/without] [alcohol/ice]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,13,0)
 ;;=1644^apply cooling mattress as prescribed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,14,0)
 ;;=1645^administer antipyretics as ordered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,15,0)
 ;;=1646^report use of prescibed/recreational drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,16,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,17,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,1,18,0)
 ;;=2992^[Extra Order]^3^NURSC^77^0
 ;;^UTILITY("^GMRD(124.2,",$J,1633,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1633,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1634,0)
 ;;=ABGs/pulse oximetry q[frequency]^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1634,4)
 ;;=assess, monitor, document
 ;;^UTILITY("^GMRD(124.2,",$J,1634,9)
 ;;=D EN2^NURCCPU2
