NURCCGGW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15783,0)
 ;;=nutrition/fluid volume altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15785,0)
 ;;=self-care deficit (hygiene, elimination)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15786,0)
 ;;=suspected abuse/neglect^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15787,0)
 ;;=accepts assistance with meeting health needs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15787,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15787,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15788,0)
 ;;=communicates within capacity, demonstrates comprehension^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15788,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15788,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15789,0)
 ;;=demonstrates required skill/knowledge from pt ed [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15789,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15789,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15790,0)
 ;;=establishes/maintains supportive, nurturing relationships^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15790,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15790,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15791,0)
 ;;=identifies coping methods to deal with chronic pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15791,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15791,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15792,0)
 ;;=maintains or regains optimal level of health^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15792,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15792,1,1,0)
 ;;=29^attention to physical appearance/grooming^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15792,1,2,0)
 ;;=15794^coping behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15792,1,3,0)
 ;;=27^relationships with others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15792,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15792,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15792,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15794,0)
 ;;=coping behaviors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15796,0)
 ;;=manages stressors without resorting to violent behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15796,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15796,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15797,0)
 ;;=participates in D/C plans for use of community resources^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15797,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15797,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15798,0)
 ;;=participates in D/C plans for supervised care setting^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15798,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15798,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15799,0)
 ;;=recognizes anxiety & uses coping skills to reduce/manage it^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15799,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15799,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15800,0)
 ;;=remains/regains orientation to time, place and person^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15800,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15800,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15801,0)
 ;;=selects appropriate coping methods for activity intolerance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15801,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15801,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15802,0)
 ;;=verbalizes community resources needed to maintain sobriety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15802,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15802,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15803,0)
 ;;=verbalizes intent to follow health regime post discharge^3^NURSC^9^1^^^T
