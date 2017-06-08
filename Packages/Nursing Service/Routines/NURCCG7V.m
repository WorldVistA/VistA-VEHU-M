NURCCG7V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4157,1,3,0)
 ;;=4161^urgency of loose, liquid stools^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4157,1,4,0)
 ;;=4163^increased frequency of bowel sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4157,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4158,0)
 ;;=behavior pattern or usual response to stimuli is changed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4159,0)
 ;;=abdominal pain, cramping^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4160,0)
 ;;=increased frequency of stools^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4161,0)
 ;;=urgency of loose, liquid stools^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4162,0)
 ;;=sensory acuity is reported or measured as changed ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4163,0)
 ;;=increased frequency of bowel sounds^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4164,0)
 ;;=Defining Characteristics^2^NURSC^12^25^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4164,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4164,1,1,0)
 ;;=4166^boredom^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4164,1,2,0)
 ;;=4168^usual hobbies cannot be undertaken in hospital^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4164,1,3,0)
 ;;=4169^desire for something to occupy time, ie crafts, read, etc.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4164,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4165,0)
 ;;=problem-solving  abilities are changed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4166,0)
 ;;=boredom^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4167,0)
 ;;=disoriented in time, place or with persons^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4168,0)
 ;;=usual hobbies cannot be undertaken in hospital^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4169,0)
 ;;=desire for something to occupy time, ie crafts, read, etc.^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4170,0)
 ;;=Defining Characteristics^2^NURSC^12^26^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4170,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4170,1,1,0)
 ;;=4173^inability of family to meet psychosocial needs of members^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4170,1,2,0)
 ;;=4174^ineffective family decision-making process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4170,1,3,0)
 ;;=4176^family does not demonstrate respect for autonomy of members^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4170,1,4,0)
 ;;=4178^inability of members to constructively adapt to change^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4170,1,5,0)
 ;;=4181^members unable to interact with each other for mutual growth^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4170,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4171,0)
 ;;=unable to take responsibility to meet basic health practices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4172,0)
 ;;=body image alteration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4173,0)
 ;;=inability of family to meet psychosocial needs of members^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4174,0)
 ;;=ineffective family decision-making process^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4175,0)
 ;;=lack of adaptive behaviors to environmental changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4176,0)
 ;;=family does not demonstrate respect for autonomy of members^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4177,0)
 ;;=Defining Characteristics^2^NURSC^12^27^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,1,0)
 ;;=4179^S/O describe outstanding debts or financial crises^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,2,0)
 ;;=4182^S/O express difficulty maintaining a comfortable home^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,3,0)
 ;;=4184^S/O request assistance with home maintenance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,4,0)
 ;;=4186^presence of vermin or rodents^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4177,1,5,0)
 ;;=108^lack of necessary equipment^3^NURSC^1
