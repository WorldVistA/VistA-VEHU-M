NURCCGBG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7921,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7953,0)
 ;;=[Extra Order]^3^NURSC^11^145^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7953,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7953,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7954,0)
 ;;=Defining Characteristics^2^NURSC^12^97^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7954,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,7954,1,1,0)
 ;;=4303^damaged or destroyed tissue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7954,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7956,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7956,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7956,1,1,0)
 ;;=7957^Etiology/Related and/or Risk Factors^2^NURSC^111
 ;;^UTILITY("^GMRD(124.2,",$J,7956,1,2,0)
 ;;=7966^Related Problems^2^NURSC^94
 ;;^UTILITY("^GMRD(124.2,",$J,7956,1,3,0)
 ;;=7971^Goals/Expected Outcomes^2^NURSC^109
 ;;^UTILITY("^GMRD(124.2,",$J,7956,1,4,0)
 ;;=7983^Nursing Intervention/Orders^2^NURSC^183
 ;;^UTILITY("^GMRD(124.2,",$J,7956,1,5,0)
 ;;=8043^Defining Characteristics^2^NURSC^98
 ;;^UTILITY("^GMRD(124.2,",$J,7956,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7956,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7956,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7956,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,7956,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,7956,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,7957,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^111^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7957,1,0)
 ;;=^124.21PI^10^2
 ;;^UTILITY("^GMRD(124.2,",$J,7957,1,9,0)
 ;;=4685^anesthesia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7957,1,10,0)
 ;;=4686^midline incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7957,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7966,0)
 ;;=Related Problems^2^NURSC^7^94^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7966,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,7966,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7966,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7966,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7966,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7966,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7971,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^109^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7971,1,0)
 ;;=^124.21PI^14^3
 ;;^UTILITY("^GMRD(124.2,",$J,7971,1,3,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7971,1,11,0)
 ;;=8075^[Extra Goal]^3^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,7971,1,14,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,7971,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7982,0)
 ;;=[Extra Goal]^3^NURSC^9^143^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7982,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7982,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7983,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^183^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7983,1,0)
 ;;=^124.21PI^35^4
 ;;^UTILITY("^GMRD(124.2,",$J,7983,1,32,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7983,1,33,0)
 ;;=4768^turn,cough,deep breath q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7983,1,34,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7983,1,35,0)
 ;;=8398^[Extra Order]^3^NURSC^149
