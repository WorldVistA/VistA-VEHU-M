NURCCG6V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2809,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2810,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^71^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2810,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2810,1,1,0)
 ;;=2828^evidence of clear airway^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2810,1,2,0)
 ;;=2829^evidence of clear lung fields^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2810,1,3,0)
 ;;=2936^[Extra Goal]^3^NURSC^117^0
 ;;^UTILITY("^GMRD(124.2,",$J,2810,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2811,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^171^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,0)
 ;;=^124.21PI^21^21
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,1,0)
 ;;=2830^assess respiratory rate and pattern/breath sounds^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,2,0)
 ;;=2831^monitor secretions:amount, color, consistency^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,3,0)
 ;;=2832^monitor secretions: presence/absence of methyllin blue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,4,0)
 ;;=2833^monitor secretions: presence/absence glucose in secretions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,5,0)
 ;;=2834^observe for coughing when eating/receiving tube feedings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,6,0)
 ;;=2835^document frequency of suctioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,7,0)
 ;;=2836^monitor level of consciousness q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,8,0)
 ;;=2837^review chest xray report for evidence of infiltration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,9,0)
 ;;=2838^measure trach/ET tube cuff pressure q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,10,0)
 ;;=2839^maintain cuff pressure between [amt]mm Hg^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,11,0)
 ;;=2840^place pt in semi-fowlers prior to eating/tube feeding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,12,0)
 ;;=2841^maintain upright position [# of] minutes after eating/TF^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,13,0)
 ;;=2842^schedule/do bronchial hygiene at least [amt] min pc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,14,0)
 ;;=2843^check gastric residual q[freuqency] hours^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,15,0)
 ;;=2844^if gastric residual > [amt] cc, D/C feeding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,16,0)
 ;;=2845^evaluate size of feeding tube/use smallest tube^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,17,0)
 ;;=2846^teach pt,S/O,caregiver to elev HOB prior to feeding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,18,0)
 ;;=2847^teach pt,S/O,caregiver to do bronchial hygiene q[] min PC^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,19,0)
 ;;=2848^teach pt,S/O,caregiver to position pt upright q[] min PC^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,20,0)
 ;;=2849^teach pt,S/O,caregiver to keep trach cuff infl when eatg/fdg^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,1,21,0)
 ;;=3023^[Extra Order]^3^NURSC^109^0
 ;;^UTILITY("^GMRD(124.2,",$J,2811,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2811,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2812,0)
 ;;=Related Problems^2^NURSC^7^31^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,1,0)
 ;;=2850^infection potential^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,2,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,4,0)
 ;;=2152^fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,5,0)
 ;;=419^anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,6,0)
 ;;=2851^nutrition, alteration in (less than body requirements)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2812,1,7,0)
 ;;=2853^powerlessness^3^NURSC^2^0
