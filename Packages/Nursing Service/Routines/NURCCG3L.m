NURCCG3L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1268,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1268,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1269,0)
 ;;=regulates own fluid intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1270,0)
 ;;=notify MD of patient's rhythm and response to therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1271,0)
 ;;=catheterization as indicated/ordered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1272,0)
 ;;=alter therapy as indicated and document^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1273,0)
 ;;=assess voiding/urgency patterns^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1273,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1273,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1274,0)
 ;;=record time between voidings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1274,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1274,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1275,0)
 ;;=remove environmental barriers to voiding:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,1,0)
 ;;=1276^clear path to bathroom^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,2,0)
 ;;=1277^commode at bedside^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,3,0)
 ;;=1278^urinal within reach^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,4,0)
 ;;=1280^use toilet facilities with hand rails^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,5,0)
 ;;=1281^lighted access to bathroom^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,6,0)
 ;;=1282^use toilet height extender^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,7,0)
 ;;=2945^call light^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,1,8,0)
 ;;=2946^provide privacy^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1275,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1275,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1275,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1276,0)
 ;;=clear path to bathroom^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1277,0)
 ;;=commode at bedside^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1278,0)
 ;;=urinal within reach^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1279,0)
 ;;=call light within reach^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1279,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1279,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1280,0)
 ;;=use toilet facilities with hand rails^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1281,0)
 ;;=lighted access to bathroom^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1282,0)
 ;;=use toilet height extender^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1283,0)
 ;;=patient fluid preference [ADDITIONAL TEXT]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1283,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1283,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1284,0)
 ;;=respond within [ ]min to request for toileting assistance^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1284,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1284,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1285,0)
 ;;=coffee^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1286,0)
 ;;=tea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1287,0)
 ;;=symptomatic bradycardia interventions ^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,1,0)
 ;;=1290^give Atropine [dose]mg IV per protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,2,0)
 ;;=1264^explain purpose of drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,3,0)
 ;;=1267^give oxygen as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,4,0)
 ;;=1265^B/P q[frequency]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1287,1,5,0)
 ;;=1294^review patient's drugs for vagolytic effects^3^NURSC^1^0
