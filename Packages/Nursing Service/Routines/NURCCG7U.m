NURCCG7U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4136,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4137,0)
 ;;=verbalization of inability to cope or ask for assistance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4138,0)
 ;;=impairment of memory, construction, information proscessing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4139,0)
 ;;=expresses interest in improving health behaviors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4140,0)
 ;;=Defining Characteristics^2^NURSC^12^21^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4140,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4140,1,1,0)
 ;;=4142^discomfort, pain, soreness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4140,1,2,0)
 ;;=4144^redness and/or drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4140,1,3,0)
 ;;=4145^hypoprotenemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4140,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4141,0)
 ;;=lack of equipment, financial and/or other resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4142,0)
 ;;=discomfort, pain, soreness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4143,0)
 ;;=impairment of personal support system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4144,0)
 ;;=redness and/or drainage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4145,0)
 ;;=hypoprotenemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4146,0)
 ;;=inability to problem solve^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4147,0)
 ;;=inappropriate use of defense mechanisms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4148,0)
 ;;=Defining Characteristics^2^NURSC^12^22^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4148,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4148,1,1,0)
 ;;=4149^decrease in social activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4148,1,2,0)
 ;;=4150^lack of energy for normal activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4148,1,3,0)
 ;;=4151^sleep disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4148,1,4,0)
 ;;=4154^verbalization of feeling worthless, hopeless, helpless^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4148,1,5,0)
 ;;=4155^poor problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4148,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4149,0)
 ;;=decrease in social activities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4150,0)
 ;;=lack of energy for normal activity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4151,0)
 ;;=sleep disturbance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4152,0)
 ;;=Defining Characteristics^2^NURSC^12^23^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4152,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4152,1,1,0)
 ;;=4158^behavior pattern or usual response to stimuli is changed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4152,1,2,0)
 ;;=4162^sensory acuity is reported or measured as changed ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4152,1,3,0)
 ;;=4165^problem-solving  abilities are changed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4152,1,4,0)
 ;;=4167^disoriented in time, place or with persons^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4152,1,5,0)
 ;;=4172^body image alteration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4152,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4153,0)
 ;;=unable to process info consistent with growth & development^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4154,0)
 ;;=verbalization of feeling worthless, hopeless, helpless^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4155,0)
 ;;=poor problem solving skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4156,0)
 ;;=judgement impaired beyond expected growth & development^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4157,0)
 ;;=Defining Characteristics^2^NURSC^12^24^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4157,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4157,1,1,0)
 ;;=4159^abdominal pain, cramping^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4157,1,2,0)
 ;;=4160^increased frequency of stools^3^NURSC^1
