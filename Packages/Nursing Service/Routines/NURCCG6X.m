NURCCG6X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2838,0)
 ;;=measure trach/ET tube cuff pressure q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2838,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2838,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2839,0)
 ;;=maintain cuff pressure between [amt]mm Hg^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2839,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2839,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2840,0)
 ;;=place pt in semi-fowlers prior to eating/tube feeding^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2840,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2840,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2841,0)
 ;;=maintain upright position [# of] minutes after eating/TF^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2841,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2841,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2842,0)
 ;;=schedule/do bronchial hygiene at least [amt] min pc^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2842,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2842,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2843,0)
 ;;=check gastric residual q[freuqency] hours^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2843,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2843,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2844,0)
 ;;=if gastric residual > [amt] cc, D/C feeding^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2844,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2844,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2845,0)
 ;;=evaluate size of feeding tube/use smallest tube^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2845,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2845,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2846,0)
 ;;=teach pt,S/O,caregiver to elev HOB prior to feeding^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2846,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2846,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2847,0)
 ;;=teach pt,S/O,caregiver to do bronchial hygiene q[] min PC^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2847,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2847,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2848,0)
 ;;=teach pt,S/O,caregiver to position pt upright q[] min PC^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2848,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2848,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2849,0)
 ;;=teach pt,S/O,caregiver to keep trach cuff infl when eatg/fdg^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2849,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2849,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2850,0)
 ;;=infection potential^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2851,0)
 ;;=nutrition, alteration in (less than body requirements)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2852,0)
 ;;=coping, ineffective (family)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2853,0)
 ;;=powerlessness^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2854,0)
 ;;=administer pharmacological agents as ordered/per protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2854,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,2854,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2854,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2855,0)
 ;;=teach techniques of massage to decrease pain^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2855,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2855,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2856,0)
 ;;=teach positioning techniques to decrease pain^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2856,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2856,10)
 ;;=D EN1^NURCCPU3
