IBDEI11F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18278,1,3,0)
 ;;=3^Self-Mgmt Educ/Train,2-4 Pt,Ea 30Min
 ;;^UTILITY(U,$J,358.3,18279,0)
 ;;=98962^^97^1161^4^^^^1
 ;;^UTILITY(U,$J,358.3,18279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18279,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,18279,1,3,0)
 ;;=3^Self-Mgmt Educ/Train,5-8 Pt,Ea 30Min
 ;;^UTILITY(U,$J,358.3,18280,0)
 ;;=97535^^97^1162^1^^^^1
 ;;^UTILITY(U,$J,358.3,18280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18280,1,2,0)
 ;;=2^97535
 ;;^UTILITY(U,$J,358.3,18280,1,3,0)
 ;;=3^ADLS Training Ea 15Min
 ;;^UTILITY(U,$J,358.3,18281,0)
 ;;=96105^^97^1162^2^^^^1
 ;;^UTILITY(U,$J,358.3,18281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18281,1,2,0)
 ;;=2^96105
 ;;^UTILITY(U,$J,358.3,18281,1,3,0)
 ;;=3^Aphasia Assessment per Hour
 ;;^UTILITY(U,$J,358.3,18282,0)
 ;;=90901^^97^1162^3^^^^1
 ;;^UTILITY(U,$J,358.3,18282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18282,1,2,0)
 ;;=2^90901
 ;;^UTILITY(U,$J,358.3,18282,1,3,0)
 ;;=3^Biofeedback Training Any Method
 ;;^UTILITY(U,$J,358.3,18283,0)
 ;;=96111^^97^1162^4^^^^1
 ;;^UTILITY(U,$J,358.3,18283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18283,1,2,0)
 ;;=2^96111
 ;;^UTILITY(U,$J,358.3,18283,1,3,0)
 ;;=3^Developmental Testing,Extended
 ;;^UTILITY(U,$J,358.3,18284,0)
 ;;=97750^^97^1162^5^^^^1
 ;;^UTILITY(U,$J,358.3,18284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18284,1,2,0)
 ;;=2^97750
 ;;^UTILITY(U,$J,358.3,18284,1,3,0)
 ;;=3^Extremity Performance Testing Ea 15Min
 ;;^UTILITY(U,$J,358.3,18285,0)
 ;;=95832^^97^1162^6^^^^1
 ;;^UTILITY(U,$J,358.3,18285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18285,1,2,0)
 ;;=2^95832
 ;;^UTILITY(U,$J,358.3,18285,1,3,0)
 ;;=3^Hand Muscle Testing
 ;;^UTILITY(U,$J,358.3,18286,0)
 ;;=95831^^97^1162^7^^^^1
 ;;^UTILITY(U,$J,358.3,18286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18286,1,2,0)
 ;;=2^95831
 ;;^UTILITY(U,$J,358.3,18286,1,3,0)
 ;;=3^Muscle Testing,Limb
 ;;^UTILITY(U,$J,358.3,18287,0)
 ;;=95834^^97^1162^8^^^^1
 ;;^UTILITY(U,$J,358.3,18287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18287,1,2,0)
 ;;=2^95834
 ;;^UTILITY(U,$J,358.3,18287,1,3,0)
 ;;=3^Muscle Testing,Total Body
 ;;^UTILITY(U,$J,358.3,18288,0)
 ;;=97003^^97^1162^9^^^^1
 ;;^UTILITY(U,$J,358.3,18288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18288,1,2,0)
 ;;=2^97003
 ;;^UTILITY(U,$J,358.3,18288,1,3,0)
 ;;=3^OT Evaluation
 ;;^UTILITY(U,$J,358.3,18289,0)
 ;;=97004^^97^1162^10^^^^1
 ;;^UTILITY(U,$J,358.3,18289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18289,1,2,0)
 ;;=2^97004
 ;;^UTILITY(U,$J,358.3,18289,1,3,0)
 ;;=3^OT Re-Evaluation
 ;;^UTILITY(U,$J,358.3,18290,0)
 ;;=97001^^97^1162^11^^^^1
 ;;^UTILITY(U,$J,358.3,18290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18290,1,2,0)
 ;;=2^97001
 ;;^UTILITY(U,$J,358.3,18290,1,3,0)
 ;;=3^PT Evaluation
 ;;^UTILITY(U,$J,358.3,18291,0)
 ;;=97002^^97^1162^12^^^^1
 ;;^UTILITY(U,$J,358.3,18291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18291,1,2,0)
 ;;=2^97002
 ;;^UTILITY(U,$J,358.3,18291,1,3,0)
 ;;=3^PT Re-Evaluation
 ;;^UTILITY(U,$J,358.3,18292,0)
 ;;=95833^^97^1162^13^^^^1
 ;;^UTILITY(U,$J,358.3,18292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18292,1,2,0)
 ;;=2^95833
 ;;^UTILITY(U,$J,358.3,18292,1,3,0)
 ;;=3^Total Body Evaluation,Excl Hands
 ;;^UTILITY(U,$J,358.3,18293,0)
 ;;=90471^^97^1163^1^^^^1
 ;;^UTILITY(U,$J,358.3,18293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18293,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,18293,1,3,0)
 ;;=3^Immunization Admin,Single
 ;;^UTILITY(U,$J,358.3,18294,0)
 ;;=90472^^97^1163^2^^^^1
 ;;^UTILITY(U,$J,358.3,18294,1,0)
 ;;=^358.31IA^3^2
 ;;
 ;;$END ROU IBDEI11F
