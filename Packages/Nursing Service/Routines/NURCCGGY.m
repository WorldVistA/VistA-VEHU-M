NURCCGGY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15824,0)
 ;;=discuss role of infection control measures^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15824,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15824,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15825,0)
 ;;=discuss role of prescribed medication^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15825,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15825,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15827,0)
 ;;=evaluate the environment to which patient is discharged^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15827,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15827,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15828,0)
 ;;=explain purpose of applicable community resources^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15828,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15828,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15829,0)
 ;;=promote reality orientation^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15829,1,1,0)
 ;;=15830^clarify misperceptions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,1,2,0)
 ;;=15831^do not support or ridicule delusions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,1,3,0)
 ;;=15832^offer orientation to person, place, and time^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,1,4,0)
 ;;=15833^use clocks and calendars^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,1,5,0)
 ;;=15834^use memory aids and simple one-step instructions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15829,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15829,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15830,0)
 ;;=clarify misperceptions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15831,0)
 ;;=do not support or ridicule delusions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15832,0)
 ;;=offer orientation to person, place, and time^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15833,0)
 ;;=use clocks and calendars^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15834,0)
 ;;=use memory aids and simple one-step instructions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15838,0)
 ;;=provide education regarding requirements of care^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15838,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15838,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15839,0)
 ;;=provide health counseling about bowel/bladder alterations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15839,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15839,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15840,0)
 ;;=provide health counseling about home safety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15840,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15840,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15841,0)
 ;;=provide health counseling about sensory changes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15841,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15841,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15842,0)
 ;;=Psychology Service^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15843,0)
 ;;=reinforce importance of adhering to treatment regime^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15843,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15843,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15844,0)
 ;;=reinforce use of adaptive/assistive devices for self-care^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15844,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15844,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15845,0)
 ;;=Cognitive Impairment^2^NURSC^2^2^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15845,1,0)
 ;;=^124.21PI^4^3
