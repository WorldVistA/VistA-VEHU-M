IBDEI12B ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18751,1,2,0)
 ;;=2^Interm repair; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,18752,0)
 ;;=12057^^104^1221^7^^^^1
 ;;^UTILITY(U,$J,358.3,18752,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,18752,1,1,0)
 ;;=1^12057
 ;;^UTILITY(U,$J,358.3,18752,1,2,0)
 ;;=2^Interm repair; over 30 cm
 ;;^UTILITY(U,$J,358.3,18753,0)
 ;;=414.01^^105^1222^12
 ;;^UTILITY(U,$J,358.3,18753,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18753,1,4,0)
 ;;=4^414.01
 ;;^UTILITY(U,$J,358.3,18753,1,5,0)
 ;;=5^Atherosclerosis, native coronary
 ;;^UTILITY(U,$J,358.3,18753,2)
 ;;=CAD, Native Vessel^303281
 ;;^UTILITY(U,$J,358.3,18754,0)
 ;;=413.9^^105^1222^2
 ;;^UTILITY(U,$J,358.3,18754,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18754,1,4,0)
 ;;=4^413.9
 ;;^UTILITY(U,$J,358.3,18754,1,5,0)
 ;;=5^Angina Pectoris
 ;;^UTILITY(U,$J,358.3,18754,2)
 ;;=Angina Pectoris^87258
 ;;^UTILITY(U,$J,358.3,18755,0)
 ;;=413.0^^105^1222^3
 ;;^UTILITY(U,$J,358.3,18755,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18755,1,4,0)
 ;;=4^413.0
 ;;^UTILITY(U,$J,358.3,18755,1,5,0)
 ;;=5^Angina at Rest
 ;;^UTILITY(U,$J,358.3,18755,2)
 ;;=Angina at Rest^265313
 ;;^UTILITY(U,$J,358.3,18756,0)
 ;;=411.1^^105^1222^5
 ;;^UTILITY(U,$J,358.3,18756,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18756,1,4,0)
 ;;=4^411.1
 ;;^UTILITY(U,$J,358.3,18756,1,5,0)
 ;;=5^Angina, Unstable
 ;;^UTILITY(U,$J,358.3,18756,2)
 ;;=Angina, Unstable^7455
 ;;^UTILITY(U,$J,358.3,18757,0)
 ;;=413.1^^105^1222^4
 ;;^UTILITY(U,$J,358.3,18757,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18757,1,4,0)
 ;;=4^413.1
 ;;^UTILITY(U,$J,358.3,18757,1,5,0)
 ;;=5^Angina, Prinzmetal
 ;;^UTILITY(U,$J,358.3,18757,2)
 ;;=^7448
 ;;^UTILITY(U,$J,358.3,18758,0)
 ;;=V58.61^^105^1222^6
 ;;^UTILITY(U,$J,358.3,18758,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18758,1,4,0)
 ;;=4^V58.61
 ;;^UTILITY(U,$J,358.3,18758,1,5,0)
 ;;=5^Anticoag Rx, chronic
 ;;^UTILITY(U,$J,358.3,18758,2)
 ;;=^303459
 ;;^UTILITY(U,$J,358.3,18759,0)
 ;;=441.4^^105^1222^7
 ;;^UTILITY(U,$J,358.3,18759,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18759,1,4,0)
 ;;=4^441.4
 ;;^UTILITY(U,$J,358.3,18759,1,5,0)
 ;;=5^Aortic Aneursym, abdominal
 ;;^UTILITY(U,$J,358.3,18759,2)
 ;;=^269769
 ;;^UTILITY(U,$J,358.3,18760,0)
 ;;=441.2^^105^1222^8
 ;;^UTILITY(U,$J,358.3,18760,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18760,1,4,0)
 ;;=4^441.2
 ;;^UTILITY(U,$J,358.3,18760,1,5,0)
 ;;=5^Aortic Aneursym, thoracic
 ;;^UTILITY(U,$J,358.3,18760,2)
 ;;=^269765
 ;;^UTILITY(U,$J,358.3,18761,0)
 ;;=786.59^^105^1222^14
 ;;^UTILITY(U,$J,358.3,18761,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18761,1,4,0)
 ;;=4^786.59
 ;;^UTILITY(U,$J,358.3,18761,1,5,0)
 ;;=5^Atypical Chest Pain
 ;;^UTILITY(U,$J,358.3,18761,2)
 ;;=^87384
 ;;^UTILITY(U,$J,358.3,18762,0)
 ;;=428.0^^105^1222^19
 ;;^UTILITY(U,$J,358.3,18762,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18762,1,4,0)
 ;;=4^428.0
 ;;^UTILITY(U,$J,358.3,18762,1,5,0)
 ;;=5^CHF
 ;;^UTILITY(U,$J,358.3,18762,2)
 ;;=^54758
 ;;^UTILITY(U,$J,358.3,18763,0)
 ;;=428.1^^105^1222^20
 ;;^UTILITY(U,$J,358.3,18763,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18763,1,4,0)
 ;;=4^428.1
 ;;^UTILITY(U,$J,358.3,18763,1,5,0)
 ;;=5^CHF, left ventricular
 ;;^UTILITY(U,$J,358.3,18763,2)
 ;;=^68721
 ;;^UTILITY(U,$J,358.3,18764,0)
 ;;=785.2^^105^1222^82
 ;;^UTILITY(U,$J,358.3,18764,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18764,1,4,0)
 ;;=4^785.2
 ;;^UTILITY(U,$J,358.3,18764,1,5,0)
 ;;=5^Undiag Cardiac murmurs
 ;;^UTILITY(U,$J,358.3,18764,2)
 ;;=^295854
 ;;^UTILITY(U,$J,358.3,18765,0)
 ;;=429.3^^105^1222^22
 ;;^UTILITY(U,$J,358.3,18765,1,0)
 ;;=^358.31IA^5^2
 ;;
 ;;$END ROU IBDEI12B
