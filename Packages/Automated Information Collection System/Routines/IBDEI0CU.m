IBDEI0CU ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5757,1,3,0)
 ;;=3^404.03
 ;;^UTILITY(U,$J,358.3,5757,1,4,0)
 ;;=4^MAL HTN HRT/REN w/ CHF&RF
 ;;^UTILITY(U,$J,358.3,5757,2)
 ;;=^334245
 ;;^UTILITY(U,$J,358.3,5758,0)
 ;;=404.00^^28^380^8
 ;;^UTILITY(U,$J,358.3,5758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5758,1,3,0)
 ;;=3^404.00
 ;;^UTILITY(U,$J,358.3,5758,1,4,0)
 ;;=4^MAL HTN HRT/REN w/o CHF&RF
 ;;^UTILITY(U,$J,358.3,5758,2)
 ;;=^334273
 ;;^UTILITY(U,$J,358.3,5759,0)
 ;;=404.02^^28^380^7
 ;;^UTILITY(U,$J,358.3,5759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5759,1,3,0)
 ;;=3^404.02
 ;;^UTILITY(U,$J,358.3,5759,1,4,0)
 ;;=4^MAL HTN HRT/REN w/ RENAL FAILURE
 ;;^UTILITY(U,$J,358.3,5759,2)
 ;;=^334244
 ;;^UTILITY(U,$J,358.3,5760,0)
 ;;=466.0^^28^381^2
 ;;^UTILITY(U,$J,358.3,5760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5760,1,3,0)
 ;;=3^466.0
 ;;^UTILITY(U,$J,358.3,5760,1,4,0)
 ;;=4^BRONCHITIS,ACUTE
 ;;^UTILITY(U,$J,358.3,5760,2)
 ;;=^259084
 ;;^UTILITY(U,$J,358.3,5761,0)
 ;;=682.8^^28^381^3
 ;;^UTILITY(U,$J,358.3,5761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5761,1,3,0)
 ;;=3^682.8
 ;;^UTILITY(U,$J,358.3,5761,1,4,0)
 ;;=4^CELLULITIS, SITE NEC
 ;;^UTILITY(U,$J,358.3,5761,2)
 ;;=^271896
 ;;^UTILITY(U,$J,358.3,5762,0)
 ;;=575.10^^28^381^4
 ;;^UTILITY(U,$J,358.3,5762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5762,1,3,0)
 ;;=3^575.10
 ;;^UTILITY(U,$J,358.3,5762,1,4,0)
 ;;=4^CHOLECYSTITIS,UNSP
 ;;^UTILITY(U,$J,358.3,5762,2)
 ;;=^23341
 ;;^UTILITY(U,$J,358.3,5763,0)
 ;;=372.39^^28^381^5
 ;;^UTILITY(U,$J,358.3,5763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5763,1,3,0)
 ;;=3^372.39
 ;;^UTILITY(U,$J,358.3,5763,1,4,0)
 ;;=4^CONJUNCTIVITIS NEC
 ;;^UTILITY(U,$J,358.3,5763,2)
 ;;=^87441
 ;;^UTILITY(U,$J,358.3,5764,0)
 ;;=110.1^^28^381^6
 ;;^UTILITY(U,$J,358.3,5764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5764,1,3,0)
 ;;=3^110.1
 ;;^UTILITY(U,$J,358.3,5764,1,4,0)
 ;;=4^DERMATOPHYTOSIS OF NAIL
 ;;^UTILITY(U,$J,358.3,5764,2)
 ;;=^33173
 ;;^UTILITY(U,$J,358.3,5765,0)
 ;;=562.11^^28^381^7
 ;;^UTILITY(U,$J,358.3,5765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5765,1,3,0)
 ;;=3^562.11
 ;;^UTILITY(U,$J,358.3,5765,1,4,0)
 ;;=4^DIVERTICULITIS
 ;;^UTILITY(U,$J,358.3,5765,2)
 ;;=^270274
 ;;^UTILITY(U,$J,358.3,5766,0)
 ;;=424.99^^28^381^8
 ;;^UTILITY(U,$J,358.3,5766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5766,1,3,0)
 ;;=3^424.99
 ;;^UTILITY(U,$J,358.3,5766,1,4,0)
 ;;=4^ENDOCARDITIS NEC
 ;;^UTILITY(U,$J,358.3,5766,2)
 ;;=^87573
 ;;^UTILITY(U,$J,358.3,5767,0)
 ;;=707.15^^28^381^9
 ;;^UTILITY(U,$J,358.3,5767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5767,1,3,0)
 ;;=3^707.15
 ;;^UTILITY(U,$J,358.3,5767,1,4,0)
 ;;=4^FOOT ULCER
 ;;^UTILITY(U,$J,358.3,5767,2)
 ;;=^322148
 ;;^UTILITY(U,$J,358.3,5768,0)
 ;;=558.9^^28^381^10
 ;;^UTILITY(U,$J,358.3,5768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5768,1,3,0)
 ;;=3^558.9
 ;;^UTILITY(U,$J,358.3,5768,1,4,0)
 ;;=4^GASTROENTERITIS
 ;;^UTILITY(U,$J,358.3,5768,2)
 ;;=^87311
 ;;^UTILITY(U,$J,358.3,5769,0)
 ;;=042.^^28^381^1
 ;;^UTILITY(U,$J,358.3,5769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5769,1,3,0)
 ;;=3^042.
 ;;^UTILITY(U,$J,358.3,5769,1,4,0)
 ;;=4^AIDS (SYMPTOMATIC)
 ;;^UTILITY(U,$J,358.3,5769,2)
 ;;=^266500
 ;;^UTILITY(U,$J,358.3,5770,0)
 ;;=V08.^^28^381^11
 ;;^UTILITY(U,$J,358.3,5770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5770,1,3,0)
 ;;=3^V08.
 ;;^UTILITY(U,$J,358.3,5770,1,4,0)
 ;;=4^HIV+ (ASYMPTOMATIC)
 ;;^UTILITY(U,$J,358.3,5770,2)
 ;;=^303392
 ;;^UTILITY(U,$J,358.3,5771,0)
 ;;=487.1^^28^381^12
 ;;^UTILITY(U,$J,358.3,5771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5771,1,3,0)
 ;;=3^487.1
 ;;
 ;;$END ROU IBDEI0CU
