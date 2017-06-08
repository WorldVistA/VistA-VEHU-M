NURCCG6K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2721,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2721,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2722,0)
 ;;=assist with identifying current stressors in life^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2722,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2722,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2723,0)
 ;;=provide information regarding an altered body function^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2723,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2723,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2724,0)
 ;;=adapt plan to patient's lifestyle^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2724,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2724,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2725,0)
 ;;=discuss relationship problems^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2725,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2725,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2726,0)
 ;;=altered body structure or function^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2727,0)
 ;;=conflicts with sexual orientation or varient preferences^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2728,0)
 ;;=fear of pregnancy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2729,0)
 ;;=fear of acquiring a sexually transmitted disease^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2730,0)
 ;;=illness or medical treatment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2731,0)
 ;;=impaired relationship with S/O^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2732,0)
 ;;=ineffective or absent role models^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2733,0)
 ;;=knowledge deficit about responses to health transitions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2734,0)
 ;;=skill deficit relating to health related transitions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2735,0)
 ;;=lack of S/O^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2736,0)
 ;;=assist with methods for dispersing sexual energy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2736,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2736,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2737,0)
 ;;=teach patient and/or S/O ^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2737,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2737,1,1,0)
 ;;=2738^methods of contraception^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2737,1,2,0)
 ;;=2739^methods used to avoid sexually transmitted diseases^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2737,1,3,0)
 ;;=2740^techniques/methods of sexual expression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2737,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2737,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2737,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2738,0)
 ;;=methods of contraception^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2739,0)
 ;;=methods used to avoid sexually transmitted diseases^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2740,0)
 ;;=techniques/methods of sexual expression^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2741,0)
 ;;=teach S/S  of infection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2741,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2741,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2742,0)
 ;;=annual flu shot^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2742,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2742,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2743,0)
 ;;=pneumococcus vaccine^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2743,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2743,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2744,0)
 ;;=reassure patient^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2745,0)
 ;;=sensorium q[frequency]hrs^3^NURSC^^2^^^T
