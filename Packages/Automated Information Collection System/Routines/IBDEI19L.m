IBDEI19L ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22404,1,5,0)
 ;;=5^CVA, Acute Onset
 ;;^UTILITY(U,$J,358.3,22404,2)
 ;;=^295738
 ;;^UTILITY(U,$J,358.3,22405,0)
 ;;=333.94^^125^1392^101
 ;;^UTILITY(U,$J,358.3,22405,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22405,1,4,0)
 ;;=4^333.94
 ;;^UTILITY(U,$J,358.3,22405,1,5,0)
 ;;=5^Restless Leg Syndrome
 ;;^UTILITY(U,$J,358.3,22405,2)
 ;;=^105368
 ;;^UTILITY(U,$J,358.3,22406,0)
 ;;=345.90^^125^1392^104
 ;;^UTILITY(U,$J,358.3,22406,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22406,1,4,0)
 ;;=4^345.90
 ;;^UTILITY(U,$J,358.3,22406,1,5,0)
 ;;=5^Seizure Disorder
 ;;^UTILITY(U,$J,358.3,22406,2)
 ;;=^268477
 ;;^UTILITY(U,$J,358.3,22407,0)
 ;;=907.0^^125^1392^73
 ;;^UTILITY(U,$J,358.3,22407,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22407,1,4,0)
 ;;=4^907.0
 ;;^UTILITY(U,$J,358.3,22407,1,5,0)
 ;;=5^Late Effect Intracranial Injury
 ;;^UTILITY(U,$J,358.3,22407,2)
 ;;=^68489
 ;;^UTILITY(U,$J,358.3,22408,0)
 ;;=339.00^^125^1392^43
 ;;^UTILITY(U,$J,358.3,22408,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22408,1,4,0)
 ;;=4^339.00
 ;;^UTILITY(U,$J,358.3,22408,1,5,0)
 ;;=5^Headache,Cluster NOS
 ;;^UTILITY(U,$J,358.3,22408,2)
 ;;=^336741
 ;;^UTILITY(U,$J,358.3,22409,0)
 ;;=339.01^^125^1392^42
 ;;^UTILITY(U,$J,358.3,22409,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22409,1,4,0)
 ;;=4^339.01
 ;;^UTILITY(U,$J,358.3,22409,1,5,0)
 ;;=5^Headache,Cluster Episodic
 ;;^UTILITY(U,$J,358.3,22409,2)
 ;;=^336545
 ;;^UTILITY(U,$J,358.3,22410,0)
 ;;=339.02^^125^1392^41
 ;;^UTILITY(U,$J,358.3,22410,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22410,1,4,0)
 ;;=4^339.02
 ;;^UTILITY(U,$J,358.3,22410,1,5,0)
 ;;=5^Headache,Cluster Chronic
 ;;^UTILITY(U,$J,358.3,22410,2)
 ;;=^336546
 ;;^UTILITY(U,$J,358.3,22411,0)
 ;;=339.03^^125^1392^65
 ;;^UTILITY(U,$J,358.3,22411,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22411,1,4,0)
 ;;=4^339.03
 ;;^UTILITY(U,$J,358.3,22411,1,5,0)
 ;;=5^Hemicrania,Paroxysmal,Episodic
 ;;^UTILITY(U,$J,358.3,22411,2)
 ;;=^336547
 ;;^UTILITY(U,$J,358.3,22412,0)
 ;;=339.04^^125^1392^64
 ;;^UTILITY(U,$J,358.3,22412,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22412,1,4,0)
 ;;=4^339.04
 ;;^UTILITY(U,$J,358.3,22412,1,5,0)
 ;;=5^Hemicrania,Paroxysmal,Chr
 ;;^UTILITY(U,$J,358.3,22412,2)
 ;;=^336548
 ;;^UTILITY(U,$J,358.3,22413,0)
 ;;=339.05^^125^1392^57
 ;;^UTILITY(U,$J,358.3,22413,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22413,1,4,0)
 ;;=4^339.05
 ;;^UTILITY(U,$J,358.3,22413,1,5,0)
 ;;=5^Headache,SUNCT
 ;;^UTILITY(U,$J,358.3,22413,2)
 ;;=^336549
 ;;^UTILITY(U,$J,358.3,22414,0)
 ;;=339.10^^125^1392^62
 ;;^UTILITY(U,$J,358.3,22414,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22414,1,4,0)
 ;;=4^339.10
 ;;^UTILITY(U,$J,358.3,22414,1,5,0)
 ;;=5^Headache,Tension NOS
 ;;^UTILITY(U,$J,358.3,22414,2)
 ;;=^336742
 ;;^UTILITY(U,$J,358.3,22415,0)
 ;;=339.11^^125^1392^61
 ;;^UTILITY(U,$J,358.3,22415,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22415,1,4,0)
 ;;=4^339.11
 ;;^UTILITY(U,$J,358.3,22415,1,5,0)
 ;;=5^Headache,Tension Episodic
 ;;^UTILITY(U,$J,358.3,22415,2)
 ;;=^336551
 ;;^UTILITY(U,$J,358.3,22416,0)
 ;;=339.12^^125^1392^60
 ;;^UTILITY(U,$J,358.3,22416,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22416,1,4,0)
 ;;=4^339.12
 ;;^UTILITY(U,$J,358.3,22416,1,5,0)
 ;;=5^Headache,Tension Chr
 ;;^UTILITY(U,$J,358.3,22416,2)
 ;;=^336552
 ;;^UTILITY(U,$J,358.3,22417,0)
 ;;=339.20^^125^1392^52
 ;;^UTILITY(U,$J,358.3,22417,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22417,1,4,0)
 ;;=4^339.20
 ;;^UTILITY(U,$J,358.3,22417,1,5,0)
 ;;=5^Headache,Post-Traumatic NOS
 ;;^UTILITY(U,$J,358.3,22417,2)
 ;;=^336743
 ;;
 ;;$END ROU IBDEI19L
