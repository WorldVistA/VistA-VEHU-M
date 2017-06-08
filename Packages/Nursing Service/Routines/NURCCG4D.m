NURCCG4D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1654,0)
 ;;=inadequate clothing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1655,0)
 ;;=medications causing vasodilation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1656,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^43^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,1,0)
 ;;=1647^aging^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,2,0)
 ;;=1648^consumption of alcohol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,3,0)
 ;;=1649^decreased metabolic rate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,4,0)
 ;;=1650^evaporation from skin in environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,5,0)
 ;;=1651^exposure to cool or cold environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,6,0)
 ;;=1652^inability or decreased ability to shiver^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,7,0)
 ;;=1653^inactivity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,8,0)
 ;;=1654^inadequate clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,9,0)
 ;;=482^malnutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,10,0)
 ;;=1655^medications causing vasodilation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,1,11,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1656,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1657,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^42^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,1,0)
 ;;=1503^maintains temperature within normal limits [degrees]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,2,0)
 ;;=1628^maintains pulse rate and rhythm at baseline [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,3,0)
 ;;=1658^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,4,0)
 ;;=1630^maintains neurological functioning at baseline^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,5,0)
 ;;=1629^skin warm to touch^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1657,1,6,0)
 ;;=2906^[Extra Goal]^3^NURSC^86^0
 ;;^UTILITY("^GMRD(124.2,",$J,1657,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1658,0)
 ;;=attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1658,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1658,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1659,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^39^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,1,0)
 ;;=1634^ABGs/pulse oximetry q[frequency]^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,2,0)
 ;;=1635^hematocrit q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,3,0)
 ;;=1636^hemoglobin q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,4,0)
 ;;=1266^sensorium q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,5,0)
 ;;=1660^cardiac rhythm q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,6,0)
 ;;=1661^move gently and protect from physical exhaustion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,7,0)
 ;;=1662^cover with warm blankets and/or layered clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,8,0)
 ;;=1663^maintain warm room temperature and avoid drafts^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,9,0)
 ;;=1664^give warm liquids PO q [frequency] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,10,0)
 ;;=1665^administer warmed IV fluids >115 degrees F at [rate]gtts/min^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,11,0)
 ;;=1666^administer heated, humidified oxygen via aerosol mask [time]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,12,0)
 ;;=1667^Apply warming blanket as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,13,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
