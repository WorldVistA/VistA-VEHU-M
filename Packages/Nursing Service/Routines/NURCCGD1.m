NURCCGD1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10828,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10828,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10830,0)
 ;;=verbalizes causative factors for respiratory difficulty^3^NURSC^9^8^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10830,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10830,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10831,0)
 ;;=[Extra Goal]^3^NURSC^9^178^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10831,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10831,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10832,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^190^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,0)
 ;;=^124.21PI^31^8
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,2,0)
 ;;=10834^promote pulmonary hygiene^3^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,5,0)
 ;;=10837^promote effective airway clearance^3^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,10,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,11,0)
 ;;=10845^teach quad cough^3^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,13,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,19,0)
 ;;=1147^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,29,0)
 ;;=4768^turn,cough,deep breath q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10832,1,31,0)
 ;;=11323^[Extra Order]^3^NURSC^186
 ;;^UTILITY("^GMRD(124.2,",$J,10832,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10832,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10834,0)
 ;;=promote pulmonary hygiene^3^NURSC^11^13^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10834,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10834,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10837,0)
 ;;=promote effective airway clearance^3^NURSC^11^16^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,10837,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10837,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10845,0)
 ;;=teach quad cough^3^NURSC^11^14^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10845,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10845,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10891,0)
 ;;=Defining Characteristics^2^NURSC^12^126^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10891,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10891,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10891,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10891,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10891,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10891,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10891,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10897,0)
 ;;=neurological changes during hypo/hyperglycemic episodes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10898,0)
 ;;=[Extra Problem]^2^NURSC^2^25^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,10898,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10898,1,1,0)
 ;;=10899^Etiology/Related and/or Risk Factors^2^NURSC^271
 ;;^UTILITY("^GMRD(124.2,",$J,10898,1,2,0)
 ;;=10903^Goals/Expected Outcomes^2^NURSC^283
 ;;^UTILITY("^GMRD(124.2,",$J,10898,1,3,0)
 ;;=10907^Nursing Intervention/Orders^2^NURSC^287
 ;;^UTILITY("^GMRD(124.2,",$J,10898,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10898,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10898,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10899,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^271^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10899,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10899,1,1,0)
 ;;=10901^[etiology]^3^NURSC^103
