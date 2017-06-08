NURCCGFL ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14578,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14578,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14579,0)
 ;;=[Extra Goal]^3^NURSC^9^399^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14579,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14579,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14582,0)
 ;;=[Extra Goal]^3^NURSC^9^400^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14582,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14582,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14584,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^304^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14584,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14584,1,1,0)
 ;;=14586^[Extra Order]^3^NURSC^405
 ;;^UTILITY("^GMRD(124.2,",$J,14584,1,2,0)
 ;;=14589^[Extra Order]^3^NURSC^406
 ;;^UTILITY("^GMRD(124.2,",$J,14584,1,3,0)
 ;;=14590^[Extra Order]^3^NURSC^407
 ;;^UTILITY("^GMRD(124.2,",$J,14584,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14584,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14586,0)
 ;;=[Extra Order]^3^NURSC^11^405^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14586,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14586,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14588,0)
 ;;=hemodynamically stable^2^NURSC^9^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14588,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14588,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14588,1,2,0)
 ;;=2695^baseline B/P for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14588,1,3,0)
 ;;=281^skin color and temperature WNL for pt^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14588,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,14588,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14588,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14588,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14589,0)
 ;;=[Extra Order]^3^NURSC^11^406^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14589,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14589,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14590,0)
 ;;=[Extra Order]^3^NURSC^11^407^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14590,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14590,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14594,0)
 ;;=[Extra Goal]^3^NURSC^9^247^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14594,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14594,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^160^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,0)
 ;;=^124.21PI^31^31
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,4,0)
 ;;=14599^respiratory pattern q [frequency]^2^NURSC^29
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,5,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,6,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,7,0)
 ;;=453^CBC with differential q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,8,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,9,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,10,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,12,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
