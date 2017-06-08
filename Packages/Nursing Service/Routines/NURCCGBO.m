NURCCGBO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8322,1,8,0)
 ;;=8473^[Extra Goal]^3^NURSC^148
 ;;^UTILITY("^GMRD(124.2,",$J,8322,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8325,0)
 ;;=normal breath sounds^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8325,4)
 ;;=attains/maintains
 ;;^UTILITY("^GMRD(124.2,",$J,8325,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8325,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8337,0)
 ;;=[Extra Goal]^3^NURSC^9^146^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8337,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8337,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^96^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,0)
 ;;=^124.21PI^18^17
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,1,0)
 ;;=556^temperature per[route] q[ frequency ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,2,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,3,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,4,0)
 ;;=495^culture sputum [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,5,0)
 ;;=334^pulmonary toilet q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,6,0)
 ;;=557^turn/reposition q[frequency]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,7,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,8,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,9,0)
 ;;=496^ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,10,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,11,0)
 ;;=497^provide humidity q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,12,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,13,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,15,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,16,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,17,0)
 ;;=8378^teach prevention of infection techniques [specify]^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,8340,1,18,0)
 ;;=8778^[Extra Order]^3^NURSC^153
 ;;^UTILITY("^GMRD(124.2,",$J,8340,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8340,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8342,0)
 ;;=[Extra Goal]^3^NURSC^9^147^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8342,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8342,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8343,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^97^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,0)
 ;;=^124.21PI^33^8
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,2,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,21,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,22,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,27,0)
 ;;=8400^assess,monitor,document peak flow q[specify] ^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,28,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,30,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,32,0)
 ;;=8425^bronchial hygiene:^2^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,8343,1,33,0)
 ;;=8930^[Extra Order]^3^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,8343,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8343,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8378,0)
 ;;=teach prevention of infection techniques [specify]^2^NURSC^11^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8378,1,0)
 ;;=^124.21PI^9^5
