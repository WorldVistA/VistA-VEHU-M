NURCCG3X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1425,0)
 ;;=release [amt]cc at 15 minute intervals till bladder drained^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1425,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1425,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1426,0)
 ;;=initiate prescribed management program:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1426,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1426,1,1,0)
 ;;=1427^intermittent cath q [time]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1426,1,2,0)
 ;;=1428^foley cath x [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1426,1,3,0)
 ;;=1429^crede method^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1426,1,4,0)
 ;;=1430^sphincter relaxation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1426,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1426,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1426,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1427,0)
 ;;=intermittent cath q [time]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1428,0)
 ;;=foley cath x [frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1429,0)
 ;;=crede method^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1430,0)
 ;;=sphincter relaxation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1431,0)
 ;;=observe return demo x[ ] by pt/S/O of management program^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1431,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1431,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1432,0)
 ;;=lab data (e.g. CBC, differential) is WNL^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1433,0)
 ;;=maintains full, equal and non-labored respirations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1433,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1433,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1434,0)
 ;;=reduces anxiety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1434,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1434,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1435,0)
 ;;=breathes easier, maintains adequate ABGs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1435,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1435,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1436,0)
 ;;=maintains clear lungs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1436,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1436,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1437,0)
 ;;=edema decreased^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1437,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1437,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1438,0)
 ;;=verbalizes sense of hope for future^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1438,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1438,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1439,0)
 ;;=maintains nontender abdomen^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1439,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1439,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1440,0)
 ;;=is free of an S3 and S4^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1440,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1440,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1441,0)
 ;;=JVD not present or returned to baseline^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1441,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1441,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1442,0)
 ;;=expresses acceptable level of comfort^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1442,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1442,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1443,0)
 ;;=accepts therapeutic regimen^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1443,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1443,10)
 ;;=D EN2^NURCCPU1
