NURCCG3I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1228,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1228,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1229,0)
 ;;=multifocal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1230,0)
 ;;=six or more a minute^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1231,0)
 ;;=R on T pattern^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1232,0)
 ;;=discuss emotional aspects^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1232,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1232,1,1,0)
 ;;=1235^guidelines on most probable time incontinent/fluids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1232,1,2,0)
 ;;=1237^activities that increase risk^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1232,1,3,0)
 ;;=1238^feelings of embarrassment, regression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1232,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,1232,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1232,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1232,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1233,0)
 ;;=ventricular tachycardia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1234,0)
 ;;=bradycardia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1235,0)
 ;;=guidelines on most probable time incontinent/fluids^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1236,0)
 ;;=progressive heart block^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1237,0)
 ;;=activities that increase risk^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1238,0)
 ;;=feelings of embarrassment, regression^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1239,0)
 ;;=active isometric pelvic exercises [ ]times per [ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1239,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1239,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1240,0)
 ;;=teach anterior and posterior pelvic floor muscle exercises^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1240,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1240,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1241,0)
 ;;=teach to start/stop stream several times during voiding^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1241,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1241,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1242,0)
 ;;=monitor for Lidocaine toxicity^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1242,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1242,1,1,0)
 ;;=1243^petit or grand mal seizures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1242,1,2,0)
 ;;=1244^drowsiness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1242,1,3,0)
 ;;=1245^lethargy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1242,1,4,0)
 ;;=1246^behavioral changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1242,4)
 ;;=assess and
 ;;^UTILITY("^GMRD(124.2,",$J,1242,5)
 ;;=and document the following:
 ;;^UTILITY("^GMRD(124.2,",$J,1242,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1242,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1242,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1243,0)
 ;;=petit or grand mal seizures^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1244,0)
 ;;=drowsiness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1245,0)
 ;;=lethargy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1246,0)
 ;;=behavioral changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1247,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^32^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1247,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1247,1,1,0)
 ;;=1255^mechanical trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1247,1,2,0)
 ;;=210^neuromuscular impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1247,1,3,0)
 ;;=1256^sensory motor impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1247,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1248,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^30^1^^T
