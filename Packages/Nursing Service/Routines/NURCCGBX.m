NURCCGBX ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8955,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8965,0)
 ;;=hemodynamically stable^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8965,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8965,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8965,1,2,0)
 ;;=2695^baseline B/P for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8965,1,3,0)
 ;;=7604^skin color and texture WNL for pt^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,8965,1,4,0)
 ;;=15666^respirations q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,8965,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,8965,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8965,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8965,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8969,0)
 ;;=[Extra Goal]^3^NURSC^9^152^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8969,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8969,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8970,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^103^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8970,1,0)
 ;;=^124.21PI^39^5
 ;;^UTILITY("^GMRD(124.2,",$J,8970,1,31,0)
 ;;=9352^[Extra Order]^3^NURSC^159
 ;;^UTILITY("^GMRD(124.2,",$J,8970,1,32,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,8970,1,33,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8970,1,34,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8970,1,39,0)
 ;;=15491^monitor laboratory values:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8970,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8970,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9039,0)
 ;;=[Extra Order]^3^NURSC^11^155^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9039,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9039,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9040,0)
 ;;=Defining Characteristics^2^NURSC^12^107^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9040,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9047,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9047,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9047,1,1,0)
 ;;=9048^Etiology/Related and/or Risk Factors^2^NURSC^123
 ;;^UTILITY("^GMRD(124.2,",$J,9047,1,2,0)
 ;;=9057^Related Problems^2^NURSC^105
 ;;^UTILITY("^GMRD(124.2,",$J,9047,1,3,0)
 ;;=9062^Goals/Expected Outcomes^2^NURSC^121
 ;;^UTILITY("^GMRD(124.2,",$J,9047,1,4,0)
 ;;=9074^Nursing Intervention/Orders^2^NURSC^185
 ;;^UTILITY("^GMRD(124.2,",$J,9047,1,5,0)
 ;;=9133^Defining Characteristics^2^NURSC^108
 ;;^UTILITY("^GMRD(124.2,",$J,9047,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9047,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9047,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9047,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,9047,"TD",1,0)
 ;;=A state in which an individual's inhalation and/or exhalation pattern
 ;;^UTILITY("^GMRD(124.2,",$J,9047,"TD",2,0)
 ;;=does not enable adequate inflation or emptying.
 ;;^UTILITY("^GMRD(124.2,",$J,9048,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^123^1^^T^1
