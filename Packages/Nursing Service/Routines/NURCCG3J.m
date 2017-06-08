NURCCG3J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,1,0)
 ;;=1119^achieves reduced number of incontinent episodes, <[ ]X/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,2,0)
 ;;=1260^establishes or re-establishes control over micturition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,3,0)
 ;;=1263^achieves residual urine <[amt] cc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,4,0)
 ;;=1268^demonstrates use of management program^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,5,0)
 ;;=1261^identifies urgency to void^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1248,1,6,0)
 ;;=2895^[Extra Goal]^3^NURSC^74^0
 ;;^UTILITY("^GMRD(124.2,",$J,1248,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1249,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^27^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,1,0)
 ;;=583^assess causative, contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,2,0)
 ;;=1273^assess voiding/urgency patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,3,0)
 ;;=1274^record time between voidings^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,4,0)
 ;;=1275^remove environmental barriers to voiding:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,5,0)
 ;;=1147^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,6,0)
 ;;=1283^patient fluid preference [ADDITIONAL TEXT]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,7,0)
 ;;=1284^respond within [ ]min to request for toileting assistance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,8,0)
 ;;=1151^initiate bladder training program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,9,0)
 ;;=1239^active isometric pelvic exercises [ ]times per [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,10,0)
 ;;=1149^limit diuretic producing liquids:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,11,0)
 ;;=1288^stimulate voiding reflex by pouring warm water over perineum^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,12,0)
 ;;=1289^provide motivation to increase bladder control:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,13,0)
 ;;=1293^provide with product resources to prevent wetting of clothes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,14,0)
 ;;=1295^teach intermittent catheterization per protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,1,15,0)
 ;;=2982^[Extra Order]^3^NURSC^65^0
 ;;^UTILITY("^GMRD(124.2,",$J,1249,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1249,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1250,0)
 ;;=laboratory data^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1250,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1250,1,1,0)
 ;;=1252^serum electrolytes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1250,1,2,0)
 ;;=1253^BUN^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1250,1,3,0)
 ;;=1254^creatinine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1250,1,4,0)
 ;;=1257^drug levels^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1250,1,5,0)
 ;;=2937^ABGs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1250,4)
 ;;=assess, monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1250,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,1250,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1250,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1250,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1251,0)
 ;;=Related Problems^2^NURSC^7^24^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,1,0)
 ;;=1412^Urinary Retention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,2,0)
 ;;=1413^Incontinence, Urine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,3,0)
 ;;=1408^Stress Incontinence^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1251,1,4,0)
 ;;=1409^Infection Potential (Specific to Elimination)^3^NURSC^1^0
