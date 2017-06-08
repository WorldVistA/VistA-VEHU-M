NURCCG53 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,10,0)
 ;;=2041^teach/review medication use^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,1,11,0)
 ;;=3003^[Extra Order]^3^NURSC^89^0
 ;;^UTILITY("^GMRD(124.2,",$J,1992,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1992,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1993,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^53^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,1,0)
 ;;=1995^make one positive self-statement daily^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,2,0)
 ;;=1996^verbally states loss/change has occurred^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,3,0)
 ;;=1998^acknowledges alteration in body image and self concept^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,4,0)
 ;;=2011^participates in activities promoting adaption to loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,5,0)
 ;;=2013^participates in activities promoting adaption to change^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1993,1,6,0)
 ;;=2917^[Extra Goal]^3^NURSC^98^0
 ;;^UTILITY("^GMRD(124.2,",$J,1993,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1994,0)
 ;;=Related Problems^2^NURSC^7^41^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,1,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,2,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,3,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,6,0)
 ;;=1405^Depressive Behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,7,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,8,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,9,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,1,10,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1994,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1995,0)
 ;;=make one positive self-statement daily^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1995,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1995,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1996,0)
 ;;=verbally states loss/change has occurred^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1996,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1996,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1997,0)
 ;;=interpersonal transmission and contagion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1998,0)
 ;;=acknowledges alteration in body image and self concept^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1998,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1998,1,1,0)
 ;;=1566^family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1998,1,2,0)
 ;;=2003^job^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1998,1,3,0)
 ;;=2005^view of life^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1998,1,4,0)
 ;;=2006^leisure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1998,1,5,0)
 ;;=2007^leisure activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1998,5)
 ;;=by verbalizing how changes will affect
 ;;^UTILITY("^GMRD(124.2,",$J,1998,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1998,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1998,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1999,0)
 ;;=threat to or change in:^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1999,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1999,1,1,0)
 ;;=2000^health status^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1999,1,2,0)
 ;;=2001^socioeconomic status^3^NURSC^1^0
