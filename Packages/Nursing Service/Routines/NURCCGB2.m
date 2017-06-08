NURCCGB2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7412,0)
 ;;=on activity restrictions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7413,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^277^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,1,0)
 ;;=5020^assess ability to participate in and complete activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,2,0)
 ;;=5026^assist to develop a plan to recognize & manage mood changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,3,0)
 ;;=5007^implement measures to promote sleep [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,4,0)
 ;;=5018^monitor nutritional intake and weigh q[specify] days^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,5,0)
 ;;=5009^promote/maintain a safe environment [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,6,0)
 ;;=5015^protect from overstimulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,7,0)
 ;;=5013^redirect motor and verbal behavior [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,1,8,0)
 ;;=7417^[Extra Order]^3^NURSC^232
 ;;^UTILITY("^GMRD(124.2,",$J,7413,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7413,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7414,0)
 ;;=S/S requiring medical evaluation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7416,0)
 ;;=[Extra Order]^3^NURSC^11^67^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7416,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7416,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7417,0)
 ;;=[Extra Order]^3^NURSC^11^232^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7417,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7417,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7418,0)
 ;;=Sensory/Perception Alteration due to Toxic Substance^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7418,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,7418,1,1,0)
 ;;=7419^Goals/Expected Outcomes^2^NURSC^275
 ;;^UTILITY("^GMRD(124.2,",$J,7418,1,2,0)
 ;;=7610^Nursing Intervention/Orders^2^NURSC^278
 ;;^UTILITY("^GMRD(124.2,",$J,7418,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7418,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7418,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7419,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^275^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7419,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7419,1,1,0)
 ;;=2121^free of S/S of substance withdrawl within [# of days] days^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7419,1,2,0)
 ;;=7515^verbalizes knowledge use/abuse causes withdrawal syndrome^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7419,1,3,0)
 ;;=7577^verbalizes knowledge continued use/abuse has adverse outcome^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7419,1,4,0)
 ;;=7590^develop plan to maintain substance free life style^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7419,1,5,0)
 ;;=14809^[Extra Goal]^3^NURSC^131
 ;;^UTILITY("^GMRD(124.2,",$J,7419,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7420,0)
 ;;=Fluid Volume Excess (Actual/Potential)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7420,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7420,1,1,0)
 ;;=7421^Etiology/Related and/or Risk Factors^2^NURSC^104
 ;;^UTILITY("^GMRD(124.2,",$J,7420,1,2,0)
 ;;=7425^Related Problems^2^NURSC^88
 ;;^UTILITY("^GMRD(124.2,",$J,7420,1,3,0)
 ;;=7432^Goals/Expected Outcomes^2^NURSC^82
 ;;^UTILITY("^GMRD(124.2,",$J,7420,1,4,0)
 ;;=7454^Nursing Intervention/Orders^2^NURSC^88
 ;;^UTILITY("^GMRD(124.2,",$J,7420,1,5,0)
 ;;=7508^Defining Characteristics^2^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,7420,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7420,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7420,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7420,"TD",0)
 ;;=^^2^2^2890802^^^^
