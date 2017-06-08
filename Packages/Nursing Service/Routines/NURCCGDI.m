NURCCGDI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,4,0)
 ;;=826^physical immobilization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,5,0)
 ;;=1771^pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,6,0)
 ;;=1773^restraint^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,7,0)
 ;;=1774^shearing factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,8,0)
 ;;=1776^alteration in skin turgor (change in elasticity)^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,9,0)
 ;;=1778^altered nutritional state (e.g. obesity,emaciation)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,10,0)
 ;;=1780^altered metabolic state^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,11,0)
 ;;=1781^edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,12,0)
 ;;=1783^excretions/secretions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,13,0)
 ;;=1785^immunologic deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,14,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,15,0)
 ;;=1786^prominence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,16,0)
 ;;=1788^psychogenic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,1,17,0)
 ;;=1789^skeletal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11644,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11662,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^155^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,0)
 ;;=^124.21PI^13^7
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,3,0)
 ;;=11666^develops granulation tissue at wound edges,& healing ^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,8,0)
 ;;=11671^demonstrates/or directs ulcer prevention techniques ^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,9,0)
 ;;=11837^[Extra Goal]^3^NURSC^189
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,10,0)
 ;;=11557^verbalizes causative factors for ulcer development^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,11,0)
 ;;=15348^directs/or performs treatment protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,12,0)
 ;;=15349^demonstrates increased tolerance to activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11662,1,13,0)
 ;;=1790^avoid irritants/noxious stimuli/oral irritants^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,11662,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11666,0)
 ;;=develops granulation tissue at wound edges,& healing ^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11666,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11666,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11671,0)
 ;;=demonstrates/or directs ulcer prevention techniques ^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11671,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11671,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11672,0)
 ;;=[Extra Goal]^3^NURSC^9^187^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11672,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11672,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^129^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,0)
 ;;=^124.21PI^25^18
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,1,0)
 ;;=11674^assess skin& document findings , related to:^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,3,0)
 ;;=11685^implement skin care protocol [specify]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,4,0)
 ;;=11686^provide comfort/preventive measures:^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,6,0)
 ;;=848^encourage adequate food and fluid intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,7,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,11,0)
 ;;=11699^teach how to attain/maintain skin integrity^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,13,0)
 ;;=12127^[Extra Order]^3^NURSC^195
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,14,0)
 ;;=15353^bedrest until [specify date]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11673,1,16,0)
 ;;=15354^utilize special use mattress/bed [specify]^3^NURSC^1
