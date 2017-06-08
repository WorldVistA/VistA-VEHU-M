NURCCG77 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3034,0)
 ;;=Adjustment Impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3035,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^37^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,1,0)
 ;;=3036^assess bowel elimination pattern/routine^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,2,0)
 ;;=3037^assess factors contributing to perception of constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,3,0)
 ;;=3038^monitor for therapeutic effects of laxatives/enemas^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,4,0)
 ;;=3039^institute bowel program [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,5,0)
 ;;=3040^teach bowel physiology and when to seek medical attention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,6,0)
 ;;=3041^assess history of laxative/enema use^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,7,0)
 ;;=3042^ensure fluid intake of [value] cc/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,8,0)
 ;;=3043^provide privacy during toileting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,9,0)
 ;;=3044^assess perception of constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,10,0)
 ;;=2524^assess dietary habits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,11,0)
 ;;=3045^perform rectal examination^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,12,0)
 ;;=3046^institute bowel program [specify]^3^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,13,0)
 ;;=3047^encourage physical activity within limits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,14,0)
 ;;=3048^instruct against habitual use of laxatives/enemas^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,15,0)
 ;;=3049^instruct to attempt defecation [value]hours pc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,3035,1,16,0)
 ;;=16559^[Extra Order]^3^NURSC^434
 ;;^UTILITY("^GMRD(124.2,",$J,3035,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3035,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3036,0)
 ;;=assess bowel elimination pattern/routine^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3036,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3036,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3037,0)
 ;;=assess factors contributing to perception of constipation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3037,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3037,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3038,0)
 ;;=monitor for therapeutic effects of laxatives/enemas^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3038,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3038,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3039,0)
 ;;=institute bowel program [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3039,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3039,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3040,0)
 ;;=teach bowel physiology and when to seek medical attention^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3040,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3040,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3041,0)
 ;;=assess history of laxative/enema use^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3041,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3041,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3042,0)
 ;;=ensure fluid intake of [value] cc/day^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3042,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3042,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3043,0)
 ;;=provide privacy during toileting^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3043,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,3043,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3044,0)
 ;;=assess perception of constipation^3^NURSC^11^1^^^T
