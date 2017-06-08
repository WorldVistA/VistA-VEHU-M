NURCCG0A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,102,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,102,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,103,0)
 ;;=demonstrates skills for home maintenance^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,103,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,103,1,1,0)
 ;;=2492^environment clean^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,103,1,2,0)
 ;;=2493^verbalizes acquisition of necessary supplies or equipment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,103,1,3,0)
 ;;=2494^verbalizes community/family resource if required^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,103,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,103,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,103,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,103,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,104,0)
 ;;=expresses satisfaction with the home situation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,104,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,104,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,105,0)
 ;;=assess causative/contributing factors^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,1,0)
 ;;=107^lack of knowledge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,2,0)
 ;;=95^insufficient finances^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,3,0)
 ;;=108^lack of necessary equipment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,4,0)
 ;;=109^inability to perform household tasks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,5,0)
 ;;=110^impaired cognitive functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,6,0)
 ;;=111^impaired emotional functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,1,7,0)
 ;;=93^inadequate support system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,105,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,105,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,105,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,106,0)
 ;;=reduce or eliminate causative/contributing factors^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,1,0)
 ;;=112^assist patient/family to plan for a clean, healthful home^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,2,0)
 ;;=113^refer to Social Work for assistance with finances^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,3,0)
 ;;=114^assist patient/family to acquire needed equipment/supplies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,4,0)
 ;;=115^refer to O.T. for instructions on work simplification skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,5,0)
 ;;=116^refer to community agency for homemaker services/meals^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,6,0)
 ;;=117^report building violations to landlord/city department^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,7,0)
 ;;=118^encourage patient/family to report building violations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,8,0)
 ;;=119^assess ability to safely maintain household^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,1,9,0)
 ;;=120^discuss long-term plan for managing situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,106,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,106,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,106,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,107,0)
 ;;=lack of knowledge^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,108,0)
 ;;=lack of necessary equipment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,109,0)
 ;;=inability to perform household tasks^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,110,0)
 ;;=impaired cognitive functioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,111,0)
 ;;=impaired emotional functioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,112,0)
 ;;=assist patient/family to plan for a clean, healthful home^3^NURSC^^1^^^T
