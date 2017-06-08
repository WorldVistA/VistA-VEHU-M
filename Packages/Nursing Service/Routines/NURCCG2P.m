NURCCG2P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",0)
 ;;=^^7^7^2890307^^^
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",1,0)
 ;;=A state which involves pathological use of a drug(s) that is charac-
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",2,0)
 ;;=terized by:
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",3,0)
 ;;=  1) frequent need and use of drugs for personal functioning,
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",4,0)
 ;;=  2) difficulty in reducing or stopping the amount of drugs used,
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",5,0)
 ;;=  3) periodic unsuccessful efforts to stop drugs, and
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",6,0)
 ;;=  4) frequent use of drug(s) causing impairment in functioning for at
 ;;^UTILITY("^GMRD(124.2,",$J,854,"TD",7,0)
 ;;=     least one month.
 ;;^UTILITY("^GMRD(124.2,",$J,855,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^20^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,1,0)
 ;;=859^environmental changes, social cues^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,2,0)
 ;;=861^illness, psychologic stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,3,0)
 ;;=2473^discomfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,4,0)
 ;;=2474^apnea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,5,0)
 ;;=2475^personal stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,855,1,6,0)
 ;;=2476^family stress^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,855,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,856,0)
 ;;=Related Problems^2^NURSC^7^16^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,856,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,856,1,1,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,856,1,2,0)
 ;;=1418^Comfort, Alteration In: Acute Pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,856,1,3,0)
 ;;=1419^Comfort, Alteration In: Chronic Pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,856,1,4,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,856,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,857,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^19^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,1,0)
 ;;=862^identifies techniques to fall asleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,2,0)
 ;;=863^falls asleep within one hour of going to bed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,3,0)
 ;;=864^sleeps for 90 minute period without awakening^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,4,0)
 ;;=865^sleeps for 4-5 hours without awakening^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,5,0)
 ;;=866^sleeps 7-9 hours without awakening^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,6,0)
 ;;=867^falls asleep within minutes if awakened^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,7,0)
 ;;=868^states feels rested after sleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,8,0)
 ;;=869^states feels less tense, less anxious after sleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,9,0)
 ;;=2467^has decreased S/S of sleep-pattern disturbance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,10,0)
 ;;=2468^verbalizes improved ability to perform activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,11,0)
 ;;=2469^verbalizes less trouble falling asleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,12,0)
 ;;=2470^has less complaints of early awakening^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,13,0)
 ;;=2471^has less complaints of sleep pattern reversal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,14,0)
 ;;=2472^has less complaints of interrupted sleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,1,15,0)
 ;;=2884^[Extra Goal]^3^NURSC^61^0
 ;;^UTILITY("^GMRD(124.2,",$J,857,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,858,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^16^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,0)
 ;;=^124.21PI^17^17
