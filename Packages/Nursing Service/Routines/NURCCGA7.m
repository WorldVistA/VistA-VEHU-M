NURCCGA7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5873,0)
 ;;=[Extra Order]^3^NURSC^11^121^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5873,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5873,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5874,0)
 ;;=Related Problems^2^NURSC^7^70^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5874,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5874,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5874,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5874,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5874,1,4,0)
 ;;=822^constipation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5874,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5874,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,5874,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,0)
 ;;=Defining Characteristics^2^NURSC^12^75^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5880,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5880,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5886,0)
 ;;=Activity Intolerance^2^NURSC^2^2^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5886,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5886,1,1,0)
 ;;=5887^Etiology/Related and/or Risk Factors^2^NURSC^82
 ;;^UTILITY("^GMRD(124.2,",$J,5886,1,2,0)
 ;;=5892^Goals/Expected Outcomes^2^NURSC^81
 ;;^UTILITY("^GMRD(124.2,",$J,5886,1,3,0)
 ;;=5903^Nursing Intervention/Orders^2^NURSC^75
 ;;^UTILITY("^GMRD(124.2,",$J,5886,1,4,0)
 ;;=5943^Related Problems^2^NURSC^71
 ;;^UTILITY("^GMRD(124.2,",$J,5886,1,5,0)
 ;;=5948^Defining Characteristics^2^NURSC^76
 ;;^UTILITY("^GMRD(124.2,",$J,5886,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5886,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5886,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5886,"TD",0)
 ;;=^^3^3^2890623^^^
 ;;^UTILITY("^GMRD(124.2,",$J,5886,"TD",1,0)
 ;;=A state in which an individual has insufficient physiological or
 ;;^UTILITY("^GMRD(124.2,",$J,5886,"TD",2,0)
 ;;=psychological energy to endure or complete required or desired
 ;;^UTILITY("^GMRD(124.2,",$J,5886,"TD",3,0)
 ;;=daily activities.
 ;;^UTILITY("^GMRD(124.2,",$J,5887,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^82^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5887,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5887,1,1,0)
 ;;=132^bed rest or immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5887,1,2,0)
 ;;=133^generalized weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5887,1,3,0)
 ;;=134^imbalance between oxygen supply and demand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5887,1,4,0)
 ;;=135^sedentary life-style^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5887,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5892,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^81^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5892,1,0)
 ;;=^124.21PI^6^2
 ;;^UTILITY("^GMRD(124.2,",$J,5892,1,1,0)
 ;;=275^verbalizes/demonstrates decreased fatigue with activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5892,1,6,0)
 ;;=5902^[Extra Goal]^3^NURSC^83
 ;;^UTILITY("^GMRD(124.2,",$J,5892,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5902,0)
 ;;=[Extra Goal]^3^NURSC^9^83^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5902,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5902,10)
 ;;=D EN2^NURCCPU1
