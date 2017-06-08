NURCCG30 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,980,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,980,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,981,0)
 ;;=verbalizes dietary management regime^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,981,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,981,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,982,0)
 ;;=maintains perineal area free from irritation/pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,982,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,982,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,983,0)
 ;;=reports decrease in diarrhea to [# of episodes]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,983,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,983,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,984,0)
 ;;=identifies factors contributing to diarrhea^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,984,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,984,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,985,0)
 ;;=assess for S/S of decreased cardiac out; monitor, document^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,985,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,985,1,1,0)
 ;;=987^B/P changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,985,1,2,0)
 ;;=988^oliguria^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,985,1,3,0)
 ;;=991^S3 or S4^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,985,1,4,0)
 ;;=996^shortness of breath^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,985,1,5,0)
 ;;=997^diaphoresis, pallor^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,985,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,985,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,985,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,985,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,986,0)
 ;;=assess for contributing factors such as:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,986,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,986,1,1,0)
 ;;=989^tube feedings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,986,1,2,0)
 ;;=990^food allergies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,986,1,3,0)
 ;;=992^untoward side effects^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,986,1,4,0)
 ;;=993^situational changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,986,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,986,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,986,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,987,0)
 ;;=B/P changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,988,0)
 ;;=oliguria^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,989,0)
 ;;=tube feedings^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,990,0)
 ;;=food allergies^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,991,0)
 ;;=S3 or S4^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,992,0)
 ;;=untoward side effects^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,993,0)
 ;;=situational changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,994,0)
 ;;=assess for impaction^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,994,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,994,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,995,0)
 ;;=assess for signs of dehydration^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,995,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,995,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,996,0)
 ;;=shortness of breath^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,997,0)
 ;;=diaphoresis, pallor^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,998,0)
 ;;=record color, odor, amt., consistency, frequency of stool^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,998,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,998,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,999,0)
 ;;=monitor serum electrolytes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,999,9)
 ;;=D EN2^NURCCPU2
