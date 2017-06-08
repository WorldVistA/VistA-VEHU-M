NURCCG3R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1334,0)
 ;;=determine and provide knowledge of health interventions^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,1,0)
 ;;=1335^skin care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,2,0)
 ;;=1336^shoes (appropriate)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,3,0)
 ;;=1337^lights for night^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,4,0)
 ;;=1338^safety precautions (stable furniture, rugs, etc.)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,5,0)
 ;;=1339^pain management adequate/available^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,6,0)
 ;;=1340^visiual inspections appropriate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,1,7,0)
 ;;=1341^consulting for help^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1334,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1334,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1334,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1334,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1335,0)
 ;;=skin care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1336,0)
 ;;=shoes (appropriate)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1337,0)
 ;;=lights for night^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1338,0)
 ;;=safety precautions (stable furniture, rugs, etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1339,0)
 ;;=pain management adequate/available^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1340,0)
 ;;=visiual inspections appropriate^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1341,0)
 ;;=consulting for help^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1342,0)
 ;;=tissue injury^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,1,0)
 ;;=1343^inflammation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,2,0)
 ;;=1344^infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,3,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,4,0)
 ;;=1345^surgical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,5,0)
 ;;=1346^chemotherapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,6,0)
 ;;=1347^alcohol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,1,7,0)
 ;;=827^radiation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1342,5)
 ;;=due to
 ;;^UTILITY("^GMRD(124.2,",$J,1342,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1343,0)
 ;;=inflammation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1344,0)
 ;;=infection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1345,0)
 ;;=surgical^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1346,0)
 ;;=chemotherapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1347,0)
 ;;=alcohol^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1348,0)
 ;;=altered tissue perfusion, too much (e.g. migraine, shunting)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1349,0)
 ;;=altered tissue perfusion, too little (ischemia, etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1350,0)
 ;;=abnormal pain perception^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1350,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1350,1,1,0)
 ;;=1351^phantom limb pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1350,1,2,0)
 ;;=1352^central pain syndrome^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1350,1,3,0)
 ;;=1353^defferentation pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1350,1,4,0)
 ;;=1354^peripheral pain syndrome^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1350,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1350,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1351,0)
 ;;=phantom limb pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1352,0)
 ;;=central pain syndrome^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1353,0)
 ;;=defferentation pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1354,0)
 ;;=peripheral pain syndrome^3^NURSC^^1^^^T
