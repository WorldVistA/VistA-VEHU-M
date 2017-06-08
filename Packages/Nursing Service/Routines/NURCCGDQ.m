NURCCGDQ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11978,0)
 ;;=provide supplemental feedings at [specify]am and [specify]pm^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11978,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11978,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12000,0)
 ;;=teach techniques to enhance nutritional content of foods^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12000,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12000,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12004,0)
 ;;=[Extra Order]^3^NURSC^11^193^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12004,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12004,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12007,0)
 ;;=Defining Characteristics^2^NURSC^12^140^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12007,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12007,1,1,0)
 ;;=12012^body weight 20% or more under ideal^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12007,1,2,0)
 ;;=12014^reported food intake under RDA^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12007,1,3,0)
 ;;=12015^reported/observed lack of food^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12007,1,4,0)
 ;;=12017^sore/inflammed bucal cavity^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12007,1,5,0)
 ;;=12018^lack of interest in food^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12007,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12012,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12014,0)
 ;;=reported food intake under RDA^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12015,0)
 ;;=reported/observed lack of food^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12017,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12018,0)
 ;;=lack of interest in food^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12032,0)
 ;;=refer for appropriate consults^2^NURSC^11^59^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,12032,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12032,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12032,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12041,0)
 ;;=Infection Potential^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12041,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12041,1,1,0)
 ;;=12043^Etiology/Related and/or Risk Factors^2^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,12041,1,2,0)
 ;;=12080^Goals/Expected Outcomes^2^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,12041,1,3,0)
 ;;=12091^Nursing Intervention/Orders^2^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,12041,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12041,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12041,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12041,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,12041,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,12041,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,12042,0)
 ;;=[Extra Order]^3^NURSC^11^194^^^T
