NURCCG0T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,313,0)
 ;;=has normal respiratory rate/breathing pattern^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,313,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,313,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,314,0)
 ;;=has decreased use of accessory muscles^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,314,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,314,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,315,0)
 ;;=is afebrile^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,315,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,315,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,316,0)
 ;;=attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,316,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,316,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,317,0)
 ;;=verbalizes patient education information^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,317,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,317,1,1,0)
 ;;=319^etiological factor^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,317,1,2,0)
 ;;=2719^effective airway clearance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,317,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,317,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,317,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,317,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,318,0)
 ;;=S/O assists with quad cough^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,318,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,318,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,319,0)
 ;;=etiological factor^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,320,0)
 ;;=assess respiratory rate and pattern/breath sounds^3^NURSC^11^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,320,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,320,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,320,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,321,0)
 ;;=TPR q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,321,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,321,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,321,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,322,0)
 ;;=B/P q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,322,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,322,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,323,0)
 ;;=respiratory pattern q [frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,323,4)
 ;;=assess, monitor, document
 ;;^UTILITY("^GMRD(124.2,",$J,324,0)
 ;;=monitor use of accessory muscles^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,324,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,324,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,325,0)
 ;;=ABGs/pulse oximetry q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,325,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,325,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,326,0)
 ;;=cardiac rhythm q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,326,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,326,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,327,0)
 ;;=monitor peak flows q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,327,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,327,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,328,0)
 ;;=observe sputum for color, consistency, amount^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,328,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,328,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,329,0)
 ;;=administer bronchodilators as ordered^3^NURSC^11^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,329,5)
 ;;=; monitor and document
