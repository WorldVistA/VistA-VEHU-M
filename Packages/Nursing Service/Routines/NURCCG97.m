NURCCG97 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4856,1,4,0)
 ;;=4289^weakness of muscles required for swallowing or mastication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4856,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4857,0)
 ;;=Thought Processes, Alteration in^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4857,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4857,1,1,0)
 ;;=4876^Etiology/Related and/or Risk Factors^2^NURSC^233
 ;;^UTILITY("^GMRD(124.2,",$J,4857,1,2,0)
 ;;=4877^Goals/Expected Outcomes^2^NURSC^238
 ;;^UTILITY("^GMRD(124.2,",$J,4857,1,3,0)
 ;;=4878^Nursing Intervention/Orders^2^NURSC^239
 ;;^UTILITY("^GMRD(124.2,",$J,4857,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4857,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4857,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4858,0)
 ;;=use of incentive spirometer q[freq]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4858,4)
 ;;=assess,monitor,document
 ;;^UTILITY("^GMRD(124.2,",$J,4858,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4858,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4859,0)
 ;;=Violence Potential, Directed at Others^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4859,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4859,1,1,0)
 ;;=4882^Etiology/Related and/or Risk Factors^2^NURSC^234
 ;;^UTILITY("^GMRD(124.2,",$J,4859,1,2,0)
 ;;=4883^Goals/Expected Outcomes^2^NURSC^239
 ;;^UTILITY("^GMRD(124.2,",$J,4859,1,3,0)
 ;;=4884^Nursing Intervention/Orders^2^NURSC^240
 ;;^UTILITY("^GMRD(124.2,",$J,4859,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4859,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4859,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4860,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^237^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4860,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4860,1,1,0)
 ;;=2618^demonstrates oral hygiene techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4860,1,2,0)
 ;;=2615^ingests p.o., [specify # of] calories q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4860,1,3,0)
 ;;=2616^maintains adequate nutritional status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4860,1,4,0)
 ;;=4993^[Extra Goal]^3^NURSC^34
 ;;^UTILITY("^GMRD(124.2,",$J,4860,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4862,0)
 ;;=[Extra Problem]^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4862,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4862,1,1,0)
 ;;=4885^Etiology/Related and/or Risk Factors^2^NURSC^235
 ;;^UTILITY("^GMRD(124.2,",$J,4862,1,2,0)
 ;;=4887^Goals/Expected Outcomes^2^NURSC^240
 ;;^UTILITY("^GMRD(124.2,",$J,4862,1,3,0)
 ;;=4889^Nursing Intervention/Orders^2^NURSC^241
 ;;^UTILITY("^GMRD(124.2,",$J,4862,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4862,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4862,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4863,0)
 ;;=[etiology]^3^NURSC^^14^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4864,0)
 ;;=[Extra Goal]^3^NURSC^9^21^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4864,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4864,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4865,0)
 ;;=[etiology]^3^NURSC^^15^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4866,0)
 ;;=[etiology]^3^NURSC^^16^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4867,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^238^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,0)
 ;;=^124.21PI^9^7
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,2,0)
 ;;=4873^assess,monitor,document ability to swallow q [frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,3,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,5,0)
 ;;=4879^monitor,document caloric intake q[freq]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,6,0)
 ;;=2631^feed slowly, assure previous bites swallowed^3^NURSC^1
