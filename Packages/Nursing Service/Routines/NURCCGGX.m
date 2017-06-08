NURCCGGX ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15803,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15803,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15804,0)
 ;;=verbalizes minimal discomfort or absence of pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15804,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15804,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15805,0)
 ;;=verbalizes post discharge instructions from patient teaching^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15805,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15805,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15806,0)
 ;;=verbalizes sense of reality^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15806,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15806,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15807,0)
 ;;=verbalizes understanding of adequate nutrition/fluid intake^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15807,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15807,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15808,0)
 ;;=verbalizes understanding of potential safety hazards^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15808,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15808,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15809,0)
 ;;=verbalizes use of preventive safety measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15809,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15809,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15811,0)
 ;;=[Extra Goal]^3^NURSC^9^262^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15811,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15811,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15812,0)
 ;;=need for structured/supervised environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15813,0)
 ;;=personal resources/support systems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15814,0)
 ;;=assess deficits/capabilities to determine D/C needs^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15814,1,1,0)
 ;;=7244^activity restrictions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,1,2,0)
 ;;=1902^dietary restriction such as excess cholesterol/lipids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,1,3,0)
 ;;=15817^follow-up care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,1,4,0)
 ;;=15818^medications to be taken^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,1,5,0)
 ;;=15819^procedures expected to be performed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,15814,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15814,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15814,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15817,0)
 ;;=follow-up care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15818,0)
 ;;=medications to be taken^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15819,0)
 ;;=procedures expected to be performed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15820,0)
 ;;=assess for proper use of assistive devices for mobility^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15820,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15820,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15821,0)
 ;;=assess impact of pain on self care ability^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15821,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15821,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15822,0)
 ;;=make necessary referrals within community^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15823,0)
 ;;=assist to match identified needs to community resources^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15823,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15823,10)
 ;;=D EN1^NURCCPU3
