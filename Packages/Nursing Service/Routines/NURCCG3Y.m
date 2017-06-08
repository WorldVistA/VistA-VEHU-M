NURCCG3Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1444,0)
 ;;=assess for reliable response/successful communication mode:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1444,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1444,1,1,0)
 ;;=1445^to 'yes' and 'no'^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1444,1,2,0)
 ;;=1446^to choice^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1444,1,3,0)
 ;;=1447^to pantomime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1444,1,4,0)
 ;;=1448^to writing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1444,1,5,0)
 ;;=1449^to English^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1444,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1444,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1444,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1445,0)
 ;;=to 'yes' and 'no'^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1446,0)
 ;;=to choice^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1447,0)
 ;;=to pantomime^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1448,0)
 ;;=to writing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1449,0)
 ;;=to English^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1450,0)
 ;;=if unreliable response/attempt communication mode:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1450,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1450,1,1,0)
 ;;=1451^use pantomime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1450,1,2,0)
 ;;=1452^anticipate needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1450,1,3,0)
 ;;=1453^assist patient to meet basic needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1450,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1450,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1450,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1451,0)
 ;;=use pantomime^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1452,0)
 ;;=anticipate needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1453,0)
 ;;=assist patient to meet basic needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1454,0)
 ;;=preload reduced; myocardial contractility increased^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1454,5)
 ;;=and cardiac output is improved
 ;;^UTILITY("^GMRD(124.2,",$J,1454,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1454,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1455,0)
 ;;=reassess communication ability q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1455,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1455,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1456,0)
 ;;=accepts and explains diagnostic procedures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1456,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1456,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1457,0)
 ;;=left ventricular end diastolic pressure is decreased^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1457,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1457,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1458,0)
 ;;=myocardial oxygen demand is minimized^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1458,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1458,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1459,0)
 ;;=is hemodynamically stable^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1459,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1459,1,1,0)
 ;;=1460^B/P WNL (baseline)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1459,1,2,0)
 ;;=1461^PAW WNL (baseline)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1459,1,3,0)
 ;;=2746^normal sinus rhythm^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1459,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,1459,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1459,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1459,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1460,0)
 ;;=B/P WNL (baseline)^3^NURSC^^1^^^T
