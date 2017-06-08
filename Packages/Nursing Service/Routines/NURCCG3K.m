NURCCG3K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,5,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,6,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,7,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1251,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1252,0)
 ;;=serum electrolytes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1253,0)
 ;;=BUN^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1254,0)
 ;;=creatinine^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1255,0)
 ;;=mechanical trauma^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1256,0)
 ;;=sensory motor impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1257,0)
 ;;=drug levels^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1258,0)
 ;;=warning ventricular dysrhythmia interventions ^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,1,0)
 ;;=1259^give Lidocaine bolus and/or IV Lidocaine [dose]mg per order^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,2,0)
 ;;=1262^titrate drug according to patient's response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,3,0)
 ;;=1264^explain purpose of drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,4,0)
 ;;=1265^B/P q[frequency]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,5,0)
 ;;=1267^give oxygen as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,6,0)
 ;;=1270^notify MD of patient's rhythm and response to therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,7,0)
 ;;=1272^alter therapy as indicated and document^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,8,0)
 ;;=2744^reassure patient^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,1,9,0)
 ;;=2745^sensorium q[frequency]hrs^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1258,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1258,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1258,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1259,0)
 ;;=give Lidocaine bolus and/or IV Lidocaine [dose]mg per order^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1260,0)
 ;;=establishes or re-establishes control over micturition^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1260,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1260,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1261,0)
 ;;=identifies urgency to void^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1261,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1261,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1262,0)
 ;;=titrate drug according to patient's response^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1263,0)
 ;;=achieves residual urine <[amt] cc^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1263,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1263,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1264,0)
 ;;=explain purpose of drugs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1265,0)
 ;;=B/P q[frequency]^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1265,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1266,0)
 ;;=sensorium q[frequency]hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1266,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1266,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1266,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1267,0)
 ;;=give oxygen as indicated^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1268,0)
 ;;=demonstrates use of management program^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1268,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1268,1,1,0)
 ;;=1269^regulates own fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1268,1,2,0)
 ;;=1271^catheterization as indicated/ordered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1268,7)
 ;;=D EN4^NURCCPU1
