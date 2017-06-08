NURCCGBZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9139,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,9139,1,1,0)
 ;;=9140^Etiology/Related and/or Risk Factors^2^NURSC^124
 ;;^UTILITY("^GMRD(124.2,",$J,9139,1,2,0)
 ;;=9170^Goals/Expected Outcomes^2^NURSC^122
 ;;^UTILITY("^GMRD(124.2,",$J,9139,1,3,0)
 ;;=9181^Nursing Intervention/Orders^2^NURSC^104
 ;;^UTILITY("^GMRD(124.2,",$J,9139,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9139,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9139,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9139,"TD",0)
 ;;=^^2^2^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,9139,"TD",1,0)
 ;;=The state in which an individual is at increased risk for being invaded
 ;;^UTILITY("^GMRD(124.2,",$J,9139,"TD",2,0)
 ;;=by pathogenic organisms.
 ;;^UTILITY("^GMRD(124.2,",$J,9140,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^124^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9140,1,0)
 ;;=^124.21PI^7^2
 ;;^UTILITY("^GMRD(124.2,",$J,9140,1,3,0)
 ;;=1163^invasive procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9140,1,7,0)
 ;;=483^medical procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9140,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9170,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^122^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9170,1,0)
 ;;=^124.21PI^8^4
 ;;^UTILITY("^GMRD(124.2,",$J,9170,1,1,0)
 ;;=9171^free of S/S chest tube site infection^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,9170,1,3,0)
 ;;=9173^free of S/S of pulmonary infection^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,9170,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9170,1,8,0)
 ;;=9256^[Extra Goal]^3^NURSC^155
 ;;^UTILITY("^GMRD(124.2,",$J,9170,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9171,0)
 ;;=free of S/S chest tube site infection^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9171,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9171,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9173,0)
 ;;=free of S/S of pulmonary infection^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9173,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9173,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9180,0)
 ;;=[Extra Goal]^3^NURSC^9^154^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9180,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9180,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^104^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,0)
 ;;=^124.21PI^23^6
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,18,0)
 ;;=9509^[Extra Order]^3^NURSC^161
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,19,0)
 ;;=15687^monitor CT insertion site/integrity of drainage system q[ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,20,0)
 ;;=15688^monitor color, consistency, amount of CT drainage q[ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,21,0)
 ;;=1877^aseptic dressing change q [frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,22,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,1,23,0)
 ;;=1610^initiate febrile protocol^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9181,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9211,0)
 ;;=[Extra Order]^3^NURSC^11^157^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9211,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9211,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9212,0)
 ;;=Coping, Ineffective Individual^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9212,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9212,1,1,0)
 ;;=9213^Etiology/Related and/or Risk Factors^2^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,9212,1,2,0)
 ;;=9235^Goals/Expected Outcomes^2^NURSC^123
 ;;^UTILITY("^GMRD(124.2,",$J,9212,1,3,0)
 ;;=9259^Nursing Intervention/Orders^2^NURSC^105
