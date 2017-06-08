NURCCG09 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,76,0)
 ;;=temporary family disorganization and role changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,77,0)
 ;;=Related Problems^2^NURSC^7^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,1,0)
 ;;=78^communication, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,2,0)
 ;;=79^coping, family: potential for growth^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,3,0)
 ;;=80^family process, alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,4,0)
 ;;=81^grieving^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,5,0)
 ;;=82^health maintenance, alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,6,0)
 ;;=83^home management, maintenance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,7,0)
 ;;=84^parenting, alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,8,0)
 ;;=85^sexual dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,9,0)
 ;;=86^sexual pattern, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,10,0)
 ;;=87^social interaction, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,11,0)
 ;;=88^social isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,1,12,0)
 ;;=89^spiritual distress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,77,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,77,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,78,0)
 ;;=communication, impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,79,0)
 ;;=coping, family: potential for growth^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,80,0)
 ;;=family process, alteration in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,81,0)
 ;;=grieving^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,82,0)
 ;;=health maintenance, alteration in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,83,0)
 ;;=home management, maintenance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,84,0)
 ;;=parenting, alteration in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,85,0)
 ;;=sexual dysfunction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,86,0)
 ;;=sexual pattern, altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,87,0)
 ;;=social interaction, impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,88,0)
 ;;=social isolation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,89,0)
 ;;=spiritual distress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,90,0)
 ;;=Related Problems^2^NURSC^7^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,90,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,90,1,1,0)
 ;;=82^health maintenance, alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,90,1,2,0)
 ;;=100^substance abuse, alcohol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,90,1,3,0)
 ;;=101^substance abuse, drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,90,1,4,0)
 ;;=87^social interaction, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,90,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,90,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,91,0)
 ;;=disease or injury of individual/family member^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,92,0)
 ;;=impaired cognition^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,93,0)
 ;;=inadequate support system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,94,0)
 ;;=insufficient family planning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,95,0)
 ;;=insufficient finances^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,96,0)
 ;;=lack of role modeling^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,97,0)
 ;;=unfamiliarity with neighborhood resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,98,0)
 ;;=substance abuse^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,99,0)
 ;;=role fatigue of care giver^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,100,0)
 ;;=substance abuse, alcohol^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,101,0)
 ;;=substance abuse, drugs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,102,0)
 ;;=identifies factors restricting self-care and home management^3^NURSC^9^1^^^T
