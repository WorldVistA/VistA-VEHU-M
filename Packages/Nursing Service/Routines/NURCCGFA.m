NURCCGFA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,1,0)
 ;;=14279^recognizes use/abuse interferes with achievement of goals^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,2,0)
 ;;=14280^identifies [specify number] triggers to use/abuse substance^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,3,0)
 ;;=14282^demonstrates alternate coping skills for substance use/abuse^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,4,0)
 ;;=14284^lists goals in major areas of life^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,5,0)
 ;;=14594^[Extra Goal]^3^NURSC^247
 ;;^UTILITY("^GMRD(124.2,",$J,14275,1,6,0)
 ;;=15268^develops plan to maintain substance free life style^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14275,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,0)
 ;;=teach patient actions to take when S/S reoccur^2^NURSC^^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,1,0)
 ;;=401^postural drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,2,0)
 ;;=402^humidification therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,3,0)
 ;;=403^use of expectorants^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,4,0)
 ;;=404^aerosol therapy q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,5,0)
 ;;=405^fluid intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,6,0)
 ;;=406^antibiotic therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,7,0)
 ;;=407^avoidance of respiratory irritants^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,1,8,0)
 ;;=408^contact health professional for assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14278,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,14278,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14279,0)
 ;;=recognizes use/abuse interferes with achievement of goals^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14279,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14279,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14280,0)
 ;;=identifies [specify number] triggers to use/abuse substance^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14280,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14280,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14282,0)
 ;;=demonstrates alternate coping skills for substance use/abuse^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14282,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14282,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14284,0)
 ;;=lists goals in major areas of life^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14284,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14284,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14286,0)
 ;;=[Extra Goal]^3^NURSC^9^244^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14286,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14286,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^158^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,1,0)
 ;;=14294^assess ability to identify nonproductive behaviors^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,2,0)
 ;;=1199^encourage fluid intake (pt preference) to [ ]cc q [ ]hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,3,0)
 ;;=2097^encourage balanced nutritional intake each meal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,4,0)
 ;;=14301^assist to identify resources for substance free lifestyle^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,5,0)
 ;;=2099^reassure patient at onset that symptoms are temporary^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,6,0)
 ;;=2100^provide quiet environment to decrease stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14288,1,7,0)
 ;;=14307^assess ability to identify impact of behavior on others^3^NURSC^10
