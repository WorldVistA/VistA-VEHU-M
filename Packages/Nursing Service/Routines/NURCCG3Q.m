NURCCG3Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,9,0)
 ;;=3170^teach safety precautions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,10,0)
 ;;=3173^assess understanding of prescribed medication q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,11,0)
 ;;=3179^teach medication self-administration^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,12,0)
 ;;=3181^support use of devices to facilitate mobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,13,0)
 ;;=3182^limit activities as identified by medical evaluation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,14,0)
 ;;=3183^maintain/increase mobility by [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,15,0)
 ;;=3184^support patient/family in process of viewing limitations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,16,0)
 ;;=3185^teach patient safe transfers from bed to W/C to commode^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,17,0)
 ;;=3186^encourage participation in Blind Rehabilitation Program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,18,0)
 ;;=3187^teach healthy food choices/preparation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,19,0)
 ;;=3188^teach diabetic management^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1318,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1319,0)
 ;;=altered sensory reception, transmission, and/or integration^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1320,0)
 ;;=altered communication^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1321,0)
 ;;=neurologic disease, trauma, or deficit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1322,0)
 ;;=sleep deprivation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1323,0)
 ;;=age related: visual, auditory, gustatory^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1324,0)
 ;;=disease of sensory end organs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1325,0)
 ;;=peripheral neuropathy: age related^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1326,0)
 ;;=diabetes (disease related)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1327,0)
 ;;=alcohol (disease related)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1328,0)
 ;;=vascular (disease related)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1329,0)
 ;;=supports autonomy^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1329,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1329,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1330,0)
 ;;=adapts home environment to reduce risk of injury^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1330,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1330,1,1,0)
 ;;=2678^lighting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1330,1,2,0)
 ;;=2679^rugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1330,1,3,0)
 ;;=2680^waxed floors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1330,1,4,0)
 ;;=2681^grab bars^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1330,1,5,0)
 ;;=2682^decrease noise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1330,5)
 ;;=specific to:
 ;;^UTILITY("^GMRD(124.2,",$J,1330,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1330,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1330,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1331,0)
 ;;=uses optimal pain control measures ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1331,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1331,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1332,0)
 ;;=assess level of functioning q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1332,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1332,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1333,0)
 ;;=determine if intervention necessary and implement^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1333,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1333,10)
 ;;=D EN1^NURCCPU3
