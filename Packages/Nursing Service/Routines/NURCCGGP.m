NURCCGGP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15703,1,4,0)
 ;;=15707^chloride^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15703,1,5,0)
 ;;=15496^carbon dioxide^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15703,5)
 ;;=assess, document &
 ;;^UTILITY("^GMRD(124.2,",$J,15703,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15703,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15703,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15704,0)
 ;;=WBC^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15707,0)
 ;;=chloride^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15709,0)
 ;;=test all secretions for presence of blood^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15709,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15709,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15710,0)
 ;;=if WBC low restrict use of catheters,injections,enemas,etc.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15710,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15710,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15713,0)
 ;;=implement measures to increase mobility [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15713,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15713,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15714,0)
 ;;=encourage support of significant others^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15714,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15714,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15715,0)
 ;;=provide safe environment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15715,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15715,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15716,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^314^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,1,0)
 ;;=15717^demonstrates improved orientation [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,2,0)
 ;;=15718^is orientated to person, place, time, & situation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,3,0)
 ;;=15719^interacts appropriately with the environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,4,0)
 ;;=15720^demonstrates use of compensation techniques [specify]  ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,5,0)
 ;;=2362^demonstrates problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,6,0)
 ;;=15722^develops awareness of stimuli on affected side^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,7,0)
 ;;=15723^identifies alternative methods of managing stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15716,1,8,0)
 ;;=15751^[Extra Goal]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,15716,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15717,0)
 ;;=demonstrates improved orientation [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15717,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15717,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15718,0)
 ;;=is orientated to person, place, time, & situation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15718,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15718,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15719,0)
 ;;=interacts appropriately with the environment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15719,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15719,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15720,0)
 ;;=demonstrates use of compensation techniques [specify]  ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15720,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15720,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15722,0)
 ;;=develops awareness of stimuli on affected side^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15722,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15722,10)
 ;;=D EN2^NURCCPU1
