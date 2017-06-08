NURCCG3A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1125,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1125,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1126,0)
 ;;=toilet 1/2 hour after eating^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1126,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1126,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1127,0)
 ;;=toilet prior to periods of increased activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1127,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1127,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1128,0)
 ;;=provide access to or keep equipment in a convenient place^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1128,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1128,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1129,0)
 ;;=initiate a specific bowel program^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1129,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1129,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1130,0)
 ;;=teach patient and S/O in underlying cause(s)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1130,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1130,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1131,0)
 ;;=teach muscle tone/strength exercises as individually able^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1131,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1131,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1132,0)
 ;;=teach patient and/or S/O in assistive devices available^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1132,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1132,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1133,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^29^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1133,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1133,1,1,0)
 ;;=207^depression, severe anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1133,1,2,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1133,1,3,0)
 ;;=210^neuromuscular impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1133,1,4,0)
 ;;=1033^perception or cognitive impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1133,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1134,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^27^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,1,0)
 ;;=1119^achieves reduced number of incontinent episodes, <[ ]X/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,2,0)
 ;;=1139^expresses knowledge of voiding patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,3,0)
 ;;=1141^develops fluid intake schedule^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,4,0)
 ;;=2660^utilizes management program^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,5,0)
 ;;=2664^remains free of urinary tract infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1134,1,6,0)
 ;;=2892^[Extra Goal]^3^NURSC^69^0
 ;;^UTILITY("^GMRD(124.2,",$J,1134,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1135,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^24^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,1,0)
 ;;=1143^assess/record bladder distention q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,2,0)
 ;;=583^assess causative, contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,3,0)
 ;;=1144^record patterns and amounts of incontinences^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,4,0)
 ;;=1145^offer urinal/bedpan q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,5,0)
 ;;=1146^take to bathroom q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,6,0)
 ;;=1147^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1135,1,7,0)
 ;;=1148^restrict fluids at bedtime^3^NURSC^1^0
