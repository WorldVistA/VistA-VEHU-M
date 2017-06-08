NURCCG4L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1758,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1758,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1759,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^46^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,1,0)
 ;;=1761^altered circulation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,2,0)
 ;;=1765^nutritional deficit/excess^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,3,0)
 ;;=1766^fluid deficit/excess^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,4,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1759,1,6,0)
 ;;=1770^irritants (e.g, chemical, thermal, mechanical)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1759,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1760,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^47^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,1,0)
 ;;=1767^chemical substance or radiation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,2,0)
 ;;=1768^hyperthermia or hypothermia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,3,0)
 ;;=825^mechanical factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,4,0)
 ;;=826^physical immobilization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,5,0)
 ;;=1771^pressure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,6,0)
 ;;=1773^restraint^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,7,0)
 ;;=1774^shearing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,8,0)
 ;;=1776^alteration in skin turgor (change in elasticity)^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,9,0)
 ;;=1778^altered nutritional state (e.g. obesity,emaciation)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,10,0)
 ;;=1780^altered metabolic state^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,11,0)
 ;;=1781^edema^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,12,0)
 ;;=1783^excretions/secretions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,13,0)
 ;;=1785^immunologic deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,14,0)
 ;;=459^medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,15,0)
 ;;=1786^prominence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,16,0)
 ;;=1788^psychogenic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,1,17,0)
 ;;=1789^skeletal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1760,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1761,0)
 ;;=altered circulation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1762,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^45^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,1,0)
 ;;=1793^maintains intact tissue surrounding lesion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,2,0)
 ;;=1797^achieves intact skin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,3,0)
 ;;=1798^develops granulation tissue at wound edges^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,4,0)
 ;;=835^identifies relevant risk factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,5,0)
 ;;=836^verbalizes preventive measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,6,0)
 ;;=2671^identifies preventive measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,7,0)
 ;;=2672^demonstrates ability to manage wound care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,8,0)
 ;;=2673^demonstrates abilty to direct care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,1,9,0)
 ;;=2909^[Extra Goal]^3^NURSC^89^0
 ;;^UTILITY("^GMRD(124.2,",$J,1762,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1763,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^42^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,1763,1,1,0)
 ;;=1802^perform skin assessment & document findings related to:^2^NURSC^1^0
