IBDEI1EE ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24783,0)
 ;;=295.20^^140^1532^2
 ;;^UTILITY(U,$J,358.3,24783,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24783,1,2,0)
 ;;=2^295.20
 ;;^UTILITY(U,$J,358.3,24783,1,5,0)
 ;;=5^CATATONIC SCHIZOPHRENIC
 ;;^UTILITY(U,$J,358.3,24783,2)
 ;;=^108310
 ;;^UTILITY(U,$J,358.3,24784,0)
 ;;=295.10^^140^1532^3
 ;;^UTILITY(U,$J,358.3,24784,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24784,1,2,0)
 ;;=2^295.10
 ;;^UTILITY(U,$J,358.3,24784,1,5,0)
 ;;=5^DISORGANIZED SCHIZOPHRENIC
 ;;^UTILITY(U,$J,358.3,24784,2)
 ;;=^108319
 ;;^UTILITY(U,$J,358.3,24785,0)
 ;;=295.30^^140^1532^4
 ;;^UTILITY(U,$J,358.3,24785,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24785,1,2,0)
 ;;=2^295.30
 ;;^UTILITY(U,$J,358.3,24785,1,5,0)
 ;;=5^PARANOID SCHIZOPHRENIC
 ;;^UTILITY(U,$J,358.3,24785,2)
 ;;=^108330
 ;;^UTILITY(U,$J,358.3,24786,0)
 ;;=295.70^^140^1532^5
 ;;^UTILITY(U,$J,358.3,24786,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24786,1,2,0)
 ;;=2^295.70
 ;;^UTILITY(U,$J,358.3,24786,1,5,0)
 ;;=5^SCHIZOAFFECTIVE DIS NOS
 ;;^UTILITY(U,$J,358.3,24786,2)
 ;;=^331857
 ;;^UTILITY(U,$J,358.3,24787,0)
 ;;=295.32^^140^1532^6
 ;;^UTILITY(U,$J,358.3,24787,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24787,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,24787,1,5,0)
 ;;=5^SCHIZOPHRENIA,CHRONIC
 ;;^UTILITY(U,$J,358.3,24787,2)
 ;;=^268061
 ;;^UTILITY(U,$J,358.3,24788,0)
 ;;=295.60^^140^1532^7
 ;;^UTILITY(U,$J,358.3,24788,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24788,1,2,0)
 ;;=2^295.60
 ;;^UTILITY(U,$J,358.3,24788,1,5,0)
 ;;=5^SCHIZOPHRENIA,RESIDUAL
 ;;^UTILITY(U,$J,358.3,24788,2)
 ;;=^331851
 ;;^UTILITY(U,$J,358.3,24789,0)
 ;;=295.90^^140^1532^8
 ;;^UTILITY(U,$J,358.3,24789,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24789,1,2,0)
 ;;=2^295.90
 ;;^UTILITY(U,$J,358.3,24789,1,5,0)
 ;;=5^SCHIZOPHRENIA,UNDIFFERENTIATED
 ;;^UTILITY(U,$J,358.3,24789,2)
 ;;=^108287
 ;;^UTILITY(U,$J,358.3,24790,0)
 ;;=303.00^^140^1533^1
 ;;^UTILITY(U,$J,358.3,24790,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24790,1,2,0)
 ;;=2^303.00
 ;;^UTILITY(U,$J,358.3,24790,1,5,0)
 ;;=5^ACUTE ALCOHOL INTOXICATION
 ;;^UTILITY(U,$J,358.3,24790,2)
 ;;=^268183
 ;;^UTILITY(U,$J,358.3,24791,0)
 ;;=305.00^^140^1533^2
 ;;^UTILITY(U,$J,358.3,24791,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24791,1,2,0)
 ;;=2^305.00
 ;;^UTILITY(U,$J,358.3,24791,1,5,0)
 ;;=5^ALCOHOL ABUSE,UNSPEC
 ;;^UTILITY(U,$J,358.3,24791,2)
 ;;=^268227
 ;;^UTILITY(U,$J,358.3,24792,0)
 ;;=303.90^^140^1533^3
 ;;^UTILITY(U,$J,358.3,24792,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24792,1,2,0)
 ;;=2^303.90
 ;;^UTILITY(U,$J,358.3,24792,1,5,0)
 ;;=5^ALCOHOL,CHRONIC DEPENDENCE
 ;;^UTILITY(U,$J,358.3,24792,2)
 ;;=^268187
 ;;^UTILITY(U,$J,358.3,24793,0)
 ;;=305.70^^140^1533^4
 ;;^UTILITY(U,$J,358.3,24793,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24793,1,2,0)
 ;;=2^305.70
 ;;^UTILITY(U,$J,358.3,24793,1,5,0)
 ;;=5^AMPHETAMINE ABUSE
 ;;^UTILITY(U,$J,358.3,24793,2)
 ;;=^268250
 ;;^UTILITY(U,$J,358.3,24794,0)
 ;;=304.40^^140^1533^5
 ;;^UTILITY(U,$J,358.3,24794,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24794,1,2,0)
 ;;=2^304.40
 ;;^UTILITY(U,$J,358.3,24794,1,5,0)
 ;;=5^AMPHETAMINE DEPENDENCE
 ;;^UTILITY(U,$J,358.3,24794,2)
 ;;=^268204
 ;;^UTILITY(U,$J,358.3,24795,0)
 ;;=305.40^^140^1533^6
 ;;^UTILITY(U,$J,358.3,24795,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24795,1,2,0)
 ;;=2^305.40
 ;;^UTILITY(U,$J,358.3,24795,1,5,0)
 ;;=5^BARBITUARATE ABUSE
 ;;^UTILITY(U,$J,358.3,24795,2)
 ;;=^331935
 ;;^UTILITY(U,$J,358.3,24796,0)
 ;;=304.10^^140^1533^7
 ;;^UTILITY(U,$J,358.3,24796,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24796,1,2,0)
 ;;=2^304.10
 ;;
 ;;$END ROU IBDEI1EE
