IBDEI00O ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.2)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.2,27,2,1,0)
 ;;=1^ ^28^1^2^^1
 ;;^UTILITY(U,$J,358.2,27,2,3,0)
 ;;=3^^^2^^1^^1^^1
 ;;^UTILITY(U,$J,358.2,27,2,4,0)
 ;;=2^ ^5^1^1
 ;;^UTILITY(U,$J,358.2,28,0)
 ;;=DIAGNOSES^42^^^^^4^0^SC^^10^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,28,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,28,1,1,0)
 ;;=1^^1
 ;;^UTILITY(U,$J,358.2,28,2,0)
 ;;=^358.22I^6^5
 ;;^UTILITY(U,$J,358.2,28,2,2,0)
 ;;=4^DIAGNOSIS^34^1^2^^1
 ;;^UTILITY(U,$J,358.2,28,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,28,2,4,0)
 ;;=1^P^^2^^1^^1^1^2
 ;;^UTILITY(U,$J,358.2,28,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,28,2,6,0)
 ;;=3^CODE^7^1^1
 ;;^UTILITY(U,$J,358.2,29,0)
 ;;=CPT CODES^43^^^^^1^0^UBC^^3^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,29,1,0)
 ;;=^358.21I^3^3
 ;;^UTILITY(U,$J,358.2,29,1,1,0)
 ;;=1^1^4
 ;;^UTILITY(U,$J,358.2,29,1,2,0)
 ;;=2^2^47
 ;;^UTILITY(U,$J,358.2,29,1,3,0)
 ;;=3^2^90
 ;;^UTILITY(U,$J,358.2,29,2,0)
 ;;=^358.22I^3^3
 ;;^UTILITY(U,$J,358.2,29,2,1,0)
 ;;=1^ ^^2^^1^^1
 ;;^UTILITY(U,$J,358.2,29,2,2,0)
 ;;=2^ ^5^1^1^^1
 ;;^UTILITY(U,$J,358.2,29,2,3,0)
 ;;=3^ ^40^1^2^^1
 ;;^UTILITY(U,$J,358.2,30,0)
 ;;=VISIT TYPE^44^^^^^2^0^C^^8^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,30,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,30,1,1,0)
 ;;=1^2
 ;;^UTILITY(U,$J,358.2,30,2,0)
 ;;=^358.22I^4^3
 ;;^UTILITY(U,$J,358.2,30,2,1,0)
 ;;=1^ ^28^1^2^^1
 ;;^UTILITY(U,$J,358.2,30,2,3,0)
 ;;=3^^^2^^1^^1^^1
 ;;^UTILITY(U,$J,358.2,30,2,4,0)
 ;;=2^ ^5^1^1
 ;;^UTILITY(U,$J,358.2,31,0)
 ;;=DIAGNOSES^47^^^^^1^0^BC^^10^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,31,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,31,1,1,0)
 ;;=1^2
 ;;^UTILITY(U,$J,358.2,31,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,31,2,1,0)
 ;;=4^ ^7^1^1^^0
 ;;^UTILITY(U,$J,358.2,31,2,2,0)
 ;;=5^ ^40^1^2^^1
 ;;^UTILITY(U,$J,358.2,31,2,3,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,31,2,4,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,31,2,5,0)
 ;;=3^A^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,32,0)
 ;;=CPT CODES^48^^^^^1^0^SC^^3^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,32,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,32,1,1,0)
 ;;=1^2^2
 ;;^UTILITY(U,$J,358.2,32,2,0)
 ;;=^358.22I^3^3
 ;;^UTILITY(U,$J,358.2,32,2,1,0)
 ;;=3^ ^5^1^1^^0
 ;;^UTILITY(U,$J,358.2,32,2,2,0)
 ;;=2^ ^40^1^2^^1
 ;;^UTILITY(U,$J,358.2,32,2,3,0)
 ;;=1^ ^^2^^1^^1^^0
 ;;^UTILITY(U,$J,358.2,33,0)
 ;;=CPT CODES^49^^^^^1^0^CSU^^3^0^2^0^^0^2^2
 ;;^UTILITY(U,$J,358.2,33,1,0)
 ;;=^358.21I^3^3
 ;;^UTILITY(U,$J,358.2,33,1,1,0)
 ;;=1^2^2
 ;;^UTILITY(U,$J,358.2,33,1,2,0)
 ;;=3^^91
 ;;^UTILITY(U,$J,358.2,33,1,3,0)
 ;;=2^3^64
 ;;^UTILITY(U,$J,358.2,33,2,0)
 ;;=^358.22I^3^3
 ;;^UTILITY(U,$J,358.2,33,2,1,0)
 ;;=2^ ^5^1^1^^0
 ;;^UTILITY(U,$J,358.2,33,2,2,0)
 ;;=3^ ^50^1^2^^1
 ;;^UTILITY(U,$J,358.2,33,2,3,0)
 ;;=1^ ^^2^^1^^1^^0
 ;;^UTILITY(U,$J,358.2,34,0)
 ;;=VISIT TYPE^50^^^^^2^0^C^^8^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,34,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,34,1,1,0)
 ;;=1^2
 ;;^UTILITY(U,$J,358.2,34,2,0)
 ;;=^358.22I^4^3
 ;;^UTILITY(U,$J,358.2,34,2,1,0)
 ;;=1^ ^28^1^2^^1
 ;;^UTILITY(U,$J,358.2,34,2,3,0)
 ;;=3^^^2^^1^^1^^1
 ;;^UTILITY(U,$J,358.2,34,2,4,0)
 ;;=2^ ^5^1^1
 ;;^UTILITY(U,$J,358.2,35,0)
 ;;=DIAGNOSES^53^^^^^1^0^BC^^10^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,35,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,35,1,1,0)
 ;;=1^2
 ;;^UTILITY(U,$J,358.2,35,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,35,2,1,0)
 ;;=4^ ^7^1^1^^0
 ;;^UTILITY(U,$J,358.2,35,2,2,0)
 ;;=5^ ^40^1^2^^1
 ;;^UTILITY(U,$J,358.2,35,2,3,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,35,2,4,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,35,2,5,0)
 ;;=3^A^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,36,0)
 ;;=VISIT TYPE^54^^^^^1^0^C^^8^0^^0^^0^3^2
 ;;
 ;;$END ROU IBDEI00O
