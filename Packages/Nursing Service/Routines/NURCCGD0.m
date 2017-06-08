NURCCGD0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10805,1,4,0)
 ;;=10832^Nursing Intervention/Orders^2^NURSC^190
 ;;^UTILITY("^GMRD(124.2,",$J,10805,1,5,0)
 ;;=10891^Defining Characteristics^2^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,10805,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10805,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10805,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10805,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,10805,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,10805,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,10806,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^147^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,1,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,2,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,4,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,5,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,6,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,7,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,1,8,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10806,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10815,0)
 ;;=Related Problems^2^NURSC^7^127^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10815,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,10815,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10815,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10815,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10815,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10815,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10820,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^145^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,0)
 ;;=^124.21PI^11^7
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,3,0)
 ;;=10823^free of respiratory infections^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,5,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,6,0)
 ;;=10826^verbalizes reportable signs/symptoms ^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,7,0)
 ;;=10827^able to perform/direct cough/deep breathing exercises^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,8,0)
 ;;=10828^requests breathing assistance when needed^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,10,0)
 ;;=10830^verbalizes causative factors for respiratory difficulty^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,10820,1,11,0)
 ;;=11035^[Extra Goal]^3^NURSC^180
 ;;^UTILITY("^GMRD(124.2,",$J,10820,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10823,0)
 ;;=free of respiratory infections^3^NURSC^9^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10823,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10823,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10826,0)
 ;;=verbalizes reportable signs/symptoms ^3^NURSC^9^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10826,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10826,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10827,0)
 ;;=able to perform/direct cough/deep breathing exercises^3^NURSC^9^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10827,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10827,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10828,0)
 ;;=requests breathing assistance when needed^3^NURSC^9^6^^^T
