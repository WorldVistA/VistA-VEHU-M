NURCCG05 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,35,1,2,0)
 ;;=46^develop care plan with patient/family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,35,1,3,0)
 ;;=47^provide time to listen to patient/family concerns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,35,1,4,0)
 ;;=48^make necessary referrals within Medical Center^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,35,1,5,0)
 ;;=15822^make necessary referrals within community^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,35,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,35,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,35,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,35,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,36,0)
 ;;=promote wellness through patient/family knowledge [specify]^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,36,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,36,1,1,0)
 ;;=146^specific diseases^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,36,1,2,0)
 ;;=147^susceptibility, e.g., presence of risk factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,36,1,3,0)
 ;;=148^value of early detection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,36,1,4,0)
 ;;=12978^disease management^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,36,5)
 ;;=of
 ;;^UTILITY("^GMRD(124.2,",$J,36,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,36,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,36,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,37,0)
 ;;=level of dependence/independence (mobility, self-care, etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,38,0)
 ;;=long term/new problem for patient^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,39,0)
 ;;=recent changes in lifestyle^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,40,0)
 ;;=ability to meet health maintenance needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,41,0)
 ;;=communication skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,42,0)
 ;;=knowledge level regarding health maintenance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,43,0)
 ;;=motivation regarding health care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,44,0)
 ;;=use of professional resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,45,0)
 ;;=involve family/friends in care management^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,46,0)
 ;;=develop care plan with patient/family^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,47,0)
 ;;=provide time to listen to patient/family concerns^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,48,0)
 ;;=make necessary referrals within Medical Center^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,49,0)
 ;;=Coping, Ineffective Family^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,49,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,49,1,1,0)
 ;;=55^Etiology/Related and/or Risk Factors^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,49,1,2,0)
 ;;=56^Goals/Expected Outcomes^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,49,1,3,0)
 ;;=57^Nursing Intervention/Orders^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,49,1,4,0)
 ;;=77^Related Problems^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,49,1,5,0)
 ;;=4242^Defining Characteristics^2^NURSC^41
 ;;^UTILITY("^GMRD(124.2,",$J,49,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,49,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,49,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,49,"TD",0)
 ;;=^^5^5^2901126^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,49,"TD",1,0)
 ;;=A usually supportive primary person (family member or close friend)
 ;;^UTILITY("^GMRD(124.2,",$J,49,"TD",2,0)
 ;;=is providing insufficient, ineffective, or compromised support,
 ;;^UTILITY("^GMRD(124.2,",$J,49,"TD",3,0)
 ;;=comfort, assistance, or encouragement that may be needed by the 
 ;;^UTILITY("^GMRD(124.2,",$J,49,"TD",4,0)
 ;;=client to manage or master adaptive tasks related to the client's
 ;;^UTILITY("^GMRD(124.2,",$J,49,"TD",5,0)
 ;;=health challenge.
