NURCCG2Y ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,958,1,4,0)
 ;;=963^precipitating and alleviating factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,958,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,958,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,958,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,959,0)
 ;;=location^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,960,0)
 ;;=quality^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,961,0)
 ;;=intensity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,962,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^23^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,1,0)
 ;;=968^contaminants^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,2,0)
 ;;=969^dietary intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,3,0)
 ;;=971^inflammation, irritation or malabsorption of bowel^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,4,0)
 ;;=459^medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,5,0)
 ;;=827^radiation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,962,1,6,0)
 ;;=972^stress and anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,962,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,963,0)
 ;;=precipitating and alleviating factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,964,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^22^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,1,0)
 ;;=977^evacuates soft, formed stool q[ ]days without pain/strain^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,2,0)
 ;;=978^describes S/S requiring medical attention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,3,0)
 ;;=979^describes methods to manage chronic diarrhea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,4,0)
 ;;=980^verbalizes medication regimen^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,5,0)
 ;;=981^verbalizes dietary management regime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,6,0)
 ;;=982^maintains perineal area free from irritation/pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,7,0)
 ;;=983^reports decrease in diarrhea to [# of episodes]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,8,0)
 ;;=984^identifies factors contributing to diarrhea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,1,9,0)
 ;;=2887^[Extra Goal]^3^NURSC^64^0
 ;;^UTILITY("^GMRD(124.2,",$J,964,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,965,0)
 ;;=assess status of chest pain^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,965,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,965,1,1,0)
 ;;=970^quality of pain on a scale of 1-10^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,965,1,2,0)
 ;;=973^12 lead EKG findings^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,965,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,965,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,965,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,965,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,966,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^19^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,1,0)
 ;;=986^assess for contributing factors such as:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,2,0)
 ;;=994^assess for impaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,3,0)
 ;;=995^assess for signs of dehydration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,4,0)
 ;;=998^record color, odor, amt., consistency, frequency of stool^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,5,0)
 ;;=999^monitor serum electrolytes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,6,0)
 ;;=1001^test stool for Guiac^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,7,0)
 ;;=1007^monitor side effects and tolerance of all medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,8,0)
 ;;=1010^restrict foods/fluids that percipitate diarrhea [list items]^3^NURSC^1^0
