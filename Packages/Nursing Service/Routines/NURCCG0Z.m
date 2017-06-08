NURCCG0Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,355,1,1,0)
 ;;=1158^Etiology/Related and/or Risk Factors^2^NURSC^30^0
 ;;^UTILITY("^GMRD(124.2,",$J,355,1,2,0)
 ;;=1159^Goals/Expected Outcomes^2^NURSC^28^0
 ;;^UTILITY("^GMRD(124.2,",$J,355,1,3,0)
 ;;=1160^Nursing Intervention/Orders^2^NURSC^25^0
 ;;^UTILITY("^GMRD(124.2,",$J,355,1,4,0)
 ;;=1161^Related Problems^2^NURSC^22^0
 ;;^UTILITY("^GMRD(124.2,",$J,355,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,355,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,355,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,355,"TD",0)
 ;;=^^2^2^2890302^^
 ;;^UTILITY("^GMRD(124.2,",$J,355,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,355,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,356,0)
 ;;=Stress Incontinence^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,356,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,356,1,1,0)
 ;;=1211^Etiology/Related and/or Risk Factors^2^NURSC^31^0
 ;;^UTILITY("^GMRD(124.2,",$J,356,1,2,0)
 ;;=1212^Goals/Expected Outcomes^2^NURSC^29^0
 ;;^UTILITY("^GMRD(124.2,",$J,356,1,3,0)
 ;;=1213^Nursing Intervention/Orders^2^NURSC^26^0
 ;;^UTILITY("^GMRD(124.2,",$J,356,1,4,0)
 ;;=1214^Related Problems^2^NURSC^23^0
 ;;^UTILITY("^GMRD(124.2,",$J,356,1,5,0)
 ;;=4092^Defining Characteristics^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,356,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,356,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,356,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,356,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,356,"TD",1,0)
 ;;=The state in which an individual experiences an involuntary passage of
 ;;^UTILITY("^GMRD(124.2,",$J,356,"TD",2,0)
 ;;=urine.
 ;;^UTILITY("^GMRD(124.2,",$J,357,0)
 ;;=Urinary Elimination, Alteration In Pattern^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,357,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,357,1,1,0)
 ;;=1247^Etiology/Related and/or Risk Factors^2^NURSC^32^0
 ;;^UTILITY("^GMRD(124.2,",$J,357,1,2,0)
 ;;=1248^Goals/Expected Outcomes^2^NURSC^30^0
 ;;^UTILITY("^GMRD(124.2,",$J,357,1,3,0)
 ;;=1249^Nursing Intervention/Orders^2^NURSC^27^0
 ;;^UTILITY("^GMRD(124.2,",$J,357,1,4,0)
 ;;=1251^Related Problems^2^NURSC^24^0
 ;;^UTILITY("^GMRD(124.2,",$J,357,1,5,0)
 ;;=4316^Defining Characteristics^2^NURSC^55
 ;;^UTILITY("^GMRD(124.2,",$J,357,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,357,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,357,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,357,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,357,"TD",1,0)
 ;;=The state in which the individual experiences a disturbance in
 ;;^UTILITY("^GMRD(124.2,",$J,357,"TD",2,0)
 ;;=urine elimination.
 ;;^UTILITY("^GMRD(124.2,",$J,358,0)
 ;;=Urinary Retention^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,358,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,358,1,1,0)
 ;;=1363^Etiology/Related and/or Risk Factors^2^NURSC^36^0
 ;;^UTILITY("^GMRD(124.2,",$J,358,1,2,0)
 ;;=1364^Goals/Expected Outcomes^2^NURSC^35^0
 ;;^UTILITY("^GMRD(124.2,",$J,358,1,3,0)
 ;;=1365^Nursing Intervention/Orders^2^NURSC^32^0
 ;;^UTILITY("^GMRD(124.2,",$J,358,1,4,0)
 ;;=1366^Related Problems^2^NURSC^26^0
 ;;^UTILITY("^GMRD(124.2,",$J,358,1,5,0)
 ;;=4329^Defining Characteristics^2^NURSC^54
 ;;^UTILITY("^GMRD(124.2,",$J,358,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,358,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,358,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,358,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,358,"TD",1,0)
 ;;=The state in which the individual experiences incomplete emptying
 ;;^UTILITY("^GMRD(124.2,",$J,358,"TD",2,0)
 ;;=of the bladder.
 ;;^UTILITY("^GMRD(124.2,",$J,359,0)
 ;;=Infection Potential (Specific to Integumentary System)^2^NURSC^2^1^1^^T
