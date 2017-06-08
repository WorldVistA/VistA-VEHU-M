NURCCGEV ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,3,0)
 ;;=2778^inflammation injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,4,0)
 ;;=2779^ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,8,0)
 ;;=2783^physical activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,9,0)
 ;;=2784^procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,16,0)
 ;;=972^stress and anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^183^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,1,0)
 ;;=13912^verbalizes measures to relieve pain^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,3,0)
 ;;=2791^identifies factors that influence pain experience^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,5,0)
 ;;=2793^demonstrates use of pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,6,0)
 ;;=2794^patient/S.O. administers medications appropriately^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,7,0)
 ;;=5364^verbalizes decrease in frequency, pain, urgency, nocturia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,8,0)
 ;;=2796^verbalizes comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13907,1,9,0)
 ;;=14134^[Extra Goal]^3^NURSC^242
 ;;^UTILITY("^GMRD(124.2,",$J,13907,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13912,0)
 ;;=verbalizes measures to relieve pain^3^NURSC^9^12^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13912,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13912,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13929,0)
 ;;=[Extra Goal]^3^NURSC^9^239^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13929,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13929,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^198^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,0)
 ;;=^124.21PI^16^14
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,1,0)
 ;;=2797^assess pain episode using 0 (no) to 10 (worst) scale^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,3,0)
 ;;=2799^monitor stimulus responses to pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,5,0)
 ;;=2803^support verbalization of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,7,0)
 ;;=13942^position patient to minimize pain during voiding^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,8,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,10,0)
 ;;=13945^explain etiology of pain^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,12,0)
 ;;=2857^teach breathing exercises to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,13,0)
 ;;=2858^teach distraction techniques to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,14,0)
 ;;=13949^administer antibiotic therapy [specify]^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,15,0)
 ;;=13950^teach strategies to relieve pain/discomfort^3^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,13932,1,16,0)
 ;;=14333^[Extra Order]^3^NURSC^250
 ;;^UTILITY("^GMRD(124.2,",$J,13932,7)
 ;;=D EN4^NURCCPU1
