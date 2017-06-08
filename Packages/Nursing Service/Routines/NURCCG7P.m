NURCCG7P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4035,1,3,0)
 ;;=4046^hostile threatening verbalizations, boasting or prior abuse ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4035,1,4,0)
 ;;=4062^overt,agressive acts-destruction of objects in environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4035,1,5,0)
 ;;=4065^suspicion of others,paranoid ideation,delusions,hallucinates^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4035,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4036,0)
 ;;=cough effective with or without sputum^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4038,0)
 ;;=breath sounds abnormal ie., wheezing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4039,0)
 ;;=cough ineffective with or without wheezing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4040,0)
 ;;=cyanosis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4042,0)
 ;;=self-destructive behavior,active aggression,suicidal acts^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4043,0)
 ;;=body language-fists,facial expression,rigid posture,tautness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4043,"TD",0)
 ;;=^^2^2^2910819^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,4043,"TD",1,0)
 ;;=body language-clenched fists, facial expression, rigid posture, tautness
 ;;^UTILITY("^GMRD(124.2,",$J,4043,"TD",2,0)
 ;;=indicating intense effort to control
 ;;^UTILITY("^GMRD(124.2,",$J,4044,0)
 ;;=Defining Characteristics^2^NURSC^12^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,1,0)
 ;;=4045^lack of information, misinformation, misconception^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,2,0)
 ;;=4047^perceived alteration in appetite^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,3,0)
 ;;=4048^reported altered food intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,4,0)
 ;;=4049^report or evidence of lack of interest in food^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,5,0)
 ;;=4050^changes in usual body weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,1,6,0)
 ;;=4051^pica^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4044,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4045,0)
 ;;=lack of information, misinformation, misconception^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4046,0)
 ;;=hostile threatening verbalizations, boasting or prior abuse ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4047,0)
 ;;=perceived alteration in appetite^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4048,0)
 ;;=reported altered food intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4049,0)
 ;;=report or evidence of lack of interest in food^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4050,0)
 ;;=changes in usual body weight^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4051,0)
 ;;=pica^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4052,0)
 ;;=Defining Characteristics^2^NURSC^12^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,1,0)
 ;;=4053^shortness of breath, orthopnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,2,0)
 ;;=4054^abnormal breath sounds; crackles (rales), wheezes (rhonchi)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,3,0)
 ;;=4056^BP, CVP, PAP changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,4,0)
 ;;=4059^changes in mental status; restlessness, anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,5,0)
 ;;=988^oliguria^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,1,6,0)
 ;;=4064^weight gain, edema, anasarca^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4052,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4053,0)
 ;;=shortness of breath, orthopnea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4054,0)
 ;;=abnormal breath sounds; crackles (rales), wheezes (rhonchi)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4055,0)
 ;;=Defining Characteristics^2^NURSC^12^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4055,1,0)
 ;;=^124.21PI^5^5
