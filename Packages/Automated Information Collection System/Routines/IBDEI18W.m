IBDEI18W ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22068,1,5,0)
 ;;=5^Cardiomyopathy, Alcoholic
 ;;^UTILITY(U,$J,358.3,22068,2)
 ;;=^19623
 ;;^UTILITY(U,$J,358.3,22069,0)
 ;;=433.10^^125^1387^24
 ;;^UTILITY(U,$J,358.3,22069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22069,1,4,0)
 ;;=4^433.10
 ;;^UTILITY(U,$J,358.3,22069,1,5,0)
 ;;=5^Carotid Artery disease
 ;;^UTILITY(U,$J,358.3,22069,2)
 ;;=^295801
 ;;^UTILITY(U,$J,358.3,22070,0)
 ;;=786.52^^125^1387^25
 ;;^UTILITY(U,$J,358.3,22070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22070,1,4,0)
 ;;=4^786.52
 ;;^UTILITY(U,$J,358.3,22070,1,5,0)
 ;;=5^Chest Pain, pleuritic
 ;;^UTILITY(U,$J,358.3,22070,2)
 ;;=^89126
 ;;^UTILITY(U,$J,358.3,22071,0)
 ;;=786.51^^125^1387^26
 ;;^UTILITY(U,$J,358.3,22071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22071,1,4,0)
 ;;=4^786.51
 ;;^UTILITY(U,$J,358.3,22071,1,5,0)
 ;;=5^Chest Pain, precordial
 ;;^UTILITY(U,$J,358.3,22071,2)
 ;;=^276877
 ;;^UTILITY(U,$J,358.3,22072,0)
 ;;=V12.51^^125^1387^53
 ;;^UTILITY(U,$J,358.3,22072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22072,1,4,0)
 ;;=4^V12.51
 ;;^UTILITY(U,$J,358.3,22072,1,5,0)
 ;;=5^Hx of DVT
 ;;^UTILITY(U,$J,358.3,22072,2)
 ;;=Hx of DVT^303397
 ;;^UTILITY(U,$J,358.3,22073,0)
 ;;=780.4^^125^1387^29
 ;;^UTILITY(U,$J,358.3,22073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22073,1,4,0)
 ;;=4^780.4
 ;;^UTILITY(U,$J,358.3,22073,1,5,0)
 ;;=5^Dizziness
 ;;^UTILITY(U,$J,358.3,22073,2)
 ;;=Dizziness^35946
 ;;^UTILITY(U,$J,358.3,22074,0)
 ;;=412.^^125^1387^71
 ;;^UTILITY(U,$J,358.3,22074,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22074,1,4,0)
 ;;=4^412.
 ;;^UTILITY(U,$J,358.3,22074,1,5,0)
 ;;=5^Past MI
 ;;^UTILITY(U,$J,358.3,22074,2)
 ;;=Past MI^259884
 ;;^UTILITY(U,$J,358.3,22075,0)
 ;;=458.0^^125^1387^64
 ;;^UTILITY(U,$J,358.3,22075,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22075,1,4,0)
 ;;=4^458.0
 ;;^UTILITY(U,$J,358.3,22075,1,5,0)
 ;;=5^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,22075,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,22076,0)
 ;;=420.91^^125^1387^72
 ;;^UTILITY(U,$J,358.3,22076,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22076,1,4,0)
 ;;=4^420.91
 ;;^UTILITY(U,$J,358.3,22076,1,5,0)
 ;;=5^Pericarditis, Acute idiopathic
 ;;^UTILITY(U,$J,358.3,22076,2)
 ;;=   ^269695
 ;;^UTILITY(U,$J,358.3,22077,0)
 ;;=780.2^^125^1387^80
 ;;^UTILITY(U,$J,358.3,22077,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22077,1,4,0)
 ;;=4^780.2
 ;;^UTILITY(U,$J,358.3,22077,1,5,0)
 ;;=5^Syncope
 ;;^UTILITY(U,$J,358.3,22077,2)
 ;;=Syncope^116707
 ;;^UTILITY(U,$J,358.3,22078,0)
 ;;=443.9^^125^1387^65
 ;;^UTILITY(U,$J,358.3,22078,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22078,1,4,0)
 ;;=4^443.9
 ;;^UTILITY(U,$J,358.3,22078,1,5,0)
 ;;=5^PVD
 ;;^UTILITY(U,$J,358.3,22078,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,22079,0)
 ;;=440.21^^125^1387^67
 ;;^UTILITY(U,$J,358.3,22079,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22079,1,4,0)
 ;;=4^440.21
 ;;^UTILITY(U,$J,358.3,22079,1,5,0)
 ;;=5^PVD w/ intermittent claudication
 ;;^UTILITY(U,$J,358.3,22079,2)
 ;;=^293885
 ;;^UTILITY(U,$J,358.3,22080,0)
 ;;=440.23^^125^1387^68
 ;;^UTILITY(U,$J,358.3,22080,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22080,1,4,0)
 ;;=4^440.23
 ;;^UTILITY(U,$J,358.3,22080,1,5,0)
 ;;=5^PVD w/ ulceration
 ;;^UTILITY(U,$J,358.3,22080,2)
 ;;=^295739
 ;;^UTILITY(U,$J,358.3,22081,0)
 ;;=440.24^^125^1387^66
 ;;^UTILITY(U,$J,358.3,22081,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22081,1,4,0)
 ;;=4^440.24
 ;;^UTILITY(U,$J,358.3,22081,1,5,0)
 ;;=5^PVD w/ Gangrene
 ;;^UTILITY(U,$J,358.3,22081,2)
 ;;=PVD w/ Gangrene^295740
 ;;^UTILITY(U,$J,358.3,22082,0)
 ;;=V45.81^^125^1387^76
 ;;
 ;;$END ROU IBDEI18W
