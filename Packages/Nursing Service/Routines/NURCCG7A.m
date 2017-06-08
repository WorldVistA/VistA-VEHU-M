NURCCG7A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3069,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3070,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^66^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,1,0)
 ;;=3071^assess existing problem-solving ability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,2,0)
 ;;=3072^assess patient perception of problem^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,3,0)
 ;;=3073^assist to identify desired goal^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,4,0)
 ;;=3074^assist to clarify goals, alternatives, potential outcomes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,5,0)
 ;;=3075^assist to identify pros and cons of alternatives^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,6,0)
 ;;=3076^provide information to assist in decision-making^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,7,0)
 ;;=3077^teach problem solving skills^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,8,0)
 ;;=3078^teach value clarification^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,9,0)
 ;;=3079^evaluate effectiveness of problem-solving ability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3070,1,10,0)
 ;;=16553^[Extra Order]^3^NURSC^431
 ;;^UTILITY("^GMRD(124.2,",$J,3070,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3070,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3071,0)
 ;;=assess existing problem-solving ability^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3071,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3071,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3072,0)
 ;;=assess patient perception of problem^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3072,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3072,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3073,0)
 ;;=assist to identify desired goal^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3073,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3073,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3074,0)
 ;;=assist to clarify goals, alternatives, potential outcomes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3074,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3074,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3075,0)
 ;;=assist to identify pros and cons of alternatives^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3075,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3075,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3076,0)
 ;;=provide information to assist in decision-making^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3076,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3076,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3077,0)
 ;;=teach problem solving skills^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3077,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3077,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3078,0)
 ;;=teach value clarification^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3078,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3078,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3079,0)
 ;;=evaluate effectiveness of problem-solving ability^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3079,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3079,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3080,0)
 ;;=Coping, Defensive^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,3080,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3080,1,1,0)
 ;;=3081^Etiology/Related and/or Risk Factors^2^NURSC^74^0
 ;;^UTILITY("^GMRD(124.2,",$J,3080,1,2,0)
 ;;=3089^Related Problems^2^NURSC^62^0
 ;;^UTILITY("^GMRD(124.2,",$J,3080,1,3,0)
 ;;=3092^Nursing Intervention/Orders^2^NURSC^67^0
 ;;^UTILITY("^GMRD(124.2,",$J,3080,1,4,0)
 ;;=3098^Goals/Expected Outcomes^2^NURSC^74^0
 ;;^UTILITY("^GMRD(124.2,",$J,3080,1,5,0)
 ;;=5574^Defining Characteristics^2^NURSC^70
