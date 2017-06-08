NURCCGCL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9957,0)
 ;;=Related Problems^2^NURSC^7^115^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9957,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,9957,1,1,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9957,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,9957,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9959,0)
 ;;=Defining Characteristics^2^NURSC^12^117^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9959,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,9959,1,1,0)
 ;;=4263^cognitive, effective, and psychomotor factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9959,1,2,0)
 ;;=4265^integrative dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9959,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9963,0)
 ;;=Pain, Acute^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9963,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9963,1,1,0)
 ;;=9964^Etiology/Related and/or Risk Factors^2^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,9963,1,2,0)
 ;;=9982^Goals/Expected Outcomes^2^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,9963,1,3,0)
 ;;=9992^Nursing Intervention/Orders^2^NURSC^187
 ;;^UTILITY("^GMRD(124.2,",$J,9963,1,4,0)
 ;;=10009^Related Problems^2^NURSC^116
 ;;^UTILITY("^GMRD(124.2,",$J,9963,1,5,0)
 ;;=10020^Defining Characteristics^2^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,9963,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9963,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9963,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9963,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9963,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,9963,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,9964,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^136^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9964,1,0)
 ;;=^124.21PI^11^4
 ;;^UTILITY("^GMRD(124.2,",$J,9964,1,1,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9964,1,2,0)
 ;;=2777^immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9964,1,3,0)
 ;;=2778^inflammation injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9964,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9964,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9982,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^134^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9982,1,0)
 ;;=^124.21PI^9^5
 ;;^UTILITY("^GMRD(124.2,",$J,9982,1,1,0)
 ;;=2789^verbalizes when in pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9982,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9982,1,7,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9982,1,8,0)
 ;;=2796^verbalizes comfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9982,1,9,0)
 ;;=10054^[Extra Goal]^3^NURSC^167
 ;;^UTILITY("^GMRD(124.2,",$J,9982,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9991,0)
 ;;=[Extra Goal]^3^NURSC^9^166^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9991,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9991,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^187^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,0)
 ;;=^124.21PI^16^7
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,8,0)
 ;;=2827^teach the purpose and use of analgesics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,11,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9992,1,15,0)
 ;;=628^teach relaxation techniques^3^NURSC^1
