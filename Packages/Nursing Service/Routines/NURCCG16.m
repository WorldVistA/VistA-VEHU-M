NURCCG16 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,399,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,400,0)
 ;;=consider/discuss preventive measures^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,1,0)
 ;;=409^annual flu shot^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,2,0)
 ;;=410^pneumococcus vaccine^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,3,0)
 ;;=411^avoid others who have infections^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,4,0)
 ;;=412^eliminate inhaled irritants^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,5,0)
 ;;=413^compliance with prescribed treatment program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,400,1,6,0)
 ;;=414^avoidance of allergens specific to [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,400,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,400,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,401,0)
 ;;=postural drainage^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,402,0)
 ;;=humidification therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,403,0)
 ;;=use of expectorants^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,404,0)
 ;;=aerosol therapy q [frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,405,0)
 ;;=fluid intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,406,0)
 ;;=antibiotic therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,407,0)
 ;;=avoidance of respiratory irritants^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,408,0)
 ;;=contact health professional for assistance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,409,0)
 ;;=annual flu shot^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,410,0)
 ;;=pneumococcus vaccine^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,411,0)
 ;;=avoid others who have infections^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,412,0)
 ;;=eliminate inhaled irritants^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,413,0)
 ;;=compliance with prescribed treatment program^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,414,0)
 ;;=avoidance of allergens specific to [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,415,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,1,0)
 ;;=419^anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,2,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,4,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,5,0)
 ;;=210^neuromuscular impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,6,0)
 ;;=211^pain, discomfort^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,7,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,1,8,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,415,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,416,0)
 ;;=Related Problems^2^NURSC^7^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,416,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,416,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,416,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,416,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,416,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,416,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,417,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,2,0)
 ;;=423^establishes breathing pattern within normal rate^3^NURSC^1^0
