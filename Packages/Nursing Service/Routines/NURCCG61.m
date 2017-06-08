NURCCG61 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,1,0)
 ;;=2749^actions to take to prevent cross-infection^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,2,0)
 ;;=1820^S/S of infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,3,0)
 ;;=2750^personal hygiene measures as indicated [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,4,0)
 ;;=2938^assess knowledge base^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,5,0)
 ;;=2939^determine ability to learn and implement plan^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,6,0)
 ;;=2940^decide what patient needs to know^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,7,0)
 ;;=2941^evaluate effectiveness of teaching plan^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,8,0)
 ;;=2942^implement teaching plan based on readiness/ability to learn^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,1,9,0)
 ;;=2943^involve S/O in teaching plan^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2436,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,2436,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2436,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2436,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2437,0)
 ;;=expresses appropriate knowledge base for self care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2437,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2437,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2438,0)
 ;;=demonstrates positive health behaviors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2438,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2438,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2439,0)
 ;;=expresses less anxiety^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2439,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2439,1,1,0)
 ;;=2440^fear of unknown^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2439,1,2,0)
 ;;=2441^loss of control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2439,1,3,0)
 ;;=609^misinformation or lack of knowledge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2439,5)
 ;;=related to:
 ;;^UTILITY("^GMRD(124.2,",$J,2439,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2439,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2439,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2440,0)
 ;;=fear of unknown^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2441,0)
 ;;=loss of control^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2442,0)
 ;;=Related Problems^2^NURSC^7^54^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2442,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,2442,1,1,0)
 ;;=1936^Sexual Dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2442,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2442,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2443,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^67^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,1,0)
 ;;=2445^verbalizes acceptance of self-limitations in sex matters^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,2,0)
 ;;=2446^verbalizes confidence/ability to resume satisfactory sex^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,3,0)
 ;;=2447^verbalizes knowledge of methods of contraception^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,4,0)
 ;;=2448^verbalizes methods to prevent sexually transmitted diseases^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,5,0)
 ;;=2449^identifies stressors related to altered sexual pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,6,0)
 ;;=2450^identifies practices that conserve energy when having sex ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,1,7,0)
 ;;=2931^[Extra Goal]^3^NURSC^112^0
 ;;^UTILITY("^GMRD(124.2,",$J,2443,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2444,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^61^1^^T
