IBDEI1WC ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33351,0)
 ;;=J45.902^^182^2002^6
 ;;^UTILITY(U,$J,358.3,33351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33351,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,33351,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,33351,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,33352,0)
 ;;=J45.901^^182^2002^5
 ;;^UTILITY(U,$J,358.3,33352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33352,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,33352,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,33352,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,33353,0)
 ;;=J47.9^^182^2002^11
 ;;^UTILITY(U,$J,358.3,33353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33353,1,3,0)
 ;;=3^Bronchiectasis,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33353,1,4,0)
 ;;=4^J47.9
 ;;^UTILITY(U,$J,358.3,33353,2)
 ;;=^5008260
 ;;^UTILITY(U,$J,358.3,33354,0)
 ;;=J47.1^^182^2002^9
 ;;^UTILITY(U,$J,358.3,33354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33354,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,33354,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,33354,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,33355,0)
 ;;=J47.0^^182^2002^10
 ;;^UTILITY(U,$J,358.3,33355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33355,1,3,0)
 ;;=3^Bronchiectasis w/ Acute Lower Respiratory Infection
 ;;^UTILITY(U,$J,358.3,33355,1,4,0)
 ;;=4^J47.0
 ;;^UTILITY(U,$J,358.3,33355,2)
 ;;=^5008258
 ;;^UTILITY(U,$J,358.3,33356,0)
 ;;=R09.1^^182^2002^37
 ;;^UTILITY(U,$J,358.3,33356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33356,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,33356,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,33356,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,33357,0)
 ;;=J94.9^^182^2002^33
 ;;^UTILITY(U,$J,358.3,33357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33357,1,3,0)
 ;;=3^Pleural Condition,Unspec
 ;;^UTILITY(U,$J,358.3,33357,1,4,0)
 ;;=4^J94.9
 ;;^UTILITY(U,$J,358.3,33357,2)
 ;;=^5008320
 ;;^UTILITY(U,$J,358.3,33358,0)
 ;;=J92.9^^182^2002^36
 ;;^UTILITY(U,$J,358.3,33358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33358,1,3,0)
 ;;=3^Pleural Plaque w/o Asbestos
 ;;^UTILITY(U,$J,358.3,33358,1,4,0)
 ;;=4^J92.9
 ;;^UTILITY(U,$J,358.3,33358,2)
 ;;=^5008313
 ;;^UTILITY(U,$J,358.3,33359,0)
 ;;=J94.8^^182^2002^34
 ;;^UTILITY(U,$J,358.3,33359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33359,1,3,0)
 ;;=3^Pleural Conditions,Other Spec
 ;;^UTILITY(U,$J,358.3,33359,1,4,0)
 ;;=4^J94.8
 ;;^UTILITY(U,$J,358.3,33359,2)
 ;;=^5008319
 ;;^UTILITY(U,$J,358.3,33360,0)
 ;;=J86.9^^182^2002^38
 ;;^UTILITY(U,$J,358.3,33360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33360,1,3,0)
 ;;=3^Pyothorax w/o Fistula
 ;;^UTILITY(U,$J,358.3,33360,1,4,0)
 ;;=4^J86.9
 ;;^UTILITY(U,$J,358.3,33360,2)
 ;;=^5008309
 ;;^UTILITY(U,$J,358.3,33361,0)
 ;;=J91.8^^182^2002^35
 ;;^UTILITY(U,$J,358.3,33361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33361,1,3,0)
 ;;=3^Pleural Effusion in Other Conditions
 ;;^UTILITY(U,$J,358.3,33361,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,33361,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,33362,0)
 ;;=J84.9^^182^2002^30
 ;;^UTILITY(U,$J,358.3,33362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33362,1,3,0)
 ;;=3^Interstitial Pulmonary Disease,Unspec
 ;;^UTILITY(U,$J,358.3,33362,1,4,0)
 ;;=4^J84.9
 ;;^UTILITY(U,$J,358.3,33362,2)
 ;;=^5008304
 ;;^UTILITY(U,$J,358.3,33363,0)
 ;;=J98.01^^182^2002^13
 ;;^UTILITY(U,$J,358.3,33363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33363,1,3,0)
 ;;=3^Bronchospasm,Acute
 ;;^UTILITY(U,$J,358.3,33363,1,4,0)
 ;;=4^J98.01
 ;;^UTILITY(U,$J,358.3,33363,2)
 ;;=^334092
 ;;^UTILITY(U,$J,358.3,33364,0)
 ;;=G47.30^^182^2002^53
 ;;
 ;;$END ROU IBDEI1WC
