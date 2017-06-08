NURCCGCD ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,7,0)
 ;;=9703^provide dietary intake q[frequency]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,9,0)
 ;;=9707^encourage family to provide favored foods at home^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,11,0)
 ;;=9711^monitor effects of antiemetics [specify]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,13,0)
 ;;=9714^encourage snacks of favored foods^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,15,0)
 ;;=9727^daily intake of [specify amount] calories^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,17,0)
 ;;=9956^[Extra Order]^3^NURSC^168
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,18,0)
 ;;=847^avoid irritants/noxious stimuli/oral irritants^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,19,0)
 ;;=2573^provide nourishment at [ ] am and [ ] pm^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9685,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9685,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9686,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^132^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,1,0)
 ;;=71^client providing little support for SO^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,2,0)
 ;;=72^inadequate/incorrect information/understanding by a SO^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,3,0)
 ;;=73^prolonged disease/disability exhausting SO^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,4,0)
 ;;=74^situational/developmental crises the SO may be facing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,5,0)
 ;;=75^SO is unable to perceive/act effectively to client's needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,1,6,0)
 ;;=76^temporary family disorganization and role changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9686,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9688,0)
 ;;=initiate oral hygiene protocol^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9688,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9688,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9690,0)
 ;;=status of oral mucous membranes^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9690,4)
 ;;=assess,monitor,document
 ;;^UTILITY("^GMRD(124.2,",$J,9690,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9690,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9697,0)
 ;;=administer antiemetics [specify]^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9697,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9697,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9699,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^130^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9699,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,9699,1,1,0)
 ;;=58^demonstrates realistic responses to stress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9699,1,2,0)
 ;;=9705^effective problem solving and decision making^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9699,1,5,0)
 ;;=9810^[Extra Goal]^3^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,9699,1,6,0)
 ;;=15343^pt/SO report decreased anxiety re: renal failure& treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9699,5)
 ;;=family demonstrates
 ;;^UTILITY("^GMRD(124.2,",$J,9699,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9703,0)
 ;;=provide dietary intake q[frequency]^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9703,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,9703,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9703,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9705,0)
 ;;=effective problem solving and decision making^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9705,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9705,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9707,0)
 ;;=encourage family to provide favored foods at home^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9707,9)
 ;;=D EN2^NURCCPU2
