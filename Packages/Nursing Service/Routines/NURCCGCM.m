NURCCGCM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,16,0)
 ;;=10378^[Extra Order]^3^NURSC^173
 ;;^UTILITY("^GMRD(124.2,",$J,9992,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10008,0)
 ;;=[Extra Order]^3^NURSC^11^169^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10008,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10008,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10009,0)
 ;;=Related Problems^2^NURSC^7^116^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10009,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,0)
 ;;=Defining Characteristics^2^NURSC^12^118^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10020,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10020,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10021,0)
 ;;=Pain (Acute) Related to Surgical Procedure^2^NURSC^2^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10021,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10021,1,1,0)
 ;;=10023^Etiology/Related and/or Risk Factors^2^NURSC^137
 ;;^UTILITY("^GMRD(124.2,",$J,10021,1,2,0)
 ;;=10045^Goals/Expected Outcomes^2^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,10021,1,3,0)
 ;;=10055^Nursing Intervention/Orders^2^NURSC^188
 ;;^UTILITY("^GMRD(124.2,",$J,10021,1,4,0)
 ;;=10072^Related Problems^2^NURSC^117
 ;;^UTILITY("^GMRD(124.2,",$J,10021,1,5,0)
 ;;=10083^Defining Characteristics^2^NURSC^119
 ;;^UTILITY("^GMRD(124.2,",$J,10021,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10021,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10021,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10021,"TD",0)
 ;;=^^2^2^2910829^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,10021,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,10021,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,10023,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^137^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,0)
 ;;=^124.21PI^17^6
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,10,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,12,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,13,0)
 ;;=2152^fear^3^NURSC^1
