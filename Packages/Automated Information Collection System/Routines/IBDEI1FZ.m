IBDEI1FZ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25571,1,5,0)
 ;;=5^OTH TOE(S) AMPUTAT STAT
 ;;^UTILITY(U,$J,358.3,25571,2)
 ;;=^303440
 ;;^UTILITY(U,$J,358.3,25572,0)
 ;;=V49.73^^147^1608^11
 ;;^UTILITY(U,$J,358.3,25572,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25572,1,4,0)
 ;;=4^V49.73
 ;;^UTILITY(U,$J,358.3,25572,1,5,0)
 ;;=5^FOOT AMPUTAT STAT
 ;;^UTILITY(U,$J,358.3,25572,2)
 ;;=^303441
 ;;^UTILITY(U,$J,358.3,25573,0)
 ;;=V49.74^^147^1608^3
 ;;^UTILITY(U,$J,358.3,25573,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25573,1,4,0)
 ;;=4^V49.74
 ;;^UTILITY(U,$J,358.3,25573,1,5,0)
 ;;=5^ANKLE AMPUTAT STAT
 ;;^UTILITY(U,$J,358.3,25573,2)
 ;;=^303442
 ;;^UTILITY(U,$J,358.3,25574,0)
 ;;=V49.75^^147^1608^8
 ;;^UTILITY(U,$J,358.3,25574,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25574,1,4,0)
 ;;=4^V49.75
 ;;^UTILITY(U,$J,358.3,25574,1,5,0)
 ;;=5^BELOW KNEE AMPUTAT STAT
 ;;^UTILITY(U,$J,358.3,25574,2)
 ;;=^303443
 ;;^UTILITY(U,$J,358.3,25575,0)
 ;;=V49.76^^147^1608^2
 ;;^UTILITY(U,$J,358.3,25575,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25575,1,4,0)
 ;;=4^V49.76
 ;;^UTILITY(U,$J,358.3,25575,1,5,0)
 ;;=5^ABOVE KNEE AMPUTAT STAT
 ;;^UTILITY(U,$J,358.3,25575,2)
 ;;=^303444
 ;;^UTILITY(U,$J,358.3,25576,0)
 ;;=V49.77^^147^1608^14
 ;;^UTILITY(U,$J,358.3,25576,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25576,1,4,0)
 ;;=4^V49.77
 ;;^UTILITY(U,$J,358.3,25576,1,5,0)
 ;;=5^HIP AMPUTATION STATUS
 ;;^UTILITY(U,$J,358.3,25576,2)
 ;;=^303445
 ;;^UTILITY(U,$J,358.3,25577,0)
 ;;=V49.81^^147^1608^4
 ;;^UTILITY(U,$J,358.3,25577,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25577,1,4,0)
 ;;=4^V49.81
 ;;^UTILITY(U,$J,358.3,25577,1,5,0)
 ;;=5^ASYMPT POSTMENOP STAT (AGE)
 ;;^UTILITY(U,$J,358.3,25577,2)
 ;;=^328737
 ;;^UTILITY(U,$J,358.3,25578,0)
 ;;=V49.83^^147^1608^5
 ;;^UTILITY(U,$J,358.3,25578,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25578,1,4,0)
 ;;=4^V49.83
 ;;^UTILITY(U,$J,358.3,25578,1,5,0)
 ;;=5^AWAIT ORGAN TRANSPLNT ST
 ;;^UTILITY(U,$J,358.3,25578,2)
 ;;=^331582
 ;;^UTILITY(U,$J,358.3,25579,0)
 ;;=V49.84^^147^1608^6
 ;;^UTILITY(U,$J,358.3,25579,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25579,1,4,0)
 ;;=4^V49.84
 ;;^UTILITY(U,$J,358.3,25579,1,5,0)
 ;;=5^BED CONFINEMENT STATUS
 ;;^UTILITY(U,$J,358.3,25579,2)
 ;;=^332868
 ;;^UTILITY(U,$J,358.3,25580,0)
 ;;=V49.89^^147^1608^19
 ;;^UTILITY(U,$J,358.3,25580,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25580,1,4,0)
 ;;=4^V49.89
 ;;^UTILITY(U,$J,358.3,25580,1,5,0)
 ;;=5^OTH SPEC COND HEALTH STAT
 ;;^UTILITY(U,$J,358.3,25580,2)
 ;;=^322071
 ;;^UTILITY(U,$J,358.3,25581,0)
 ;;=V41.2^^147^1608^21
 ;;^UTILITY(U,$J,358.3,25581,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25581,1,4,0)
 ;;=4^V41.2
 ;;^UTILITY(U,$J,358.3,25581,1,5,0)
 ;;=5^PROBLEMS WITH HEARING
 ;;^UTILITY(U,$J,358.3,25581,2)
 ;;=^295429
 ;;^UTILITY(U,$J,358.3,25582,0)
 ;;=V41.0^^147^1608^22
 ;;^UTILITY(U,$J,358.3,25582,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25582,1,4,0)
 ;;=4^V41.0
 ;;^UTILITY(U,$J,358.3,25582,1,5,0)
 ;;=5^PROBLEMS WITH SIGHT
 ;;^UTILITY(U,$J,358.3,25582,2)
 ;;=^295427
 ;;^UTILITY(U,$J,358.3,25583,0)
 ;;=V60.0^^147^1609^4
 ;;^UTILITY(U,$J,358.3,25583,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25583,1,4,0)
 ;;=4^V60.0
 ;;^UTILITY(U,$J,358.3,25583,1,5,0)
 ;;=5^HOMELESS
 ;;^UTILITY(U,$J,358.3,25583,2)
 ;;=^295539
 ;;^UTILITY(U,$J,358.3,25584,0)
 ;;=V60.1^^147^1609^6
 ;;^UTILITY(U,$J,358.3,25584,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25584,1,4,0)
 ;;=4^V60.1
 ;;^UTILITY(U,$J,358.3,25584,1,5,0)
 ;;=5^INADEQUATE HOUSING
 ;;^UTILITY(U,$J,358.3,25584,2)
 ;;=^295540
 ;;^UTILITY(U,$J,358.3,25585,0)
 ;;=V60.2^^147^1609^2
 ;;
 ;;$END ROU IBDEI1FZ
