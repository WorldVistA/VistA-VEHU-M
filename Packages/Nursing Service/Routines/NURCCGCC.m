NURCCGCC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9662,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9662,5)
 ;;=see:
 ;;^UTILITY("^GMRD(124.2,",$J,9662,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9669,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^129^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9669,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,9669,1,2,0)
 ;;=9671^maintains nutritional intake to meet metabolic requirements^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9669,1,3,0)
 ;;=9678^decreased complaints of nausea or discomfort^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9669,1,4,0)
 ;;=9710^[Extra Goal]^3^NURSC^162
 ;;^UTILITY("^GMRD(124.2,",$J,9669,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,0)
 ;;=maintains nutritional intake to meet metabolic requirements^2^NURSC^9^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,9671,1,1,0)
 ;;=2553^stable weight greater than [specify] lbs/kgs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,1,2,0)
 ;;=2554^stable weight less than [specify] lbs/kgs ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,1,3,0)
 ;;=2555^daily intake of [number of] calories^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,1,6,0)
 ;;=2558^absence of negative nitrogen balance indicators^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,9671,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9671,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9671,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9678,0)
 ;;=decreased complaints of nausea or discomfort^3^NURSC^9^4^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,9678,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9678,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9683,0)
 ;;=Coping, Ineffective Family^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9683,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9683,1,1,0)
 ;;=9686^Etiology/Related and/or Risk Factors^2^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,9683,1,2,0)
 ;;=9699^Goals/Expected Outcomes^2^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,9683,1,3,0)
 ;;=9712^Nursing Intervention/Orders^2^NURSC^111
 ;;^UTILITY("^GMRD(124.2,",$J,9683,1,4,0)
 ;;=9746^Related Problems^2^NURSC^113
 ;;^UTILITY("^GMRD(124.2,",$J,9683,1,5,0)
 ;;=9759^Defining Characteristics^2^NURSC^115
 ;;^UTILITY("^GMRD(124.2,",$J,9683,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9683,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9683,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9683,"TD",0)
 ;;=^^5^5^2901126^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9683,"TD",1,0)
 ;;=A usually supportive primary person (family member or close friend)
 ;;^UTILITY("^GMRD(124.2,",$J,9683,"TD",2,0)
 ;;=is providing insufficient, ineffective, or compromised support,
 ;;^UTILITY("^GMRD(124.2,",$J,9683,"TD",3,0)
 ;;=comfort, assistance, or encouragement that may be needed by the 
 ;;^UTILITY("^GMRD(124.2,",$J,9683,"TD",4,0)
 ;;=client to manage or master adaptive tasks related to the client's
 ;;^UTILITY("^GMRD(124.2,",$J,9683,"TD",5,0)
 ;;=health challenge.
 ;;^UTILITY("^GMRD(124.2,",$J,9684,0)
 ;;=[Extra Goal]^3^NURSC^9^161^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9684,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9684,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9685,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^110^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,0)
 ;;=^124.21PI^19^13
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,1,0)
 ;;=9688^initiate oral hygiene protocol^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,2,0)
 ;;=9690^status of oral mucous membranes^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,4,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9685,1,5,0)
 ;;=9697^administer antiemetics [specify]^3^NURSC^4
