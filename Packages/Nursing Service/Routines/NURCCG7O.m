NURCCG7O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3247,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3247,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3248,0)
 ;;=allow decision making regarding own care^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3248,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3248,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3249,0)
 ;;=explain treatments/procedures^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3249,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3249,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3250,0)
 ;;=encourage participation in self care^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3250,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3250,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3251,0)
 ;;=assist in identifying available support systems^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3251,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3251,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3252,0)
 ;;=teach coping behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3252,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3252,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3253,0)
 ;;=consult with clergy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3253,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3253,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3254,0)
 ;;=consult with psychologist^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3254,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3254,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3255,0)
 ;;=consult with social worker^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3255,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3255,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4029,0)
 ;;=Defining Characteristics^2^NURSC^12^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4029,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4029,1,1,0)
 ;;=291^exertional dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4029,1,2,0)
 ;;=4031^verbal report of fatigue or weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4029,1,3,0)
 ;;=4032^abnormal heart rate or BP response to activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4029,1,4,0)
 ;;=4033^ECG changes reflecting arrhythmias or ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4029,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4031,0)
 ;;=verbal report of fatigue or weakness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4032,0)
 ;;=abnormal heart rate or BP response to activity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4033,0)
 ;;=ECG changes reflecting arrhythmias or ischemia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4034,0)
 ;;=Defining Characteristics^2^NURSC^12^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4034,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4035,0)
 ;;=Defining Characteristics^2^NURSC^12^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4035,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4035,1,1,0)
 ;;=4042^self-destructive behavior,active aggression,suicidal acts^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4035,1,2,0)
 ;;=4043^body language-fists,facial expression,rigid posture,tautness^3^NURSC^1
