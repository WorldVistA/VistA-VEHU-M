IBDEI0OI ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11685,2)
 ;;=^336801
 ;;^UTILITY(U,$J,358.3,11686,0)
 ;;=V61.04^^53^669^13
 ;;^UTILITY(U,$J,358.3,11686,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11686,1,2,0)
 ;;=2^V61.04
 ;;^UTILITY(U,$J,358.3,11686,1,5,0)
 ;;=5^Fmily Dsrpt-Parent-Child Estrangment
 ;;^UTILITY(U,$J,358.3,11686,2)
 ;;=^336802
 ;;^UTILITY(U,$J,358.3,11687,0)
 ;;=V61.05^^53^669^10
 ;;^UTILITY(U,$J,358.3,11687,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11687,1,2,0)
 ;;=2^V61.05
 ;;^UTILITY(U,$J,358.3,11687,1,5,0)
 ;;=5^Fmily Dsrpt-Chld Custody
 ;;^UTILITY(U,$J,358.3,11687,2)
 ;;=^336803
 ;;^UTILITY(U,$J,358.3,11688,0)
 ;;=V61.09^^53^669^9
 ;;^UTILITY(U,$J,358.3,11688,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11688,1,2,0)
 ;;=2^V61.09
 ;;^UTILITY(U,$J,358.3,11688,1,5,0)
 ;;=5^Family Disruption NEC
 ;;^UTILITY(U,$J,358.3,11688,2)
 ;;=^336805
 ;;^UTILITY(U,$J,358.3,11689,0)
 ;;=V62.21^^53^669^4
 ;;^UTILITY(U,$J,358.3,11689,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11689,1,2,0)
 ;;=2^V62.21
 ;;^UTILITY(U,$J,358.3,11689,1,5,0)
 ;;=5^Current Military Deployment
 ;;^UTILITY(U,$J,358.3,11689,2)
 ;;=^336806
 ;;^UTILITY(U,$J,358.3,11690,0)
 ;;=V62.22^^53^669^16
 ;;^UTILITY(U,$J,358.3,11690,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11690,1,2,0)
 ;;=2^V62.22
 ;;^UTILITY(U,$J,358.3,11690,1,5,0)
 ;;=5^HX Retrn Military Deploy
 ;;^UTILITY(U,$J,358.3,11690,2)
 ;;=^336807
 ;;^UTILITY(U,$J,358.3,11691,0)
 ;;=V62.29^^53^669^38
 ;;^UTILITY(U,$J,358.3,11691,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11691,1,2,0)
 ;;=2^V62.29
 ;;^UTILITY(U,$J,358.3,11691,1,5,0)
 ;;=5^Occupationl Circumst NEC
 ;;^UTILITY(U,$J,358.3,11691,2)
 ;;=^87746
 ;;^UTILITY(U,$J,358.3,11692,0)
 ;;=V60.81^^53^669^15
 ;;^UTILITY(U,$J,358.3,11692,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11692,1,2,0)
 ;;=2^V60.81
 ;;^UTILITY(U,$J,358.3,11692,1,5,0)
 ;;=5^Foster Care (Status)
 ;;^UTILITY(U,$J,358.3,11692,2)
 ;;=^338505
 ;;^UTILITY(U,$J,358.3,11693,0)
 ;;=V60.89^^53^669^19
 ;;^UTILITY(U,$J,358.3,11693,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11693,1,2,0)
 ;;=2^V60.89
 ;;^UTILITY(U,$J,358.3,11693,1,5,0)
 ;;=5^Housing/Econom Circum NEC
 ;;^UTILITY(U,$J,358.3,11693,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,11694,0)
 ;;=V61.22^^53^669^44
 ;;^UTILITY(U,$J,358.3,11694,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11694,1,2,0)
 ;;=2^V61.22
 ;;^UTILITY(U,$J,358.3,11694,1,5,0)
 ;;=5^Perpetrator-Parental Child
 ;;^UTILITY(U,$J,358.3,11694,2)
 ;;=^304358
 ;;^UTILITY(U,$J,358.3,11695,0)
 ;;=V61.23^^53^669^40
 ;;^UTILITY(U,$J,358.3,11695,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11695,1,2,0)
 ;;=2^V61.23
 ;;^UTILITY(U,$J,358.3,11695,1,5,0)
 ;;=5^Parent-Biological Child Prob
 ;;^UTILITY(U,$J,358.3,11695,2)
 ;;=^338508
 ;;^UTILITY(U,$J,358.3,11696,0)
 ;;=V61.24^^53^669^39
 ;;^UTILITY(U,$J,358.3,11696,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11696,1,2,0)
 ;;=2^V61.24
 ;;^UTILITY(U,$J,358.3,11696,1,5,0)
 ;;=5^Parent-Adopted Child Prob
 ;;^UTILITY(U,$J,358.3,11696,2)
 ;;=^338509
 ;;^UTILITY(U,$J,358.3,11697,0)
 ;;=V61.25^^53^669^42
 ;;^UTILITY(U,$J,358.3,11697,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11697,1,2,0)
 ;;=2^V61.25
 ;;^UTILITY(U,$J,358.3,11697,1,5,0)
 ;;=5^Parent-Foster Child Prob
 ;;^UTILITY(U,$J,358.3,11697,2)
 ;;=^338510
 ;;^UTILITY(U,$J,358.3,11698,0)
 ;;=V40.31^^53^669^52
 ;;^UTILITY(U,$J,358.3,11698,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11698,1,2,0)
 ;;=2^V40.31
 ;;^UTILITY(U,$J,358.3,11698,1,5,0)
 ;;=5^Wandering-Dis Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,11698,2)
 ;;=^340621
 ;;^UTILITY(U,$J,358.3,11699,0)
 ;;=V40.39^^53^669^1
 ;;
 ;;$END ROU IBDEI0OI
