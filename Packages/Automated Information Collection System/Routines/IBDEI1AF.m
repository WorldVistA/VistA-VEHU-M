IBDEI1AF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22809,2)
 ;;=^123801
 ;;^UTILITY(U,$J,358.3,22810,0)
 ;;=281.0^^125^1397^123
 ;;^UTILITY(U,$J,358.3,22810,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22810,1,4,0)
 ;;=4^281.0
 ;;^UTILITY(U,$J,358.3,22810,1,5,0)
 ;;=5^Vit B12 Deficiency (Pernicious Anemia)
 ;;^UTILITY(U,$J,358.3,22810,2)
 ;;=^7161
 ;;^UTILITY(U,$J,358.3,22811,0)
 ;;=282.60^^125^1397^111
 ;;^UTILITY(U,$J,358.3,22811,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22811,1,4,0)
 ;;=4^282.60
 ;;^UTILITY(U,$J,358.3,22811,1,5,0)
 ;;=5^Sickle-Cell Anemia
 ;;^UTILITY(U,$J,358.3,22811,2)
 ;;=^7188
 ;;^UTILITY(U,$J,358.3,22812,0)
 ;;=282.62^^125^1397^112
 ;;^UTILITY(U,$J,358.3,22812,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22812,1,4,0)
 ;;=4^282.62
 ;;^UTILITY(U,$J,358.3,22812,1,5,0)
 ;;=5^Sickle-Cell With Crisis
 ;;^UTILITY(U,$J,358.3,22812,2)
 ;;=^267982
 ;;^UTILITY(U,$J,358.3,22813,0)
 ;;=281.1^^125^1397^124
 ;;^UTILITY(U,$J,358.3,22813,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22813,1,4,0)
 ;;=4^281.1
 ;;^UTILITY(U,$J,358.3,22813,1,5,0)
 ;;=5^Vit B12 Deficiency(Dietary)
 ;;^UTILITY(U,$J,358.3,22813,2)
 ;;=^267974
 ;;^UTILITY(U,$J,358.3,22814,0)
 ;;=286.7^^125^1397^54
 ;;^UTILITY(U,$J,358.3,22814,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22814,1,4,0)
 ;;=4^286.7
 ;;^UTILITY(U,$J,358.3,22814,1,5,0)
 ;;=5^Coagulation Defect(Any),Acquired
 ;;^UTILITY(U,$J,358.3,22814,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,22815,0)
 ;;=289.9^^125^1397^120
 ;;^UTILITY(U,$J,358.3,22815,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22815,1,4,0)
 ;;=4^289.9
 ;;^UTILITY(U,$J,358.3,22815,1,5,0)
 ;;=5^Thrombocytosis, Essential
 ;;^UTILITY(U,$J,358.3,22815,2)
 ;;=^55344
 ;;^UTILITY(U,$J,358.3,22816,0)
 ;;=451.9^^125^1397^121
 ;;^UTILITY(U,$J,358.3,22816,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22816,1,4,0)
 ;;=4^451.9
 ;;^UTILITY(U,$J,358.3,22816,1,5,0)
 ;;=5^Thrombophlebitis 
 ;;^UTILITY(U,$J,358.3,22816,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,22817,0)
 ;;=446.6^^125^1397^122
 ;;^UTILITY(U,$J,358.3,22817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22817,1,4,0)
 ;;=4^446.6
 ;;^UTILITY(U,$J,358.3,22817,1,5,0)
 ;;=5^Thrombotic Thrombocytopenic Purpura(Ttp)
 ;;^UTILITY(U,$J,358.3,22817,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,22818,0)
 ;;=286.4^^125^1397^125
 ;;^UTILITY(U,$J,358.3,22818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22818,1,4,0)
 ;;=4^286.4
 ;;^UTILITY(U,$J,358.3,22818,1,5,0)
 ;;=5^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,22818,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,22819,0)
 ;;=204.00^^125^1397^1
 ;;^UTILITY(U,$J,358.3,22819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22819,1,4,0)
 ;;=4^204.00
 ;;^UTILITY(U,$J,358.3,22819,1,5,0)
 ;;=5^ALL w/o Remission
 ;;^UTILITY(U,$J,358.3,22819,2)
 ;;=^267521
 ;;^UTILITY(U,$J,358.3,22820,0)
 ;;=204.01^^125^1397^3
 ;;^UTILITY(U,$J,358.3,22820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22820,1,4,0)
 ;;=4^204.01
 ;;^UTILITY(U,$J,358.3,22820,1,5,0)
 ;;=5^ALL,In Remission
 ;;^UTILITY(U,$J,358.3,22820,2)
 ;;=^267522
 ;;^UTILITY(U,$J,358.3,22821,0)
 ;;=204.10^^125^1397^16
 ;;^UTILITY(U,$J,358.3,22821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22821,1,4,0)
 ;;=4^204.10
 ;;^UTILITY(U,$J,358.3,22821,1,5,0)
 ;;=5^CLL w/o Remission
 ;;^UTILITY(U,$J,358.3,22821,2)
 ;;=^267523
 ;;^UTILITY(U,$J,358.3,22822,0)
 ;;=204.11^^125^1397^18
 ;;^UTILITY(U,$J,358.3,22822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22822,1,4,0)
 ;;=4^204.11
 ;;^UTILITY(U,$J,358.3,22822,1,5,0)
 ;;=5^CLL,In Remission
 ;;^UTILITY(U,$J,358.3,22822,2)
 ;;=^267524
 ;;^UTILITY(U,$J,358.3,22823,0)
 ;;=201.90^^125^1397^83
 ;;^UTILITY(U,$J,358.3,22823,1,0)
 ;;=^358.31IA^5^2
 ;;
 ;;$END ROU IBDEI1AF
