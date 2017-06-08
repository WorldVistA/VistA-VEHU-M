NURCCGEU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,4,0)
 ;;=13814^decreased urinary output^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,5,0)
 ;;=1191^hematuria^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,6,0)
 ;;=15337^positive blood/urine culture^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13816,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13816,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13816,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13817,0)
 ;;=tachycardia and tachypnea^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13826,0)
 ;;=Related Problems^2^NURSC^7^158^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,1,0)
 ;;=1412^Urinary Retention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,2,0)
 ;;=1413^Incontinence, Urine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,3,0)
 ;;=1408^Stress Incontinence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,4,0)
 ;;=1409^Infection Potential (Specific to Elimination)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,5,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,6,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,1,7,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13826,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,0)
 ;;=Defining Characteristics^2^NURSC^12^161^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,1,0)
 ;;=4319^flow of urine occurs at unpredictable times w/o distention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,2,0)
 ;;=4320^unsuccessful incontinence refractory treatments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,3,0)
 ;;=4088^nocturia (more than 2 instances per night)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,4,0)
 ;;=4321^urinary urgency; frequency (voiding more often than q2h)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,5,0)
 ;;=4324^voiding in small amounts (less than 100cc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,6,0)
 ;;=4325^voiding in large amounts (greater than 550cc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,7,0)
 ;;=4326^unable to reach toilet in time to void^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,8,0)
 ;;=4327^bladder contractures/spasms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,1,9,0)
 ;;=4328^dysuria, hesitance, incontinence, retention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13841,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13874,0)
 ;;=Pain, Acute^2^NURSC^2^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13874,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13874,1,1,0)
 ;;=13877^Etiology/Related and/or Risk Factors^2^NURSC^186
 ;;^UTILITY("^GMRD(124.2,",$J,13874,1,2,0)
 ;;=13907^Goals/Expected Outcomes^2^NURSC^183
 ;;^UTILITY("^GMRD(124.2,",$J,13874,1,3,0)
 ;;=13932^Nursing Intervention/Orders^2^NURSC^198
 ;;^UTILITY("^GMRD(124.2,",$J,13874,1,4,0)
 ;;=13952^Related Problems^2^NURSC^159
 ;;^UTILITY("^GMRD(124.2,",$J,13874,1,5,0)
 ;;=13963^Defining Characteristics^2^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,13874,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13874,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13874,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13874,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,13874,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,13874,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,13877,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^186^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,0)
 ;;=^124.21PI^16^8
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,1,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13877,1,2,0)
 ;;=2777^immobility^3^NURSC^1
