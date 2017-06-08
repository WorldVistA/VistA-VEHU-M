NURCCG2S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,879,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,880,0)
 ;;=back rub^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,881,0)
 ;;=warm milk^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,882,0)
 ;;=soft music^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,883,0)
 ;;=analgesic for pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,884,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^21^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,1,0)
 ;;=892^diagnostic procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,2,0)
 ;;=893^emotional status^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,3,0)
 ;;=895^gastrointestinal obstructive lesions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,4,0)
 ;;=607^lack of privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,5,0)
 ;;=896^less than adequate physical activity or immobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,6,0)
 ;;=897^less than adequate dietary intake and bulk^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,7,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,8,0)
 ;;=210^neuromuscular impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,9,0)
 ;;=898^pain on defecation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,10,0)
 ;;=899^personal habits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,11,0)
 ;;=900^pregnancy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,12,0)
 ;;=901^use of medication and enemas^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,1,13,0)
 ;;=902^weak abdominal musculature^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,884,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,885,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^20^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,1,0)
 ;;=905^evacuates soft, formed stool q[ ]days without pain/strain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,2,0)
 ;;=906^describes contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,3,0)
 ;;=907^maintains fluid intake of <2,000cc q day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,4,0)
 ;;=908^consumes bulk/high fiber daily^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,5,0)
 ;;=912^demonstrates increased activity/exercise within own limits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,6,0)
 ;;=913^indicates decreased related stress/anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,7,0)
 ;;=914^presents with normal bowel sounds^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,8,0)
 ;;=915^describes methods to reduce or prevent constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,1,9,0)
 ;;=2885^[Extra Goal]^3^NURSC^62^0
 ;;^UTILITY("^GMRD(124.2,",$J,885,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,886,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^17^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,1,0)
 ;;=918^assess bowel elimination pattern/routine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,2,0)
 ;;=919^assess for signs/symptoms such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,3,0)
 ;;=927^identify factors contributing to constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,4,0)
 ;;=930^monitor effects of laxatives, stool softeners, enemas etc...^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,5,0)
 ;;=932^place in sitting position unless contraindicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,6,0)
 ;;=934^allow for time in the bathroom or on commode/bedpan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,7,0)
 ;;=937^provide privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,8,0)
 ;;=938^provide comfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,886,1,9,0)
 ;;=939^encourage fluids [ ]cc/day, roughage; discuss rationale ^3^NURSC^1^0
