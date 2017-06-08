NURCCG02 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/28/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,0)
 ;;=^124.21PI^24^24
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,1,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,2,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,3,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,4,0)
 ;;=853^Substance Abuse, Alcohol^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,5,0)
 ;;=854^Substance Abuse, Drugs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,6,0)
 ;;=749^Social Isolation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,7,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,8,0)
 ;;=751^Family Processes, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,9,0)
 ;;=829^Post Trauma Response^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,10,0)
 ;;=743^Grieving, Anticipatory^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,11,0)
 ;;=744^Grieving, Dysfunctional^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,12,0)
 ;;=746^Depressive Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,13,0)
 ;;=1832^Manic Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,14,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,15,0)
 ;;=748^Violence Potential, Directed At Others^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,16,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,17,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,18,0)
 ;;=752^Diversional Activity Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,19,0)
 ;;=3054^Decisional Conflict [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,20,0)
 ;;=3080^Coping, Defensive^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,21,0)
 ;;=3107^Fatigue^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,22,0)
 ;;=3134^Ineffective Denial^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,23,0)
 ;;=3231^Hopelessness^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13,1,24,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14,0)
 ;;=Spiritual Needs^2^NURSC^3^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,14,1,1,0)
 ;;=558^Spiritual Distress^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,15,0)
 ;;=Health Maintenance, Alteration in^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15,1,1,0)
 ;;=17^Etiology/Related and/or Risk Factors^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,15,1,2,0)
 ;;=18^Goals/Expected Outcomes^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,15,1,3,0)
 ;;=19^Nursing Intervention/Orders^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,15,1,4,0)
 ;;=145^Related Problems^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,15,1,5,0)
 ;;=4136^Defining Characteristics^2^NURSC^20
 ;;^UTILITY("^GMRD(124.2,",$J,15,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15,"TD",0)
 ;;=^^1^1^2890404^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,15,"TD",1,0)
 ;;=Inability to identify, manage, and/or seek help to maintain health.
 ;;^UTILITY("^GMRD(124.2,",$J,16,0)
 ;;=Knowledge Deficit [specify]^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,16,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,16,1,1,0)
 ;;=158^Etiology/Related and/or Risk Factors^2^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,16,1,2,0)
 ;;=166^Goals/Expected Outcomes^2^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,16,1,3,0)
 ;;=168^Nursing Intervention/Orders^2^NURSC^89^0
 ;;^UTILITY("^GMRD(124.2,",$J,16,1,4,0)
 ;;=4268^Defining Characteristics^2^NURSC^46
 ;;^UTILITY("^GMRD(124.2,",$J,16,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,16,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,16,10)
 ;;=D EN3^NURCCPU1
