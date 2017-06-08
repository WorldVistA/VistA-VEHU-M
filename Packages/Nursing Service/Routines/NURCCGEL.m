NURCCGEL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13358,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,13358,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13358,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13358,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13365,0)
 ;;=if unreliable response/attempt communication mode:^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13365,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13365,1,1,0)
 ;;=1451^use pantomime^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13365,1,2,0)
 ;;=1452^anticipate needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13365,1,3,0)
 ;;=1453^assist patient to meet basic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13365,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13365,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13365,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13376,0)
 ;;=[Extra Order]^3^NURSC^11^237^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13376,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13376,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13378,0)
 ;;=[Extra Order]^3^NURSC^11^238^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13378,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13378,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13379,0)
 ;;=Defining Characteristics^2^NURSC^12^154^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13379,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13379,1,1,0)
 ;;=4346^unable to speak dominant language^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13379,1,2,0)
 ;;=4347^incessant verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13379,1,3,0)
 ;;=4348^inability to speak in sentences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13379,1,4,0)
 ;;=4349^inability to modulate speech, find words, name words etc.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13379,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,0)
 ;;=Defining Characteristics^2^NURSC^12^155^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13381,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13391,0)
 ;;=[Extra Problem]^2^NURSC^2^33^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,13391,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13391,1,1,0)
 ;;=13392^Etiology/Related and/or Risk Factors^2^NURSC^280
 ;;^UTILITY("^GMRD(124.2,",$J,13391,1,2,0)
 ;;=13396^Goals/Expected Outcomes^2^NURSC^292
 ;;^UTILITY("^GMRD(124.2,",$J,13391,1,3,0)
 ;;=13400^Nursing Intervention/Orders^2^NURSC^296
 ;;^UTILITY("^GMRD(124.2,",$J,13391,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13391,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13391,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13392,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^280^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13392,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13392,1,1,0)
 ;;=13394^[etiology]^3^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,13392,1,2,0)
 ;;=13395^[etiology]^3^NURSC^137
 ;;^UTILITY("^GMRD(124.2,",$J,13392,1,3,0)
 ;;=13687^[etiology]^3^NURSC^99
 ;;^UTILITY("^GMRD(124.2,",$J,13392,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13393,0)
 ;;=[etiology]^3^NURSC^^138^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13394,0)
 ;;=[etiology]^3^NURSC^^136^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13395,0)
 ;;=[etiology]^3^NURSC^^137^^^T
