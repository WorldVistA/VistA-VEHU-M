NURCCG0E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,141,0)
 ;;=external locus of control^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,142,0)
 ;;=health beliefs (lack of perceived health threat)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,143,0)
 ;;=inaccessibility to adequate health care services^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,144,0)
 ;;=religious beliefs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,145,0)
 ;;=Related Problems^2^NURSC^7^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,145,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,145,1,1,0)
 ;;=644^home maintenance management, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,145,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,145,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,146,0)
 ;;=specific diseases^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,147,0)
 ;;=susceptibility, e.g., presence of risk factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,148,0)
 ;;=value of early detection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,149,0)
 ;;=promote wellness through past patterns of health care^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,149,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,149,1,1,0)
 ;;=155^expectations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,149,1,2,0)
 ;;=156^interaction with health care system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,149,1,3,0)
 ;;=157^influences of family, cultural/peer groups, mass media^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,149,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,149,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,149,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,149,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,150,0)
 ;;=discuss role of nutrition^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,150,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,150,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,151,0)
 ;;=discuss role of exercise^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,151,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,151,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,152,0)
 ;;=discuss role of safety measures^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,152,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,152,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,153,0)
 ;;=discuss role of stress management^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,153,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,153,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,154,0)
 ;;=discuss role of social support systems^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,154,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,154,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,155,0)
 ;;=expectations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,156,0)
 ;;=interaction with health care system^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,157,0)
 ;;=influences of family, cultural/peer groups, mass media^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,158,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^6^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,1,0)
 ;;=159^cognitive limitation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,2,0)
 ;;=160^information misinterpretation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,3,0)
 ;;=161^lack of exposure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,4,0)
 ;;=162^lack of recall^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,5,0)
 ;;=163^lack of interest in learning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,6,0)
 ;;=164^patient's request for no information^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,158,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,159,0)
 ;;=cognitive limitation^3^NURSC^^1^^^T
