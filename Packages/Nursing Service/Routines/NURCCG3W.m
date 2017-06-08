NURCCG3W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1394,0)
 ;;=Activity Intolerance (Circulatory System)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1395,0)
 ;;=maintains adequate cardiac output^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,1,0)
 ;;=514^vital signs WNL or returns to baseline^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,2,0)
 ;;=1422^skin dry and warm to touch^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,3,0)
 ;;=1424^normal skin color^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,4,0)
 ;;=517^lab data (e.g. BUN, creatinine) is normal or baseline^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,5,0)
 ;;=1432^lab data (e.g. CBC, differential) is WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,1,6,0)
 ;;=516^capillary filling WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,1395,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1395,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1395,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1396,0)
 ;;=Fluid Volume Deficit (Actual/Potential)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1397,0)
 ;;=Fluid Volume Excess (Actual/Potential)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1398,0)
 ;;=Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1399,0)
 ;;=Nutrition, Alteration In: More Than Body Requirements^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1400,0)
 ;;=Incontinence, Bowel^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1401,0)
 ;;=Skin Integrity, Impairment Of (Actual)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1402,0)
 ;;=Skin Integrity, Impairment Of (Potential)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1403,0)
 ;;=Anxiety^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1404,0)
 ;;=Diarrhea^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1405,0)
 ;;=Depressive Behavior^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1406,0)
 ;;=Cognitive Impairment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1407,0)
 ;;=Sensory-Perceptual, Alteration In^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1408,0)
 ;;=Stress Incontinence^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1409,0)
 ;;=Infection Potential (Specific to Elimination)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1410,0)
 ;;=Urinary Elimination, Alteration In Pattern^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1411,0)
 ;;=Self Concept, Disturbance In^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1412,0)
 ;;=Urinary Retention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1413,0)
 ;;=Incontinence, Urine^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1414,0)
 ;;=Constipation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1415,0)
 ;;=Coping, Ineffective Individual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1416,0)
 ;;=Coping, Ineffective Family^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1417,0)
 ;;=Mobility, Impaired Physical^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1418,0)
 ;;=Comfort, Alteration In: Acute Pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1419,0)
 ;;=Comfort, Alteration In: Chronic Pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1420,0)
 ;;=Fear^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1421,0)
 ;;=use toilet facilities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1421,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1421,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1422,0)
 ;;=skin dry and warm to touch^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1423,0)
 ;;=clamp catheter if >[amt]cc urine obtained on catheterization^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1423,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1423,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1424,0)
 ;;=normal skin color^3^NURSC^^1^^^T
