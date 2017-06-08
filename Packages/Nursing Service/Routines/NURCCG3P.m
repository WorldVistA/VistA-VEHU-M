NURCCG3P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1316,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^35^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,1,0)
 ;;=1319^altered sensory reception, transmission, and/or integration^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,2,0)
 ;;=1320^altered communication^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,3,0)
 ;;=1321^neurologic disease, trauma, or deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,4,0)
 ;;=1045^pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,5,0)
 ;;=1322^sleep deprivation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,6,0)
 ;;=1323^age related: visual, auditory, gustatory^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,7,0)
 ;;=1324^disease of sensory end organs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,8,0)
 ;;=1325^peripheral neuropathy: age related^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,9,0)
 ;;=1326^diabetes (disease related)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,10,0)
 ;;=1327^alcohol (disease related)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,1,11,0)
 ;;=1328^vascular (disease related)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1316,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1317,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^34^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,1,0)
 ;;=1329^supports autonomy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,2,0)
 ;;=1330^adapts home environment to reduce risk of injury^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,3,0)
 ;;=1331^uses optimal pain control measures ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,4,0)
 ;;=2677^reduce isolation with assistive/adaptive devices [example]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,5,0)
 ;;=2683^demonstrates ability to direct care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,6,0)
 ;;=2899^[Extra Goal]^3^NURSC^78^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,7,0)
 ;;=3156^increases self care ability [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,8,0)
 ;;=3157^evaluates environment for safety risks^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,9,0)
 ;;=3158^administer pharmacological agents as ordered/per protocol^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,10,0)
 ;;=3159^recognizes signs/symptoms of [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,11,0)
 ;;=3160^states interventions for complications of [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,12,0)
 ;;=3161^demonstrates health management strategies for [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,13,0)
 ;;=3162^identifies support system/resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,1,14,0)
 ;;=3163^conveys attitude of own worth/positive body image^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1317,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1318,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^31^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,0)
 ;;=^124.21PI^19^19
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,1,0)
 ;;=1332^assess level of functioning q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,2,0)
 ;;=1333^determine if intervention necessary and implement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,3,0)
 ;;=1334^determine and provide knowledge of health interventions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,4,0)
 ;;=2986^[Extra Order]^3^NURSC^71^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,5,0)
 ;;=169^assess knowledge base^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,6,0)
 ;;=3164^assess knowledge of health state^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,7,0)
 ;;=1084^assess level of understanding and decision making ability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1318,1,8,0)
 ;;=3169^provide protective environment^3^NURSC^1^0
