NURCCGFY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14981,1,8,0)
 ;;=4766^vibrations q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14981,1,9,0)
 ;;=4767^cough/turn/deep breathe q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14981,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14981,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14981,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14996,0)
 ;;=encourage self-expression^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14996,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14996,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15005,0)
 ;;=[Extra Order]^3^NURSC^11^257^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15005,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15005,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15006,0)
 ;;=Defining Characteristics^2^NURSC^12^175^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15006,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15006,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15006,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15006,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15006,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15006,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15006,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15012,0)
 ;;=discuss importance of maintaining drug schedule (eye drops)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15012,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15012,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15013,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15013,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15013,1,1,0)
 ;;=15014^Etiology/Related and/or Risk Factors^2^NURSC^199
 ;;^UTILITY("^GMRD(124.2,",$J,15013,1,2,0)
 ;;=15019^Related Problems^2^NURSC^170
 ;;^UTILITY("^GMRD(124.2,",$J,15013,1,3,0)
 ;;=15024^Goals/Expected Outcomes^2^NURSC^196
 ;;^UTILITY("^GMRD(124.2,",$J,15013,1,4,0)
 ;;=15039^Nursing Intervention/Orders^2^NURSC^164
 ;;^UTILITY("^GMRD(124.2,",$J,15013,1,5,0)
 ;;=15109^Defining Characteristics^2^NURSC^176
 ;;^UTILITY("^GMRD(124.2,",$J,15013,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15013,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15013,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15013,"TD",0)
 ;;=^^3^3^2910822^^
 ;;^UTILITY("^GMRD(124.2,",$J,15013,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,15013,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,15013,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,15014,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^199^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15014,1,0)
 ;;=^124.21PI^4^1
 ;;^UTILITY("^GMRD(124.2,",$J,15014,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15014,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15019,0)
 ;;=Related Problems^2^NURSC^7^170^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15019,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15019,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15019,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15019,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15019,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15019,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15024,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^196^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15024,1,0)
 ;;=^124.21PI^11^11
