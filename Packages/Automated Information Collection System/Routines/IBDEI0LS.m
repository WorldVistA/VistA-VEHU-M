IBDEI0LS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10330,1,3,0)
 ;;=3^Anatomic Narrow Angle
 ;;^UTILITY(U,$J,358.3,10330,1,4,0)
 ;;=4^365.02
 ;;^UTILITY(U,$J,358.3,10330,2)
 ;;=Anatomic Narrow Angle^268748
 ;;^UTILITY(U,$J,358.3,10331,0)
 ;;=364.53^^44^563^39
 ;;^UTILITY(U,$J,358.3,10331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10331,1,3,0)
 ;;=3^Pigment Dispersion w/o Glauc
 ;;^UTILITY(U,$J,358.3,10331,1,4,0)
 ;;=4^364.53
 ;;^UTILITY(U,$J,358.3,10331,2)
 ;;=^268720
 ;;^UTILITY(U,$J,358.3,10332,0)
 ;;=364.42^^44^563^42
 ;;^UTILITY(U,$J,358.3,10332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10332,1,3,0)
 ;;=3^Rubeosis Iridis w/o Glaucoma
 ;;^UTILITY(U,$J,358.3,10332,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,10332,2)
 ;;=Rubeosis Iridis w/o Glaucoma^268716
 ;;^UTILITY(U,$J,358.3,10333,0)
 ;;=364.77^^44^563^2
 ;;^UTILITY(U,$J,358.3,10333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10333,1,3,0)
 ;;=3^Angle Recession w/o Glauc
 ;;^UTILITY(U,$J,358.3,10333,1,4,0)
 ;;=4^364.77
 ;;^UTILITY(U,$J,358.3,10333,2)
 ;;=Angle Recession w/o Glauc^268743
 ;;^UTILITY(U,$J,358.3,10334,0)
 ;;=368.40^^44^563^45
 ;;^UTILITY(U,$J,358.3,10334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10334,1,3,0)
 ;;=3^Visual Field Defect
 ;;^UTILITY(U,$J,358.3,10334,1,4,0)
 ;;=4^368.40
 ;;^UTILITY(U,$J,358.3,10334,2)
 ;;=Visual Field Defect^126859
 ;;^UTILITY(U,$J,358.3,10335,0)
 ;;=363.70^^44^563^4
 ;;^UTILITY(U,$J,358.3,10335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10335,1,3,0)
 ;;=3^Choroidal Detachment NOS
 ;;^UTILITY(U,$J,358.3,10335,1,4,0)
 ;;=4^363.70
 ;;^UTILITY(U,$J,358.3,10335,2)
 ;;=^276841
 ;;^UTILITY(U,$J,358.3,10336,0)
 ;;=365.24^^44^563^28
 ;;^UTILITY(U,$J,358.3,10336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10336,1,3,0)
 ;;=3^Glaucoma,Residual Angle Closure
 ;;^UTILITY(U,$J,358.3,10336,1,4,0)
 ;;=4^365.24
 ;;^UTILITY(U,$J,358.3,10336,2)
 ;;=^268758
 ;;^UTILITY(U,$J,358.3,10337,0)
 ;;=365.65^^44^563^34
 ;;^UTILITY(U,$J,358.3,10337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10337,1,3,0)
 ;;=3^Glaucoma,Traumatic
 ;;^UTILITY(U,$J,358.3,10337,1,4,0)
 ;;=4^365.65
 ;;^UTILITY(U,$J,358.3,10337,2)
 ;;=^268780
 ;;^UTILITY(U,$J,358.3,10338,0)
 ;;=365.89^^44^563^23
 ;;^UTILITY(U,$J,358.3,10338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10338,1,3,0)
 ;;=3^Glaucoma,Oth Specified
 ;;^UTILITY(U,$J,358.3,10338,1,4,0)
 ;;=4^365.89
 ;;^UTILITY(U,$J,358.3,10338,2)
 ;;=^88069
 ;;^UTILITY(U,$J,358.3,10339,0)
 ;;=365.05^^44^563^38
 ;;^UTILITY(U,$J,358.3,10339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10339,1,3,0)
 ;;=3^Opn Ang w/ brdrlne fnd-Hi Risk
 ;;^UTILITY(U,$J,358.3,10339,1,4,0)
 ;;=4^365.05
 ;;^UTILITY(U,$J,358.3,10339,2)
 ;;=^340511
 ;;^UTILITY(U,$J,358.3,10340,0)
 ;;=365.06^^44^563^40
 ;;^UTILITY(U,$J,358.3,10340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10340,1,3,0)
 ;;=3^Prim Ang Clos w/o Glauc Dmg
 ;;^UTILITY(U,$J,358.3,10340,1,4,0)
 ;;=4^365.06
 ;;^UTILITY(U,$J,358.3,10340,2)
 ;;=^340512
 ;;^UTILITY(U,$J,358.3,10341,0)
 ;;=365.70^^44^563^31
 ;;^UTILITY(U,$J,358.3,10341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10341,1,3,0)
 ;;=3^Glaucoma,Stage NOS
 ;;^UTILITY(U,$J,358.3,10341,1,4,0)
 ;;=4^365.70
 ;;^UTILITY(U,$J,358.3,10341,2)
 ;;=^340609
 ;;^UTILITY(U,$J,358.3,10342,0)
 ;;=365.71^^44^563^17
 ;;^UTILITY(U,$J,358.3,10342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10342,1,3,0)
 ;;=3^Glaucoma,Mild Stage
 ;;^UTILITY(U,$J,358.3,10342,1,4,0)
 ;;=4^365.71
 ;;^UTILITY(U,$J,358.3,10342,2)
 ;;=^340513
 ;;^UTILITY(U,$J,358.3,10343,0)
 ;;=365.72^^44^563^18
 ;;^UTILITY(U,$J,358.3,10343,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI0LS
