NURCCG2V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,907,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,907,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,908,0)
 ;;=consumes bulk/high fiber daily^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,908,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,908,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,909,0)
 ;;=expresses sense of comfort with ICU/CCU routine^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,909,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,909,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,910,0)
 ;;=states anxiety and fears are alleviated^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,910,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,910,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,911,0)
 ;;=conserves energy^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,911,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,911,1,1,0)
 ;;=916^overt activity is moderated within [hrs or days]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,911,1,2,0)
 ;;=917^expressed need for oxygen is decreased within [hrs or days]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,911,5)
 ;;=as witnessed by
 ;;^UTILITY("^GMRD(124.2,",$J,911,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,911,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,911,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,912,0)
 ;;=demonstrates increased activity/exercise within own limits^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,912,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,912,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,913,0)
 ;;=indicates decreased related stress/anxiety^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,913,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,913,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,914,0)
 ;;=presents with normal bowel sounds^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,914,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,914,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,915,0)
 ;;=describes methods to reduce or prevent constipation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,915,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,915,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,916,0)
 ;;=overt activity is moderated within [hrs or days]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,917,0)
 ;;=expressed need for oxygen is decreased within [hrs or days]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,918,0)
 ;;=assess bowel elimination pattern/routine^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,918,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,918,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,919,0)
 ;;=assess for signs/symptoms such as:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,919,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,919,1,1,0)
 ;;=921^headache^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,919,1,2,0)
 ;;=922^nausea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,919,1,3,0)
 ;;=924^abdominal distention/cramping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,919,1,4,0)
 ;;=925^feeling of fullness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,919,1,5,0)
 ;;=926^pressure in abdomen/rectum^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,919,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,919,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,919,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,920,0)
 ;;=verbalizes onset & description of chest pain on 1-10 scale^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,920,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,920,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,921,0)
 ;;=headache^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,922,0)
 ;;=nausea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,923,0)
 ;;=remains hemodynamically stable^2^NURSC^9^1^1^^T^1
