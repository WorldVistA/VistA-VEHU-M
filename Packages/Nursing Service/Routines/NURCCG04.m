NURCCG04 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,20,0)
 ;;=altered communication^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,21,0)
 ;;=cognition impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,22,0)
 ;;=development tasks impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,23,0)
 ;;=ineffective family/individual coping^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,24,0)
 ;;=lack of ability to make judgement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,25,0)
 ;;=lack of growth of fine motor skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,26,0)
 ;;=maintains a state of wellness^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,26,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,26,1,1,0)
 ;;=27^relationships with others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,26,1,2,0)
 ;;=28^coping behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,26,1,3,0)
 ;;=29^attention to physical appearance/grooming^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,26,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,26,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,26,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,26,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,27,0)
 ;;=relationships with others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,28,0)
 ;;=coping behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,29,0)
 ;;=attention to physical appearance/grooming^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,30,0)
 ;;=tissue intact^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,30,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,30,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,31,0)
 ;;=maintains or regains optimal level of mobility^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,31,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,31,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,32,0)
 ;;=remains/regains orientation to time, place and space^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,32,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,32,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,33,0)
 ;;=communicates within capacity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,33,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,33,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,34,0)
 ;;=assess causative factors on admission^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,1,0)
 ;;=37^level of dependence/independence (mobility, self-care, etc.)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,2,0)
 ;;=38^long term/new problem for patient^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,3,0)
 ;;=39^recent changes in lifestyle^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,4,0)
 ;;=40^ability to meet health maintenance needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,5,0)
 ;;=41^communication skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,6,0)
 ;;=42^knowledge level regarding health maintenance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,7,0)
 ;;=43^motivation regarding health care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,8,0)
 ;;=44^use of professional resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,9,0)
 ;;=15812^need for structured/supervised environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,34,1,10,0)
 ;;=15813^personal resources/support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,34,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,34,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,34,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,34,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,35,0)
 ;;=assist to maintain and manage health care^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,35,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,35,1,1,0)
 ;;=45^involve family/friends in care management^3^NURSC^1^0
