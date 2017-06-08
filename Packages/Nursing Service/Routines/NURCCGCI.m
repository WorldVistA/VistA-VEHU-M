NURCCGCI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9819,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9819,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9827,0)
 ;;=monitor for signs and symptoms of sepsis^3^NURSC^11^13^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9827,4)
 ;;=assess, document &
 ;;^UTILITY("^GMRD(124.2,",$J,9827,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9827,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9830,0)
 ;;=institute neutropenic precautions if WBC warrants^3^NURSC^11^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9830,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9830,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9832,0)
 ;;=initiate intravenous therapy protocol^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9832,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9832,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9847,0)
 ;;=observe for evidence of bleeding^3^NURSC^11^24^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9847,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9847,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9855,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^132^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9855,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9855,1,1,0)
 ;;=776^remains free from injuries^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9855,1,2,0)
 ;;=777^verbalizes how to prevent injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9855,1,3,0)
 ;;=9928^[Extra Goal]^3^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,9855,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9862,0)
 ;;=[Extra Goal]^3^NURSC^9^164^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9862,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9862,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^113^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,0)
 ;;=^124.21PI^14^13
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,1,0)
 ;;=778^inspect for external factors which produce injury q [freq.]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,2,0)
 ;;=779^observe for adverse effects of chemical agents/treatments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,3,0)
 ;;=780^identify and eliminate potential sources of injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,4,0)
 ;;=9872^provide physically safe environment:^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,5,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,7,0)
 ;;=784^teach patient regarding health maintenance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,8,0)
 ;;=785^teach S/O regarding potential for injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,9,0)
 ;;=786^assure understanding of informed consent^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,11,0)
 ;;=10121^[Extra Order]^3^NURSC^171
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,12,0)
 ;;=12705^discuss post-operative expectations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,13,0)
 ;;=12768^evaluate eye: during dressing change & eye drop instillation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,1,14,0)
 ;;=13024^instruct patient in post-operative eye care:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9865,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9868,0)
 ;;=[Extra Order]^3^NURSC^11^166^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9868,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9868,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9872,0)
 ;;=provide physically safe environment:^2^NURSC^11^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9872,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,9872,1,1,0)
 ;;=787^bedrails^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9872,1,2,0)
 ;;=788^call light^3^NURSC^1
