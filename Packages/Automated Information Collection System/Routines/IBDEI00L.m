IBDEI00L ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.2)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.2)
 ;;=^IBE(358.2,
 ;;^UTILITY(U,$J,358.2,0)
 ;;=IMP/EXP SELECTION LIST^358.2I^189^189
 ;;^UTILITY(U,$J,358.2,1,0)
 ;;=ICD-10 DIAGNOSES^1^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,1,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,1,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,1,2,2,0)
 ;;=3^DIAGNOSIS^64^1^2^^1
 ;;^UTILITY(U,$J,358.2,1,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,1,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,1,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,2,0)
 ;;=ICD-10 DIAGNOSES^2^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,2,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,2,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,2,2,2,0)
 ;;=3^DIAGNOSIS^95^1^2^^1
 ;;^UTILITY(U,$J,358.2,2,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,2,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,2,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,3,0)
 ;;=ICD-10 DIAGNOSES^3^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,3,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,3,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,3,2,2,0)
 ;;=3^DIAGNOSIS^64^1^2^^1
 ;;^UTILITY(U,$J,358.2,3,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,3,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,3,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,4,0)
 ;;=ICD-10 DIAGNOSES^4^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,4,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,4,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,4,2,2,0)
 ;;=3^DIAGNOSIS^95^1^2^^1
 ;;^UTILITY(U,$J,358.2,4,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,4,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,4,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,5,0)
 ;;=ICD-10 DIAGNOSES^5^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,5,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,5,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,5,2,2,0)
 ;;=3^DIAGNOSIS^95^1^2^^1
 ;;^UTILITY(U,$J,358.2,5,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,5,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,5,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,6,0)
 ;;=ICD-10 DIAGNOSES^6^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,6,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,6,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,6,2,2,0)
 ;;=3^DIAGNOSIS^95^1^2^^1
 ;;^UTILITY(U,$J,358.2,6,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,6,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,6,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,7,0)
 ;;=ICD-10 DIAGNOSES^7^^^^^4^0^SC^^1^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,7,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,7,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,7,2,2,0)
 ;;=3^DIAGNOSIS^95^1^2^^1
 ;;^UTILITY(U,$J,358.2,7,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,7,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,7,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,8,0)
 ;;=ICD-10 DIAGNOSES^8^^^^^4^0^SC^^1^0^1^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,8,1,0)
 ;;=^358.21I^1^1
 ;;^UTILITY(U,$J,358.2,8,1,1,0)
 ;;=1^2^1
 ;;^UTILITY(U,$J,358.2,8,2,0)
 ;;=^358.22I^5^5
 ;;^UTILITY(U,$J,358.2,8,2,1,0)
 ;;=4^CODE^8^1^1^^0
 ;;^UTILITY(U,$J,358.2,8,2,2,0)
 ;;=3^DIAGNOSIS^95^1^2^^1
 ;;^UTILITY(U,$J,358.2,8,2,3,0)
 ;;=5^ADD^^2^^1^^1^7^0
 ;;^UTILITY(U,$J,358.2,8,2,4,0)
 ;;=1^P^^2^^1^^1^1^1
 ;;^UTILITY(U,$J,358.2,8,2,5,0)
 ;;=2^S^^2^^1^^1^2^0
 ;;^UTILITY(U,$J,358.2,9,0)
 ;;=CPT CODES^9^^^^^1^0^UBC^^3^0^^0^^0^3^2
 ;;^UTILITY(U,$J,358.2,9,1,0)
 ;;=^358.21I^3^3
 ;;^UTILITY(U,$J,358.2,9,1,1,0)
 ;;=1^2^4
 ;;^UTILITY(U,$J,358.2,9,1,2,0)
 ;;=2^2
 ;;^UTILITY(U,$J,358.2,9,1,3,0)
 ;;=3^2
 ;;
 ;;$END ROU IBDEI00L
