IBDEI17X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21577,0)
 ;;=428.33^^118^1341^5
 ;;^UTILITY(U,$J,358.3,21577,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21577,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,21577,1,5,0)
 ;;=5^Acute on Chronic Diastolic CHF
 ;;^UTILITY(U,$J,358.3,21577,2)
 ;;=^328499
 ;;^UTILITY(U,$J,358.3,21578,0)
 ;;=428.41^^118^1341^2
 ;;^UTILITY(U,$J,358.3,21578,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21578,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,21578,1,5,0)
 ;;=5^Acute Systolic & Diastolic CHF
 ;;^UTILITY(U,$J,358.3,21578,2)
 ;;=^328500
 ;;^UTILITY(U,$J,358.3,21579,0)
 ;;=428.42^^118^1341^13
 ;;^UTILITY(U,$J,358.3,21579,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21579,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,21579,1,5,0)
 ;;=5^Chr Systolic & Diastolic CHF
 ;;^UTILITY(U,$J,358.3,21579,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,21580,0)
 ;;=428.43^^118^1341^4
 ;;^UTILITY(U,$J,358.3,21580,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21580,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,21580,1,5,0)
 ;;=5^Acute on Chr Systolic & Diastolic CHF
 ;;^UTILITY(U,$J,358.3,21580,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,21581,0)
 ;;=429.1^^118^1341^29
 ;;^UTILITY(U,$J,358.3,21581,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21581,1,4,0)
 ;;=4^429.1
 ;;^UTILITY(U,$J,358.3,21581,1,5,0)
 ;;=5^Myocardial Degeneration
 ;;^UTILITY(U,$J,358.3,21581,2)
 ;;=^80547
 ;;^UTILITY(U,$J,358.3,21582,0)
 ;;=V42.2^^118^1341^32
 ;;^UTILITY(U,$J,358.3,21582,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21582,1,4,0)
 ;;=4^V42.2
 ;;^UTILITY(U,$J,358.3,21582,1,5,0)
 ;;=5^Heart Valve Transplant
 ;;^UTILITY(U,$J,358.3,21582,2)
 ;;=^295437
 ;;^UTILITY(U,$J,358.3,21583,0)
 ;;=426.0^^118^1342^2
 ;;^UTILITY(U,$J,358.3,21583,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21583,1,4,0)
 ;;=4^426.0
 ;;^UTILITY(U,$J,358.3,21583,1,5,0)
 ;;=5^AV Block, Complete
 ;;^UTILITY(U,$J,358.3,21583,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,21584,0)
 ;;=426.10^^118^1342^3
 ;;^UTILITY(U,$J,358.3,21584,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21584,1,4,0)
 ;;=4^426.10
 ;;^UTILITY(U,$J,358.3,21584,1,5,0)
 ;;=5^AV Block, Incomplete
 ;;^UTILITY(U,$J,358.3,21584,2)
 ;;=^11396
 ;;^UTILITY(U,$J,358.3,21585,0)
 ;;=426.11^^118^1342^1
 ;;^UTILITY(U,$J,358.3,21585,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21585,1,4,0)
 ;;=4^426.11
 ;;^UTILITY(U,$J,358.3,21585,1,5,0)
 ;;=5^AV Block, 1st Degree,Incomplete
 ;;^UTILITY(U,$J,358.3,21585,2)
 ;;=^186726
 ;;^UTILITY(U,$J,358.3,21586,0)
 ;;=426.12^^118^1342^5
 ;;^UTILITY(U,$J,358.3,21586,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21586,1,4,0)
 ;;=4^426.12
 ;;^UTILITY(U,$J,358.3,21586,1,5,0)
 ;;=5^AV Block,Type II,Incomplete
 ;;^UTILITY(U,$J,358.3,21586,2)
 ;;=^269719
 ;;^UTILITY(U,$J,358.3,21587,0)
 ;;=426.13^^118^1342^4
 ;;^UTILITY(U,$J,358.3,21587,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21587,1,4,0)
 ;;=4^426.13
 ;;^UTILITY(U,$J,358.3,21587,1,5,0)
 ;;=5^AV Block,Oth 2nd Degree Blk
 ;;^UTILITY(U,$J,358.3,21587,2)
 ;;=^269720
 ;;^UTILITY(U,$J,358.3,21588,0)
 ;;=426.2^^118^1342^16
 ;;^UTILITY(U,$J,358.3,21588,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21588,1,4,0)
 ;;=4^426.2
 ;;^UTILITY(U,$J,358.3,21588,1,5,0)
 ;;=5^Left Hemiblock
 ;;^UTILITY(U,$J,358.3,21588,2)
 ;;=^269721
 ;;^UTILITY(U,$J,358.3,21589,0)
 ;;=426.3^^118^1342^20
 ;;^UTILITY(U,$J,358.3,21589,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,21589,1,4,0)
 ;;=4^426.3
 ;;^UTILITY(U,$J,358.3,21589,1,5,0)
 ;;=5^Oth Left Bundle Branch Block
 ;;^UTILITY(U,$J,358.3,21589,2)
 ;;=^269722
 ;;^UTILITY(U,$J,358.3,21590,0)
 ;;=426.4^^118^1342^30
 ;;^UTILITY(U,$J,358.3,21590,1,0)
 ;;=^358.31IA^5^2
 ;;
 ;;$END ROU IBDEI17X
