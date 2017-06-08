NURCCGEQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13640,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13659,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^180^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,1,0)
 ;;=1117^preserves individual integrity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,2,0)
 ;;=2674^demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,3,0)
 ;;=2675^develops a mechanism (system) for communication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,4,0)
 ;;=33^communicates within capacity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,5,0)
 ;;=13929^[Extra Goal]^3^NURSC^239
 ;;^UTILITY("^GMRD(124.2,",$J,13659,1,6,0)
 ;;=14819^verbalizes decreased frustration with communication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13659,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13665,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^151^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13665,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,13665,1,3,0)
 ;;=1455^reassess communication ability q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13665,1,4,0)
 ;;=14138^[Extra Order]^3^NURSC^247
 ;;^UTILITY("^GMRD(124.2,",$J,13665,1,5,0)
 ;;=14937^teach/reinforce speech improvement exercise^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13665,1,6,0)
 ;;=14996^encourage self-expression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13665,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13665,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13677,0)
 ;;=[Extra Order]^3^NURSC^11^242^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13677,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13677,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13678,0)
 ;;=Defining Characteristics^2^NURSC^12^159^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13678,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13678,1,1,0)
 ;;=4346^unable to speak dominant language^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13678,1,2,0)
 ;;=4347^incessant verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13678,1,3,0)
 ;;=4348^inability to speak in sentences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13678,1,4,0)
 ;;=4349^inability to modulate speech, find words, name words etc.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13678,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13680,0)
 ;;=[additional instructions]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13684,0)
 ;;=[Extra Problem]^2^NURSC^2^34^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,13684,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13684,1,1,0)
 ;;=13685^Etiology/Related and/or Risk Factors^2^NURSC^281
 ;;^UTILITY("^GMRD(124.2,",$J,13684,1,2,0)
 ;;=13691^Goals/Expected Outcomes^2^NURSC^293
 ;;^UTILITY("^GMRD(124.2,",$J,13684,1,3,0)
 ;;=13701^Nursing Intervention/Orders^2^NURSC^297
 ;;^UTILITY("^GMRD(124.2,",$J,13684,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13684,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13684,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13685,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^281^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13685,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13685,1,1,0)
 ;;=13688^[etiology]^3^NURSC^97
 ;;^UTILITY("^GMRD(124.2,",$J,13685,1,2,0)
 ;;=13690^[etiology]^3^NURSC^98
 ;;^UTILITY("^GMRD(124.2,",$J,13685,1,3,0)
 ;;=13971^[etiology]^3^NURSC^55
 ;;^UTILITY("^GMRD(124.2,",$J,13685,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13687,0)
 ;;=[etiology]^3^NURSC^^99^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13688,0)
 ;;=[etiology]^3^NURSC^^97^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13690,0)
 ;;=[etiology]^3^NURSC^^98^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13691,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^293^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13691,1,0)
 ;;=^124.21PI^3^3
