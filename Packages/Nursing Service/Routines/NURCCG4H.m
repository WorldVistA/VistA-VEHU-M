NURCCG4H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,10,0)
 ;;=1758^explain the common causes of mucosal irritation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,1,11,0)
 ;;=2994^[Extra Order]^3^NURSC^79^0
 ;;^UTILITY("^GMRD(124.2,",$J,1688,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1688,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1689,0)
 ;;=Related Problems^2^NURSC^7^33^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1689,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1689,1,1,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1689,1,2,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1689,1,3,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1689,1,4,0)
 ;;=1579^Swallowing, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1689,1,5,0)
 ;;=2752^Infection Potential (Specific to Integumentary System)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1689,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1690,0)
 ;;=cholesterol level optimal [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1691,0)
 ;;=electrolytes WNL^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1692,0)
 ;;=uses methods to improve circulation^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1692,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1692,1,1,0)
 ;;=1693^exercises as prescibed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1692,1,2,0)
 ;;=1694^keeps legs uncrossed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1692,1,3,0)
 ;;=1695^avoid constrictive clothing^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1692,1,4,0)
 ;;=1698^elevates legs when feasible^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1692,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1692,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1692,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1692,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1693,0)
 ;;=exercises as prescibed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1694,0)
 ;;=keeps legs uncrossed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1695,0)
 ;;=avoid constrictive clothing^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1696,0)
 ;;=does not smoke^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1696,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1696,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1697,0)
 ;;=chemical/noxious agents [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1698,0)
 ;;=elevates legs when feasible^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1699,0)
 ;;=lists cardiac risk factors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1699,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1699,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1700,0)
 ;;=ineffective oral hygiene^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1701,0)
 ;;=keeps clinic appointments^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1701,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1701,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1702,0)
 ;;=lack of or decreased salivation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1703,0)
 ;;=mechanical (e.g.ill fitting dentures,braces,tubes-NG/ET)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1704,0)
 ;;=NPO for more that 24 hours^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1705,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^41^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,1,0)
 ;;=1706^assess pt's knowledge base concerning his illness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,2,0)
 ;;=1707^identify cause of lack of knowledge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,3,0)
 ;;=1709^determine readiness/ability to learn^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1705,1,4,0)
 ;;=1710^teach cardiac instructions based on pt's learning level^2^NURSC^1^0
