IBDEI0Z8 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17177,0)
 ;;=V61.02^^88^1049^15
 ;;^UTILITY(U,$J,358.3,17177,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17177,1,4,0)
 ;;=4^V61.02
 ;;^UTILITY(U,$J,358.3,17177,1,5,0)
 ;;=5^FMILY DSRPT-RET MILITARY
 ;;^UTILITY(U,$J,358.3,17177,2)
 ;;=^336800
 ;;^UTILITY(U,$J,358.3,17178,0)
 ;;=V61.29^^88^1049^16
 ;;^UTILITY(U,$J,358.3,17178,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17178,1,4,0)
 ;;=4^V61.29
 ;;^UTILITY(U,$J,358.3,17178,1,5,0)
 ;;=5^PARENT-CHILD PROBLEM NEC
 ;;^UTILITY(U,$J,358.3,17178,2)
 ;;=^87774
 ;;^UTILITY(U,$J,358.3,17179,0)
 ;;=V61.3^^88^1049^17
 ;;^UTILITY(U,$J,358.3,17179,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17179,1,4,0)
 ;;=4^V61.3
 ;;^UTILITY(U,$J,358.3,17179,1,5,0)
 ;;=5^PROBLEM W AGED PARENT
 ;;^UTILITY(U,$J,358.3,17179,2)
 ;;=^295547
 ;;^UTILITY(U,$J,358.3,17180,0)
 ;;=V61.8^^88^1049^10
 ;;^UTILITY(U,$J,358.3,17180,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17180,1,4,0)
 ;;=4^V61.8
 ;;^UTILITY(U,$J,358.3,17180,1,5,0)
 ;;=5^FAMILY HEALTH CIRCUMSTANCES NEC
 ;;^UTILITY(U,$J,358.3,17180,2)
 ;;=^88048
 ;;^UTILITY(U,$J,358.3,17181,0)
 ;;=V16.0^^88^1050^11
 ;;^UTILITY(U,$J,358.3,17181,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17181,1,4,0)
 ;;=4^V16.0
 ;;^UTILITY(U,$J,358.3,17181,1,5,0)
 ;;=5^FAMILY HX-GI MALIGNANCY
 ;;^UTILITY(U,$J,358.3,17181,2)
 ;;=^295292
 ;;^UTILITY(U,$J,358.3,17182,0)
 ;;=V16.1^^88^1050^14
 ;;^UTILITY(U,$J,358.3,17182,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17182,1,4,0)
 ;;=4^V16.1
 ;;^UTILITY(U,$J,358.3,17182,1,5,0)
 ;;=5^FM HX-TRACH/BRONCHOG MAL
 ;;^UTILITY(U,$J,358.3,17182,2)
 ;;=^295293
 ;;^UTILITY(U,$J,358.3,17183,0)
 ;;=V16.2^^88^1050^6
 ;;^UTILITY(U,$J,358.3,17183,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17183,1,4,0)
 ;;=4^V16.2
 ;;^UTILITY(U,$J,358.3,17183,1,5,0)
 ;;=5^FAM HX-INTRATHORACIC MAL
 ;;^UTILITY(U,$J,358.3,17183,2)
 ;;=^295294
 ;;^UTILITY(U,$J,358.3,17184,0)
 ;;=V16.3^^88^1050^10
 ;;^UTILITY(U,$J,358.3,17184,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17184,1,4,0)
 ;;=4^V16.3
 ;;^UTILITY(U,$J,358.3,17184,1,5,0)
 ;;=5^FAMILY HX-BREAST MALIG
 ;;^UTILITY(U,$J,358.3,17184,2)
 ;;=^295295
 ;;^UTILITY(U,$J,358.3,17185,0)
 ;;=V16.40^^88^1050^1
 ;;^UTILITY(U,$J,358.3,17185,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17185,1,4,0)
 ;;=4^V16.40
 ;;^UTILITY(U,$J,358.3,17185,1,5,0)
 ;;=5^FAM HX MALIG NEOPL,GENITAL
 ;;^UTILITY(U,$J,358.3,17185,2)
 ;;=^295296
 ;;^UTILITY(U,$J,358.3,17186,0)
 ;;=V16.41^^88^1050^2
 ;;^UTILITY(U,$J,358.3,17186,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17186,1,4,0)
 ;;=4^V16.41
 ;;^UTILITY(U,$J,358.3,17186,1,5,0)
 ;;=5^FAM HX, MALIG NEOPL OF OVARY
 ;;^UTILITY(U,$J,358.3,17186,2)
 ;;=^317951
 ;;^UTILITY(U,$J,358.3,17187,0)
 ;;=V16.42^^88^1050^3
 ;;^UTILITY(U,$J,358.3,17187,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17187,1,4,0)
 ;;=4^V16.42
 ;;^UTILITY(U,$J,358.3,17187,1,5,0)
 ;;=5^FAM HX, MALIG NEOPL OF PROST
 ;;^UTILITY(U,$J,358.3,17187,2)
 ;;=^317952
 ;;^UTILITY(U,$J,358.3,17188,0)
 ;;=V16.43^^88^1050^4
 ;;^UTILITY(U,$J,358.3,17188,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17188,1,4,0)
 ;;=4^V16.43
 ;;^UTILITY(U,$J,358.3,17188,1,5,0)
 ;;=5^FAM HX, MALIG NEOPL OF TESTIS
 ;;^UTILITY(U,$J,358.3,17188,2)
 ;;=^317953
 ;;^UTILITY(U,$J,358.3,17189,0)
 ;;=V16.49^^88^1050^5
 ;;^UTILITY(U,$J,358.3,17189,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,17189,1,4,0)
 ;;=4^V16.49
 ;;^UTILITY(U,$J,358.3,17189,1,5,0)
 ;;=5^FAM HX, OF OTH MALIG NEOPL
 ;;^UTILITY(U,$J,358.3,17189,2)
 ;;=^317954
 ;;^UTILITY(U,$J,358.3,17190,0)
 ;;=V16.51^^88^1050^8
 ;;^UTILITY(U,$J,358.3,17190,1,0)
 ;;=^358.31IA^5^2
 ;;
 ;;$END ROU IBDEI0Z8
