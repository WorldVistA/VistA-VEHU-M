NURCCGB7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,11,0)
 ;;=497^provide humidity q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,13,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,15,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,17,0)
 ;;=7579^teach prevention of infection techniques:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,18,0)
 ;;=7589^[Extra Order]^3^NURSC^140
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,19,0)
 ;;=16560^fluid intake [amount]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,20,0)
 ;;=15559^maintain strict asepis during dialysis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,21,0)
 ;;=15560^medicate PRN for c/o itching^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,1,22,0)
 ;;=15561^instruct patient to avoid scratching^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7558,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7577,0)
 ;;=verbalizes knowledge continued use/abuse has adverse outcome^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7577,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7577,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7579,0)
 ;;=teach prevention of infection techniques:^2^NURSC^11^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,1,0)
 ;;=554^actions to take to prevent cross-infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,2,0)
 ;;=1820^S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,3,0)
 ;;=2750^personal hygiene measures as indicated [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,4,0)
 ;;=2938^assess knowledge base^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,5,0)
 ;;=2939^determine ability to learn and implement plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,6,0)
 ;;=2940^decide what patient needs to know^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,7,0)
 ;;=2941^evaluate effectiveness of teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,8,0)
 ;;=2942^implement teaching plan based on readiness/ability to learn^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,1,9,0)
 ;;=2943^involve S/O in teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,7579,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7579,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7579,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7589,0)
 ;;=[Extra Order]^3^NURSC^11^140^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7589,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7589,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7590,0)
 ;;=develop plan to maintain substance free life style^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7590,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7590,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7591,0)
 ;;=Activity Intolerance^2^NURSC^2^3^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7591,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7591,1,1,0)
 ;;=7592^Etiology/Related and/or Risk Factors^2^NURSC^106
 ;;^UTILITY("^GMRD(124.2,",$J,7591,1,2,0)
 ;;=7597^Goals/Expected Outcomes^2^NURSC^104
 ;;^UTILITY("^GMRD(124.2,",$J,7591,1,3,0)
 ;;=7608^Nursing Intervention/Orders^2^NURSC^90
 ;;^UTILITY("^GMRD(124.2,",$J,7591,1,4,0)
 ;;=7663^Related Problems^2^NURSC^89
 ;;^UTILITY("^GMRD(124.2,",$J,7591,1,5,0)
 ;;=7674^Defining Characteristics^2^NURSC^94
 ;;^UTILITY("^GMRD(124.2,",$J,7591,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7591,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7591,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7591,"TD",0)
 ;;=^^3^3^2890623^^^
