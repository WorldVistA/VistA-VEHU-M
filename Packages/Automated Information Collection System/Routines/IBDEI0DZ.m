IBDEI0DZ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6354,0)
 ;;=V11.8^^31^409^18
 ;;^UTILITY(U,$J,358.3,6354,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6354,1,4,0)
 ;;=4^V11.8
 ;;^UTILITY(U,$J,358.3,6354,1,5,0)
 ;;=5^HX Psychological Disorder
 ;;^UTILITY(U,$J,358.3,6354,2)
 ;;=^295253
 ;;^UTILITY(U,$J,358.3,6355,0)
 ;;=V15.81^^31^409^17
 ;;^UTILITY(U,$J,358.3,6355,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6355,1,4,0)
 ;;=4^V15.81
 ;;^UTILITY(U,$J,358.3,6355,1,5,0)
 ;;=5^HX Noncompliance w/Tx
 ;;^UTILITY(U,$J,358.3,6355,2)
 ;;=^295290
 ;;^UTILITY(U,$J,358.3,6356,0)
 ;;=V62.89^^31^409^27
 ;;^UTILITY(U,$J,358.3,6356,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6356,1,4,0)
 ;;=4^V62.89
 ;;^UTILITY(U,$J,358.3,6356,1,5,0)
 ;;=5^Psychosocial Problems
 ;;^UTILITY(U,$J,358.3,6356,2)
 ;;=^87822
 ;;^UTILITY(U,$J,358.3,6357,0)
 ;;=785.9^^31^410^2
 ;;^UTILITY(U,$J,358.3,6357,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6357,1,4,0)
 ;;=4^785.9
 ;;^UTILITY(U,$J,358.3,6357,1,5,0)
 ;;=5^Abdominal Bruit
 ;;^UTILITY(U,$J,358.3,6357,2)
 ;;=^273372
 ;;^UTILITY(U,$J,358.3,6358,0)
 ;;=789.30^^31^410^3
 ;;^UTILITY(U,$J,358.3,6358,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6358,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,6358,1,5,0)
 ;;=5^Abdominal/Pelvic Mass, 
 ;;^UTILITY(U,$J,358.3,6358,2)
 ;;=^917
 ;;^UTILITY(U,$J,358.3,6359,0)
 ;;=578.1^^31^410^78
 ;;^UTILITY(U,$J,358.3,6359,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6359,1,4,0)
 ;;=4^578.1
 ;;^UTILITY(U,$J,358.3,6359,1,5,0)
 ;;=5^Melena
 ;;^UTILITY(U,$J,358.3,6359,2)
 ;;=^276839
 ;;^UTILITY(U,$J,358.3,6360,0)
 ;;=112.84^^31^410^7
 ;;^UTILITY(U,$J,358.3,6360,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6360,1,4,0)
 ;;=4^112.84
 ;;^UTILITY(U,$J,358.3,6360,1,5,0)
 ;;=5^Candidiasis Esophagitis
 ;;^UTILITY(U,$J,358.3,6360,2)
 ;;=^259729
 ;;^UTILITY(U,$J,358.3,6361,0)
 ;;=112.0^^31^410^8
 ;;^UTILITY(U,$J,358.3,6361,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6361,1,4,0)
 ;;=4^112.0
 ;;^UTILITY(U,$J,358.3,6361,1,5,0)
 ;;=5^Candidiasis, Oral
 ;;^UTILITY(U,$J,358.3,6361,2)
 ;;=^18599
 ;;^UTILITY(U,$J,358.3,6362,0)
 ;;=575.10^^31^410^9
 ;;^UTILITY(U,$J,358.3,6362,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6362,1,4,0)
 ;;=4^575.10
 ;;^UTILITY(U,$J,358.3,6362,1,5,0)
 ;;=5^Cholecystitis
 ;;^UTILITY(U,$J,358.3,6362,2)
 ;;=^23341
 ;;^UTILITY(U,$J,358.3,6363,0)
 ;;=574.20^^31^410^42
 ;;^UTILITY(U,$J,358.3,6363,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6363,1,4,0)
 ;;=4^574.20
 ;;^UTILITY(U,$J,358.3,6363,1,5,0)
 ;;=5^Gallstones
 ;;^UTILITY(U,$J,358.3,6363,2)
 ;;=^18282
 ;;^UTILITY(U,$J,358.3,6364,0)
 ;;=571.2^^31^410^10
 ;;^UTILITY(U,$J,358.3,6364,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6364,1,4,0)
 ;;=4^571.2
 ;;^UTILITY(U,$J,358.3,6364,1,5,0)
 ;;=5^Cirrhosis, Alcoholic
 ;;^UTILITY(U,$J,358.3,6364,2)
 ;;=^71505
 ;;^UTILITY(U,$J,358.3,6365,0)
 ;;=571.5^^31^410^11
 ;;^UTILITY(U,$J,358.3,6365,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6365,1,4,0)
 ;;=4^571.5
 ;;^UTILITY(U,$J,358.3,6365,1,5,0)
 ;;=5^Cirrhosis, Non-Alcoholic
 ;;^UTILITY(U,$J,358.3,6365,2)
 ;;=^24731
 ;;^UTILITY(U,$J,358.3,6366,0)
 ;;=558.9^^31^410^71
 ;;^UTILITY(U,$J,358.3,6366,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6366,1,4,0)
 ;;=4^558.9
 ;;^UTILITY(U,$J,358.3,6366,1,5,0)
 ;;=5^Inflammatory Bowel Disease
 ;;^UTILITY(U,$J,358.3,6366,2)
 ;;=^87311
 ;;^UTILITY(U,$J,358.3,6367,0)
 ;;=211.3^^31^410^12
 ;;^UTILITY(U,$J,358.3,6367,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6367,1,4,0)
 ;;=4^211.3
 ;;^UTILITY(U,$J,358.3,6367,1,5,0)
 ;;=5^Colon Polyps (current)
 ;;^UTILITY(U,$J,358.3,6367,2)
 ;;=Colon Polyps (current)^13295
 ;;^UTILITY(U,$J,358.3,6368,0)
 ;;=V12.72^^31^410^13
 ;;
 ;;$END ROU IBDEI0DZ
