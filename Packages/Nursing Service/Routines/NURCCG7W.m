NURCCG7W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,6,0)
 ;;=4190^inappropriate household temperature^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,7,0)
 ;;=4193^offensive odors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,8,0)
 ;;=4196^accumulation of dirt, food or hygienic wastes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,9,0)
 ;;=4203^disorderly surroundings i.e.,unwashed clothes, cooking equip^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4178,0)
 ;;=inability of members to constructively adapt to change^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4179,0)
 ;;=S/O describe outstanding debts or financial crises^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4180,0)
 ;;=Defining Characteristics^2^NURSC^12^28^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4180,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4180,1,1,0)
 ;;=4185^verbal report of pain experienced for more than 6 months^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4180,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4180,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4180,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4180,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4180,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4181,0)
 ;;=members unable to interact with each other for mutual growth^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4182,0)
 ;;=S/O express difficulty maintaining a comfortable home^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4183,0)
 ;;=Defining Characteristics^2^NURSC^12^29^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4183,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4183,1,1,0)
 ;;=4187^apprehension, fright^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4183,1,2,0)
 ;;=4188^concentration on source of fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4183,1,3,0)
 ;;=4191^aggressive behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4183,1,4,0)
 ;;=4194^withdrawal behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4183,1,5,0)
 ;;=4195^sympathetic stimulation of the autonomic nervous system^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4183,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4184,0)
 ;;=S/O request assistance with home maintenance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4185,0)
 ;;=verbal report of pain experienced for more than 6 months^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4186,0)
 ;;=presence of vermin or rodents^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4187,0)
 ;;=apprehension, fright^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4188,0)
 ;;=concentration on source of fear^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4190,0)
 ;;=inappropriate household temperature^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4191,0)
 ;;=aggressive behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4192,0)
 ;;=alteration in muscle tone (may span from listless to rigid)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4193,0)
 ;;=offensive odors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4194,0)
 ;;=withdrawal behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4195,0)
 ;;=sympathetic stimulation of the autonomic nervous system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4196,0)
 ;;=accumulation of dirt, food or hygienic wastes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4197,0)
 ;;=distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4199,0)
 ;;=skin turgor decreased^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4200,0)
 ;;=facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^^1^^^T
