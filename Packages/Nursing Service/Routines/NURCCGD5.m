NURCCGD5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11095,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11101,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11101,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11101,1,1,0)
 ;;=11102^Etiology/Related and/or Risk Factors^2^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,11101,1,2,0)
 ;;=11107^Related Problems^2^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,11101,1,3,0)
 ;;=11112^Goals/Expected Outcomes^2^NURSC^148
 ;;^UTILITY("^GMRD(124.2,",$J,11101,1,4,0)
 ;;=11127^Nursing Intervention/Orders^2^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,11101,1,5,0)
 ;;=11197^Defining Characteristics^2^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,11101,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11101,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11101,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11101,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,11101,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,11101,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,11101,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,11102,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^150^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11102,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,11102,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11102,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11102,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11102,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11107,0)
 ;;=Related Problems^2^NURSC^7^130^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11107,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11107,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11107,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11107,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11107,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11107,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11112,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^148^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11112,1,0)
 ;;=^124.21PI^13^3
 ;;^UTILITY("^GMRD(124.2,",$J,11112,1,11,0)
 ;;=11306^[Extra Goal]^3^NURSC^183
 ;;^UTILITY("^GMRD(124.2,",$J,11112,1,12,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11112,1,13,0)
 ;;=4462^maintain fluid/electrolyte balance WNL for pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11112,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11126,0)
 ;;=[Extra Goal]^3^NURSC^9^181^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11126,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11126,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^124^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,0)
 ;;=^124.21PI^36^9
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,5,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,17,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,18,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,31,0)
 ;;=11568^[Extra Order]^3^NURSC^234
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,32,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,33,0)
 ;;=8183^monitor lab values^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,34,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11127,1,35,0)
 ;;=15503^initiate mechanical ventilator protocol^3^NURSC^1
