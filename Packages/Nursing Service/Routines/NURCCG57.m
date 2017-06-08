NURCCG57 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,7,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,8,0)
 ;;=2101^provide education/instruction within [ ]days of admission^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,9,0)
 ;;=2102^provide physical sequelae within [ ] days of admission^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,10,0)
 ;;=2103^be available for patient's questions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,11,0)
 ;;=2104^encourage pt to list areas adversely affected within [ ]days^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,12,0)
 ;;=2105^give patient positive reinforcement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,13,0)
 ;;=2106^encourage patient to ventilate feelings ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,14,0)
 ;;=2107^establish an after care follow-up plan before discharge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,15,0)
 ;;=2108^ask patient to list all support resources by [date]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,16,0)
 ;;=2109^reinforce need for follow-up care or support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,17,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,18,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,1,19,0)
 ;;=3005^[Extra Order]^3^NURSC^91^0
 ;;^UTILITY("^GMRD(124.2,",$J,2046,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2046,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2047,0)
 ;;=assistance with basic needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2048,0)
 ;;=Related Problems^2^NURSC^7^42^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,1,0)
 ;;=1987^Depression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,2,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,3,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,5,0)
 ;;=2077^Post Trauma Response^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,7,0)
 ;;=1916^Powerlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,8,0)
 ;;=2079^Substance Abuse, Drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,1,9,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2048,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2049,0)
 ;;=reinforcement that present feeling are normal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2050,0)
 ;;=arrange for community support group visit if needed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2050,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2050,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2051,0)
 ;;=encourage patient to become involved in helping others^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2051,5)
 ;;=who have experienced similar losses/changes
 ;;^UTILITY("^GMRD(124.2,",$J,2051,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2051,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2052,0)
 ;;=genetic factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2053,0)
 ;;=sociocultural drinking patterns^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2054,0)
 ;;=peer pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2055,0)
 ;;=positively reinforce for effort at adaption^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2055,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2055,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2056,0)
 ;;=do not support denial^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2056,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2056,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2057,0)
 ;;=teach^2^NURSC^11^1^1^^T^1
