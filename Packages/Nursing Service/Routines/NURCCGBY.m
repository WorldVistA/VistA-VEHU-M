NURCCGBY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9048,1,0)
 ;;=^124.21PI^8^3
 ;;^UTILITY("^GMRD(124.2,",$J,9048,1,3,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9048,1,6,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9048,1,8,0)
 ;;=422^tracheobronchial obstruction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9048,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9057,0)
 ;;=Related Problems^2^NURSC^7^105^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9057,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,9057,1,1,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9057,1,2,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9057,1,3,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9057,1,4,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9057,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9062,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^121^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9062,1,0)
 ;;=^124.21PI^12^4
 ;;^UTILITY("^GMRD(124.2,",$J,9062,1,2,0)
 ;;=423^establishes breathing pattern within normal rate^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9062,1,3,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9062,1,11,0)
 ;;=9180^[Extra Goal]^3^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,9062,1,12,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,9062,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9073,0)
 ;;=[Extra Goal]^3^NURSC^9^153^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9073,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9073,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^185^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,0)
 ;;=^124.21PI^39^9
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,31,0)
 ;;=9405^[Extra Order]^3^NURSC^160
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,32,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,33,0)
 ;;=4818^assess,monitor,document sputum color/consistancy/amount q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,34,0)
 ;;=16563^cough/turn/deep breathe q[specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,35,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,36,0)
 ;;=15680^assess,monitor,document use of incentive spirometry q[freq]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,37,0)
 ;;=15681^position for comfort,ventilation,drainage chest tube q[ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,38,0)
 ;;=849^up in chair q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,1,39,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9074,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9132,0)
 ;;=[Extra Order]^3^NURSC^11^156^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9132,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9132,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9133,0)
 ;;=Defining Characteristics^2^NURSC^12^108^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9133,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9133,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9133,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9133,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9133,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9133,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9133,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9139,0)
 ;;=Infection Potential^2^NURSC^2^5^1^^T
