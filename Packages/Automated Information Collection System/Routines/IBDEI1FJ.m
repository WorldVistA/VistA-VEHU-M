IBDEI1FJ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25354,1,5,0)
 ;;=5^ACQ. ABS. OF INTESTINE (LG,SM)
 ;;^UTILITY(U,$J,358.3,25354,2)
 ;;=^317959
 ;;^UTILITY(U,$J,358.3,25355,0)
 ;;=V45.73^^147^1588^8
 ;;^UTILITY(U,$J,358.3,25355,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25355,1,4,0)
 ;;=4^V45.73
 ;;^UTILITY(U,$J,358.3,25355,1,5,0)
 ;;=5^ACQUIRED ABSENCE OF KIDNEY
 ;;^UTILITY(U,$J,358.3,25355,2)
 ;;=^317962
 ;;^UTILITY(U,$J,358.3,25356,0)
 ;;=V45.74^^147^1588^4
 ;;^UTILITY(U,$J,358.3,25356,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25356,1,4,0)
 ;;=4^V45.74
 ;;^UTILITY(U,$J,358.3,25356,1,5,0)
 ;;=5^ACQ ABSENCE ORG,URINARY TRACT
 ;;^UTILITY(U,$J,358.3,25356,2)
 ;;=^322063
 ;;^UTILITY(U,$J,358.3,25357,0)
 ;;=V45.75^^147^1588^3
 ;;^UTILITY(U,$J,358.3,25357,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25357,1,4,0)
 ;;=4^V45.75
 ;;^UTILITY(U,$J,358.3,25357,1,5,0)
 ;;=5^ACQ ABSENCE ORG,STOMACH
 ;;^UTILITY(U,$J,358.3,25357,2)
 ;;=^322065
 ;;^UTILITY(U,$J,358.3,25358,0)
 ;;=V45.76^^147^1588^2
 ;;^UTILITY(U,$J,358.3,25358,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25358,1,4,0)
 ;;=4^V45.76
 ;;^UTILITY(U,$J,358.3,25358,1,5,0)
 ;;=5^ACQ ABSENCE ORG,LUNG
 ;;^UTILITY(U,$J,358.3,25358,2)
 ;;=^322066
 ;;^UTILITY(U,$J,358.3,25359,0)
 ;;=V45.77^^147^1588^1
 ;;^UTILITY(U,$J,358.3,25359,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25359,1,4,0)
 ;;=4^V45.77
 ;;^UTILITY(U,$J,358.3,25359,1,5,0)
 ;;=5^ACQ ABSENCE ORG,GENITALS
 ;;^UTILITY(U,$J,358.3,25359,2)
 ;;=^322067
 ;;^UTILITY(U,$J,358.3,25360,0)
 ;;=V45.78^^147^1588^5
 ;;^UTILITY(U,$J,358.3,25360,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25360,1,4,0)
 ;;=4^V45.78
 ;;^UTILITY(U,$J,358.3,25360,1,5,0)
 ;;=5^ACQ ABSENCE ORGAN,EYE
 ;;^UTILITY(U,$J,358.3,25360,2)
 ;;=^322068
 ;;^UTILITY(U,$J,358.3,25361,0)
 ;;=V45.79^^147^1588^9
 ;;^UTILITY(U,$J,358.3,25361,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25361,1,4,0)
 ;;=4^V45.79
 ;;^UTILITY(U,$J,358.3,25361,1,5,0)
 ;;=5^OTH ACQ ABSENCE ORGAN
 ;;^UTILITY(U,$J,358.3,25361,2)
 ;;=^322069
 ;;^UTILITY(U,$J,358.3,25362,0)
 ;;=V65.0^^147^1589^4
 ;;^UTILITY(U,$J,358.3,25362,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25362,1,4,0)
 ;;=4^V65.0
 ;;^UTILITY(U,$J,358.3,25362,1,5,0)
 ;;=5^HEALTHY PERSON W SICK
 ;;^UTILITY(U,$J,358.3,25362,2)
 ;;=^295561
 ;;^UTILITY(U,$J,358.3,25363,0)
 ;;=V65.19^^147^1589^8
 ;;^UTILITY(U,$J,358.3,25363,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25363,1,4,0)
 ;;=4^V65.19
 ;;^UTILITY(U,$J,358.3,25363,1,5,0)
 ;;=5^PERSON CONSULT FOR ANOTH
 ;;^UTILITY(U,$J,358.3,25363,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,25364,0)
 ;;=V65.2^^147^1589^9
 ;;^UTILITY(U,$J,358.3,25364,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25364,1,4,0)
 ;;=4^V65.2
 ;;^UTILITY(U,$J,358.3,25364,1,5,0)
 ;;=5^PERSON FEIGNING ILLNESS
 ;;^UTILITY(U,$J,358.3,25364,2)
 ;;=^92393
 ;;^UTILITY(U,$J,358.3,25365,0)
 ;;=V65.40^^147^1589^6
 ;;^UTILITY(U,$J,358.3,25365,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25365,1,4,0)
 ;;=4^V65.40
 ;;^UTILITY(U,$J,358.3,25365,1,5,0)
 ;;=5^OTH UNSP COUNSEL
 ;;^UTILITY(U,$J,358.3,25365,2)
 ;;=^87449
 ;;^UTILITY(U,$J,358.3,25366,0)
 ;;=V65.42^^147^1589^3
 ;;^UTILITY(U,$J,358.3,25366,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25366,1,4,0)
 ;;=4^V65.42
 ;;^UTILITY(U,$J,358.3,25366,1,5,0)
 ;;=5^COUNSEL-SUBS USE/ABUSE
 ;;^UTILITY(U,$J,358.3,25366,2)
 ;;=^303467
 ;;^UTILITY(U,$J,358.3,25367,0)
 ;;=V65.43^^147^1589^1
 ;;^UTILITY(U,$J,358.3,25367,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,25367,1,4,0)
 ;;=4^V65.43
 ;;^UTILITY(U,$J,358.3,25367,1,5,0)
 ;;=5^COUNSEL-INJURY PREVEN
 ;;^UTILITY(U,$J,358.3,25367,2)
 ;;=^303468
 ;;^UTILITY(U,$J,358.3,25368,0)
 ;;=V65.44^^147^1589^5
 ;;
 ;;$END ROU IBDEI1FJ
