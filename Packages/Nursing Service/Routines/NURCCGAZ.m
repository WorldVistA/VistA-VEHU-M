NURCCGAZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7247,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,7248,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^102^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7248,1,0)
 ;;=^124.21PI^18^4
 ;;^UTILITY("^GMRD(124.2,",$J,7248,1,8,0)
 ;;=2783^physical activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7248,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7248,1,17,0)
 ;;=2784^procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7248,1,18,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7248,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7266,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^101^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,0)
 ;;=^124.21PI^11^7
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,2,0)
 ;;=7268^reports decrease in pain after interventions used^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,5,0)
 ;;=7271^accepts pain medication as prescribed^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,6,0)
 ;;=7272^exhibits decrease physical & behaviorial signs of pain^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,7,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,9,0)
 ;;=7453^[Extra Goal]^3^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,7266,1,11,0)
 ;;=4905^hemodynamically stable^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7266,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7268,0)
 ;;=reports decrease in pain after interventions used^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7268,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7268,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7271,0)
 ;;=accepts pain medication as prescribed^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7271,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7271,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7272,0)
 ;;=exhibits decrease physical & behaviorial signs of pain^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7272,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7272,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7275,0)
 ;;=[Extra Goal]^3^NURSC^9^135^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7275,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7275,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7276,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^180^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,0)
 ;;=^124.21PI^16^7
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,1,0)
 ;;=2797^assess pain episode using 0 (no) to 10 (worst) scale^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,3,0)
 ;;=7279^assess patient's behavioral response to pain^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,5,0)
 ;;=7281^identify/encourage ways of avoiding/minimizing pain^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7276,1,16,0)
 ;;=7292^[Extra Order]^3^NURSC^138
 ;;^UTILITY("^GMRD(124.2,",$J,7276,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7276,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7279,0)
 ;;=assess patient's behavioral response to pain^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7279,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7279,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7281,0)
 ;;=identify/encourage ways of avoiding/minimizing pain^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7281,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7281,10)
 ;;=D EN1^NURCCPU3
