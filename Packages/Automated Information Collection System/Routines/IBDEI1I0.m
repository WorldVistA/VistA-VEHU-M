IBDEI1I0 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26591,1,4,0)
 ;;=4^V49.70
 ;;^UTILITY(U,$J,358.3,26591,2)
 ;;=^303438
 ;;^UTILITY(U,$J,358.3,26592,0)
 ;;=V49.71^^156^1714^7
 ;;^UTILITY(U,$J,358.3,26592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26592,1,3,0)
 ;;=3^Great Toe Amputat Stat
 ;;^UTILITY(U,$J,358.3,26592,1,4,0)
 ;;=4^V49.71
 ;;^UTILITY(U,$J,358.3,26592,2)
 ;;=^303439
 ;;^UTILITY(U,$J,358.3,26593,0)
 ;;=V49.72^^156^1714^11
 ;;^UTILITY(U,$J,358.3,26593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26593,1,3,0)
 ;;=3^Oth Toe(S) Amputat Stat
 ;;^UTILITY(U,$J,358.3,26593,1,4,0)
 ;;=4^V49.72
 ;;^UTILITY(U,$J,358.3,26593,2)
 ;;=^303440
 ;;^UTILITY(U,$J,358.3,26594,0)
 ;;=V49.60^^156^1714^15
 ;;^UTILITY(U,$J,358.3,26594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26594,1,3,0)
 ;;=3^Unsp Lev U Limb Amput
 ;;^UTILITY(U,$J,358.3,26594,1,4,0)
 ;;=4^V49.60
 ;;^UTILITY(U,$J,358.3,26594,2)
 ;;=^303427
 ;;^UTILITY(U,$J,358.3,26595,0)
 ;;=V49.61^^156^1714^13
 ;;^UTILITY(U,$J,358.3,26595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26595,1,3,0)
 ;;=3^Thumb Amput Status
 ;;^UTILITY(U,$J,358.3,26595,1,4,0)
 ;;=4^V49.61
 ;;^UTILITY(U,$J,358.3,26595,2)
 ;;=^303428
 ;;^UTILITY(U,$J,358.3,26596,0)
 ;;=V49.62^^156^1714^10
 ;;^UTILITY(U,$J,358.3,26596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26596,1,3,0)
 ;;=3^Oth Finger(s) Amput Status
 ;;^UTILITY(U,$J,358.3,26596,1,4,0)
 ;;=4^V49.62
 ;;^UTILITY(U,$J,358.3,26596,2)
 ;;=^303429
 ;;^UTILITY(U,$J,358.3,26597,0)
 ;;=V49.63^^156^1714^8
 ;;^UTILITY(U,$J,358.3,26597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26597,1,3,0)
 ;;=3^Hand Amput Status
 ;;^UTILITY(U,$J,358.3,26597,1,4,0)
 ;;=4^V49.63
 ;;^UTILITY(U,$J,358.3,26597,2)
 ;;=^303430
 ;;^UTILITY(U,$J,358.3,26598,0)
 ;;=V49.64^^156^1714^16
 ;;^UTILITY(U,$J,358.3,26598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26598,1,3,0)
 ;;=3^Wrist Amput Status
 ;;^UTILITY(U,$J,358.3,26598,1,4,0)
 ;;=4^V49.64
 ;;^UTILITY(U,$J,358.3,26598,2)
 ;;=^303431
 ;;^UTILITY(U,$J,358.3,26599,0)
 ;;=V49.65^^156^1714^4
 ;;^UTILITY(U,$J,358.3,26599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26599,1,3,0)
 ;;=3^Below Elbow Amput Status
 ;;^UTILITY(U,$J,358.3,26599,1,4,0)
 ;;=4^V49.65
 ;;^UTILITY(U,$J,358.3,26599,2)
 ;;=^303432
 ;;^UTILITY(U,$J,358.3,26600,0)
 ;;=V49.66^^156^1714^1
 ;;^UTILITY(U,$J,358.3,26600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26600,1,3,0)
 ;;=3^Above Elbow Amput Status
 ;;^UTILITY(U,$J,358.3,26600,1,4,0)
 ;;=4^V49.66
 ;;^UTILITY(U,$J,358.3,26600,2)
 ;;=^303433
 ;;^UTILITY(U,$J,358.3,26601,0)
 ;;=V49.67^^156^1714^12
 ;;^UTILITY(U,$J,358.3,26601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26601,1,3,0)
 ;;=3^Shoulder Amput Status
 ;;^UTILITY(U,$J,358.3,26601,1,4,0)
 ;;=4^V49.67
 ;;^UTILITY(U,$J,358.3,26601,2)
 ;;=^303434
 ;;^UTILITY(U,$J,358.3,26602,0)
 ;;=V49.77^^156^1714^9
 ;;^UTILITY(U,$J,358.3,26602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26602,1,3,0)
 ;;=3^Hip Amput Status
 ;;^UTILITY(U,$J,358.3,26602,1,4,0)
 ;;=4^V49.77
 ;;^UTILITY(U,$J,358.3,26602,2)
 ;;=^303445
 ;;^UTILITY(U,$J,358.3,26603,0)
 ;;=784.3^^156^1715^1
 ;;^UTILITY(U,$J,358.3,26603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26603,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,26603,1,4,0)
 ;;=4^784.3
 ;;^UTILITY(U,$J,358.3,26603,2)
 ;;=^9453
 ;;^UTILITY(U,$J,358.3,26604,0)
 ;;=334.3^^156^1715^2
 ;;^UTILITY(U,$J,358.3,26604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26604,1,3,0)
 ;;=3^Cerebellar Ataxia Nec
 ;;^UTILITY(U,$J,358.3,26604,1,4,0)
 ;;=4^334.3
 ;;^UTILITY(U,$J,358.3,26604,2)
 ;;=^87376
 ;;^UTILITY(U,$J,358.3,26605,0)
 ;;=438.11^^156^1715^9
 ;;^UTILITY(U,$J,358.3,26605,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI1I0
