NURCCG2U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,3,0)
 ;;=965^assess status of chest pain^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,4,0)
 ;;=985^assess for S/S of decreased cardiac out; monitor, document^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,5,0)
 ;;=1000^assess general appearance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,6,0)
 ;;=1008^advise patient to notify the nurse of pain/discomfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,7,0)
 ;;=1009^administer prescribed narcotic/analgesic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,8,0)
 ;;=1037^lab data and related tests^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,9,0)
 ;;=1060^provide for personal hygiene^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,10,0)
 ;;=1067^offer commode q [frequency] hrs. while providing privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,11,0)
 ;;=1074^apply anti-embolic stockings as prescribed^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,12,0)
 ;;=1105^assess for EKG changes (lead 1/AVL/V1-V4)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,13,0)
 ;;=1152^establish procedures/treatments for LCA occlusion^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,14,0)
 ;;=1162^assess for EKG changes (leads II/III/AVF)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,15,0)
 ;;=1176^establish procedures/treatments for RCA occlusion^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,16,0)
 ;;=2747^teach patient^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,17,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,1,18,0)
 ;;=2973^[Extra Order]^3^NURSC^56^0
 ;;^UTILITY("^GMRD(124.2,",$J,890,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,890,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,890,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,891,0)
 ;;=Related Problems^2^NURSC^7^18^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,891,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,891,1,1,0)
 ;;=1394^Activity Intolerance (Circulatory System)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,891,1,2,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,891,1,3,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,891,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,892,0)
 ;;=diagnostic procedures^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,893,0)
 ;;=emotional status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,894,0)
 ;;=insuring agents^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,895,0)
 ;;=gastrointestinal obstructive lesions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,896,0)
 ;;=less than adequate physical activity or immobility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,897,0)
 ;;=less than adequate dietary intake and bulk^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,898,0)
 ;;=pain on defecation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,899,0)
 ;;=personal habits^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,900,0)
 ;;=pregnancy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,901,0)
 ;;=use of medication and enemas^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,902,0)
 ;;=weak abdominal musculature^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,903,0)
 ;;=chemical^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,904,0)
 ;;=physical^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,905,0)
 ;;=evacuates soft, formed stool q[ ]days without pain/strain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,905,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,905,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,906,0)
 ;;=describes contributing factors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,906,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,906,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,907,0)
 ;;=maintains fluid intake of <2,000cc q day^3^NURSC^9^1^^^T
