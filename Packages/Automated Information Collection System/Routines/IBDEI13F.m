IBDEI13F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19290,1,5,0)
 ;;=5^Gastritis,Eosinophilic w/o Hemorrhage
 ;;^UTILITY(U,$J,358.3,19290,2)
 ;;=^336750
 ;;^UTILITY(U,$J,358.3,19291,0)
 ;;=535.71^^105^1229^44
 ;;^UTILITY(U,$J,358.3,19291,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19291,1,4,0)
 ;;=4^535.71
 ;;^UTILITY(U,$J,358.3,19291,1,5,0)
 ;;=5^Gastritis,Eosinophilic w/ Hemorrhage
 ;;^UTILITY(U,$J,358.3,19291,2)
 ;;=^336606
 ;;^UTILITY(U,$J,358.3,19292,0)
 ;;=558.41^^105^1229^28
 ;;^UTILITY(U,$J,358.3,19292,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19292,1,4,0)
 ;;=4^558.41
 ;;^UTILITY(U,$J,358.3,19292,1,5,0)
 ;;=5^Eosinophilic Gastroenteritis
 ;;^UTILITY(U,$J,358.3,19292,2)
 ;;=^336607
 ;;^UTILITY(U,$J,358.3,19293,0)
 ;;=558.42^^105^1229^27
 ;;^UTILITY(U,$J,358.3,19293,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19293,1,4,0)
 ;;=4^558.42
 ;;^UTILITY(U,$J,358.3,19293,1,5,0)
 ;;=5^Eosinophilic Colitis
 ;;^UTILITY(U,$J,358.3,19293,2)
 ;;=^336608
 ;;^UTILITY(U,$J,358.3,19294,0)
 ;;=569.44^^105^1229^25
 ;;^UTILITY(U,$J,358.3,19294,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19294,1,4,0)
 ;;=4^569.44
 ;;^UTILITY(U,$J,358.3,19294,1,5,0)
 ;;=5^Dysplasia of Anus
 ;;^UTILITY(U,$J,358.3,19294,2)
 ;;=^336609
 ;;^UTILITY(U,$J,358.3,19295,0)
 ;;=571.42^^105^1229^59
 ;;^UTILITY(U,$J,358.3,19295,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19295,1,4,0)
 ;;=4^571.42
 ;;^UTILITY(U,$J,358.3,19295,1,5,0)
 ;;=5^Hepatitis,Autoimmune
 ;;^UTILITY(U,$J,358.3,19295,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,19296,0)
 ;;=787.21^^105^1229^21
 ;;^UTILITY(U,$J,358.3,19296,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19296,1,4,0)
 ;;=4^787.21
 ;;^UTILITY(U,$J,358.3,19296,1,5,0)
 ;;=5^Dysphagia,Oral Phase
 ;;^UTILITY(U,$J,358.3,19296,2)
 ;;=^335276
 ;;^UTILITY(U,$J,358.3,19297,0)
 ;;=787.22^^105^1229^22
 ;;^UTILITY(U,$J,358.3,19297,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19297,1,4,0)
 ;;=4^787.22
 ;;^UTILITY(U,$J,358.3,19297,1,5,0)
 ;;=5^Dysphagia,Oropharyngeal
 ;;^UTILITY(U,$J,358.3,19297,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,19298,0)
 ;;=787.23^^105^1229^23
 ;;^UTILITY(U,$J,358.3,19298,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19298,1,4,0)
 ;;=4^787.23
 ;;^UTILITY(U,$J,358.3,19298,1,5,0)
 ;;=5^Dysphagia,Pharyngeal
 ;;^UTILITY(U,$J,358.3,19298,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,19299,0)
 ;;=787.24^^105^1229^24
 ;;^UTILITY(U,$J,358.3,19299,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19299,1,4,0)
 ;;=4^787.24
 ;;^UTILITY(U,$J,358.3,19299,1,5,0)
 ;;=5^Dysphagia,Pharyngoesoph
 ;;^UTILITY(U,$J,358.3,19299,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,19300,0)
 ;;=787.29^^105^1229^20
 ;;^UTILITY(U,$J,358.3,19300,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19300,1,4,0)
 ;;=4^787.29
 ;;^UTILITY(U,$J,358.3,19300,1,5,0)
 ;;=5^Dysphagia NEC
 ;;^UTILITY(U,$J,358.3,19300,2)
 ;;=^335280
 ;;^UTILITY(U,$J,358.3,19301,0)
 ;;=584.9^^105^1230^2
 ;;^UTILITY(U,$J,358.3,19301,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19301,1,4,0)
 ;;=4^584.9
 ;;^UTILITY(U,$J,358.3,19301,1,5,0)
 ;;=5^Acute Renal Failure
 ;;^UTILITY(U,$J,358.3,19301,2)
 ;;=^67114
 ;;^UTILITY(U,$J,358.3,19302,0)
 ;;=583.9^^105^1230^19
 ;;^UTILITY(U,$J,358.3,19302,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19302,1,4,0)
 ;;=4^583.9
 ;;^UTILITY(U,$J,358.3,19302,1,5,0)
 ;;=5^Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,19302,2)
 ;;=^83446
 ;;^UTILITY(U,$J,358.3,19303,0)
 ;;=403.90^^105^1230^51
 ;;^UTILITY(U,$J,358.3,19303,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19303,1,4,0)
 ;;=4^403.90
 ;;^UTILITY(U,$J,358.3,19303,1,5,0)
 ;;=5^Renal Insufficiency with Hypertension (CRI and HTN)
 ;;^UTILITY(U,$J,358.3,19303,2)
 ;;=Renal Insufficiency with Hypertension (CRI and HTN)^269609
 ;;
 ;;$END ROU IBDEI13F
