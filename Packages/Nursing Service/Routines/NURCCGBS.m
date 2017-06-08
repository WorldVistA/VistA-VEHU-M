NURCCGBS ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8629,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,8629,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8629,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8629,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8638,0)
 ;;=skin color and texture WNL for pt^3^NURSC^9^149^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8638,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8638,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^99^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,0)
 ;;=^124.21PI^40^7
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,31,0)
 ;;=9132^[Extra Order]^3^NURSC^156
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,33,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,36,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,37,0)
 ;;=15358^provide,assess,monitor,document hydration & nutrition q[]hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,38,0)
 ;;=4858^use of incentive spirometer q[freq]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,39,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,1,40,0)
 ;;=15392^institute care of patient on mechanical ventilator protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8640,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8714,0)
 ;;=[Extra Order]^3^NURSC^11^152^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8714,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8714,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8715,0)
 ;;=Defining Characteristics^2^NURSC^12^104^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8715,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8722,0)
 ;;=Activity Intolerance^2^NURSC^2^4^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,8722,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8722,1,1,0)
 ;;=8723^Etiology/Related and/or Risk Factors^2^NURSC^119
 ;;^UTILITY("^GMRD(124.2,",$J,8722,1,2,0)
 ;;=8728^Goals/Expected Outcomes^2^NURSC^117
 ;;^UTILITY("^GMRD(124.2,",$J,8722,1,3,0)
 ;;=8739^Nursing Intervention/Orders^2^NURSC^100
 ;;^UTILITY("^GMRD(124.2,",$J,8722,1,4,0)
 ;;=8779^Related Problems^2^NURSC^101
 ;;^UTILITY("^GMRD(124.2,",$J,8722,1,5,0)
 ;;=8784^Defining Characteristics^2^NURSC^105
 ;;^UTILITY("^GMRD(124.2,",$J,8722,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8722,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8722,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8722,"TD",0)
 ;;=^^3^3^2890623^^^
 ;;^UTILITY("^GMRD(124.2,",$J,8722,"TD",1,0)
 ;;=A state in which an individual has insufficient physiological or
 ;;^UTILITY("^GMRD(124.2,",$J,8722,"TD",2,0)
 ;;=psychological energy to endure or complete required or desired
 ;;^UTILITY("^GMRD(124.2,",$J,8722,"TD",3,0)
 ;;=daily activities.
 ;;^UTILITY("^GMRD(124.2,",$J,8723,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^119^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8723,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,8723,1,2,0)
 ;;=133^generalized weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8723,1,3,0)
 ;;=134^imbalance between oxygen supply and demand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8723,7)
 ;;=D EN4^NURCCPU1
