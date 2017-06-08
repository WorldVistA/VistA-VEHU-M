NURCCG3G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1203,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1203,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1204,0)
 ;;=change collection [specify] bag q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1204,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1204,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1205,0)
 ;;=run water while attempting to void^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1205,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1205,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1206,0)
 ;;=acidify urine by offering cranberry juice^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1206,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1206,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1207,0)
 ;;=initiate teaching protocol on S/S of urinary infection:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1207,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1207,1,1,0)
 ;;=1208^chills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1207,1,2,0)
 ;;=1209^fever^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1207,1,3,0)
 ;;=1210^frequent urination^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1207,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1207,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1207,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1208,0)
 ;;=chills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1209,0)
 ;;=fever^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1210,0)
 ;;=frequent urination^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1211,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^31^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1211,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1211,1,1,0)
 ;;=1215^weak pelvic muscles and structural support^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1211,1,2,0)
 ;;=1217^degenerative changes associated with increased age^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1211,1,3,0)
 ;;=1218^high intra-abdominal pressure (e.g. obesity/gravid uterus)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1211,1,4,0)
 ;;=1219^incompetent bladder outlet^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1211,1,5,0)
 ;;=1220^overdistention between voiding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1211,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1212,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^29^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,1,0)
 ;;=1119^achieves reduced number of incontinent episodes, <[ ]X/day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,2,0)
 ;;=1223^acknowledges need for muscle/sphincter exercises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,3,0)
 ;;=1225^describes causes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,4,0)
 ;;=1228^demonstrates pelvic floor muscle exercises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,5,0)
 ;;=2669^describes control measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1212,1,6,0)
 ;;=2894^[Extra Goal]^3^NURSC^73^0
 ;;^UTILITY("^GMRD(124.2,",$J,1212,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1213,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^26^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,1,0)
 ;;=583^assess causative, contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,2,0)
 ;;=1232^discuss emotional aspects^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,3,0)
 ;;=1239^active isometric pelvic exercises [ ]times per [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,4,0)
 ;;=1240^teach anterior and posterior pelvic floor muscle exercises^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,5,0)
 ;;=1241^teach to start/stop stream several times during voiding^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1213,1,6,0)
 ;;=1132^teach patient and/or S/O in assistive devices available^3^NURSC^1^0
