NURCCG7Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4055,1,1,0)
 ;;=4057^apprehension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4055,1,2,0)
 ;;=4058^increased tension/helplessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4055,1,3,0)
 ;;=4060^uncertainty^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4055,1,4,0)
 ;;=4063^extraneous movement ie., foot shuffling, hand/arm movements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4055,1,5,0)
 ;;=4067^sympathetic stimulation-cardiovascular excitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4055,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4056,0)
 ;;=BP, CVP, PAP changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4057,0)
 ;;=apprehension^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4058,0)
 ;;=increased tension/helplessness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4059,0)
 ;;=changes in mental status; restlessness, anxiety^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4060,0)
 ;;=uncertainty^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4062,0)
 ;;=overt,agressive acts-destruction of objects in environment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4063,0)
 ;;=extraneous movement ie., foot shuffling, hand/arm movements^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4064,0)
 ;;=weight gain, edema, anasarca^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4065,0)
 ;;=suspicion of others,paranoid ideation,delusions,hallucinates^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4066,0)
 ;;=Defining Characteristics^2^NURSC^12^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,0)
 ;;=^124.21PI^8^6
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,1,0)
 ;;=4069^urinary urgency, incontinence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,2,0)
 ;;=4072^intake altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,3,0)
 ;;=4073^thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,6,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,7,0)
 ;;=4199^skin turgor decreased^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,1,8,0)
 ;;=4201^urine output altered (diluted, increased or decreased)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4066,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4067,0)
 ;;=sympathetic stimulation-cardiovascular excitation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4068,0)
 ;;=Defining Characteristics^2^NURSC^12^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4068,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4068,1,1,0)
 ;;=4071^excessive verbalization of the traumatic event^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4068,1,2,0)
 ;;=4078^flashbacks,intrusive thoughts^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4068,1,3,0)
 ;;=4080^guilt or guilt about behaviour required for survival^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4068,1,4,0)
 ;;=4082^verbalization of survival^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4068,1,5,0)
 ;;=4083^repetitive dreams or nightmares^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4068,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4069,0)
 ;;=urinary urgency, incontinence^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4070,0)
 ;;=Defining Characteristics^2^NURSC^12^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4070,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4070,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4070,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4070,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4070,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4070,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4070,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4071,0)
 ;;=excessive verbalization of the traumatic event^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4072,0)
 ;;=intake altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4073,0)
 ;;=thirst^3^NURSC^^1^^^T
