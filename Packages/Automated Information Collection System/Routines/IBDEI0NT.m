IBDEI0NT ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11348,2)
 ;;=^336803
 ;;^UTILITY(U,$J,358.3,11349,0)
 ;;=V61.09^^50^642^9
 ;;^UTILITY(U,$J,358.3,11349,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11349,1,2,0)
 ;;=2^V61.09
 ;;^UTILITY(U,$J,358.3,11349,1,5,0)
 ;;=5^Family Disruption NEC
 ;;^UTILITY(U,$J,358.3,11349,2)
 ;;=^336805
 ;;^UTILITY(U,$J,358.3,11350,0)
 ;;=V62.21^^50^642^4
 ;;^UTILITY(U,$J,358.3,11350,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11350,1,2,0)
 ;;=2^V62.21
 ;;^UTILITY(U,$J,358.3,11350,1,5,0)
 ;;=5^Current Military Deployment
 ;;^UTILITY(U,$J,358.3,11350,2)
 ;;=^336806
 ;;^UTILITY(U,$J,358.3,11351,0)
 ;;=V62.22^^50^642^16
 ;;^UTILITY(U,$J,358.3,11351,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11351,1,2,0)
 ;;=2^V62.22
 ;;^UTILITY(U,$J,358.3,11351,1,5,0)
 ;;=5^HX Retrn Military Deploy
 ;;^UTILITY(U,$J,358.3,11351,2)
 ;;=^336807
 ;;^UTILITY(U,$J,358.3,11352,0)
 ;;=V62.29^^50^642^38
 ;;^UTILITY(U,$J,358.3,11352,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11352,1,2,0)
 ;;=2^V62.29
 ;;^UTILITY(U,$J,358.3,11352,1,5,0)
 ;;=5^Occupationl Circumst NEC
 ;;^UTILITY(U,$J,358.3,11352,2)
 ;;=^87746
 ;;^UTILITY(U,$J,358.3,11353,0)
 ;;=V60.81^^50^642^15
 ;;^UTILITY(U,$J,358.3,11353,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11353,1,2,0)
 ;;=2^V60.81
 ;;^UTILITY(U,$J,358.3,11353,1,5,0)
 ;;=5^Foster Care (Status)
 ;;^UTILITY(U,$J,358.3,11353,2)
 ;;=^338505
 ;;^UTILITY(U,$J,358.3,11354,0)
 ;;=V60.89^^50^642^19
 ;;^UTILITY(U,$J,358.3,11354,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11354,1,2,0)
 ;;=2^V60.89
 ;;^UTILITY(U,$J,358.3,11354,1,5,0)
 ;;=5^Housing/Econom Circum NEC
 ;;^UTILITY(U,$J,358.3,11354,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,11355,0)
 ;;=V61.22^^50^642^44
 ;;^UTILITY(U,$J,358.3,11355,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11355,1,2,0)
 ;;=2^V61.22
 ;;^UTILITY(U,$J,358.3,11355,1,5,0)
 ;;=5^Perpetrator-Parental Child
 ;;^UTILITY(U,$J,358.3,11355,2)
 ;;=^304358
 ;;^UTILITY(U,$J,358.3,11356,0)
 ;;=V61.23^^50^642^40
 ;;^UTILITY(U,$J,358.3,11356,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11356,1,2,0)
 ;;=2^V61.23
 ;;^UTILITY(U,$J,358.3,11356,1,5,0)
 ;;=5^Parent-Biological Child Prob
 ;;^UTILITY(U,$J,358.3,11356,2)
 ;;=^338508
 ;;^UTILITY(U,$J,358.3,11357,0)
 ;;=V61.24^^50^642^39
 ;;^UTILITY(U,$J,358.3,11357,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11357,1,2,0)
 ;;=2^V61.24
 ;;^UTILITY(U,$J,358.3,11357,1,5,0)
 ;;=5^Parent-Adopted Child Prob
 ;;^UTILITY(U,$J,358.3,11357,2)
 ;;=^338509
 ;;^UTILITY(U,$J,358.3,11358,0)
 ;;=V61.25^^50^642^42
 ;;^UTILITY(U,$J,358.3,11358,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11358,1,2,0)
 ;;=2^V61.25
 ;;^UTILITY(U,$J,358.3,11358,1,5,0)
 ;;=5^Parent-Foster Child Prob
 ;;^UTILITY(U,$J,358.3,11358,2)
 ;;=^338510
 ;;^UTILITY(U,$J,358.3,11359,0)
 ;;=V40.31^^50^642^52
 ;;^UTILITY(U,$J,358.3,11359,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11359,1,2,0)
 ;;=2^V40.31
 ;;^UTILITY(U,$J,358.3,11359,1,5,0)
 ;;=5^Wandering-Dis Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,11359,2)
 ;;=^340621
 ;;^UTILITY(U,$J,358.3,11360,0)
 ;;=V40.39^^50^642^1
 ;;^UTILITY(U,$J,358.3,11360,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11360,1,2,0)
 ;;=2^V40.39
 ;;^UTILITY(U,$J,358.3,11360,1,5,0)
 ;;=5^Behavioral Problem NEC
 ;;^UTILITY(U,$J,358.3,11360,2)
 ;;=^340622
 ;;^UTILITY(U,$J,358.3,11361,0)
 ;;=V65.19^^50^642^45
 ;;^UTILITY(U,$J,358.3,11361,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11361,1,2,0)
 ;;=2^V65.19
 ;;^UTILITY(U,$J,358.3,11361,1,5,0)
 ;;=5^Person Consulting on Behalf of Pt
 ;;^UTILITY(U,$J,358.3,11361,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,11362,0)
 ;;=V66.7^^50^642^8
 ;;
 ;;$END ROU IBDEI0NT
