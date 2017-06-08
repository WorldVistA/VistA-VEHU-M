NURCCGC1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9235,1,10,0)
 ;;=15605^demonstrates effective coping skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9235,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9238,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^124^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9238,1,0)
 ;;=^124.21PI^24^2
 ;;^UTILITY("^GMRD(124.2,",$J,9238,1,17,0)
 ;;=9388^[Extra Goal]^3^NURSC^157
 ;;^UTILITY("^GMRD(124.2,",$J,9238,1,24,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9238,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9245,0)
 ;;=vital signs WNL or returns to baseline^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9245,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9245,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9256,0)
 ;;=[Extra Goal]^3^NURSC^9^155^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9256,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9256,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9259,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^105^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9259,1,0)
 ;;=^124.21PI^10^5
 ;;^UTILITY("^GMRD(124.2,",$J,9259,1,3,0)
 ;;=1879^assist in listing alternative methods of managing stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9259,1,6,0)
 ;;=9276^assess client's coping response^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9259,1,7,0)
 ;;=9278^assist in identifying how ESRD Tx impacts on family/job^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9259,1,8,0)
 ;;=9280^teach the following:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9259,1,10,0)
 ;;=9569^[Extra Order]^3^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,9259,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9259,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9276,0)
 ;;=assess client's coping response^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9276,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9276,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9278,0)
 ;;=assist in identifying how ESRD Tx impacts on family/job^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9278,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9278,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9280,0)
 ;;=teach the following:^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9280,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,9280,1,1,0)
 ;;=1889^assertiveness skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9280,1,2,0)
 ;;=1890^problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9280,1,3,0)
 ;;=1869^good basic health habits^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9280,1,5,0)
 ;;=1893^stress reduction/relaxation techniques^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9280,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9280,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9280,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9288,0)
 ;;=[Extra Goal]^3^NURSC^9^156^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9288,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9288,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9291,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^106^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9291,1,0)
 ;;=^124.21PI^26^4
 ;;^UTILITY("^GMRD(124.2,",$J,9291,1,23,0)
 ;;=9656^[Extra Order]^3^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,9291,1,24,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9291,1,25,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9291,1,26,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9291,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9291,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9292,0)
 ;;=[Extra Order]^3^NURSC^11^158^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9292,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9292,10)
 ;;=D EN1^NURCCPU3
