NURCCG4A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1610,1,2,0)
 ;;=1612^ice packs to pulse points if temp. exceeds [ ] degrees F^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1610,1,3,0)
 ;;=1613^topical sponge bath if temp. exceeds [ ] degrees F^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1610,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1610,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1610,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1610,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1611,0)
 ;;=cooling blanket if temperature exceeds [ ] degrees F^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1612,0)
 ;;=ice packs to pulse points if temp. exceeds [ ] degrees F^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1613,0)
 ;;=topical sponge bath if temp. exceeds [ ] degrees F^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1614,0)
 ;;=give small, frequent amts. of clear liquids if nauseated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1614,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1614,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1615,0)
 ;;=teach patient^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1615,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1615,1,1,0)
 ;;=1616^observe for S/S of dehydration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1615,1,2,0)
 ;;=1617^increased needs for fluids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1615,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1615,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1615,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1615,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1616,0)
 ;;=observe for S/S of dehydration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1617,0)
 ;;=increased needs for fluids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1617,5)
 ;;=as related to heat, stress, fever, amd activity
 ;;^UTILITY("^GMRD(124.2,",$J,1618,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^42^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,1,0)
 ;;=1619^dehydration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,2,0)
 ;;=1620^exposure to hot environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,3,0)
 ;;=1621^illness or trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,4,0)
 ;;=1622^increased metabolic rate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,5,0)
 ;;=1623^inability or decreased ability to perspire^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,6,0)
 ;;=1624^inappropriate clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,7,0)
 ;;=1625^vigorous activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,1,8,0)
 ;;=1626^drug therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1618,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1619,0)
 ;;=dehydration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1620,0)
 ;;=exposure to hot environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1621,0)
 ;;=illness or trauma^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1622,0)
 ;;=increased metabolic rate^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1623,0)
 ;;=inability or decreased ability to perspire^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1624,0)
 ;;=inappropriate clothing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1625,0)
 ;;=vigorous activity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1626,0)
 ;;=drug therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1627,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^41^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,1,0)
 ;;=1628^maintains pulse rate and rhythm at baseline [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,2,0)
 ;;=1629^skin warm to touch^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1627,1,3,0)
 ;;=1630^maintains neurological functioning at baseline^3^NURSC^1^0
