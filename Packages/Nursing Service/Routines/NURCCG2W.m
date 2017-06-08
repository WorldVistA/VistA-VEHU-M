NURCCG2W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,1,0)
 ;;=928^EKG indicates no MI, ongoing ischemia, or extension of MI^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,2,0)
 ;;=929^absence of dyspnea/crackles/wheezes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,3,0)
 ;;=931^absence of extra heart sounds^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,4,0)
 ;;=933^B/P WNL (baseline)^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,5,0)
 ;;=935^stable heart rate/rhythm^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,6,0)
 ;;=936^level of consciousness WNL, oriented x3^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,1,7,0)
 ;;=1182^adequate cardiac output while using commode^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,923,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,923,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,923,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,923,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,924,0)
 ;;=abdominal distention/cramping^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,925,0)
 ;;=feeling of fullness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,926,0)
 ;;=pressure in abdomen/rectum^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,927,0)
 ;;=identify factors contributing to constipation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,927,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,927,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,928,0)
 ;;=EKG indicates no MI, ongoing ischemia, or extension of MI^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,929,0)
 ;;=absence of dyspnea/crackles/wheezes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,930,0)
 ;;=monitor effects of laxatives, stool softeners, enemas etc...^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,930,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,930,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,931,0)
 ;;=absence of extra heart sounds^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,932,0)
 ;;=place in sitting position unless contraindicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,932,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,932,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,933,0)
 ;;=B/P WNL (baseline)^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,934,0)
 ;;=allow for time in the bathroom or on commode/bedpan^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,934,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,934,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,935,0)
 ;;=stable heart rate/rhythm^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,936,0)
 ;;=level of consciousness WNL, oriented x3^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,937,0)
 ;;=provide privacy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,937,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,937,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,938,0)
 ;;=provide comfort^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,938,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,938,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,939,0)
 ;;=encourage fluids [ ]cc/day, roughage; discuss rationale ^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,939,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,939,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,940,0)
 ;;=administer prescribed laxative, stool softener or enema^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,940,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,940,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,941,0)
 ;;=states free of pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,941,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,941,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,942,0)
 ;;=lab values return to normal e.g. enzymes, ABGs, CBC^3^NURSC^9^1^^^T
