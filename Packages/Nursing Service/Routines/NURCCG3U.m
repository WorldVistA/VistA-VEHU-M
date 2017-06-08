NURCCG3U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1374,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1374,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1375,0)
 ;;=alteration in preload^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1376,0)
 ;;=independently^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1377,0)
 ;;=with assistance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1378,0)
 ;;=by direction to another^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1379,0)
 ;;=related to alteration in myocardial contractility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1380,0)
 ;;=Related Problems^2^NURSC^7^27^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1380,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1380,1,1,0)
 ;;=1383^Activity Intolerance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1380,1,2,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1380,1,3,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1380,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1381,0)
 ;;=states frequency for performance of management program^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1381,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1381,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1382,0)
 ;;=states S/S of complications (infect./incontinence)^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1382,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1382,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1383,0)
 ;;=Activity Intolerance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1384,0)
 ;;=maintains adequate bladder emptying^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1384,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1384,1,1,0)
 ;;=1385^output volume of [amt]cc or less q [frequency] hr^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1384,1,2,0)
 ;;=1386^no incontinence between caths^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1384,1,3,0)
 ;;=1387^foley cath to straight drainage without bladder distention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1384,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,1384,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1384,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1384,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1385,0)
 ;;=output volume of [amt]cc or less q [frequency] hr^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1386,0)
 ;;=no incontinence between caths^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1387,0)
 ;;=foley cath to straight drainage without bladder distention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1388,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^36^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,0)
 ;;=^124.21PI^17^17
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,1,0)
 ;;=1395^maintains adequate cardiac output^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,2,0)
 ;;=1433^maintains full, equal and non-labored respirations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,3,0)
 ;;=1434^reduces anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,4,0)
 ;;=1435^breathes easier, maintains adequate ABGs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,5,0)
 ;;=1436^maintains clear lungs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,6,0)
 ;;=1437^edema decreased^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,7,0)
 ;;=1439^maintains nontender abdomen^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,8,0)
 ;;=1440^is free of an S3 and S4^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,9,0)
 ;;=1441^JVD not present or returned to baseline^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,10,0)
 ;;=1442^expresses acceptable level of comfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,11,0)
 ;;=1443^accepts therapeutic regimen^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1388,1,12,0)
 ;;=1454^preload reduced; myocardial contractility increased^3^NURSC^1^0
