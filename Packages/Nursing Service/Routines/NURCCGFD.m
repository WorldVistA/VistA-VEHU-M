NURCCGFD ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,1,0)
 ;;=4277^dependency needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,2,0)
 ;;=2115^low frustration tolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,3,0)
 ;;=4278^poor self insight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,4,0)
 ;;=2062^low self-esteem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,5,0)
 ;;=4281^impaired occupational functions(impulsive,manipulative,etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,6,0)
 ;;=4282^impaired social functioning (traffic accidents,arrests,etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,7,0)
 ;;=4283^physical problems (infections, malnutrition, etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,1,8,0)
 ;;=4287^interpersonal difficulties^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14349,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14364,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14364,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14364,1,1,0)
 ;;=14365^Etiology/Related and/or Risk Factors^2^NURSC^192
 ;;^UTILITY("^GMRD(124.2,",$J,14364,1,2,0)
 ;;=14374^Related Problems^2^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,14364,1,3,0)
 ;;=14379^Goals/Expected Outcomes^2^NURSC^189
 ;;^UTILITY("^GMRD(124.2,",$J,14364,1,4,0)
 ;;=14391^Nursing Intervention/Orders^2^NURSC^199
 ;;^UTILITY("^GMRD(124.2,",$J,14364,1,5,0)
 ;;=14463^Defining Characteristics^2^NURSC^169
 ;;^UTILITY("^GMRD(124.2,",$J,14364,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14364,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14364,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14364,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,14364,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,14364,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,14365,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^192^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,1,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,2,0)
 ;;=420^decreased energy and fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,4,0)
 ;;=209^musculoskeletal impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,5,0)
 ;;=210^neuromuscular impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,6,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,7,0)
 ;;=308^perceptual/cognitive impairment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,1,8,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14365,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14374,0)
 ;;=Related Problems^2^NURSC^7^165^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14374,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14374,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14374,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14374,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14374,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14374,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14379,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^189^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14379,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,14379,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14379,1,2,0)
 ;;=423^establishes breathing pattern within normal rate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14379,1,3,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
