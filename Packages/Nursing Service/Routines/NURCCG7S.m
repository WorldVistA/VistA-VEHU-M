NURCCG7S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4098,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4099,0)
 ;;=confusion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4100,0)
 ;;=irritability^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4102,0)
 ;;=Defining Characteristics^2^NURSC^12^14^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4102,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4102,1,1,0)
 ;;=4110^inability to wash body,obtain water & regulate water temp^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4102,1,2,0)
 ;;=4112^inability to dress & groom self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4102,1,3,0)
 ;;=4113^inability to feed self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4102,1,4,0)
 ;;=4114^inability to toilet self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4102,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4103,0)
 ;;=somnolence^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4104,0)
 ;;=hypercapnia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4105,0)
 ;;=hypoxia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4106,0)
 ;;=Defining Characteristics^2^NURSC^12^15^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4106,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4106,1,1,0)
 ;;=4107^changes in eating habits^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4106,1,2,0)
 ;;=4108^sleep patterns alterations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4106,1,3,0)
 ;;=4109^expression of distress at potential loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4106,1,4,0)
 ;;=4111^potential loss of significant object^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4106,1,5,0)
 ;;=4115^choked feelings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4106,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4107,0)
 ;;=changes in eating habits^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4108,0)
 ;;=sleep patterns alterations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4109,0)
 ;;=expression of distress at potential loss^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4110,0)
 ;;=inability to wash body,obtain water & regulate water temp^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4111,0)
 ;;=potential loss of significant object^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4112,0)
 ;;=inability to dress & groom self^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4113,0)
 ;;=inability to feed self^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4114,0)
 ;;=inability to toilet self^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4115,0)
 ;;=choked feelings^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4116,0)
 ;;=Defining Characteristics^2^NURSC^12^73^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4116,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4116,1,1,0)
 ;;=605^altered body structure or function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4116,1,2,0)
 ;;=4120^changed ability to estimate relationship of body/environmt^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4116,1,3,0)
 ;;=4127^missing body part^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4116,1,4,0)
 ;;=4132^inability to accept positive reinforcement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4116,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,0)
 ;;=Defining Characteristics^2^NURSC^12^16^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4117,1,1,0)
 ;;=4123^concentration and/or pursuits of tasks, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,1,2,0)
 ;;=4126^eating habits, sleep patterns, activity level, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,1,3,0)
 ;;=4128^interference with life functioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,1,4,0)
 ;;=4129^reliving of past experiences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,1,5,0)
 ;;=4130^verbal expressions of distress at loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4117,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,0)
 ;;=Defining Characteristics^2^NURSC^12^17^1^^T^1
