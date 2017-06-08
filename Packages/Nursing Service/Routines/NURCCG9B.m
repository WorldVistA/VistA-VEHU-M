NURCCG9B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4902,1,2,0)
 ;;=2009^threat of death^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4902,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4903,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^242^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4903,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4903,1,1,0)
 ;;=4947^[Extra Goal]^3^NURSC^290
 ;;^UTILITY("^GMRD(124.2,",$J,4903,1,2,0)
 ;;=4948^[Extra Goal]^3^NURSC^291
 ;;^UTILITY("^GMRD(124.2,",$J,4903,1,3,0)
 ;;=4951^[Extra Goal]^3^NURSC^292
 ;;^UTILITY("^GMRD(124.2,",$J,4903,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4905,0)
 ;;=hemodynamically stable^2^NURSC^9^2^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4905,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4905,1,1,0)
 ;;=4909^B/P q[frequency]^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4905,1,2,0)
 ;;=4387^pulse [specify range] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4905,1,3,0)
 ;;=4388^respirations [specify range]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4905,1,4,0)
 ;;=4914^temperature=[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4905,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4905,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4905,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4906,0)
 ;;=assess presenting behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4906,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4906,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4907,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^243^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4907,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4907,1,1,0)
 ;;=4911^anxiety signs and symptoms decrease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4907,1,2,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4907,1,3,0)
 ;;=5037^[Extra Goal]^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,4907,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4908,0)
 ;;=[Extra Goal]^3^NURSC^9^287^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4908,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4908,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4909,0)
 ;;=B/P q[frequency]^3^NURSC^^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4911,0)
 ;;=anxiety signs and symptoms decrease^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4911,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4911,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4913,0)
 ;;=[Extra Goal]^3^NURSC^9^288^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4913,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4913,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4914,0)
 ;;=temperature=[specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4915,0)
 ;;=[Extra Goal]^3^NURSC^9^222^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4915,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4915,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4916,0)
 ;;=[Extra Goal]^3^NURSC^9^10^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4916,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4916,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4917,0)
 ;;=[Extra Goal]^3^NURSC^9^289^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4917,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4917,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4918,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^242^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4918,1,0)
 ;;=^124.21PI^2^4
 ;;^UTILITY("^GMRD(124.2,",$J,4918,1,1,0)
 ;;=2037^use active listening techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4918,1,2,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4918,1,3,0)
 ;;=4465^position for comfort,mobilize secretions,ventilation q[freq]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4918,1,4,0)
 ;;=5008^[Extra Order]^3^NURSC^33
