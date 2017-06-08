NURCCGDB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11394,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11394,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11397,0)
 ;;=emphasize avoidance of:^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,1,0)
 ;;=11398^stress^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,2,0)
 ;;=11399^tobacco use^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,3,0)
 ;;=1043^injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,4,0)
 ;;=15609^crossing legs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,5,0)
 ;;=15610^restrictive clothing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11397,1,6,0)
 ;;=15611^cold extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11397,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11397,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11397,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11398,0)
 ;;=stress^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11399,0)
 ;;=tobacco use^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11402,0)
 ;;=use mild cleansing agent for bathing^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11402,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11402,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11412,0)
 ;;=teach pt & S/O S/S of hypo/hyperglycemia^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11412,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11412,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11426,0)
 ;;=inspect at risk areas of skin for breakdown q[specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11426,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11426,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11427,0)
 ;;=[Extra Order]^3^NURSC^11^187^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11427,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11427,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11428,0)
 ;;=Defining Characteristics^2^NURSC^12^132^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,1,0)
 ;;=4306^claudication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,2,0)
 ;;=4307^diminished arterial pulsation, BP changes in extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,4,0)
 ;;=4311^skin of extremity blue or purple when dependent^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,5,0)
 ;;=4312^leg becomes pale on elevation and remains pale when lowered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,6,0)
 ;;=4313^skin quality shining and without hair^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,1,7,0)
 ;;=4314^skin temperature cold extremities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11428,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11436,0)
 ;;=Pain, Chronic^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11436,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11436,1,1,0)
 ;;=11437^Etiology/Related and/or Risk Factors^2^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,11436,1,2,0)
 ;;=11454^Goals/Expected Outcomes^2^NURSC^152
 ;;^UTILITY("^GMRD(124.2,",$J,11436,1,3,0)
 ;;=11459^Nursing Intervention/Orders^2^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,11436,1,4,0)
 ;;=11469^Related Problems^2^NURSC^133
 ;;^UTILITY("^GMRD(124.2,",$J,11436,1,5,0)
 ;;=11546^Defining Characteristics^2^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,11436,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11436,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11436,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11436,"TD",0)
 ;;=^^1^1^2890802^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,11436,"TD",1,0)
 ;;=A state of discomfort that continues for more than 6 months in duration.
 ;;^UTILITY("^GMRD(124.2,",$J,11437,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^154^1^^T^1
