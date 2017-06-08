NURCCGCZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10778,1,1,0)
 ;;=15658^allowing time for the grief process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10778,1,2,0)
 ;;=15659^providing support^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10778,1,3,0)
 ;;=15660^promoting expression of feelings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10778,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10778,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10778,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10780,0)
 ;;=observe for signs of grieving^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10780,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10780,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10781,0)
 ;;=assess family interactions^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10781,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10781,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10783,0)
 ;;=encourage family participation in care^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10783,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10783,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10785,0)
 ;;=encourage questions^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10785,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10785,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10786,0)
 ;;=[Extra Order]^3^NURSC^11^180^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10786,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10786,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10787,0)
 ;;=Related Problems^2^NURSC^7^126^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,2,0)
 ;;=1405^Depressive Behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,3,0)
 ;;=1915^Grieving, Anticipatory^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,4,0)
 ;;=1389^Health Maintenance, Alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,6,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,7,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,8,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,9,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,10,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,1,11,0)
 ;;=1919^Spiritual Distress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10787,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,0)
 ;;=Defining Characteristics^2^NURSC^12^125^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10799,1,1,0)
 ;;=4123^concentration and/or pursuits of tasks, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,1,2,0)
 ;;=4126^eating habits, sleep patterns, activity level, alteration in^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,1,3,0)
 ;;=4128^interference with life functioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,1,4,0)
 ;;=4129^reliving of past experiences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,1,5,0)
 ;;=4130^verbal expressions of distress at loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10799,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10805,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10805,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10805,1,1,0)
 ;;=10806^Etiology/Related and/or Risk Factors^2^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,10805,1,2,0)
 ;;=10815^Related Problems^2^NURSC^127
 ;;^UTILITY("^GMRD(124.2,",$J,10805,1,3,0)
 ;;=10820^Goals/Expected Outcomes^2^NURSC^145
