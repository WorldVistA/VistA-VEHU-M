IBDEI0JA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9062,1,4,0)
 ;;=4^HYPOKALEMIA
 ;;^UTILITY(U,$J,358.3,9062,1,5,0)
 ;;=5^276.8
 ;;^UTILITY(U,$J,358.3,9062,2)
 ;;=^60611
 ;;^UTILITY(U,$J,358.3,9063,0)
 ;;=275.41^^38^510^19
 ;;^UTILITY(U,$J,358.3,9063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9063,1,4,0)
 ;;=4^HYPOCALCEMIA
 ;;^UTILITY(U,$J,358.3,9063,1,5,0)
 ;;=5^275.41
 ;;^UTILITY(U,$J,358.3,9063,2)
 ;;=^60542
 ;;^UTILITY(U,$J,358.3,9064,0)
 ;;=266.2^^38^510^6
 ;;^UTILITY(U,$J,358.3,9064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9064,1,4,0)
 ;;=4^B-COMPLEX DEFIC NEC
 ;;^UTILITY(U,$J,358.3,9064,1,5,0)
 ;;=5^266.2
 ;;^UTILITY(U,$J,358.3,9064,2)
 ;;=^87347
 ;;^UTILITY(U,$J,358.3,9065,0)
 ;;=780.71^^38^510^9
 ;;^UTILITY(U,$J,358.3,9065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9065,1,4,0)
 ;;=4^CHRONIC FATIGUE SYNDROME
 ;;^UTILITY(U,$J,358.3,9065,1,5,0)
 ;;=5^780.71
 ;;^UTILITY(U,$J,358.3,9065,2)
 ;;=^304659
 ;;^UTILITY(U,$J,358.3,9066,0)
 ;;=274.9^^38^510^14
 ;;^UTILITY(U,$J,358.3,9066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9066,1,4,0)
 ;;=4^GOUT NOS
 ;;^UTILITY(U,$J,358.3,9066,1,5,0)
 ;;=5^274.9
 ;;^UTILITY(U,$J,358.3,9066,2)
 ;;=^52625
 ;;^UTILITY(U,$J,358.3,9067,0)
 ;;=790.6^^38^510^17
 ;;^UTILITY(U,$J,358.3,9067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9067,1,4,0)
 ;;=4^HYPERURICEMIA
 ;;^UTILITY(U,$J,358.3,9067,1,5,0)
 ;;=5^790.6
 ;;^UTILITY(U,$J,358.3,9067,2)
 ;;=^87228
 ;;^UTILITY(U,$J,358.3,9068,0)
 ;;=239.0^^38^510^26
 ;;^UTILITY(U,$J,358.3,9068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9068,1,4,0)
 ;;=4^ISLET CELL TUMOR
 ;;^UTILITY(U,$J,358.3,9068,1,5,0)
 ;;=5^239.0
 ;;^UTILITY(U,$J,358.3,9068,2)
 ;;=^267781
 ;;^UTILITY(U,$J,358.3,9069,0)
 ;;=157.4^^38^510^28
 ;;^UTILITY(U,$J,358.3,9069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9069,1,4,0)
 ;;=4^MAL NEO ISLET LANGERHANS
 ;;^UTILITY(U,$J,358.3,9069,1,5,0)
 ;;=5^157.4
 ;;^UTILITY(U,$J,358.3,9069,2)
 ;;=^267108
 ;;^UTILITY(U,$J,358.3,9070,0)
 ;;=681.00^^38^511^4
 ;;^UTILITY(U,$J,358.3,9070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9070,1,4,0)
 ;;=4^CELLULITIS/ABSCESS FINGER
 ;;^UTILITY(U,$J,358.3,9070,1,5,0)
 ;;=5^681.00
 ;;^UTILITY(U,$J,358.3,9070,2)
 ;;=^271883
 ;;^UTILITY(U,$J,358.3,9071,0)
 ;;=681.10^^38^511^10
 ;;^UTILITY(U,$J,358.3,9071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9071,1,4,0)
 ;;=4^CELLULITIS/ABSCESS TOE
 ;;^UTILITY(U,$J,358.3,9071,1,5,0)
 ;;=5^681.10
 ;;^UTILITY(U,$J,358.3,9071,2)
 ;;=^271885
 ;;^UTILITY(U,$J,358.3,9072,0)
 ;;=682.0^^38^511^3
 ;;^UTILITY(U,$J,358.3,9072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9072,1,4,0)
 ;;=4^CELLULITIS/ABSCESS FACE
 ;;^UTILITY(U,$J,358.3,9072,1,5,0)
 ;;=5^682.0
 ;;^UTILITY(U,$J,358.3,9072,2)
 ;;=^271888
 ;;^UTILITY(U,$J,358.3,9073,0)
 ;;=682.1^^38^511^8
 ;;^UTILITY(U,$J,358.3,9073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9073,1,4,0)
 ;;=4^CELLULITIS/ABSCESS NECK
 ;;^UTILITY(U,$J,358.3,9073,1,5,0)
 ;;=5^682.1
 ;;^UTILITY(U,$J,358.3,9073,2)
 ;;=^271889
 ;;^UTILITY(U,$J,358.3,9074,0)
 ;;=682.2^^38^511^11
 ;;^UTILITY(U,$J,358.3,9074,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9074,1,4,0)
 ;;=4^CELLULITIS/ABSCESS TRUNK
 ;;^UTILITY(U,$J,358.3,9074,1,5,0)
 ;;=5^682.2
 ;;^UTILITY(U,$J,358.3,9074,2)
 ;;=^271890
 ;;^UTILITY(U,$J,358.3,9075,0)
 ;;=682.3^^38^511^1
 ;;^UTILITY(U,$J,358.3,9075,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9075,1,4,0)
 ;;=4^CELLULITIS/ABSCESS ARM
 ;;^UTILITY(U,$J,358.3,9075,1,5,0)
 ;;=5^682.3
 ;;^UTILITY(U,$J,358.3,9075,2)
 ;;=^271891
 ;;^UTILITY(U,$J,358.3,9076,0)
 ;;=682.4^^38^511^6
 ;;^UTILITY(U,$J,358.3,9076,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9076,1,4,0)
 ;;=4^CELLULITIS/ABSCESS HAND
 ;;
 ;;$END ROU IBDEI0JA
