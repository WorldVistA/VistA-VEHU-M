NURCCGA2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5586,1,3,0)
 ;;=5591^verbalized uncertainty about choices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5586,1,4,0)
 ;;=5594^vacillation between alternate choices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5586,1,5,0)
 ;;=5596^delayed decision making^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5586,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5587,0)
 ;;=verbalizes factors that increase risk of infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5587,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5587,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5588,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^79^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5588,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5588,1,1,0)
 ;;=5599^[Extra Goal]^3^NURSC^311
 ;;^UTILITY("^GMRD(124.2,",$J,5588,1,2,0)
 ;;=5601^[Extra Goal]^3^NURSC^312
 ;;^UTILITY("^GMRD(124.2,",$J,5588,1,3,0)
 ;;=5603^[Extra Goal]^3^NURSC^313
 ;;^UTILITY("^GMRD(124.2,",$J,5588,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5590,0)
 ;;=verbalization of undesired consequences of actions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5591,0)
 ;;=verbalized uncertainty about choices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5592,0)
 ;;=demonstrates adequate personal hygiene^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5592,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5592,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5593,0)
 ;;=[Extra Goal]^3^NURSC^9^27^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5593,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5593,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5594,0)
 ;;=vacillation between alternate choices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5595,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^264^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5595,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5595,1,1,0)
 ;;=5605^[Extra Order]^3^NURSC^318
 ;;^UTILITY("^GMRD(124.2,",$J,5595,1,2,0)
 ;;=5606^[Extra Order]^3^NURSC^319
 ;;^UTILITY("^GMRD(124.2,",$J,5595,1,3,0)
 ;;=5610^[Extra Order]^3^NURSC^320
 ;;^UTILITY("^GMRD(124.2,",$J,5595,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5595,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5596,0)
 ;;=delayed decision making^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5597,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^265^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,1,0)
 ;;=3214^monitor for S/S of urinary tract infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,2,0)
 ;;=2741^teach S/S  of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,3,0)
 ;;=5604^teach risk factors for urinary tract infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,4,0)
 ;;=1273^assess voiding/urgency patterns^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,5,0)
 ;;=5607^assess adequacy of personal hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5597,1,6,0)
 ;;=5942^[Extra Order]^3^NURSC^83
 ;;^UTILITY("^GMRD(124.2,",$J,5597,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5597,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5598,0)
 ;;=Defining Characteristics^2^NURSC^12^72^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5598,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,5598,1,1,0)
 ;;=5600^delays seeking or refuses health care attentioon^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5598,1,2,0)
 ;;=5602^does not perceive personal relevance of symptoms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5598,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5599,0)
 ;;=[Extra Goal]^3^NURSC^9^311^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5599,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5599,10)
 ;;=D EN2^NURCCPU1
