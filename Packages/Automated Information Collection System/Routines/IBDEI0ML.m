IBDEI0ML ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10750,0)
 ;;=300.02^^47^599^7
 ;;^UTILITY(U,$J,358.3,10750,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10750,1,2,0)
 ;;=2^300.02
 ;;^UTILITY(U,$J,358.3,10750,1,5,0)
 ;;=5^Generalized Anxiety Dis
 ;;^UTILITY(U,$J,358.3,10750,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,10751,0)
 ;;=300.20^^47^599^14
 ;;^UTILITY(U,$J,358.3,10751,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10751,1,2,0)
 ;;=2^300.20
 ;;^UTILITY(U,$J,358.3,10751,1,5,0)
 ;;=5^Phobia, Unspecified
 ;;^UTILITY(U,$J,358.3,10751,2)
 ;;=^93428
 ;;^UTILITY(U,$J,358.3,10752,0)
 ;;=300.21^^47^599^10
 ;;^UTILITY(U,$J,358.3,10752,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10752,1,2,0)
 ;;=2^300.21
 ;;^UTILITY(U,$J,358.3,10752,1,5,0)
 ;;=5^Panic W/Agoraphobia
 ;;^UTILITY(U,$J,358.3,10752,2)
 ;;=^268168
 ;;^UTILITY(U,$J,358.3,10753,0)
 ;;=300.22^^47^599^3
 ;;^UTILITY(U,$J,358.3,10753,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10753,1,2,0)
 ;;=2^300.22
 ;;^UTILITY(U,$J,358.3,10753,1,5,0)
 ;;=5^Agoraphobia w/o Panic
 ;;^UTILITY(U,$J,358.3,10753,2)
 ;;=^4218
 ;;^UTILITY(U,$J,358.3,10754,0)
 ;;=300.23^^47^599^13
 ;;^UTILITY(U,$J,358.3,10754,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10754,1,2,0)
 ;;=2^300.23
 ;;^UTILITY(U,$J,358.3,10754,1,5,0)
 ;;=5^Phobia, Social
 ;;^UTILITY(U,$J,358.3,10754,2)
 ;;=^93420
 ;;^UTILITY(U,$J,358.3,10755,0)
 ;;=300.29^^47^599^12
 ;;^UTILITY(U,$J,358.3,10755,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10755,1,2,0)
 ;;=2^300.29
 ;;^UTILITY(U,$J,358.3,10755,1,5,0)
 ;;=5^Phobia, Simple
 ;;^UTILITY(U,$J,358.3,10755,2)
 ;;=^87670
 ;;^UTILITY(U,$J,358.3,10756,0)
 ;;=300.3^^47^599^8
 ;;^UTILITY(U,$J,358.3,10756,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10756,1,2,0)
 ;;=2^300.3
 ;;^UTILITY(U,$J,358.3,10756,1,5,0)
 ;;=5^Obsessive/Compulsive
 ;;^UTILITY(U,$J,358.3,10756,2)
 ;;=^84904
 ;;^UTILITY(U,$J,358.3,10757,0)
 ;;=308.9^^47^599^1
 ;;^UTILITY(U,$J,358.3,10757,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10757,1,2,0)
 ;;=2^308.9
 ;;^UTILITY(U,$J,358.3,10757,1,5,0)
 ;;=5^Acute Stress Reaction,Unspec
 ;;^UTILITY(U,$J,358.3,10757,2)
 ;;=^268303
 ;;^UTILITY(U,$J,358.3,10758,0)
 ;;=300.15^^47^599^6
 ;;^UTILITY(U,$J,358.3,10758,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10758,1,2,0)
 ;;=2^300.15
 ;;^UTILITY(U,$J,358.3,10758,1,5,0)
 ;;=5^Dissociative Reaction,Unspec
 ;;^UTILITY(U,$J,358.3,10758,2)
 ;;=^35700
 ;;^UTILITY(U,$J,358.3,10759,0)
 ;;=291.1^^47^600^5
 ;;^UTILITY(U,$J,358.3,10759,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10759,1,2,0)
 ;;=2^291.1
 ;;^UTILITY(U,$J,358.3,10759,1,5,0)
 ;;=5^Amnestic Syndrome Due to Alcohol
 ;;^UTILITY(U,$J,358.3,10759,2)
 ;;=^303492
 ;;^UTILITY(U,$J,358.3,10760,0)
 ;;=294.0^^47^600^7
 ;;^UTILITY(U,$J,358.3,10760,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10760,1,2,0)
 ;;=2^294.0
 ;;^UTILITY(U,$J,358.3,10760,1,5,0)
 ;;=5^Amnestic Syndrome in Oth Conditions
 ;;^UTILITY(U,$J,358.3,10760,2)
 ;;=^6319
 ;;^UTILITY(U,$J,358.3,10761,0)
 ;;=292.83^^47^600^6
 ;;^UTILITY(U,$J,358.3,10761,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10761,1,2,0)
 ;;=2^292.83
 ;;^UTILITY(U,$J,358.3,10761,1,5,0)
 ;;=5^Amnestic Syndrome Due to Drugs
 ;;^UTILITY(U,$J,358.3,10761,2)
 ;;=^268027
 ;;^UTILITY(U,$J,358.3,10762,0)
 ;;=291.2^^47^600^3
 ;;^UTILITY(U,$J,358.3,10762,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10762,1,2,0)
 ;;=2^291.2
 ;;^UTILITY(U,$J,358.3,10762,1,5,0)
 ;;=5^Alcohol Persisting Dementia
 ;;^UTILITY(U,$J,358.3,10762,2)
 ;;=^331824
 ;;^UTILITY(U,$J,358.3,10763,0)
 ;;=291.3^^47^600^1
 ;;^UTILITY(U,$J,358.3,10763,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10763,1,2,0)
 ;;=2^291.3
 ;;
 ;;$END ROU IBDEI0ML
