NURCCG0D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,3,0)
 ;;=277^demonstrates increased independence for self-care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,4,0)
 ;;=278^hemodynamically stable during activity^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,5,0)
 ;;=2648^verbalizes/demonstrates physical conditioning techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,129,1,6,0)
 ;;=2870^[Extra Goal]^3^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,129,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,130,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,1,0)
 ;;=282^assess for signs of fatigue and weakness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,2,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,3,0)
 ;;=284^administer bronchodilators as ordered^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,4,0)
 ;;=285^plan activities to maximize medication/treatment benefits^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,5,0)
 ;;=286^provide [number of] minutes of rest between activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,6,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,7,0)
 ;;=288^initiate muscle strengthening/conditioning as indiciated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,8,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,9,0)
 ;;=290^teach patient^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,10,0)
 ;;=2654^skin color/texture during activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,11,0)
 ;;=2655^respiratory rate during activities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,12,0)
 ;;=427^respiratory pattern q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,13,0)
 ;;=1799^pulse q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,1,14,0)
 ;;=2957^[Extra Order]^3^NURSC^31^0
 ;;^UTILITY("^GMRD(124.2,",$J,130,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,130,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,131,0)
 ;;=Related Problems^2^NURSC^7^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,131,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,131,1,1,0)
 ;;=136^Comfort, Altered: Chest Pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,131,1,2,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,131,1,3,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,131,1,4,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,131,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,131,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,132,0)
 ;;=bed rest or immobility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,133,0)
 ;;=generalized weakness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,134,0)
 ;;=imbalance between oxygen supply and demand^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,135,0)
 ;;=sedentary life-style^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,136,0)
 ;;=Comfort, Altered: Chest Pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,137,0)
 ;;=Related Problems^2^NURSC^7^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,137,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,137,1,1,0)
 ;;=139^coping, ineffective, individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,137,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,137,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,137,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,138,0)
 ;;=bathing/hygiene^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,139,0)
 ;;=coping, ineffective, individual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,140,0)
 ;;=alteration in comfort related to pain^3^NURSC^^1^^^T
