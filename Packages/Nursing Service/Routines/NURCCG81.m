NURCCG81 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4268,1,3,0)
 ;;=4275^verbalization of the problem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4268,1,4,0)
 ;;=4322^inadequate performance of test or inadequate verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4268,1,5,0)
 ;;=4323^inappropriate/exagerated behaviors ie.,hysterical,agitated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4268,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4269,0)
 ;;=expresses concern with meaning of life,death,belief systems^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4270,0)
 ;;=request for information^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4271,0)
 ;;=questions meaning of suffering^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4272,0)
 ;;=statement of misconception^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4273,0)
 ;;=verbalizes inner conflict about beliefs/relationship w/God^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4274,0)
 ;;=unable to choose/chooses not to participate in religion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4275,0)
 ;;=verbalization of the problem^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4276,0)
 ;;=Defining Characteristics^2^NURSC^12^47^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,1,0)
 ;;=4277^dependency needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,2,0)
 ;;=2115^low frustration tolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,3,0)
 ;;=4278^poor self insight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,4,0)
 ;;=2062^low self-esteem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,5,0)
 ;;=4281^impaired occupational functions(impulsive,manipulative,etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,6,0)
 ;;=4282^impaired social functioning (traffic accidents,arrests,etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,7,0)
 ;;=4283^physical problems (infections, malnutrition, etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,1,8,0)
 ;;=4287^interpersonal difficulties^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4276,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4277,0)
 ;;=dependency needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4278,0)
 ;;=poor self insight^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4280,0)
 ;;=Defining Characteristics^2^NURSC^12^48^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,2,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,3,0)
 ;;=4122^abnormal heart sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,5,0)
 ;;=4125^cold clammy skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,1,6,0)
 ;;=4124^variations in hemodynamic readings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4280,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4281,0)
 ;;=impaired occupational functions(impulsive,manipulative,etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4282,0)
 ;;=impaired social functioning (traffic accidents,arrests,etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4283,0)
 ;;=physical problems (infections, malnutrition, etc.)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4284,0)
 ;;=Defining Characteristics^2^NURSC^12^49^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,1,0)
 ;;=4277^dependency needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,2,0)
 ;;=2115^low frustration tolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,3,0)
 ;;=4281^impaired occupational functions(impulsive,manipulative,etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4284,1,4,0)
 ;;=4282^impaired social functioning (traffic accidents,arrests,etc.)^3^NURSC^1
