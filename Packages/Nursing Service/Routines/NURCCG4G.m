NURCCG4G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1683,0)
 ;;=adheres to dietary modification^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1683,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1683,1,1,0)
 ;;=1686^acceptable weight [#lbs,kg]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1683,1,2,0)
 ;;=1687^blood sugar WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1683,1,3,0)
 ;;=1690^cholesterol level optimal [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1683,1,4,0)
 ;;=1691^electrolytes WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1683,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1683,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1683,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1683,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1684,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^45^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,1,0)
 ;;=1697^chemical/noxious agents [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,2,0)
 ;;=1619^dehydration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,3,0)
 ;;=1700^ineffective oral hygiene^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,4,0)
 ;;=1702^lack of or decreased salivation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,5,0)
 ;;=482^malnutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,6,0)
 ;;=1703^mechanical (e.g.ill fitting dentures,braces,tubes-NG/ET)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,7,0)
 ;;=573^surgery^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,8,0)
 ;;=459^medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,9,0)
 ;;=1704^NPO for more that 24 hours^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,10,0)
 ;;=1708^pathophysical:diabetes,periodontal disease,infection,oral CA^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,1,11,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1684,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1685,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^44^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,1,0)
 ;;=1732^achieves relief from pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,2,0)
 ;;=1733^verbalizes importance of routine oral care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,3,0)
 ;;=1734^demonstrates adequate oral care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,4,0)
 ;;=1736^identifies and avoids common causes of mucosal irritation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,5,0)
 ;;=2670^achieves intact mucosa^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1685,1,6,0)
 ;;=2908^[Extra Goal]^3^NURSC^88^0
 ;;^UTILITY("^GMRD(124.2,",$J,1685,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1686,0)
 ;;=acceptable weight [#lbs,kg]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1687,0)
 ;;=blood sugar WNL^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1688,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^40^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,1,0)
 ;;=1743^inspect mouth daily for changes in lesions,sores,bleeding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,2,0)
 ;;=1746^administer pain relieving agent [specify] a.c.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,3,0)
 ;;=1747^oral hygiene q[frequency]hrs^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,4,0)
 ;;=1749^apply emollients to lips q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,5,0)
 ;;=1752^if endotracheal tube - move daily^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,6,0)
 ;;=1754^initiate dental consult^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,7,0)
 ;;=848^encourage adequate food and fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,8,0)
 ;;=1756^encourage self-oral care q [frequency] times a day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,9,0)
 ;;=1757^demonstrate use of assistive devices [specify]^3^NURSC^1^0
