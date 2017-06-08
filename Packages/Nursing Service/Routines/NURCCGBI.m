NURCCGBI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8064,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8071,0)
 ;;=demonstrates problem solving skills such as:^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8071,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8071,1,1,0)
 ;;=1869^good basic health habits^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8071,1,2,0)
 ;;=1870^body awareness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8071,1,3,0)
 ;;=1871^stress reduction/relaxation techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8071,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8071,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8071,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8075,0)
 ;;=[Extra Goal]^3^NURSC^9^144^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8075,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8075,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^94^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,1,0)
 ;;=1875^encourage discussion of blocks to coping^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,2,0)
 ;;=1876^assist in listing factors contributing to inadequate coping^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,3,0)
 ;;=1879^assist in listing alternative methods of managing stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,4,0)
 ;;=1882^assist in evaluating current situation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,5,0)
 ;;=1884^help identify ways of fulfilling role expectations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,6,0)
 ;;=1886^provide positive feedback for effective coping^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,7,0)
 ;;=1887^involve patient in planning own care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,8,0)
 ;;=8084^teach the following:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,9,0)
 ;;=1874^encourage verbalization of feelings^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8076,1,10,0)
 ;;=8434^[Extra Order]^3^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,8076,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8076,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8084,0)
 ;;=teach the following:^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8084,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8084,1,1,0)
 ;;=1889^assertiveness skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8084,1,2,0)
 ;;=1890^problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8084,1,3,0)
 ;;=1869^good basic health habits^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8084,1,4,0)
 ;;=1870^body awareness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8084,1,5,0)
 ;;=1893^stress reduction/relaxation techniques^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8084,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8084,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8084,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8091,0)
 ;;=[Extra Order]^3^NURSC^11^147^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8091,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8091,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8092,0)
 ;;=Related Problems^2^NURSC^7^95^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,1,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,3,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,5,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,6,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8092,1,7,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
