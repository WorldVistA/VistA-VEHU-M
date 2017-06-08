NURCCGF0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,13,0)
 ;;=14032^assess for physiological effects of a depressed state^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,14,0)
 ;;=14462^[Extra Order]^3^NURSC^251
 ;;^UTILITY("^GMRD(124.2,",$J,14019,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14020,0)
 ;;=assist to identify causative, contributing factors^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14020,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14020,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14023,0)
 ;;=assist to develop a plan to deal with contributing factors^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14023,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14023,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14024,0)
 ;;=assess for potential for self harm q[specify] hrs^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14024,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14024,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14025,0)
 ;;=help in defining,setting,meeting realistic goals [specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14025,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14025,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14027,0)
 ;;=implement measures to deal with alterations in health^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14027,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14027,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14032,0)
 ;;=assess for physiological effects of a depressed state^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14032,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14032,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14033,0)
 ;;=[Extra Order]^3^NURSC^11^246^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14033,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14033,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14034,0)
 ;;=Related Problems^2^NURSC^7^160^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,1,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,3,0)
 ;;=1918^Social Isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,4,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,5,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,6,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,7,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,1,8,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14034,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,0)
 ;;=Defining Characteristics^2^NURSC^12^163^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14043,1,1,0)
 ;;=4149^decrease in social activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,1,2,0)
 ;;=4150^lack of energy for normal activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,1,3,0)
 ;;=4151^sleep disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,1,4,0)
 ;;=4154^verbalization of feeling worthless, hopeless, helpless^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,1,5,0)
 ;;=4155^poor problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14043,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14049,0)
 ;;=Violence Potential, Directed At Others^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14049,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14049,1,1,0)
 ;;=14050^Etiology/Related and/or Risk Factors^2^NURSC^188
