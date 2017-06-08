NURCCG2M ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,817,0)
 ;;=utilize devices [specify] to facilitate mobility^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,817,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,817,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,818,0)
 ;;=limit activities as set by medical protocols & as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,818,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,818,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,819,0)
 ;;=skin integrity, impairment of^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,820,0)
 ;;=tissue perfusion, alteration in ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,821,0)
 ;;=gas exchange, impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,822,0)
 ;;=constipation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,823,0)
 ;;=injury, potential for^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,824,0)
 ;;=alteration in skin turgor (change in elasticity)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,825,0)
 ;;=mechanical factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,826,0)
 ;;=physical immobilization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,827,0)
 ;;=radiation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,828,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^19^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,828,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,828,1,1,0)
 ;;=824^alteration in skin turgor (change in elasticity)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,828,1,2,0)
 ;;=825^mechanical factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,828,1,3,0)
 ;;=826^physical immobilization^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,828,1,4,0)
 ;;=827^radiation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,828,1,5,0)
 ;;=1778^altered nutritional state (e.g. obesity,emaciation)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,828,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,829,0)
 ;;=Post Trauma Response^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,829,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,829,1,1,0)
 ;;=2065^Etiology/Related and/or Risk Factors^2^NURSC^56^0
 ;;^UTILITY("^GMRD(124.2,",$J,829,1,2,0)
 ;;=2075^Related Problems^2^NURSC^43^0
 ;;^UTILITY("^GMRD(124.2,",$J,829,1,3,0)
 ;;=2081^Goals/Expected Outcomes^2^NURSC^55^0
 ;;^UTILITY("^GMRD(124.2,",$J,829,1,4,0)
 ;;=2147^Nursing Intervention/Orders^2^NURSC^52^0
 ;;^UTILITY("^GMRD(124.2,",$J,829,1,5,0)
 ;;=4068^Defining Characteristics^2^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,829,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,829,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,829,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,829,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,829,"TD",1,0)
 ;;=The state of an individual experiencing a sustained painful response
 ;;^UTILITY("^GMRD(124.2,",$J,829,"TD",2,0)
 ;;=to (an) overwhelming traumatic event(s).
 ;;^UTILITY("^GMRD(124.2,",$J,830,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^18^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,1,0)
 ;;=833^maintains intact skin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,2,0)
 ;;=834^maintains normal skin color and temperature^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,3,0)
 ;;=835^identifies relevant risk factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,4,0)
 ;;=836^verbalizes preventive measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,5,0)
 ;;=2688^demonstrates ability to do self assessment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,830,1,6,0)
 ;;=2883^[Extra Goal]^3^NURSC^60^0
 ;;^UTILITY("^GMRD(124.2,",$J,830,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,831,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^15^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,0)
 ;;=^124.21PI^12^12
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,1,0)
 ;;=839^perform skin assessment q[frequency]^3^NURSC^1^0
