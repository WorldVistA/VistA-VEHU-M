NURCCG3T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,3,0)
 ;;=1143^assess/record bladder distention q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,4,0)
 ;;=1392^notify MD if not voided by [time]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,5,0)
 ;;=994^assess for impaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,6,0)
 ;;=1393^establish daily management schedule [type] q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,7,0)
 ;;=937^provide privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,8,0)
 ;;=938^provide comfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,9,0)
 ;;=1421^use toilet facilities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,10,0)
 ;;=1423^clamp catheter if >[amt]cc urine obtained on catheterization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,11,0)
 ;;=1425^release [amt]cc at 15 minute intervals till bladder drained^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,12,0)
 ;;=1426^initiate prescribed management program:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,13,0)
 ;;=1431^observe return demo x[ ] by pt/S/O of management program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,14,0)
 ;;=1295^teach intermittent catheterization per protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,15,0)
 ;;=1207^initiate teaching protocol on S/S of urinary infection:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,16,0)
 ;;=2987^[Extra Order]^3^NURSC^72^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1365,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1366,0)
 ;;=Related Problems^2^NURSC^7^26^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1366,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1366,1,1,0)
 ;;=1410^Urinary Elimination, Alteration In Pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1366,1,2,0)
 ;;=1413^Incontinence, Urine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1366,1,3,0)
 ;;=1414^Constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1366,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1366,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1366,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1367,0)
 ;;=blockage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1368,0)
 ;;=high urethral pressure caused by weak detrusor^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1369,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^37^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1369,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1369,1,1,0)
 ;;=1372^alteration in afterload^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1369,1,2,0)
 ;;=1373^alteration in inotropic changes in the heart^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1369,1,3,0)
 ;;=1375^alteration in preload^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1369,1,4,0)
 ;;=1379^related to alteration in myocardial contractility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1369,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1370,0)
 ;;=inhibition of reflex arc^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1371,0)
 ;;=strong sphincter^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1372,0)
 ;;=alteration in afterload^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1373,0)
 ;;=alteration in inotropic changes in the heart^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1374,0)
 ;;=demonstrates an established voiding/cath pattern^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1374,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1374,1,1,0)
 ;;=1376^independently^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1374,1,2,0)
 ;;=1377^with assistance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1374,1,3,0)
 ;;=1378^by direction to another^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1374,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,1374,7)
 ;;=D EN4^NURCCPU1
