IBDEI0UB ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14695,1,2,0)
 ;;=2^97010
 ;;^UTILITY(U,$J,358.3,14695,1,3,0)
 ;;=3^HOT OR COLD PACKS THERAPY
 ;;^UTILITY(U,$J,358.3,14696,0)
 ;;=97140^^78^910^13^^^^1
 ;;^UTILITY(U,$J,358.3,14696,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14696,1,2,0)
 ;;=2^97140
 ;;^UTILITY(U,$J,358.3,14696,1,3,0)
 ;;=3^MANUAL THERAPY EA 15MIN
 ;;^UTILITY(U,$J,358.3,14697,0)
 ;;=97112^^78^910^14^^^^1
 ;;^UTILITY(U,$J,358.3,14697,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14697,1,2,0)
 ;;=2^97112
 ;;^UTILITY(U,$J,358.3,14697,1,3,0)
 ;;=3^NEUROMUSCULAR REEDUCATION
 ;;^UTILITY(U,$J,358.3,14698,0)
 ;;=97799^^78^910^15^^^^1
 ;;^UTILITY(U,$J,358.3,14698,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14698,1,2,0)
 ;;=2^97799
 ;;^UTILITY(U,$J,358.3,14698,1,3,0)
 ;;=3^PHYSICAL MEDICINE PROCEDURE
 ;;^UTILITY(U,$J,358.3,14699,0)
 ;;=97533^^78^910^16^^^^1
 ;;^UTILITY(U,$J,358.3,14699,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14699,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,14699,1,3,0)
 ;;=3^SENSORY INTEGRATION EA 15MIN
 ;;^UTILITY(U,$J,358.3,14700,0)
 ;;=97035^^78^910^17^^^^1
 ;;^UTILITY(U,$J,358.3,14700,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14700,1,2,0)
 ;;=2^97035
 ;;^UTILITY(U,$J,358.3,14700,1,3,0)
 ;;=3^ULTASOUND THERAPY EA 15MIN
 ;;^UTILITY(U,$J,358.3,14701,0)
 ;;=95831^^78^911^1^^^^1
 ;;^UTILITY(U,$J,358.3,14701,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14701,1,2,0)
 ;;=2^95831
 ;;^UTILITY(U,$J,358.3,14701,1,3,0)
 ;;=3^MUSCLE TESTING,MANUAL,EXT OR TRUNK
 ;;^UTILITY(U,$J,358.3,14702,0)
 ;;=95832^^78^911^2^^^^1
 ;;^UTILITY(U,$J,358.3,14702,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14702,1,2,0)
 ;;=2^95832
 ;;^UTILITY(U,$J,358.3,14702,1,3,0)
 ;;=3^MUSCLE TESTING,MANUAL,HAND
 ;;^UTILITY(U,$J,358.3,14703,0)
 ;;=95833^^78^911^3^^^^1
 ;;^UTILITY(U,$J,358.3,14703,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14703,1,2,0)
 ;;=2^95833
 ;;^UTILITY(U,$J,358.3,14703,1,3,0)
 ;;=3^TOTAL EVAL,EXCLUDING HANDS
 ;;^UTILITY(U,$J,358.3,14704,0)
 ;;=95834^^78^911^4^^^^1
 ;;^UTILITY(U,$J,358.3,14704,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14704,1,2,0)
 ;;=2^95834
 ;;^UTILITY(U,$J,358.3,14704,1,3,0)
 ;;=3^TOTAL EVAL,INCLUDING HANDS
 ;;^UTILITY(U,$J,358.3,14705,0)
 ;;=95851^^78^911^5^^^^1
 ;;^UTILITY(U,$J,358.3,14705,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14705,1,2,0)
 ;;=2^95851
 ;;^UTILITY(U,$J,358.3,14705,1,3,0)
 ;;=3^ROM MEASURE,EACH EXT/SPINE
 ;;^UTILITY(U,$J,358.3,14706,0)
 ;;=95852^^78^911^6^^^^1
 ;;^UTILITY(U,$J,358.3,14706,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14706,1,2,0)
 ;;=2^95852
 ;;^UTILITY(U,$J,358.3,14706,1,3,0)
 ;;=3^ROM MEASUREMENT,HANDS
 ;;^UTILITY(U,$J,358.3,14707,0)
 ;;=95857^^78^911^7^^^^1
 ;;^UTILITY(U,$J,358.3,14707,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14707,1,2,0)
 ;;=2^95857
 ;;^UTILITY(U,$J,358.3,14707,1,3,0)
 ;;=3^CHOLINESTERASE INHIB CHALLENGE
 ;;^UTILITY(U,$J,358.3,14708,0)
 ;;=95860^^78^911^8^^^^1
 ;;^UTILITY(U,$J,358.3,14708,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14708,1,2,0)
 ;;=2^95860
 ;;^UTILITY(U,$J,358.3,14708,1,3,0)
 ;;=3^EMG,ONE EXTREMITY
 ;;^UTILITY(U,$J,358.3,14709,0)
 ;;=95861^^78^911^9^^^^1
 ;;^UTILITY(U,$J,358.3,14709,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14709,1,2,0)
 ;;=2^95861
 ;;^UTILITY(U,$J,358.3,14709,1,3,0)
 ;;=3^EMG,TWO EXTREMITIES
 ;;^UTILITY(U,$J,358.3,14710,0)
 ;;=95863^^78^911^10^^^^1
 ;;^UTILITY(U,$J,358.3,14710,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14710,1,2,0)
 ;;=2^95863
 ;;^UTILITY(U,$J,358.3,14710,1,3,0)
 ;;=3^EMG,THREE EXTREMITIES
 ;;^UTILITY(U,$J,358.3,14711,0)
 ;;=95864^^78^911^11^^^^1
 ;;^UTILITY(U,$J,358.3,14711,1,0)
 ;;=^358.31IA^3^2
 ;;
 ;;$END ROU IBDEI0UB
