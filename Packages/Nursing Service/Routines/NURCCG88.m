NURCCG88 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4376,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4376,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4377,0)
 ;;=Pain, Chest^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4377,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4377,1,1,0)
 ;;=4509^Etiology/Related and/or Risk Factors^2^NURSC^209
 ;;^UTILITY("^GMRD(124.2,",$J,4377,1,2,0)
 ;;=4510^Goals/Expected Outcomes^2^NURSC^209
 ;;^UTILITY("^GMRD(124.2,",$J,4377,1,3,0)
 ;;=4513^Nursing Intervention/Orders^2^NURSC^210
 ;;^UTILITY("^GMRD(124.2,",$J,4377,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4377,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4377,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4378,0)
 ;;=Pain, Chest^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4378,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4378,1,1,0)
 ;;=4390^Etiology/Related and/or Risk Factors^2^NURSC^204
 ;;^UTILITY("^GMRD(124.2,",$J,4378,1,2,0)
 ;;=4403^Goals/Expected Outcomes^2^NURSC^201
 ;;^UTILITY("^GMRD(124.2,",$J,4378,1,3,0)
 ;;=4407^Nursing Intervention/Orders^2^NURSC^202
 ;;^UTILITY("^GMRD(124.2,",$J,4378,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4378,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4378,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4379,0)
 ;;=Nutrition, Alteration in:(Less Than Required) ^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4379,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4379,1,1,0)
 ;;=4449^Goals/Expected Outcomes^2^NURSC^204
 ;;^UTILITY("^GMRD(124.2,",$J,4379,1,2,0)
 ;;=4450^Nursing Intervention/Orders^2^NURSC^204
 ;;^UTILITY("^GMRD(124.2,",$J,4379,1,3,0)
 ;;=2543^Etiology/Related and/or Risk Factors^2^NURSC^68
 ;;^UTILITY("^GMRD(124.2,",$J,4379,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4379,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4379,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4380,0)
 ;;=Cardiac Index (CI) [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4381,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^203^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4381,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4381,1,1,0)
 ;;=4405^electrophysiological disturbance/impulse formation/conduct^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4381,1,2,0)
 ;;=4368^alteration in preload/afterload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4381,1,3,0)
 ;;=4371^activity intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4381,1,4,0)
 ;;=134^imbalance between oxygen supply and demand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4381,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4382,0)
 ;;=Cardiac Output (CO) [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4383,0)
 ;;=SVR (systemic vascular resistance) [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4384,0)
 ;;=PAWP pulmonary artery wedge pressure [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4386,0)
 ;;=BP [specify systolic/diastolic HIGH] to [specify LOW]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4387,0)
 ;;=pulse [specify range] ^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4388,0)
 ;;=respirations [specify range]^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4389,0)
 ;;=Fluid Volume, Altered: Excess^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4389,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4389,1,1,0)
 ;;=4444^Goals/Expected Outcomes^2^NURSC^203
 ;;^UTILITY("^GMRD(124.2,",$J,4389,1,2,0)
 ;;=4447^Nursing Intervention/Orders^2^NURSC^203
 ;;^UTILITY("^GMRD(124.2,",$J,4389,1,3,0)
 ;;=1508^Etiology/Related and/or Risk Factors^2^NURSC^39
 ;;^UTILITY("^GMRD(124.2,",$J,4389,1,4,0)
 ;;=4052^Defining Characteristics^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4389,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4389,9)
 ;;=D EN2^NURCCPU3
