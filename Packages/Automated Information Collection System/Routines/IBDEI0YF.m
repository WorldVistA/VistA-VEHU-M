IBDEI0YF ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16774,1,1,0)
 ;;=1^A7037
 ;;^UTILITY(U,$J,358.3,16774,1,3,0)
 ;;=3^PRESSURE TUBING
 ;;^UTILITY(U,$J,358.3,16775,0)
 ;;=A4604^^85^1013^15^^^^1
 ;;^UTILITY(U,$J,358.3,16775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16775,1,1,0)
 ;;=1^A4604
 ;;^UTILITY(U,$J,358.3,16775,1,3,0)
 ;;=3^TUBING WITH HEATING ELEMENT
 ;;^UTILITY(U,$J,358.3,16776,0)
 ;;=A7046^^85^1013^16^^^^1
 ;;^UTILITY(U,$J,358.3,16776,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16776,1,1,0)
 ;;=1^A7046
 ;;^UTILITY(U,$J,358.3,16776,1,3,0)
 ;;=3^WATER CHAMBER REPLACEMENT
 ;;^UTILITY(U,$J,358.3,16777,0)
 ;;=A7031^^85^1013^8^^^^1
 ;;^UTILITY(U,$J,358.3,16777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16777,1,1,0)
 ;;=1^A7031
 ;;^UTILITY(U,$J,358.3,16777,1,3,0)
 ;;=3^MASK INTERFACE REPLACEMENT
 ;;^UTILITY(U,$J,358.3,16778,0)
 ;;=A7034^^85^1013^9^^^^1
 ;;^UTILITY(U,$J,358.3,16778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16778,1,1,0)
 ;;=1^A7034
 ;;^UTILITY(U,$J,358.3,16778,1,3,0)
 ;;=3^NASAL APPLICATION DEVICE
 ;;^UTILITY(U,$J,358.3,16779,0)
 ;;=99211^^86^1014^1
 ;;^UTILITY(U,$J,358.3,16779,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,16779,1,1,0)
 ;;=1^Problem Focused Visit
 ;;^UTILITY(U,$J,358.3,16779,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,16780,0)
 ;;=99221^^86^1015^1
 ;;^UTILITY(U,$J,358.3,16780,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,16780,1,1,0)
 ;;=1^Initial Hospital Care
 ;;^UTILITY(U,$J,358.3,16780,1,2,0)
 ;;=2^99221
 ;;^UTILITY(U,$J,358.3,16781,0)
 ;;=783.0^^87^1016^4
 ;;^UTILITY(U,$J,358.3,16781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16781,1,3,0)
 ;;=3^783.0
 ;;^UTILITY(U,$J,358.3,16781,1,4,0)
 ;;=4^Anorexia
 ;;^UTILITY(U,$J,358.3,16782,0)
 ;;=786.50^^87^1016^6
 ;;^UTILITY(U,$J,358.3,16782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16782,1,3,0)
 ;;=3^786.50
 ;;^UTILITY(U,$J,358.3,16782,1,4,0)
 ;;=4^Chest Pain
 ;;^UTILITY(U,$J,358.3,16783,0)
 ;;=786.2^^87^1016^8
 ;;^UTILITY(U,$J,358.3,16783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16783,1,3,0)
 ;;=3^786.2
 ;;^UTILITY(U,$J,358.3,16783,1,4,0)
 ;;=4^Cough
 ;;^UTILITY(U,$J,358.3,16784,0)
 ;;=780.4^^87^1016^10
 ;;^UTILITY(U,$J,358.3,16784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16784,1,3,0)
 ;;=3^780.4
 ;;^UTILITY(U,$J,358.3,16784,1,4,0)
 ;;=4^Dizziness/Vertigo
 ;;^UTILITY(U,$J,358.3,16784,2)
 ;;=^35946
 ;;^UTILITY(U,$J,358.3,16785,0)
 ;;=536.8^^87^1016^11
 ;;^UTILITY(U,$J,358.3,16785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16785,1,3,0)
 ;;=3^536.8
 ;;^UTILITY(U,$J,358.3,16785,1,4,0)
 ;;=4^Dyspepsia/Indigest
 ;;^UTILITY(U,$J,358.3,16786,0)
 ;;=788.1^^87^1016^13
 ;;^UTILITY(U,$J,358.3,16786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16786,1,3,0)
 ;;=3^788.1
 ;;^UTILITY(U,$J,358.3,16786,1,4,0)
 ;;=4^Dysuria,Urgency,Freq.
 ;;^UTILITY(U,$J,358.3,16787,0)
 ;;=782.3^^87^1016^14
 ;;^UTILITY(U,$J,358.3,16787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16787,1,3,0)
 ;;=3^782.3
 ;;^UTILITY(U,$J,358.3,16787,1,4,0)
 ;;=4^Edema
 ;;^UTILITY(U,$J,358.3,16788,0)
 ;;=784.0^^87^1016^16
 ;;^UTILITY(U,$J,358.3,16788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16788,1,3,0)
 ;;=3^784.0
 ;;^UTILITY(U,$J,358.3,16788,1,4,0)
 ;;=4^Headache
 ;;^UTILITY(U,$J,358.3,16789,0)
 ;;=782.2^^87^1016^20
 ;;^UTILITY(U,$J,358.3,16789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16789,1,3,0)
 ;;=3^782.2
 ;;^UTILITY(U,$J,358.3,16789,1,4,0)
 ;;=4^Mass/Local Swelling
 ;;^UTILITY(U,$J,358.3,16790,0)
 ;;=785.1^^87^1016^23
 ;;^UTILITY(U,$J,358.3,16790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16790,1,3,0)
 ;;=3^785.1
 ;;^UTILITY(U,$J,358.3,16790,1,4,0)
 ;;=4^Palpitations
 ;;
 ;;$END ROU IBDEI0YF
