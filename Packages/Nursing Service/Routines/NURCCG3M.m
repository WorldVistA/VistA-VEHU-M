NURCCG3M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,6,0)
 ;;=1270^notify MD of patient's rhythm and response to therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,7,0)
 ;;=1272^alter therapy as indicated and document^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,8,0)
 ;;=1296^increase surveillance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,9,0)
 ;;=323^respiratory pattern q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,10,0)
 ;;=2745^sensorium q[frequency]hrs^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1287,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1287,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1288,0)
 ;;=stimulate voiding reflex by pouring warm water over perineum^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1288,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1288,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1289,0)
 ;;=provide motivation to increase bladder control:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1289,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1289,1,1,0)
 ;;=1291^encourage street clothes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1289,1,2,0)
 ;;=1292^change wet clothes/bedding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1289,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1289,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1289,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1290,0)
 ;;=give Atropine [dose]mg IV per protocol^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1291,0)
 ;;=encourage street clothes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1292,0)
 ;;=change wet clothes/bedding^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1293,0)
 ;;=provide with product resources to prevent wetting of clothes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1293,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1293,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1294,0)
 ;;=review patient's drugs for vagolytic effects^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1295,0)
 ;;=teach intermittent catheterization per protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1295,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1295,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1296,0)
 ;;=increase surveillance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1297,0)
 ;;=complete heart block interventions ^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,1,0)
 ;;=1290^give Atropine [dose]mg IV per protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,2,0)
 ;;=1265^B/P q[frequency]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,3,0)
 ;;=2745^sensorium q[frequency]hrs^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,4,0)
 ;;=1270^notify MD of patient's rhythm and response to therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,5,0)
 ;;=1355^prepare Isuprel drip for IV infusion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,6,0)
 ;;=1356^prepare for temporary cardiac pacemaker^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,1,7,0)
 ;;=323^respiratory pattern q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1297,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1297,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1297,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1297,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1298,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^31^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1298,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1298,1,1,0)
 ;;=776^remains free from injuries^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1298,1,2,0)
 ;;=777^verbalizes how to prevent injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1298,1,3,0)
 ;;=2896^[Extra Goal]^3^NURSC^75^0
 ;;^UTILITY("^GMRD(124.2,",$J,1298,7)
 ;;=D EN4^NURCCPU1
