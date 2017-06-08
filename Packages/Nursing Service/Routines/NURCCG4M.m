NURCCG4M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,2,0)
 ;;=1637^notify MD of lab results if indicated^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,3,0)
 ;;=1812^institute skin care protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,4,0)
 ;;=840^provide comfort/preventive measures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,5,0)
 ;;=847^avoid irritants/noxious stimuli/oral irritants^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,6,0)
 ;;=848^encourage adequate food and fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,7,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,8,0)
 ;;=849^up in chair q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,9,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,10,0)
 ;;=850^provide stoma care q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,11,0)
 ;;=851^teach how to maintain skin integrity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,12,0)
 ;;=852^teach radiation therapy precautions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,13,0)
 ;;=2996^[Extra Order]^3^NURSC^81^0
 ;;^UTILITY("^GMRD(124.2,",$J,1763,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1763,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1764,0)
 ;;=Related Problems^2^NURSC^7^34^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1764,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1764,1,1,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1764,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1764,1,3,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1764,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1765,0)
 ;;=nutritional deficit/excess^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1766,0)
 ;;=fluid deficit/excess^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1767,0)
 ;;=chemical substance or radiation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1767,5)
 ;;=(external factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1768,0)
 ;;=hyperthermia or hypothermia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1768,5)
 ;;=(external factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1769,0)
 ;;=impaired physical mobility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1770,0)
 ;;=irritants (e.g, chemical, thermal, mechanical)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1771,0)
 ;;=pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1771,5)
 ;;=(external factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1772,0)
 ;;=Related Problems^2^NURSC^7^35^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1772,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1772,1,1,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1772,1,2,0)
 ;;=1775^Knowledge Deficit (Specify)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1772,1,3,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1772,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1773,0)
 ;;=restraint^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1773,5)
 ;;=(external factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1774,0)
 ;;=shearing factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1774,5)
 ;;=(external factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1775,0)
 ;;=Knowledge Deficit (Specify)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1776,0)
 ;;=alteration in skin turgor (change in elasticity)^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1776,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1777,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^46^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,1,0)
 ;;=1779^circulation improves^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,2,0)
 ;;=1787^fluid intake is greater/equal to resting maintenace level^3^NURSC^1^0
