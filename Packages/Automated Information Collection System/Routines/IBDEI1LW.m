IBDEI1LW ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28506,1,5,0)
 ;;=5^Fever
 ;;^UTILITY(U,$J,358.3,28506,2)
 ;;=^336764
 ;;^UTILITY(U,$J,358.3,28507,0)
 ;;=780.64^^162^1797^36
 ;;^UTILITY(U,$J,358.3,28507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28507,1,4,0)
 ;;=4^780.64
 ;;^UTILITY(U,$J,358.3,28507,1,5,0)
 ;;=5^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,28507,2)
 ;;=^336670
 ;;^UTILITY(U,$J,358.3,28508,0)
 ;;=780.61^^162^1797^73
 ;;^UTILITY(U,$J,358.3,28508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28508,1,4,0)
 ;;=4^780.61
 ;;^UTILITY(U,$J,358.3,28508,1,5,0)
 ;;=5^Fever, presenting w/ other cond
 ;;^UTILITY(U,$J,358.3,28508,2)
 ;;=^336667
 ;;^UTILITY(U,$J,358.3,28509,0)
 ;;=780.62^^162^1797^71
 ;;^UTILITY(U,$J,358.3,28509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28509,1,4,0)
 ;;=4^780.62
 ;;^UTILITY(U,$J,358.3,28509,1,5,0)
 ;;=5^Fever, Post-Procedural
 ;;^UTILITY(U,$J,358.3,28509,2)
 ;;=^336668
 ;;^UTILITY(U,$J,358.3,28510,0)
 ;;=780.63^^162^1797^72
 ;;^UTILITY(U,$J,358.3,28510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28510,1,4,0)
 ;;=4^780.63
 ;;^UTILITY(U,$J,358.3,28510,1,5,0)
 ;;=5^Fever, Post-Vaccination
 ;;^UTILITY(U,$J,358.3,28510,2)
 ;;=^336669
 ;;^UTILITY(U,$J,358.3,28511,0)
 ;;=780.65^^162^1797^87
 ;;^UTILITY(U,$J,358.3,28511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28511,1,4,0)
 ;;=4^780.65
 ;;^UTILITY(U,$J,358.3,28511,1,5,0)
 ;;=5^Hypothermia, not linked to Envir
 ;;^UTILITY(U,$J,358.3,28511,2)
 ;;=^336671
 ;;^UTILITY(U,$J,358.3,28512,0)
 ;;=784.59^^162^1797^137
 ;;^UTILITY(U,$J,358.3,28512,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28512,1,4,0)
 ;;=4^784.59
 ;;^UTILITY(U,$J,358.3,28512,1,5,0)
 ;;=5^Speech Disturbance NEC
 ;;^UTILITY(U,$J,358.3,28512,2)
 ;;=^338287
 ;;^UTILITY(U,$J,358.3,28513,0)
 ;;=799.21^^162^1797^112
 ;;^UTILITY(U,$J,358.3,28513,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28513,1,4,0)
 ;;=4^799.21
 ;;^UTILITY(U,$J,358.3,28513,1,5,0)
 ;;=5^Nervousness
 ;;^UTILITY(U,$J,358.3,28513,2)
 ;;=^338291
 ;;^UTILITY(U,$J,358.3,28514,0)
 ;;=790.4^^162^1797^14
 ;;^UTILITY(U,$J,358.3,28514,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28514,1,4,0)
 ;;=4^790.4
 ;;^UTILITY(U,$J,358.3,28514,1,5,0)
 ;;=5^Abnormal Transaminase/Lactic Acid
 ;;^UTILITY(U,$J,358.3,28514,2)
 ;;=^273401
 ;;^UTILITY(U,$J,358.3,28515,0)
 ;;=995.83^^162^1798^2
 ;;^UTILITY(U,$J,358.3,28515,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28515,1,4,0)
 ;;=4^995.83
 ;;^UTILITY(U,$J,358.3,28515,1,5,0)
 ;;=5^Non-Military Sexual Trauma
 ;;^UTILITY(U,$J,358.3,28515,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,28516,0)
 ;;=E967.9^^162^1798^1
 ;;^UTILITY(U,$J,358.3,28516,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28516,1,4,0)
 ;;=4^E967.9
 ;;^UTILITY(U,$J,358.3,28516,1,5,0)
 ;;=5^MST
 ;;^UTILITY(U,$J,358.3,28516,2)
 ;;=^22623
 ;;^UTILITY(U,$J,358.3,28517,0)
 ;;=784.0^^162^1799^10
 ;;^UTILITY(U,$J,358.3,28517,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28517,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,28517,1,5,0)
 ;;=5^Headache
 ;;^UTILITY(U,$J,358.3,28517,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,28518,0)
 ;;=729.5^^162^1799^9
 ;;^UTILITY(U,$J,358.3,28518,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28518,1,4,0)
 ;;=4^729.5
 ;;^UTILITY(U,$J,358.3,28518,1,5,0)
 ;;=5^Foot Pain
 ;;^UTILITY(U,$J,358.3,28518,2)
 ;;=Foot Pain^89086
 ;;^UTILITY(U,$J,358.3,28519,0)
 ;;=723.1^^162^1799^16
 ;;^UTILITY(U,$J,358.3,28519,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28519,1,4,0)
 ;;=4^723.1
 ;;^UTILITY(U,$J,358.3,28519,1,5,0)
 ;;=5^Neck Pain
 ;;^UTILITY(U,$J,358.3,28519,2)
 ;;=Neck Pain^21917
 ;;^UTILITY(U,$J,358.3,28520,0)
 ;;=719.41^^162^1799^22
 ;;
 ;;$END ROU IBDEI1LW
