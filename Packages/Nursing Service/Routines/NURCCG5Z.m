NURCCG5Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,2,0)
 ;;=2410^express freedom of oral discomfort during food/fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,3,0)
 ;;=2503^experiences increased calories/day of [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,4,0)
 ;;=2504^experiences decreased calories/day of [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,5,0)
 ;;=2505^experiences increased CHO of [ ]gms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,6,0)
 ;;=2506^experiences decreased CHO of [ ]gms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,7,0)
 ;;=2507^experiences an increase of [ ]gms of fat^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,8,0)
 ;;=2508^experiences a decrease of [ ]gms of fat^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,9,0)
 ;;=2509^experiences an increase of [ ]gms of protein^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,10,0)
 ;;=2510^experiences a decrease of [ ]gms of protein^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,11,0)
 ;;=2511^achieves weight loss of [number of lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,12,0)
 ;;=2512^achieves weight gain of [number of lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,13,0)
 ;;=2513^maintains optimal weight [specify lbs/kgs]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,14,0)
 ;;=2514^demonstrates energy to obtain/prepare/consume food^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,15,0)
 ;;=2518^displays increased social interaction at meals with S/O^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,16,0)
 ;;=2519^describes rationale for (nutritional) treatment plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,17,0)
 ;;=2520^selects menu within dietary restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,1,18,0)
 ;;=2930^[Extra Goal]^3^NURSC^111^0
 ;;^UTILITY("^GMRD(124.2,",$J,2408,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2409,0)
 ;;=express satisfaction with amount/taste/type of food^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2409,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2409,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2410,0)
 ;;=express freedom of oral discomfort during food/fluid intake^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2410,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2410,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2411,0)
 ;;=afebrile, specify temperature less than [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2411,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2411,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2412,0)
 ;;=indicate inappropriate behavior to develop honesty/awareness^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2412,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2412,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2413,0)
 ;;=through 1:1 relationship, assist in identifying problems^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2413,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2413,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2414,0)
 ;;=through pt. education, assist in identifying problem^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2414,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2414,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2415,0)
 ;;=assist to plan way to compensate for loss^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2415,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2415,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2416,0)
 ;;=teach holistic health (activity, recreation, and rest)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2416,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2416,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2417,0)
 ;;=assist listing of supportive persons/agencies before D/C^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2417,9)
 ;;=D EN2^NURCCPU2
