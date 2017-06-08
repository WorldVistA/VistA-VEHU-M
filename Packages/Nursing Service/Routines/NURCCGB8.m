NURCCGB8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7591,"TD",1,0)
 ;;=A state in which an individual has insufficient physiological or
 ;;^UTILITY("^GMRD(124.2,",$J,7591,"TD",2,0)
 ;;=psychological energy to endure or complete required or desired
 ;;^UTILITY("^GMRD(124.2,",$J,7591,"TD",3,0)
 ;;=daily activities.
 ;;^UTILITY("^GMRD(124.2,",$J,7592,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^106^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7592,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,7592,1,2,0)
 ;;=133^generalized weakness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7592,1,4,0)
 ;;=135^sedentary life-style^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7592,1,5,0)
 ;;=15516^anemic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7592,1,6,0)
 ;;=15517^hypertension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7592,1,7,0)
 ;;=15518^prone to CAD^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7592,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7597,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^104^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7597,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,7597,1,1,0)
 ;;=275^verbalizes/demonstrates decreased fatigue with activity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7597,1,3,0)
 ;;=277^demonstrates increased independence for self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7597,1,4,0)
 ;;=7601^hemodynamically stable during activity^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7597,1,6,0)
 ;;=7688^[Extra Goal]^3^NURSC^139
 ;;^UTILITY("^GMRD(124.2,",$J,7597,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7601,0)
 ;;=hemodynamically stable during activity^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7601,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,7601,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7601,1,2,0)
 ;;=280^B/P^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7601,1,3,0)
 ;;=7604^skin color and texture WNL for pt^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7601,1,4,0)
 ;;=2647^ear oximetry indicates oxygen saturation of 90% or greater^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7601,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,7601,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7601,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7601,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7604,0)
 ;;=skin color and texture WNL for pt^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7607,0)
 ;;=[Extra Goal]^3^NURSC^9^138^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7607,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7607,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^90^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,0)
 ;;=^124.21PI^20^10
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,4,0)
 ;;=285^plan activities to maximize medication/treatment benefits^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,5,0)
 ;;=286^provide [number of] minutes of rest between activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,6,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,7,0)
 ;;=288^initiate muscle strengthening/conditioning as indiciated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,8,0)
 ;;=7622^refer for appropriate consults^2^NURSC^20
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,11,0)
 ;;=2655^respiratory rate during activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,14,0)
 ;;=7660^[Extra Order]^3^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,16,0)
 ;;=15523^monitor pulse/BP during activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,17,0)
 ;;=5904^assess for signs of fatigue and weakness^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7608,1,20,0)
 ;;=15564^instruct patient in:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7608,9)
 ;;=D EN1^NURCCPU2
