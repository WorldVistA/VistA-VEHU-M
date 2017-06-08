NURCCGDE ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11553,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^273^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11553,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,11553,1,1,0)
 ;;=1343^inflammation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11553,1,2,0)
 ;;=1761^altered circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11553,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11556,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^285^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11556,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11556,1,1,0)
 ;;=11557^verbalizes causative factors for ulcer development^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11556,1,2,0)
 ;;=11558^demonstrates progressive healing of ulcer^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11556,1,3,0)
 ;;=11672^[Extra Goal]^3^NURSC^187
 ;;^UTILITY("^GMRD(124.2,",$J,11556,1,4,0)
 ;;=15613^demonstrates/directs treatment protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11556,1,5,0)
 ;;=836^verbalizes preventive measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11556,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11557,0)
 ;;=verbalizes causative factors for ulcer development^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11557,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11557,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11558,0)
 ;;=demonstrates progressive healing of ulcer^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11558,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11558,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11559,0)
 ;;=[Extra Goal]^3^NURSC^9^229^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11559,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11559,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^289^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,2,0)
 ;;=11567^assess size, stage of ulcer q[specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,3,0)
 ;;=12004^[Extra Order]^3^NURSC^193
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,4,0)
 ;;=15615^utilize protective aids [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,5,0)
 ;;=15616^apply barrier cream to at risk skin areas^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,6,0)
 ;;=15617^teach causative factors for ulcer development^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,7,0)
 ;;=7407^wound care/drsg change(s) of [specify area] q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,8,0)
 ;;=15619^assess patient's/caregiver's dressing technique^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,1,9,0)
 ;;=15374^debridement technique [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11560,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11567,0)
 ;;=assess size, stage of ulcer q[specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11567,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11567,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11568,0)
 ;;=[Extra Order]^3^NURSC^11^234^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11568,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11568,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11569,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11569,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11569,1,1,0)
 ;;=11570^Etiology/Related and/or Risk Factors^2^NURSC^156
 ;;^UTILITY("^GMRD(124.2,",$J,11569,1,2,0)
 ;;=11590^Goals/Expected Outcomes^2^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,11569,1,3,0)
 ;;=11595^Nursing Intervention/Orders^2^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,11569,1,4,0)
 ;;=11618^Related Problems^2^NURSC^135
 ;;^UTILITY("^GMRD(124.2,",$J,11569,1,5,0)
 ;;=11624^Defining Characteristics^2^NURSC^135
