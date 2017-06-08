NURCCGG5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15257,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15257,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15258,0)
 ;;=[Extra Order]^3^NURSC^11^409^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15258,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15258,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15259,0)
 ;;=[Extra Order]^3^NURSC^11^410^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15259,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15259,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15260,0)
 ;;=inform patient/SO: clinic visit,need for follow-up care,etc^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15260,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15260,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15261,0)
 ;;=demonstrates excercises to improve mobility^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15261,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15261,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15262,0)
 ;;=adapts gait to wide base with arm swing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15262,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15262,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15263,0)
 ;;=correctly uses adaptive equipment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15263,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15263,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15264,0)
 ;;=advise patient/SO to maintain safe home environment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15264,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15264,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15265,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^304^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15265,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15265,1,1,0)
 ;;=2437^expresses appropriate knowledge base for self care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15265,1,2,0)
 ;;=15266^verbalizes knowledge of risk factors and S/S^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15265,1,3,0)
 ;;=15557^[Extra Goal]^3^NURSC^258
 ;;^UTILITY("^GMRD(124.2,",$J,15265,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15266,0)
 ;;=verbalizes knowledge of risk factors and S/S^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15266,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15266,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15267,0)
 ;;=[Extra Goal]^3^NURSC^9^255^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15267,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15267,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15268,0)
 ;;=develops plan to maintain substance free life style^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15268,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15268,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15270,0)
 ;;=anger management^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15271,0)
 ;;=stress management^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15273,0)
 ;;=goal setting^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15274,0)
 ;;=assess,report signs and symptoms of metabolic acidosis^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15274,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15274,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15275,0)
 ;;=[Extra Problem]^2^NURSC^2^42^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15275,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15275,1,1,0)
 ;;=15276^Etiology/Related and/or Risk Factors^2^NURSC^291
 ;;^UTILITY("^GMRD(124.2,",$J,15275,1,2,0)
 ;;=15280^Goals/Expected Outcomes^2^NURSC^305
 ;;^UTILITY("^GMRD(124.2,",$J,15275,1,3,0)
 ;;=15284^Nursing Intervention/Orders^2^NURSC^307
 ;;^UTILITY("^GMRD(124.2,",$J,15275,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15275,9)
 ;;=D EN2^NURCCPU3
