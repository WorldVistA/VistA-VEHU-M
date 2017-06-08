NURCCGG1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15143,1,2,0)
 ;;=2431^chest pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15143,1,3,0)
 ;;=306^obstruction, tracheobronchial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15143,5)
 ;;=due to:
 ;;^UTILITY("^GMRD(124.2,",$J,15143,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15147,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^197^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,0)
 ;;=^124.21PI^8^7
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,1,0)
 ;;=548^normal sputum production^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,2,0)
 ;;=15149^states actions to prevent cross infection^3^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,3,0)
 ;;=550^intact mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,4,0)
 ;;=551^optimal weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,5,0)
 ;;=552^optimal fluid balance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,7,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15147,1,8,0)
 ;;=15400^[Extra Goal]^3^NURSC^256
 ;;^UTILITY("^GMRD(124.2,",$J,15147,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15149,0)
 ;;=states actions to prevent cross infection^3^NURSC^9^11^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15149,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15149,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15157,0)
 ;;=[Extra Goal]^3^NURSC^9^253^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15157,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15157,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^165^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,0)
 ;;=^124.21PI^22^20
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,1,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,2,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,3,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,4,0)
 ;;=495^culture sputum [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,5,0)
 ;;=334^pulmonary toilet q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,7,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,8,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,9,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,10,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,11,0)
 ;;=497^provide humidity q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,12,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,13,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,15,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,18,0)
 ;;=15652^[Extra Order]^3^NURSC^264
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,19,0)
 ;;=388^sputum culture as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,20,0)
 ;;=4650^activity: chair q[frequency] or ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,21,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15158,1,22,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15158,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15188,0)
 ;;=[Extra Order]^3^NURSC^11^259^^^T
