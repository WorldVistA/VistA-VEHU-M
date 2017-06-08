NURCCG46 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,5,0)
 ;;=1563^elevate extremities  [ ] (i.e., RL, LL, RA, LA)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,6,0)
 ;;=1564^prevent leg or ankle crossing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,7,0)
 ;;=1565^use of antihypertensives^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,8,0)
 ;;=2947^avoid constrictive clothing^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,1,9,0)
 ;;=2948^apply antiemboli hose^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1557,5)
 ;;=the following
 ;;^UTILITY("^GMRD(124.2,",$J,1557,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1557,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1557,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1558,0)
 ;;=S/S of fluid overload^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1559,0)
 ;;=taking and recording blood pressure as indicated^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1560,0)
 ;;=sodium/protein restrictions; salt substitutes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1561,0)
 ;;=shift of body weight q 15-30 minutes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1562,0)
 ;;=apply antiemboli hose q [frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1562,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1562,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1563,0)
 ;;=elevate extremities  [ ] (i.e., RL, LL, RA, LA)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1564,0)
 ;;=prevent leg or ankle crossing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1565,0)
 ;;=use of antihypertensives^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1566,0)
 ;;=family^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1567,0)
 ;;=Fluid Volume Deficit (Actual/Potential)^2^NURSC^2^1^1^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,1567,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1567,1,1,0)
 ;;=1568^Etiology/Related and/or Risk Factors^2^NURSC^41^0
 ;;^UTILITY("^GMRD(124.2,",$J,1567,1,2,0)
 ;;=1576^Related Problems^2^NURSC^30^0
 ;;^UTILITY("^GMRD(124.2,",$J,1567,1,3,0)
 ;;=1580^Goals/Expected Outcomes^2^NURSC^39^0
 ;;^UTILITY("^GMRD(124.2,",$J,1567,1,4,0)
 ;;=1590^Nursing Intervention/Orders^2^NURSC^36^0
 ;;^UTILITY("^GMRD(124.2,",$J,1567,1,5,0)
 ;;=4066^Defining Characteristics^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,1567,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1567,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1567,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1568,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^41^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,1,0)
 ;;=1569^deviation affecting access, intake, absorption of fluids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,2,0)
 ;;=1570^excessive loss through normal routes (e.g., diarrhea)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,3,0)
 ;;=1571^extremes of ages^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,4,0)
 ;;=1572^extremes of weight^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,5,0)
 ;;=1573^factors influencing fluid needs (e.g., hypermetabolic state)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,6,0)
 ;;=1574^knowledge deficiency related to fluid volume^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,7,0)
 ;;=1575^medications^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,8,0)
 ;;=2644^actual loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,9,0)
 ;;=2645^failure of regulatory mechanisms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,1,10,0)
 ;;=2646^loss of fluids though abnormal routes (indwelling tubes)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1568,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1569,0)
 ;;=deviation affecting access, intake, absorption of fluids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1570,0)
 ;;=excessive loss through normal routes (e.g., diarrhea)^3^NURSC^^1^^^T
