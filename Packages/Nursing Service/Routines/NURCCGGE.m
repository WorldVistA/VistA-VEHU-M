NURCCGGE ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15489,0)
 ;;=absence or reduction in syncope^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15490,0)
 ;;=improved mental status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15491,0)
 ;;=monitor laboratory values:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,0)
 ;;=^124.21PI^9^7
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,1,0)
 ;;=1739^sodium^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,2,0)
 ;;=1740^potassium^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,3,0)
 ;;=15495^glucose^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,4,0)
 ;;=15496^carbon dioxide^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,5,0)
 ;;=1253^BUN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,8,0)
 ;;=2950^hematocrit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,1,9,0)
 ;;=2951^hemoglobin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15491,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15491,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15492,0)
 ;;=improved motor/sensory function^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15495,0)
 ;;=glucose^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15496,0)
 ;;=carbon dioxide^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15501,0)
 ;;=verbalizes plan of follow-up care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15501,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15501,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15502,0)
 ;;=temperature=[specify]^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15503,0)
 ;;=initiate mechanical ventilator protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15503,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15503,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15504,0)
 ;;=protect skin from urine/feces^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15504,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15504,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15505,0)
 ;;=assess for visual/spatial disturbances^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15505,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15505,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15506,0)
 ;;=orient to enviroment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15506,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15506,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15507,0)
 ;;=assist with ADL's^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15507,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15507,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15508,0)
 ;;=septemia-monitor,report S/S:^2^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,1,0)
 ;;=13812^temperature elevation/chills^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,2,0)
 ;;=13817^tachycardia and tachypnea^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,3,0)
 ;;=15334^pale, cool skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,4,0)
 ;;=4627^urine output less than [specify] cc/hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,5,0)
 ;;=15510^WBC above normal limits, and/or bacteria in urine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,6,0)
 ;;=15337^positive blood/urine culture^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,7,0)
 ;;=15512^purulent drainage^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15508,1,8,0)
 ;;=15513^[additional S/S]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15508,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15508,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15508,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15509,0)
 ;;=assess for alterations in thought processes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15509,9)
 ;;=D EN2^NURCCPU2
