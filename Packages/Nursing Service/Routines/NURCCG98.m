NURCCG98 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,7,0)
 ;;=2841^maintain upright position [# of] minutes after eating/TF^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,8,0)
 ;;=4931^[Extra Order]^3^NURSC^25
 ;;^UTILITY("^GMRD(124.2,",$J,4867,1,9,0)
 ;;=2629^oral hygiene before and after feedings^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4867,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4867,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4868,0)
 ;;=[Extra Goal]^3^NURSC^9^284^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4868,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4868,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4869,0)
 ;;=[Extra Goal]^3^NURSC^9^285^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4869,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4869,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4871,0)
 ;;=[Extra Goal]^3^NURSC^9^286^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4871,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4871,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4872,0)
 ;;=[Extra Order]^3^NURSC^11^291^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4872,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4872,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4873,0)
 ;;=assess,monitor,document ability to swallow q [frequency ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4873,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4873,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4874,0)
 ;;=[Extra Order]^3^NURSC^11^292^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4874,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4874,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4875,0)
 ;;=[Extra Order]^3^NURSC^11^293^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4875,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4875,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4876,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^233^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4876,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^238^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,1,0)
 ;;=4890^controls impulsive behavior dictated by psychosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,2,0)
 ;;=4892^identifies psychotic thoughts^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,3,0)
 ;;=2179^initiates conversation with staff or other patients^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,4,0)
 ;;=2180^makes thoughts understandable to others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,5,0)
 ;;=2181^maintains good personal hygiene and grooming each morning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,6,0)
 ;;=4898^communicates to staff feelings of loss of control^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4877,1,7,0)
 ;;=4901^[Extra Goal]^3^NURSC^221
 ;;^UTILITY("^GMRD(124.2,",$J,4877,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^239^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,1,0)
 ;;=4906^assess presenting behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,2,0)
 ;;=2311^assist pt. in identifying anxiety/its relation to behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,3,0)
 ;;=2314^determine amount of control pt. has over hallucinations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,4,0)
 ;;=2315^develop plan with pt. to report impulsive behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,5,0)
 ;;=2329^encourage reality testing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,6,0)
 ;;=2343^encourage verbalization of feelings^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4878,1,7,0)
 ;;=2350^interact with patient [specify] minutes/day^2^NURSC^1
