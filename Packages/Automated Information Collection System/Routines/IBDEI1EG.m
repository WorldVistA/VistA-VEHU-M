IBDEI1EG ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24810,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24810,1,2,0)
 ;;=2^V79.0
 ;;^UTILITY(U,$J,358.3,24810,1,5,0)
 ;;=5^DEPRESSION SCREENING
 ;;^UTILITY(U,$J,358.3,24810,2)
 ;;=^295677
 ;;^UTILITY(U,$J,358.3,24811,0)
 ;;=V79.8^^140^1534^3
 ;;^UTILITY(U,$J,358.3,24811,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24811,1,2,0)
 ;;=2^V79.8
 ;;^UTILITY(U,$J,358.3,24811,1,5,0)
 ;;=5^SUICIDAL/MH D/O SCREENING
 ;;^UTILITY(U,$J,358.3,24811,2)
 ;;=^295681
 ;;^UTILITY(U,$J,358.3,24812,0)
 ;;=V74.1^^140^1534^4
 ;;^UTILITY(U,$J,358.3,24812,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24812,1,2,0)
 ;;=2^V74.1
 ;;^UTILITY(U,$J,358.3,24812,1,5,0)
 ;;=5^TB SCREENING
 ;;^UTILITY(U,$J,358.3,24812,2)
 ;;=^108715
 ;;^UTILITY(U,$J,358.3,24813,0)
 ;;=V82.89^^140^1534^5
 ;;^UTILITY(U,$J,358.3,24813,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24813,1,2,0)
 ;;=2^V82.89
 ;;^UTILITY(U,$J,358.3,24813,1,5,0)
 ;;=5^VIOLENT TENDENCY SCREENING
 ;;^UTILITY(U,$J,358.3,24813,2)
 ;;=^322099
 ;;^UTILITY(U,$J,358.3,24814,0)
 ;;=312.39^^140^1535^1
 ;;^UTILITY(U,$J,358.3,24814,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24814,1,2,0)
 ;;=2^312.39
 ;;^UTILITY(U,$J,358.3,24814,1,5,0)
 ;;=5^ANGER OUTBURSTS
 ;;^UTILITY(U,$J,358.3,24814,2)
 ;;=^87511
 ;;^UTILITY(U,$J,358.3,24815,0)
 ;;=297.9^^140^1535^2
 ;;^UTILITY(U,$J,358.3,24815,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24815,1,2,0)
 ;;=2^297.9
 ;;^UTILITY(U,$J,358.3,24815,1,5,0)
 ;;=5^DELUSIONS/PARANOID
 ;;^UTILITY(U,$J,358.3,24815,2)
 ;;=^123970
 ;;^UTILITY(U,$J,358.3,24816,0)
 ;;=783.0^^140^1535^3
 ;;^UTILITY(U,$J,358.3,24816,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24816,1,2,0)
 ;;=2^783.0
 ;;^UTILITY(U,$J,358.3,24816,1,5,0)
 ;;=5^DIMINISHED APPETITE
 ;;^UTILITY(U,$J,358.3,24816,2)
 ;;=^7939
 ;;^UTILITY(U,$J,358.3,24817,0)
 ;;=302.71^^140^1535^4
 ;;^UTILITY(U,$J,358.3,24817,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24817,1,2,0)
 ;;=2^302.71
 ;;^UTILITY(U,$J,358.3,24817,1,5,0)
 ;;=5^DIMINISHED LIBIDO
 ;;^UTILITY(U,$J,358.3,24817,2)
 ;;=^331925
 ;;^UTILITY(U,$J,358.3,24818,0)
 ;;=780.79^^140^1535^5
 ;;^UTILITY(U,$J,358.3,24818,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24818,1,2,0)
 ;;=2^780.79
 ;;^UTILITY(U,$J,358.3,24818,1,5,0)
 ;;=5^FATIGUE
 ;;^UTILITY(U,$J,358.3,24818,2)
 ;;=^73344
 ;;^UTILITY(U,$J,358.3,24819,0)
 ;;=780.1^^140^1535^6
 ;;^UTILITY(U,$J,358.3,24819,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24819,1,2,0)
 ;;=2^780.1
 ;;^UTILITY(U,$J,358.3,24819,1,5,0)
 ;;=5^HALLUCINATIONS
 ;;^UTILITY(U,$J,358.3,24819,2)
 ;;=^53738
 ;;^UTILITY(U,$J,358.3,24820,0)
 ;;=780.52^^140^1535^7
 ;;^UTILITY(U,$J,358.3,24820,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24820,1,2,0)
 ;;=2^780.52
 ;;^UTILITY(U,$J,358.3,24820,1,5,0)
 ;;=5^INSOMNIA NOS
 ;;^UTILITY(U,$J,358.3,24820,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,24821,0)
 ;;=297.1^^140^1535^8
 ;;^UTILITY(U,$J,358.3,24821,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24821,1,2,0)
 ;;=2^297.1
 ;;^UTILITY(U,$J,358.3,24821,1,5,0)
 ;;=5^PARANOIA
 ;;^UTILITY(U,$J,358.3,24821,2)
 ;;=^331896
 ;;^UTILITY(U,$J,358.3,24822,0)
 ;;=300.9^^140^1535^9
 ;;^UTILITY(U,$J,358.3,24822,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24822,1,2,0)
 ;;=2^300.9
 ;;^UTILITY(U,$J,358.3,24822,1,5,0)
 ;;=5^SUICIDAL IDEATION
 ;;^UTILITY(U,$J,358.3,24822,2)
 ;;=^331916
 ;;^UTILITY(U,$J,358.3,24823,0)
 ;;=783.21^^140^1535^11
 ;;^UTILITY(U,$J,358.3,24823,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24823,1,2,0)
 ;;=2^783.21
 ;;^UTILITY(U,$J,358.3,24823,1,5,0)
 ;;=5^WEIGHT LOSS
 ;;^UTILITY(U,$J,358.3,24823,2)
 ;;=^322005
 ;;^UTILITY(U,$J,358.3,24824,0)
 ;;=V62.84^^140^1535^10
 ;;
 ;;$END ROU IBDEI1EG
