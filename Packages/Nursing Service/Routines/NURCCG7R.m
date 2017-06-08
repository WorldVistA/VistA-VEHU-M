NURCCG7R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4077,0)
 ;;=abnormal arterial blood gases^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4078,0)
 ;;=flashbacks,intrusive thoughts^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4079,0)
 ;;=respiratory depth changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4080,0)
 ;;=guilt or guilt about behaviour required for survival^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4081,0)
 ;;=Defining Characteristics^2^NURSC^12^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,1,0)
 ;;=1187^dysuria^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,2,0)
 ;;=4085^frequency^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,3,0)
 ;;=4086^hesitancy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,4,0)
 ;;=4087^incontinence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,5,0)
 ;;=4088^nocturia (more than 2 instances per night)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,6,0)
 ;;=4089^retention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,1,7,0)
 ;;=4091^urgency^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4081,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4082,0)
 ;;=verbalization of survival^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4083,0)
 ;;=repetitive dreams or nightmares^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4085,0)
 ;;=frequency^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4086,0)
 ;;=hesitancy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4087,0)
 ;;=incontinence^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4088,0)
 ;;=nocturia (more than 2 instances per night)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4089,0)
 ;;=retention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4090,0)
 ;;=Defining Characteristics^2^NURSC^12^11^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4090,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4090,1,1,0)
 ;;=4093^dependence resulting in  irritability,resentment,anger,guilt^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4090,1,2,0)
 ;;=4095^expressed dissatisfaction,frustration w/decreased perform^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4090,1,3,0)
 ;;=4097^passivity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4090,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4091,0)
 ;;=urgency^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4092,0)
 ;;=Defining Characteristics^2^NURSC^12^12^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4092,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4092,1,1,0)
 ;;=4094^dribbling with increased abdominal pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4092,1,2,0)
 ;;=4069^urinary urgency, incontinence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4092,1,3,0)
 ;;=4096^urinary frequency ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4092,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4093,0)
 ;;=dependence resulting in  irritability,resentment,anger,guilt^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4094,0)
 ;;=dribbling with increased abdominal pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4095,0)
 ;;=expressed dissatisfaction,frustration w/decreased perform^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4096,0)
 ;;=urinary frequency ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4097,0)
 ;;=passivity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4098,0)
 ;;=Defining Characteristics^2^NURSC^12^13^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4098,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
