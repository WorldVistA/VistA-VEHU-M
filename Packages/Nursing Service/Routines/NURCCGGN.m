NURCCGGN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15659,0)
 ;;=providing support^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15660,0)
 ;;=promoting expression of feelings^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15661,0)
 ;;=initiate referrals to:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15661,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15661,1,1,0)
 ;;=15662^counseling^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15661,1,2,0)
 ;;=15663^support groups^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15661,1,3,0)
 ;;=15664^community resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15661,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15661,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15661,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15662,0)
 ;;=counseling^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15663,0)
 ;;=support groups^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15664,0)
 ;;=community resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15665,0)
 ;;=diuretic therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15666,0)
 ;;=respirations q[frequency]^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15667,0)
 ;;=assess,monitor,document venous distention q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15667,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15667,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15668,0)
 ;;=[Extra Order]^3^NURSC^11^265^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15668,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15668,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15669,0)
 ;;=[Extra Order]^3^NURSC^11^266^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15669,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15669,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15670,0)
 ;;=[Extra Order]^3^NURSC^11^267^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15670,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15670,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15674,0)
 ;;=decrease external noise and distractions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15674,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15674,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15675,0)
 ;;=validate non-verbal communication^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15675,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15675,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15676,0)
 ;;=teach adaptive techniques for communicating^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15676,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15676,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15677,0)
 ;;=seek consultation from [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15677,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15677,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15678,0)
 ;;=achieves independent w/c mobility^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15678,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15678,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15679,0)
 ;;=achieves w/c mobility with [min/mod/max] assistance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15679,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15679,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15680,0)
 ;;=assess,monitor,document use of incentive spirometry q[freq]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15680,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15680,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15681,0)
 ;;=position for comfort,ventilation,drainage chest tube q[ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15681,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15681,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15682,0)
 ;;=ambulates [#]ft. with [min/mod/max] assistance^3^NURSC^9^1^^^T
