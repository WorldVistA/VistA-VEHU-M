NURCCG5Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2392,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2393,0)
 ;;=have staff sit with patient to provide support/control^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2393,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2393,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2394,0)
 ;;=medicate as prescribed by MD^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2394,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2394,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2395,0)
 ;;=teach^2^NURSC^11^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2395,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2395,1,1,0)
 ;;=2753^how to contact someone for help^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2395,1,2,0)
 ;;=2754^self care during manic episode^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2395,1,3,0)
 ;;=2755^identification of behaviors leading to manic episode^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2395,5)
 ;;=:
 ;;^UTILITY("^GMRD(124.2,",$J,2395,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2395,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2395,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2396,0)
 ;;=Airway Clearance, Ineffective^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2397,0)
 ;;=Gas Exchange, Impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2398,0)
 ;;=Breathing Pattern, Ineffective^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2399,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^67^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,1,0)
 ;;=2400^alteration in mental status^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,2,0)
 ;;=2401^altered body image^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,3,0)
 ;;=2402^altered taste or olfactory sensation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,4,0)
 ;;=2403^depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,5,0)
 ;;=2404^disturbance in self-concept^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,6,0)
 ;;=2405^factors influencing nutritional needs ^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,7,0)
 ;;=630^fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,8,0)
 ;;=1045^pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,9,0)
 ;;=2406^psychological stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,1,10,0)
 ;;=2407^sore,inflamed buccal cavity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2399,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2400,0)
 ;;=alteration in mental status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2401,0)
 ;;=altered body image^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2402,0)
 ;;=altered taste or olfactory sensation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2403,0)
 ;;=depression^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2404,0)
 ;;=disturbance in self-concept^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2405,0)
 ;;=factors influencing nutritional needs ^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2405,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2405,1,1,0)
 ;;=827^radiation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2405,1,2,0)
 ;;=2502^hypermetabolic status^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2405,1,3,0)
 ;;=1346^chemotherapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2405,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,2405,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2406,0)
 ;;=psychological stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2407,0)
 ;;=sore,inflamed buccal cavity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2408,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^66^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,1,0)
 ;;=2409^express satisfaction with amount/taste/type of food^3^NURSC^1^0
