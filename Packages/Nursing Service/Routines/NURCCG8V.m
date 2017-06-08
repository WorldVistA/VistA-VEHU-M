NURCCG8V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4707,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4707,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4708,0)
 ;;=maintains baseline sinus rhythm^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4708,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4708,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4709,0)
 ;;=initiates consults to [specify] service^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4709,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4709,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4711,0)
 ;;=[Extra Goal]^3^NURSC^9^119^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4711,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4711,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4712,0)
 ;;=monitor electrolytes as available^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4712,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4712,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4713,0)
 ;;=implement health teaching protocol^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4713,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4713,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4714,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^224^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,1,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,2,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,4,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,5,0)
 ;;=4430^assess heart sounds q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,6,0)
 ;;=4719^assess,monitor,document assistance with ADL q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,7,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,8,0)
 ;;=4438^monitor lab values^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,9,0)
 ;;=4563^initiate lethal dysrhythmia protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,1,10,0)
 ;;=4812^[Extra Order]^3^NURSC^217
 ;;^UTILITY("^GMRD(124.2,",$J,4714,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4714,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4715,0)
 ;;=[Extra Order]^3^NURSC^11^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4715,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4715,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4719,0)
 ;;=assess,monitor,document assistance with ADL q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4719,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4719,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4720,0)
 ;;=[Extra Order]^3^NURSC^11^216^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4720,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4720,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4721,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^220^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4721,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4721,1,1,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4721,1,2,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4721,1,3,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4721,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4722,0)
 ;;=attains,maintains resp rate,pattern & breath sounds WNL/pt ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4722,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4722,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4724,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^225^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4724,1,0)
 ;;=^124.21PI^2^2
