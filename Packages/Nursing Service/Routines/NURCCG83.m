NURCCG83 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4304,1,7,0)
 ;;=4314^skin temperature cold extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4304,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4305,0)
 ;;=S/O doting behavior affects client's autonomy/abilities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4306,0)
 ;;=claudication^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4307,0)
 ;;=diminished arterial pulsation, BP changes in extremities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4309,0)
 ;;=S/O is withdrawn from patient at time of need^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4310,0)
 ;;=S/O attempts assistance with less than satisfactory results^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4311,0)
 ;;=skin of extremity blue or purple when dependent^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4312,0)
 ;;=leg becomes pale on elevation and remains pale when lowered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4313,0)
 ;;=skin quality shining and without hair^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4314,0)
 ;;=skin temperature cold extremities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4315,0)
 ;;=abandonment, desertion, intolerance or rejection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4316,0)
 ;;=Defining Characteristics^2^NURSC^12^55^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,1,0)
 ;;=4319^flow of urine occurs at unpredictable times w/o distention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,2,0)
 ;;=4320^unsuccessful incontinence refractory treatments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,3,0)
 ;;=4088^nocturia (more than 2 instances per night)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,4,0)
 ;;=4321^urinary urgency; frequency (voiding more often than q2h)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,5,0)
 ;;=4324^voiding in small amounts (less than 100cc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,6,0)
 ;;=4325^voiding in large amounts (greater than 550cc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,7,0)
 ;;=4326^unable to reach toilet in time to void^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,8,0)
 ;;=4327^bladder contractures/spasms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,1,9,0)
 ;;=4328^dysuria, hesitance, incontinence, retention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4316,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4317,0)
 ;;=distortion of reality to client's illness ie., denial^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4318,0)
 ;;=S/O assumes clients signs of illness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4319,0)
 ;;=flow of urine occurs at unpredictable times w/o distention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4320,0)
 ;;=unsuccessful incontinence refractory treatments^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4321,0)
 ;;=urinary urgency; frequency (voiding more often than q2h)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4322,0)
 ;;=inadequate performance of test or inadequate verbalization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4323,0)
 ;;=inappropriate/exagerated behaviors ie.,hysterical,agitated^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4324,0)
 ;;=voiding in small amounts (less than 100cc)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4325,0)
 ;;=voiding in large amounts (greater than 550cc)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4326,0)
 ;;=unable to reach toilet in time to void^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4327,0)
 ;;=bladder contractures/spasms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4328,0)
 ;;=dysuria, hesitance, incontinence, retention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4329,0)
 ;;=Defining Characteristics^2^NURSC^12^54^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4329,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4329,1,1,0)
 ;;=4331^absence of urine output^3^NURSC^1
