NURCCG4N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,3,0)
 ;;=473^maintains optimal weight [specify lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,4,0)
 ;;=1790^avoid irritants/noxious stimuli/oral irritants^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,5,0)
 ;;=1791^moves all extremities freely^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,6,0)
 ;;=1792^demonstrates dressing change(s)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,7,0)
 ;;=1794^describes healing process and health care precautions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,8,0)
 ;;=1696^does not smoke^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,9,0)
 ;;=1795^does not use drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,10,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,1,11,0)
 ;;=2910^[Extra Goal]^3^NURSC^90^0
 ;;^UTILITY("^GMRD(124.2,",$J,1777,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1778,0)
 ;;=altered nutritional state (e.g. obesity,emaciation)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1778,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1779,0)
 ;;=circulation improves^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1779,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1779,1,1,0)
 ;;=1782^progressive healing of impaired tissue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1779,1,2,0)
 ;;=1784^lab data WNL (e.g., CBC, differential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1779,1,3,0)
 ;;=2748^free from edema/swelling^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1779,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,1779,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1779,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1779,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1780,0)
 ;;=altered metabolic state^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1780,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1781,0)
 ;;=edema^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1781,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1782,0)
 ;;=progressive healing of impaired tissue^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1783,0)
 ;;=excretions/secretions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1783,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1784,0)
 ;;=lab data WNL (e.g., CBC, differential)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1785,0)
 ;;=immunologic deficit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1785,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1786,0)
 ;;=prominence^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1786,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1787,0)
 ;;=fluid intake is greater/equal to resting maintenace level^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1787,5)
 ;;=(500cc intake over output)
 ;;^UTILITY("^GMRD(124.2,",$J,1787,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1787,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1788,0)
 ;;=psychogenic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1788,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1789,0)
 ;;=skeletal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1789,5)
 ;;=(internal factor)
 ;;^UTILITY("^GMRD(124.2,",$J,1790,0)
 ;;=avoid irritants/noxious stimuli/oral irritants^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1790,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1790,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1791,0)
 ;;=moves all extremities freely^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1791,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1791,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1792,0)
 ;;=demonstrates dressing change(s)^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1792,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1792,10)
 ;;=D EN2^NURCCPU1
