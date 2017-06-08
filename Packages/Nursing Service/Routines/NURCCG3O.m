NURCCG3O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1303,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1303,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1304,0)
 ;;=verbalizes an appropriate knowledge base to be safe^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1304,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1304,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1305,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^34^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1305,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1305,1,1,0)
 ;;=1308^effects of disturbed perceptual abilities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1305,1,2,0)
 ;;=1309^unable to integrate self with environment (rt. brain damage)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1305,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1306,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^33^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1306,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1306,1,1,0)
 ;;=1310^functions safely within limitations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1306,1,2,0)
 ;;=1311^understands limitations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1306,1,3,0)
 ;;=2674^demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1306,1,4,0)
 ;;=2676^demonstrates compensatory techniques (i.e., scanning)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1306,1,5,0)
 ;;=2898^[Extra Goal]^3^NURSC^77^0
 ;;^UTILITY("^GMRD(124.2,",$J,1306,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1307,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^30^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1307,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1307,1,1,0)
 ;;=1312^assess physical limits prior to instituting restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1307,1,2,0)
 ;;=1313^determine spatial deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1307,1,3,0)
 ;;=1314^cue patient to attend to left/right side of body^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1307,1,4,0)
 ;;=1315^teach family to coach/remind patient to attend to left side^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1307,1,5,0)
 ;;=2985^[Extra Order]^3^NURSC^70^0
 ;;^UTILITY("^GMRD(124.2,",$J,1307,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1307,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1308,0)
 ;;=effects of disturbed perceptual abilities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1309,0)
 ;;=unable to integrate self with environment (rt. brain damage)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1310,0)
 ;;=functions safely within limitations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1310,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1310,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1311,0)
 ;;=understands limitations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1311,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1311,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1312,0)
 ;;=assess physical limits prior to instituting restrictions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1312,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1312,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1313,0)
 ;;=determine spatial deficit^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1313,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1313,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1314,0)
 ;;=cue patient to attend to left/right side of body^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1314,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1314,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1315,0)
 ;;=teach family to coach/remind patient to attend to left side^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1315,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1315,10)
 ;;=D EN1^NURCCPU3
