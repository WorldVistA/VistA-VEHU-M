NURCCG6W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,8,0)
 ;;=2852^coping, ineffective (family)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2813,0)
 ;;=reduced level of consciousness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2814,0)
 ;;=depressed cough and gag reflex^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2815,0)
 ;;=presence of endotracheal/tracheal tube^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2816,0)
 ;;=incomplete esophageal sphincter^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2817,0)
 ;;=gastrointestinal tubes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2818,0)
 ;;=medication administration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2819,0)
 ;;=increased intragastric pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2820,0)
 ;;=increased gastric residual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2821,0)
 ;;=decreased gastrointestinal motility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2822,0)
 ;;=delayed gastric emptying^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2823,0)
 ;;=wired jaws^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2824,0)
 ;;=impaired swallowing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2825,0)
 ;;=facial/oral/neck surgery/trauma^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2826,0)
 ;;=situations hindering elevation of upper body^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2827,0)
 ;;=teach the purpose and use of analgesics^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2827,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2827,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2828,0)
 ;;=evidence of clear airway^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2828,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2828,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2829,0)
 ;;=evidence of clear lung fields^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2829,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2829,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2830,0)
 ;;=assess respiratory rate and pattern/breath sounds^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2830,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2830,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2831,0)
 ;;=monitor secretions:amount, color, consistency^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2831,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2831,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2832,0)
 ;;=monitor secretions: presence/absence of methyllin blue^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2832,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2832,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2833,0)
 ;;=monitor secretions: presence/absence glucose in secretions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2833,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2833,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2834,0)
 ;;=observe for coughing when eating/receiving tube feedings^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2834,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2834,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2835,0)
 ;;=document frequency of suctioning^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2835,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2835,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2836,0)
 ;;=monitor level of consciousness q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2836,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2836,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2837,0)
 ;;=review chest xray report for evidence of infiltration^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2837,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2837,10)
 ;;=D EN1^NURCCPU3
