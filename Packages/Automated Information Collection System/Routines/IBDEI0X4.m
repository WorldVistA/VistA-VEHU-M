IBDEI0X4 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16100,0)
 ;;=780.64^^81^951^38
 ;;^UTILITY(U,$J,358.3,16100,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16100,1,4,0)
 ;;=4^780.64
 ;;^UTILITY(U,$J,358.3,16100,1,5,0)
 ;;=5^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,16100,2)
 ;;=^336670
 ;;^UTILITY(U,$J,358.3,16101,0)
 ;;=780.65^^81^951^89
 ;;^UTILITY(U,$J,358.3,16101,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16101,1,4,0)
 ;;=4^780.65
 ;;^UTILITY(U,$J,358.3,16101,1,5,0)
 ;;=5^Hypothermia w/o Low Env Temp
 ;;^UTILITY(U,$J,358.3,16101,2)
 ;;=^336671
 ;;^UTILITY(U,$J,358.3,16102,0)
 ;;=780.99^^81^951^41
 ;;^UTILITY(U,$J,358.3,16102,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16102,1,4,0)
 ;;=4^780.99
 ;;^UTILITY(U,$J,358.3,16102,1,5,0)
 ;;=5^Cold Intolerence
 ;;^UTILITY(U,$J,358.3,16102,2)
 ;;=^328568
 ;;^UTILITY(U,$J,358.3,16103,0)
 ;;=787.21^^81^951^56
 ;;^UTILITY(U,$J,358.3,16103,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16103,1,4,0)
 ;;=4^787.21
 ;;^UTILITY(U,$J,358.3,16103,1,5,0)
 ;;=5^Dysphagia, Oral Phase
 ;;^UTILITY(U,$J,358.3,16103,2)
 ;;=^335276
 ;;^UTILITY(U,$J,358.3,16104,0)
 ;;=787.22^^81^951^57
 ;;^UTILITY(U,$J,358.3,16104,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16104,1,4,0)
 ;;=4^787.22
 ;;^UTILITY(U,$J,358.3,16104,1,5,0)
 ;;=5^Dysphagia, Oropharyngeal
 ;;^UTILITY(U,$J,358.3,16104,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,16105,0)
 ;;=787.23^^81^951^58
 ;;^UTILITY(U,$J,358.3,16105,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16105,1,4,0)
 ;;=4^787.23
 ;;^UTILITY(U,$J,358.3,16105,1,5,0)
 ;;=5^Dysphagia, Pharyngeal
 ;;^UTILITY(U,$J,358.3,16105,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,16106,0)
 ;;=787.24^^81^951^59
 ;;^UTILITY(U,$J,358.3,16106,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16106,1,4,0)
 ;;=4^787.24
 ;;^UTILITY(U,$J,358.3,16106,1,5,0)
 ;;=5^Dysphagia, Pharyngoesoph
 ;;^UTILITY(U,$J,358.3,16106,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,16107,0)
 ;;=995.83^^81^952^2
 ;;^UTILITY(U,$J,358.3,16107,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16107,1,4,0)
 ;;=4^995.83
 ;;^UTILITY(U,$J,358.3,16107,1,5,0)
 ;;=5^Non-Military Sexual Trauma
 ;;^UTILITY(U,$J,358.3,16107,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,16108,0)
 ;;=E967.9^^81^952^1
 ;;^UTILITY(U,$J,358.3,16108,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16108,1,4,0)
 ;;=4^E967.9
 ;;^UTILITY(U,$J,358.3,16108,1,5,0)
 ;;=5^Child & Adult Abuse by Unspec Person
 ;;^UTILITY(U,$J,358.3,16108,2)
 ;;=^22623
 ;;^UTILITY(U,$J,358.3,16109,0)
 ;;=784.0^^81^953^18
 ;;^UTILITY(U,$J,358.3,16109,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16109,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,16109,1,5,0)
 ;;=5^Headache
 ;;^UTILITY(U,$J,358.3,16109,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,16110,0)
 ;;=729.5^^81^953^16
 ;;^UTILITY(U,$J,358.3,16110,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16110,1,4,0)
 ;;=4^729.5
 ;;^UTILITY(U,$J,358.3,16110,1,5,0)
 ;;=5^Foot Pain
 ;;^UTILITY(U,$J,358.3,16110,2)
 ;;=Foot Pain^89086
 ;;^UTILITY(U,$J,358.3,16111,0)
 ;;=723.1^^81^953^24
 ;;^UTILITY(U,$J,358.3,16111,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16111,1,4,0)
 ;;=4^723.1
 ;;^UTILITY(U,$J,358.3,16111,1,5,0)
 ;;=5^Neck Pain
 ;;^UTILITY(U,$J,358.3,16111,2)
 ;;=Neck Pain^21917
 ;;^UTILITY(U,$J,358.3,16112,0)
 ;;=719.41^^81^953^33
 ;;^UTILITY(U,$J,358.3,16112,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16112,1,4,0)
 ;;=4^719.41
 ;;^UTILITY(U,$J,358.3,16112,1,5,0)
 ;;=5^Shoulder Pain
 ;;^UTILITY(U,$J,358.3,16112,2)
 ;;=^272398
 ;;^UTILITY(U,$J,358.3,16113,0)
 ;;=719.45^^81^953^19
 ;;^UTILITY(U,$J,358.3,16113,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16113,1,4,0)
 ;;=4^719.45
 ;;^UTILITY(U,$J,358.3,16113,1,5,0)
 ;;=5^Hip Pain
 ;;
 ;;$END ROU IBDEI0X4
