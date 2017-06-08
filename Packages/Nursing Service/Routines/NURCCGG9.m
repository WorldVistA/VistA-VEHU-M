NURCCGG9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15349,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15351,0)
 ;;=maintain fluid intake of [ ]cc q[frequency]^3^NURSC^9^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15351,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15351,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15352,0)
 ;;=performs independent toilet transfers^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15352,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15352,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15353,0)
 ;;=bedrest until [specify date]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15353,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15353,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15354,0)
 ;;=utilize special use mattress/bed [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15354,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15354,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15355,0)
 ;;=protective aids [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15357,0)
 ;;=apply barrier cream to skin at risk [specify area]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15357,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15357,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15358,0)
 ;;=provide,assess,monitor,document hydration & nutrition q[]hr^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15358,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15358,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15359,0)
 ;;=evaluate effectiveness of bowel/bladder program^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15359,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15359,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15360,0)
 ;;=assess & monitor pulse,skin color,oxygen sat during exercise^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15360,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15360,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15361,0)
 ;;=teach self skin inspection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15361,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15361,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15362,0)
 ;;=monitor for S/S of increased intracranial pressure^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15362,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15362,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15363,0)
 ;;=evaluate pt/SO in performing dressing changes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15363,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15363,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15365,0)
 ;;=teach appropriate positioning for activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15365,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15365,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15366,0)
 ;;=assess,teach,evaluate:^2^NURSC^11^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15366,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15366,1,1,0)
 ;;=15367^use of metered dose inhalers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15366,1,2,0)
 ;;=15368^knowledge of side effects of medications [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15366,1,3,0)
 ;;=15369^knowledge of diet^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15366,1,4,0)
 ;;=15370^knowledge of respiratory equipment at home^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15366,1,5,0)
 ;;=15371^knowledge of when to contact health care provider^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15366,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15366,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15366,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15367,0)
 ;;=use of metered dose inhalers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15368,0)
 ;;=knowledge of side effects of medications [specify]^3^NURSC^^1^^^T
