IBDEI1UX ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32690,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,32690,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,32690,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,32691,0)
 ;;=R59.1^^182^1992^55
 ;;^UTILITY(U,$J,358.3,32691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32691,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,32691,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,32691,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,32692,0)
 ;;=C91.40^^182^1992^74
 ;;^UTILITY(U,$J,358.3,32692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32692,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,32692,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,32692,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,32693,0)
 ;;=C91.42^^182^1992^72
 ;;^UTILITY(U,$J,358.3,32693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32693,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,32693,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,32693,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,32694,0)
 ;;=C91.41^^182^1992^73
 ;;^UTILITY(U,$J,358.3,32694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32694,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,32694,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,32694,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,32695,0)
 ;;=D57.01^^182^1992^75
 ;;^UTILITY(U,$J,358.3,32695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32695,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,32695,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,32695,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,32696,0)
 ;;=D57.00^^182^1992^76
 ;;^UTILITY(U,$J,358.3,32696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32696,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,32696,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,32696,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,32697,0)
 ;;=D57.02^^182^1992^77
 ;;^UTILITY(U,$J,358.3,32697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32697,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,32697,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,32697,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,32698,0)
 ;;=D68.32^^182^1992^79
 ;;^UTILITY(U,$J,358.3,32698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32698,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,32698,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,32698,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,32699,0)
 ;;=C22.2^^182^1992^80
 ;;^UTILITY(U,$J,358.3,32699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32699,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,32699,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,32699,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,32700,0)
 ;;=D58.9^^182^1992^82
 ;;^UTILITY(U,$J,358.3,32700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32700,1,3,0)
 ;;=3^Hereditary Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,32700,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,32700,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,32701,0)
 ;;=D56.4^^182^1992^81
 ;;^UTILITY(U,$J,358.3,32701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32701,1,3,0)
 ;;=3^Herediatary Persistence of Fetal Hemoglobin
 ;;^UTILITY(U,$J,358.3,32701,1,4,0)
 ;;=4^D56.4
 ;;^UTILITY(U,$J,358.3,32701,2)
 ;;=^293655
 ;;^UTILITY(U,$J,358.3,32702,0)
 ;;=C81.99^^182^1992^83
 ;;^UTILITY(U,$J,358.3,32702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32702,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,32702,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,32702,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,32703,0)
 ;;=C81.90^^182^1992^84
 ;;
 ;;$END ROU IBDEI1UX
