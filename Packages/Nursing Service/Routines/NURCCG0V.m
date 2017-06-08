NURCCG0V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,339,"TD",2,0)
 ;;=sufficiently reduced so that it is inadequate to meet the needs of
 ;;^UTILITY("^GMRD(124.2,",$J,339,"TD",3,0)
 ;;=the body's tissues.
 ;;^UTILITY("^GMRD(124.2,",$J,340,0)
 ;;=Pain, Chest^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,340,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,340,1,1,0)
 ;;=887^Etiology/Related and/or Risk Factors^2^NURSC^22^0
 ;;^UTILITY("^GMRD(124.2,",$J,340,1,2,0)
 ;;=888^Goals/Expected Outcomes^2^NURSC^21^0
 ;;^UTILITY("^GMRD(124.2,",$J,340,1,3,0)
 ;;=890^Nursing Intervention/Orders^2^NURSC^18^0
 ;;^UTILITY("^GMRD(124.2,",$J,340,1,4,0)
 ;;=891^Related Problems^2^NURSC^18^0
 ;;^UTILITY("^GMRD(124.2,",$J,340,1,5,0)
 ;;=5362^Defining Characteristics^2^NURSC^65
 ;;^UTILITY("^GMRD(124.2,",$J,340,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,340,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,340,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,340,"TD",0)
 ;;=^^2^2^2911018^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,340,"TD",1,0)
 ;;=A state in which an individual experiences and reports the presence
 ;;^UTILITY("^GMRD(124.2,",$J,340,"TD",2,0)
 ;;=of severe discomfort or an uncomfortable sensation.
 ;;^UTILITY("^GMRD(124.2,",$J,341,0)
 ;;=Fluid Volume Excess (Actual/Potential)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,341,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,341,1,1,0)
 ;;=1508^Etiology/Related and/or Risk Factors^2^NURSC^39^0
 ;;^UTILITY("^GMRD(124.2,",$J,341,1,2,0)
 ;;=1512^Related Problems^2^NURSC^29^0
 ;;^UTILITY("^GMRD(124.2,",$J,341,1,3,0)
 ;;=1517^Goals/Expected Outcomes^2^NURSC^38^0
 ;;^UTILITY("^GMRD(124.2,",$J,341,1,4,0)
 ;;=1538^Nursing Intervention/Orders^2^NURSC^35^0
 ;;^UTILITY("^GMRD(124.2,",$J,341,1,5,0)
 ;;=4052^Defining Characteristics^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,341,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,341,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,341,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,341,"TD",0)
 ;;=^^2^2^2890802^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,341,"TD",1,0)
 ;;=The state in which an individual experiences increased fluid retention
 ;;^UTILITY("^GMRD(124.2,",$J,341,"TD",2,0)
 ;;=and edema.
 ;;^UTILITY("^GMRD(124.2,",$J,342,0)
 ;;=Hyperthermia^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,342,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,342,1,1,0)
 ;;=1618^Etiology/Related and/or Risk Factors^2^NURSC^42^0
 ;;^UTILITY("^GMRD(124.2,",$J,342,1,2,0)
 ;;=1627^Goals/Expected Outcomes^2^NURSC^41^0
 ;;^UTILITY("^GMRD(124.2,",$J,342,1,3,0)
 ;;=1633^Nursing Intervention/Orders^2^NURSC^38^0
 ;;^UTILITY("^GMRD(124.2,",$J,342,1,4,0)
 ;;=4220^Defining Characteristics^2^NURSC^34
 ;;^UTILITY("^GMRD(124.2,",$J,342,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,342,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,342,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,342,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,342,"TD",1,0)
 ;;=A state in which the individual is at risk because the body temperture
 ;;^UTILITY("^GMRD(124.2,",$J,342,"TD",2,0)
 ;;=is elevated above the individual's normal range.
 ;;^UTILITY("^GMRD(124.2,",$J,343,0)
 ;;=Hypothermia^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,343,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,343,1,1,0)
 ;;=1656^Etiology/Related and/or Risk Factors^2^NURSC^43^0
 ;;^UTILITY("^GMRD(124.2,",$J,343,1,2,0)
 ;;=1657^Goals/Expected Outcomes^2^NURSC^42^0
 ;;^UTILITY("^GMRD(124.2,",$J,343,1,3,0)
 ;;=1659^Nursing Intervention/Orders^2^NURSC^39^0
 ;;^UTILITY("^GMRD(124.2,",$J,343,1,4,0)
 ;;=4223^Defining Characteristics^2^NURSC^36
 ;;^UTILITY("^GMRD(124.2,",$J,343,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,343,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,343,10)
 ;;=D EN3^NURCCPU1
