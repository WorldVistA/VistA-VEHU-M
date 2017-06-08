NURCCG1A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,4,0)
 ;;=427^respiratory pattern q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,5,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,6,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,7,0)
 ;;=453^CBC with differential q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,8,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,9,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,10,0)
 ;;=330^elevate head of bed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,12,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,13,0)
 ;;=389^oxygen [numeric value]% per [flow rate]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,14,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,15,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,16,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,17,0)
 ;;=337^I&O q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,18,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,19,0)
 ;;=454^encourage rest^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,20,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,21,0)
 ;;=434^provide calm, supportive environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,22,0)
 ;;=456^provide patient teaching (Gas Exchange, Impaired)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,23,0)
 ;;=436^assess for complications of mechanical ventilation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,24,0)
 ;;=437^provide communication (see Communication, Impaired Verbal)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,25,0)
 ;;=2699^ear oximetry q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,26,0)
 ;;=2700^document use of accessory muscles q [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,27,0)
 ;;=2701^peak flows [frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,28,0)
 ;;=2702^bronchial hygiene q[frequency]hrs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,29,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,30,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,31,0)
 ;;=2962^[Extra Order]^3^NURSC^39^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,446,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,447,0)
 ;;=alveoli-capillary membrane changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,448,0)
 ;;=blood flow, altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,449,0)
 ;;=oxygen carrying capacity of blood altered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,450,0)
 ;;=remains free of S/S of hypoxia^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,450,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,450,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,451,0)
 ;;=identifies etiology^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,451,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,451,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,452,0)
 ;;=complies with treatment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,452,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,452,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,453,0)
 ;;=CBC with differential q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,453,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,453,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,454,0)
 ;;=encourage rest^3^NURSC^11^1^^^T
