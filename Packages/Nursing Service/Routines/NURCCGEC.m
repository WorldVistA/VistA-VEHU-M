NURCCGEC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12953,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12953,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12962,0)
 ;;=Defining Characteristics^2^NURSC^12^90^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12962,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12962,1,1,0)
 ;;=605^altered body structure or function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12962,1,2,0)
 ;;=4120^changed ability to estimate relationship of body/environmt^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12962,1,3,0)
 ;;=4127^missing body part^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12962,1,4,0)
 ;;=4132^inability to accept positive reinforcement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12962,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12970,0)
 ;;=Knowledge Deficit^2^NURSC^2^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12970,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12970,1,1,0)
 ;;=12971^Etiology/Related and/or Risk Factors^2^NURSC^174
 ;;^UTILITY("^GMRD(124.2,",$J,12970,1,2,0)
 ;;=12979^Related Problems^2^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,12970,1,3,0)
 ;;=12982^Goals/Expected Outcomes^2^NURSC^172
 ;;^UTILITY("^GMRD(124.2,",$J,12970,1,4,0)
 ;;=13005^Nursing Intervention/Orders^2^NURSC^146
 ;;^UTILITY("^GMRD(124.2,",$J,12970,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12970,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12970,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12970,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,12970,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,12971,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^174^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12971,1,0)
 ;;=^124.21PI^7^2
 ;;^UTILITY("^GMRD(124.2,",$J,12971,1,5,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12971,1,7,0)
 ;;=12978^disease management^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12971,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12978,0)
 ;;=disease management^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12979,0)
 ;;=Related Problems^2^NURSC^7^150^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12979,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,12979,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12979,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12979,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^172^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,0)
 ;;=^124.21PI^14^12
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,1,0)
 ;;=1677^recognizes knowledge deficit^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,2,0)
 ;;=1678^describes cardiovascular status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,3,0)
 ;;=1443^accepts therapeutic regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,4,0)
 ;;=1680^verbalizes anxiety is resolved^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,5,0)
 ;;=980^verbalizes medication regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,6,0)
 ;;=1681^maintains medication regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,9,0)
 ;;=1699^lists cardiac risk factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,10,0)
 ;;=1701^keeps clinic appointments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,11,0)
 ;;=1696^does not smoke^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,12,0)
 ;;=13242^[Extra Goal]^3^NURSC^231
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,13,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,1,14,0)
 ;;=2487^verbalizes knowledge of disease process & treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12982,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13002,0)
 ;;=[Extra Goal]^3^NURSC^9^207^^^T
