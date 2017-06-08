NURCCG0C ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,123,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,123,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,124,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,124,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,124,1,1,0)
 ;;=443^Etiology/Related and/or Risk Factors^2^NURSC^10^0
 ;;^UTILITY("^GMRD(124.2,",$J,124,1,2,0)
 ;;=444^Related Problems^2^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,124,1,3,0)
 ;;=445^Goals/Expected Outcomes^2^NURSC^10^0
 ;;^UTILITY("^GMRD(124.2,",$J,124,1,4,0)
 ;;=446^Nursing Intervention/Orders^2^NURSC^7^0
 ;;^UTILITY("^GMRD(124.2,",$J,124,1,5,0)
 ;;=4098^Defining Characteristics^2^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,124,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,124,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,124,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,124,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,124,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,124,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,124,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,125,0)
 ;;=Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,125,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,125,"TD",1,0)
 ;;=A state of reduced respiratory effort; reduced alveolar ventilation.
 ;;^UTILITY("^GMRD(124.2,",$J,126,0)
 ;;=Hypoxia (see Gas Exchange, Impaired)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,126,"TD",0)
 ;;=^^3^3^2890803^^
 ;;^UTILITY("^GMRD(124.2,",$J,126,"TD",1,0)
 ;;=A state wherein a physiologically inadequate amount of oxygen is
 ;;^UTILITY("^GMRD(124.2,",$J,126,"TD",2,0)
 ;;=available to, or utilized by, tissue without respect to cause or
 ;;^UTILITY("^GMRD(124.2,",$J,126,"TD",3,0)
 ;;=degree.
 ;;^UTILITY("^GMRD(124.2,",$J,127,0)
 ;;=Infection Potential (Specific to Respiratory System)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,127,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,127,1,1,0)
 ;;=467^Etiology/Related and/or Risk Factors^2^NURSC^11^0
 ;;^UTILITY("^GMRD(124.2,",$J,127,1,2,0)
 ;;=468^Goals/Expected Outcomes^2^NURSC^11^0
 ;;^UTILITY("^GMRD(124.2,",$J,127,1,3,0)
 ;;=469^Nursing Intervention/Orders^2^NURSC^8^0
 ;;^UTILITY("^GMRD(124.2,",$J,127,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,127,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,127,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,127,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,127,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,127,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,128,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,128,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,128,1,1,0)
 ;;=132^bed rest or immobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,128,1,2,0)
 ;;=133^generalized weakness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,128,1,3,0)
 ;;=134^imbalance between oxygen supply and demand^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,128,1,4,0)
 ;;=135^sedentary life-style^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,128,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,129,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,1,0)
 ;;=275^verbalizes/demonstrates decreased fatigue with activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,2,0)
 ;;=276^demonstrates increased control of dyspnea with activity^3^NURSC^1^0
