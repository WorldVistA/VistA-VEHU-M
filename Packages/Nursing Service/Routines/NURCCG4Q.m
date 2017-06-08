NURCCG4Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1820,0)
 ;;=S/S of infection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1821,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^48^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1821,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1821,1,1,0)
 ;;=1822^interruption of arterial flow^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1821,1,2,0)
 ;;=1823^interruption of venous flow^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1821,1,3,0)
 ;;=1824^exchange problems - hypervolemia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1821,1,4,0)
 ;;=1825^exchange problems - hypovolemia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1821,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1822,0)
 ;;=interruption of arterial flow^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1823,0)
 ;;=interruption of venous flow^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1824,0)
 ;;=exchange problems - hypervolemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1825,0)
 ;;=exchange problems - hypovolemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1826,0)
 ;;=Related Problems^2^NURSC^7^36^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1826,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1826,1,1,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1826,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1826,1,3,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1826,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1827,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^47^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,1,0)
 ;;=1828^tissue perfusion is visually improved^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,2,0)
 ;;=515^skin is warm to touch and is normal color^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,3,0)
 ;;=1829^ulcer is healed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,4,0)
 ;;=1830^verbalizes knowledge of S/S of neurovascular changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,5,0)
 ;;=1831^demonstrates improved circulation by [specify]:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,6,0)
 ;;=1833^demonstrates measures to improve circulation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,7,0)
 ;;=1834^demonstrates progressive tolerance to increased activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,8,0)
 ;;=1835^remains free from leg pain related to claudication^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,9,0)
 ;;=1836^SMA-6/SMA-12, CBC, and differential WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,1,10,0)
 ;;=2911^[Extra Goal]^3^NURSC^91^0
 ;;^UTILITY("^GMRD(124.2,",$J,1827,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1828,0)
 ;;=tissue perfusion is visually improved^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1828,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1828,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1829,0)
 ;;=ulcer is healed^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1829,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1829,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1830,0)
 ;;=verbalizes knowledge of S/S of neurovascular changes^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1830,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1830,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1831,0)
 ;;=demonstrates improved circulation by [specify]:^2^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1831,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,1831,1,1,0)
 ;;=9908^stable vital signs WNL for patient^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,1831,1,2,0)
 ;;=281^skin color and temperature WNL for pt^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1831,1,3,0)
 ;;=337^assess memory/intellectual functioning^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1831,1,5,0)
 ;;=1519^balanced I/O, urine ouput WNL^3^NURSC^1^0
