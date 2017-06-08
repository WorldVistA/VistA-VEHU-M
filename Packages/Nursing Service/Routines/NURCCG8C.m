NURCCG8C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4432,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4432,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4433,0)
 ;;=assess assistance needed with ADL q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4433,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,4433,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4433,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4434,0)
 ;;=respirations q[frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4436,0)
 ;;=temperature per[route] q[ frequency ]^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4438,0)
 ;;=monitor lab values^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,1,0)
 ;;=4393^electrolytes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,2,0)
 ;;=4394^BUN [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,3,0)
 ;;=4395^creatinine [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,4,0)
 ;;=1597^CBC^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,6,0)
 ;;=15429^albumin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,1,7,0)
 ;;=15526^cardiac enzymes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4438,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4438,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4443,0)
 ;;=assess weight q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4443,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,4443,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4443,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4444,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^203^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4444,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,4444,1,2,0)
 ;;=4502^maintains fluid/electrolyte balance^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4444,1,3,0)
 ;;=4565^[Extra Goal]^3^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,4444,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4446,0)
 ;;=initiate febrile protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4446,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4446,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4447,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^203^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,1,0)
 ;;=4514^assess, monitor & record:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,2,0)
 ;;=4832^assess degree of peripheral dependent edema q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,3,0)
 ;;=1546^abdominal girth q[ ]hrs. and document^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,4,0)
 ;;=4841^elevate legs when sitting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,5,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,6,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,7,0)
 ;;=4847^monitor B/P q[frequency], TPR q[frequency] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,1,8,0)
 ;;=4626^[Extra Order]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4447,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4447,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4449,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^204^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4449,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4449,1,1,0)
 ;;=4464^maintains nutritional intake to meet metabolic requirements^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4449,1,2,0)
 ;;=4567^[Extra Goal]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4449,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^204^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,0)
 ;;=^124.21PI^7^7
