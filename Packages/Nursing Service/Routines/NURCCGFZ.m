NURCCGFZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,3,0)
 ;;=451^identifies etiology^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,4,0)
 ;;=452^complies with treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,5,0)
 ;;=2691^has improved breath sounds^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,6,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,7,0)
 ;;=2692^has no signs of paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,8,0)
 ;;=2693^has no signs of respiratory alternans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,9,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,10,0)
 ;;=15034^hemodynamically stable^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,11,0)
 ;;=15267^[Extra Goal]^3^NURSC^255
 ;;^UTILITY("^GMRD(124.2,",$J,15024,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15034,0)
 ;;=hemodynamically stable^2^NURSC^9^8^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15034,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15034,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15034,1,2,0)
 ;;=2695^baseline B/P for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15034,1,3,0)
 ;;=281^skin color and temperature WNL for pt^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15034,1,4,0)
 ;;=4905^hemodynamically stable^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15034,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,15034,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15034,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15034,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15038,0)
 ;;=[Extra Goal]^3^NURSC^9^252^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15038,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15038,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^164^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,0)
 ;;=^124.21PI^34^29
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,5,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,6,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,7,0)
 ;;=453^CBC with differential q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,8,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,9,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,10,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,12,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,13,0)
 ;;=389^oxygen [numeric value]% per [flow rate]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,14,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,15,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,16,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,17,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15039,1,18,0)
 ;;=384^weight q[frequency]^3^NURSC^1
