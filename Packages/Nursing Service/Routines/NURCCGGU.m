NURCCGGU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,18,0)
 ;;=768^perceptual deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,19,0)
 ;;=15785^self-care deficit (hygiene, elimination)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,20,0)
 ;;=98^substance abuse^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,1,21,0)
 ;;=15786^suspected abuse/neglect^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15772,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^318^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,0)
 ;;=^124.21PI^25^25
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,1,0)
 ;;=15787^accepts assistance with meeting health needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,2,0)
 ;;=15788^communicates within capacity, demonstrates comprehension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,3,0)
 ;;=15789^demonstrates required skill/knowledge from pt ed [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,4,0)
 ;;=15790^establishes/maintains supportive, nurturing relationships^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,5,0)
 ;;=2489^follows treatment regime^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,6,0)
 ;;=15791^identifies coping methods to deal with chronic pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,7,0)
 ;;=2490^maintains or regains ability for self-care in ADL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,8,0)
 ;;=15792^maintains or regains optimal level of health^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,9,0)
 ;;=31^maintains or regains optimal level of mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,10,0)
 ;;=15796^manages stressors without resorting to violent behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,11,0)
 ;;=15797^participates in D/C plans for use of community resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,12,0)
 ;;=15798^participates in D/C plans for supervised care setting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,13,0)
 ;;=15799^recognizes anxiety & uses coping skills to reduce/manage it^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,14,0)
 ;;=15800^remains/regains orientation to time, place and person^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,15,0)
 ;;=15801^selects appropriate coping methods for activity intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,16,0)
 ;;=15802^verbalizes community resources needed to maintain sobriety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,17,0)
 ;;=15803^verbalizes intent to follow health regime post discharge^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,18,0)
 ;;=15804^verbalizes minimal discomfort or absence of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,19,0)
 ;;=15805^verbalizes post discharge instructions from patient teaching^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,20,0)
 ;;=15806^verbalizes sense of reality^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,21,0)
 ;;=15807^verbalizes understanding of adequate nutrition/fluid intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,22,0)
 ;;=15808^verbalizes understanding of potential safety hazards^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,23,0)
 ;;=15809^verbalizes use of preventive safety measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,24,0)
 ;;=10182^identifies S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15773,1,25,0)
 ;;=15811^[Extra Goal]^3^NURSC^262
 ;;^UTILITY("^GMRD(124.2,",$J,15773,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^320^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,0)
 ;;=^124.21PI^34^33
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,1,0)
 ;;=34^assess causative factors on admission^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,2,0)
 ;;=15814^assess deficits/capabilities to determine D/C needs^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,3,0)
 ;;=15820^assess for proper use of assistive devices for mobility^3^NURSC^1
