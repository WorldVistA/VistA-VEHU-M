NURCCG7T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,2,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,3,0)
 ;;=4122^abnormal heart sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,5,0)
 ;;=4124^variations in hemodynamic readings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,1,6,0)
 ;;=4125^cold clammy skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4119,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4120,0)
 ;;=changed ability to estimate relationship of body/environmt^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4122,0)
 ;;=abnormal heart sounds^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4123,0)
 ;;=concentration and/or pursuits of tasks, alteration in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4124,0)
 ;;=variations in hemodynamic readings^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4125,0)
 ;;=cold clammy skin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4126,0)
 ;;=eating habits, sleep patterns, activity level, alteration in^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4127,0)
 ;;=missing body part^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4128,0)
 ;;=interference with life functioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4129,0)
 ;;=reliving of past experiences^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4130,0)
 ;;=verbal expressions of distress at loss^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4131,0)
 ;;=Defining Characteristics^2^NURSC^12^18^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4131,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4131,1,1,0)
 ;;=4133^chronic worry, anxiety, depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4131,1,2,0)
 ;;=4135^inability to meet role expectations and for basic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4131,1,3,0)
 ;;=4137^verbalization of inability to cope or ask for assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4131,1,4,0)
 ;;=4146^inability to problem solve^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4131,1,5,0)
 ;;=4147^inappropriate use of defense mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4131,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4132,0)
 ;;=inability to accept positive reinforcement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4133,0)
 ;;=chronic worry, anxiety, depression^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4134,0)
 ;;=Defining Characteristics^2^NURSC^12^19^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4134,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4134,1,1,0)
 ;;=4138^impairment of memory, construction, information proscessing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4134,1,2,0)
 ;;=4153^unable to process info consistent with growth & development^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4134,1,3,0)
 ;;=4156^judgement impaired beyond expected growth & development^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4134,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4135,0)
 ;;=inability to meet role expectations and for basic needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4136,0)
 ;;=Defining Characteristics^2^NURSC^12^20^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4136,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4136,1,1,0)
 ;;=4139^expresses interest in improving health behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4136,1,2,0)
 ;;=4141^lack of equipment, financial and/or other resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4136,1,3,0)
 ;;=4143^impairment of personal support system^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4136,1,4,0)
 ;;=4171^unable to take responsibility to meet basic health practices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4136,1,5,0)
 ;;=4175^lack of adaptive behaviors to environmental changes^3^NURSC^1
