IBDEI0D0 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5843,1,3,0)
 ;;=3^996.80
 ;;^UTILITY(U,$J,358.3,5843,1,4,0)
 ;;=4^COMPL OF TRANSPLANTED KIDNEY
 ;;^UTILITY(U,$J,358.3,5843,2)
 ;;=^27064
 ;;^UTILITY(U,$J,358.3,5844,0)
 ;;=V59.4^^28^387^3
 ;;^UTILITY(U,$J,358.3,5844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5844,1,3,0)
 ;;=3^V59.4
 ;;^UTILITY(U,$J,358.3,5844,1,4,0)
 ;;=4^KIDNEY DONOR
 ;;^UTILITY(U,$J,358.3,5844,2)
 ;;=^295536
 ;;^UTILITY(U,$J,358.3,5845,0)
 ;;=V42.0^^28^387^4
 ;;^UTILITY(U,$J,358.3,5845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5845,1,3,0)
 ;;=3^V42.0
 ;;^UTILITY(U,$J,358.3,5845,1,4,0)
 ;;=4^S/P KIDNEY TRANSPLANT
 ;;^UTILITY(U,$J,358.3,5845,2)
 ;;=^121356
 ;;^UTILITY(U,$J,358.3,5846,0)
 ;;=V42.7^^28^387^5
 ;;^UTILITY(U,$J,358.3,5846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5846,1,3,0)
 ;;=3^V42.7
 ;;^UTILITY(U,$J,358.3,5846,1,4,0)
 ;;=4^S/P LIVER TRANSPLANT
 ;;^UTILITY(U,$J,358.3,5846,2)
 ;;=^71599
 ;;^UTILITY(U,$J,358.3,5847,0)
 ;;=V58.44^^28^387^2
 ;;^UTILITY(U,$J,358.3,5847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5847,1,3,0)
 ;;=3^V58.44
 ;;^UTILITY(U,$J,358.3,5847,1,4,0)
 ;;=4^F/U TRANSPLANT
 ;;^UTILITY(U,$J,358.3,5847,2)
 ;;=^331583
 ;;^UTILITY(U,$J,358.3,5848,0)
 ;;=A4740^^29^388^7^^^^1
 ;;^UTILITY(U,$J,358.3,5848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5848,1,2,0)
 ;;=2^A4740
 ;;^UTILITY(U,$J,358.3,5848,1,3,0)
 ;;=3^SHUNT ACCESSORY
 ;;^UTILITY(U,$J,358.3,5849,0)
 ;;=A4730^^29^388^3^^^^1
 ;;^UTILITY(U,$J,358.3,5849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5849,1,2,0)
 ;;=2^A4730
 ;;^UTILITY(U,$J,358.3,5849,1,3,0)
 ;;=3^FISTULA CANNULATION SET, EA
 ;;^UTILITY(U,$J,358.3,5850,0)
 ;;=49422^^29^388^6^^^^1
 ;;^UTILITY(U,$J,358.3,5850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5850,1,2,0)
 ;;=2^49422
 ;;^UTILITY(U,$J,358.3,5850,1,3,0)
 ;;=3^REMOVE TUNNELED IP CATH
 ;;^UTILITY(U,$J,358.3,5851,0)
 ;;=C1752^^29^388^1^^^^1
 ;;^UTILITY(U,$J,358.3,5851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5851,1,2,0)
 ;;=2^C1752
 ;;^UTILITY(U,$J,358.3,5851,1,3,0)
 ;;=3^CATH,HEMODIALYSIS,SHORT-TERM
 ;;^UTILITY(U,$J,358.3,5852,0)
 ;;=15852^^29^388^2^^^^1
 ;;^UTILITY(U,$J,358.3,5852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5852,1,2,0)
 ;;=2^15852
 ;;^UTILITY(U,$J,358.3,5852,1,3,0)
 ;;=3^DRESSING CHANGE,NOT FOR BURN
 ;;^UTILITY(U,$J,358.3,5853,0)
 ;;=90940^^29^388^4^^^^1
 ;;^UTILITY(U,$J,358.3,5853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5853,1,2,0)
 ;;=2^90940
 ;;^UTILITY(U,$J,358.3,5853,1,3,0)
 ;;=3^HEMODIALYSIS ACCESS STUDY
 ;;^UTILITY(U,$J,358.3,5854,0)
 ;;=4051F^^29^388^5^^^^1
 ;;^UTILITY(U,$J,358.3,5854,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5854,1,2,0)
 ;;=2^4051F
 ;;^UTILITY(U,$J,358.3,5854,1,3,0)
 ;;=3^REFERRED FOR AN AV FISTULA
 ;;^UTILITY(U,$J,358.3,5855,0)
 ;;=A4708^^29^389^1^^^^1
 ;;^UTILITY(U,$J,358.3,5855,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5855,1,2,0)
 ;;=2^A4708
 ;;^UTILITY(U,$J,358.3,5855,1,3,0)
 ;;=3^ACETATE CONC SOL PER GALLON
 ;;^UTILITY(U,$J,358.3,5856,0)
 ;;=A4750^^29^389^2^^^^1
 ;;^UTILITY(U,$J,358.3,5856,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5856,1,2,0)
 ;;=2^A4750
 ;;^UTILITY(U,$J,358.3,5856,1,3,0)
 ;;=3^ART OR VENOUS BLOOD TUBING
 ;;^UTILITY(U,$J,358.3,5857,0)
 ;;=A4707^^29^389^3^^^^1
 ;;^UTILITY(U,$J,358.3,5857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5857,1,2,0)
 ;;=2^A4707
 ;;^UTILITY(U,$J,358.3,5857,1,3,0)
 ;;=3^BICARBONATE CONC POW PER PAC
 ;;^UTILITY(U,$J,358.3,5858,0)
 ;;=90999^^29^389^4^^^^1
 ;;^UTILITY(U,$J,358.3,5858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5858,1,2,0)
 ;;=2^90999
 ;;
 ;;$END ROU IBDEI0D0
