IBDEI0H6 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7993,1,5,0)
 ;;=5^GI Bleed
 ;;^UTILITY(U,$J,358.3,7993,2)
 ;;=GI Bleed^49525
 ;;^UTILITY(U,$J,358.3,7994,0)
 ;;=531.70^^35^479^42
 ;;^UTILITY(U,$J,358.3,7994,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7994,1,4,0)
 ;;=4^531.70
 ;;^UTILITY(U,$J,358.3,7994,1,5,0)
 ;;=5^Gastric Ulcer, Chronic
 ;;^UTILITY(U,$J,358.3,7994,2)
 ;;=^270086
 ;;^UTILITY(U,$J,358.3,7995,0)
 ;;=535.50^^35^479^43
 ;;^UTILITY(U,$J,358.3,7995,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7995,1,4,0)
 ;;=4^535.50
 ;;^UTILITY(U,$J,358.3,7995,1,5,0)
 ;;=5^Gastritis
 ;;^UTILITY(U,$J,358.3,7995,2)
 ;;=^270181
 ;;^UTILITY(U,$J,358.3,7996,0)
 ;;=041.86^^35^479^47
 ;;^UTILITY(U,$J,358.3,7996,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7996,1,4,0)
 ;;=4^041.86
 ;;^UTILITY(U,$J,358.3,7996,1,5,0)
 ;;=5^H. Pylori Infection
 ;;^UTILITY(U,$J,358.3,7996,2)
 ;;=^303246
 ;;^UTILITY(U,$J,358.3,7997,0)
 ;;=455.6^^35^479^49
 ;;^UTILITY(U,$J,358.3,7997,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7997,1,4,0)
 ;;=4^455.6
 ;;^UTILITY(U,$J,358.3,7997,1,5,0)
 ;;=5^Hemorrhoids NOS
 ;;^UTILITY(U,$J,358.3,7997,2)
 ;;=^123922
 ;;^UTILITY(U,$J,358.3,7998,0)
 ;;=789.1^^35^479^60
 ;;^UTILITY(U,$J,358.3,7998,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7998,1,4,0)
 ;;=4^789.1
 ;;^UTILITY(U,$J,358.3,7998,1,5,0)
 ;;=5^Hepatomegaly
 ;;^UTILITY(U,$J,358.3,7998,2)
 ;;=^56494
 ;;^UTILITY(U,$J,358.3,7999,0)
 ;;=553.3^^35^479^64
 ;;^UTILITY(U,$J,358.3,7999,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7999,1,4,0)
 ;;=4^553.3
 ;;^UTILITY(U,$J,358.3,7999,1,5,0)
 ;;=5^Hiatal Hernia
 ;;^UTILITY(U,$J,358.3,7999,2)
 ;;=^33903
 ;;^UTILITY(U,$J,358.3,8000,0)
 ;;=550.92^^35^479^62
 ;;^UTILITY(U,$J,358.3,8000,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8000,1,4,0)
 ;;=4^550.92
 ;;^UTILITY(U,$J,358.3,8000,1,5,0)
 ;;=5^Hernia, Inguinal, Bilat
 ;;^UTILITY(U,$J,358.3,8000,2)
 ;;=^270212
 ;;^UTILITY(U,$J,358.3,8001,0)
 ;;=550.90^^35^479^63
 ;;^UTILITY(U,$J,358.3,8001,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8001,1,4,0)
 ;;=4^550.90
 ;;^UTILITY(U,$J,358.3,8001,1,5,0)
 ;;=5^Hernia, Inguinal, Unilat
 ;;^UTILITY(U,$J,358.3,8001,2)
 ;;=^63302
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=553.9^^35^479^61
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8002,1,4,0)
 ;;=4^553.9
 ;;^UTILITY(U,$J,358.3,8002,1,5,0)
 ;;=5^Hernia NOS
 ;;^UTILITY(U,$J,358.3,8002,2)
 ;;=^56659
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=564.1^^35^479^68
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8003,1,4,0)
 ;;=4^564.1
 ;;^UTILITY(U,$J,358.3,8003,1,5,0)
 ;;=5^Irritable Bowel Syndrome
 ;;^UTILITY(U,$J,358.3,8003,2)
 ;;=^65682^909.2
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=787.02^^35^479^74
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^787.02
 ;;^UTILITY(U,$J,358.3,8004,1,5,0)
 ;;=5^Nausea
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^81639
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=787.01^^35^479^75
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^787.01
 ;;^UTILITY(U,$J,358.3,8005,1,5,0)
 ;;=5^Nausea W/ Vomiting
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=^81644
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=577.2^^35^479^77
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^577.2
 ;;^UTILITY(U,$J,358.3,8006,1,5,0)
 ;;=5^Pancreatic Pseudocyst
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=^30078
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=577.0^^35^479^78
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^577.0
 ;;^UTILITY(U,$J,358.3,8007,1,5,0)
 ;;=5^Pancreatitis, Acute
 ;;
 ;;$END ROU IBDEI0H6
