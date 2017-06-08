NURCCGFX ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/28/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14937,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14937,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14945,0)
 ;;=[Extra Goal]^3^NURSC^9^251^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14945,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14945,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^200^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,0)
 ;;=^124.21PI^34^29
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,4,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,6,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,7,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,8,0)
 ;;=428^peak flows [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,9,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,10,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,11,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,12,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,13,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,14,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,15,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,16,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,17,0)
 ;;=389^oxygen [numeric value]% per [flow rate]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,18,0)
 ;;=432^provide for relief of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,19,0)
 ;;=433^use relaxation techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,20,0)
 ;;=434^provide calm, supportive environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,21,0)
 ;;=435^provide patient teaching on the mechanical ventilator^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,23,0)
 ;;=437^provide communication (see Communication, Impaired Verbal)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,24,0)
 ;;=2700^document use of accessory muscles q [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,25,0)
 ;;=2699^ear oximetry q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,26,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,27,0)
 ;;=2701^peak flows [frequency]^3^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,28,0)
 ;;=14981^bronchial hygiene q[frequency]hrs^2^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,29,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,31,0)
 ;;=15555^[Extra Order]^3^NURSC^262
 ;;^UTILITY("^GMRD(124.2,",$J,14946,1,34,0)
 ;;=4858^use of incentive spirometer q[freq]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14946,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14981,0)
 ;;=bronchial hygiene q[frequency]hrs^2^NURSC^11^16^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,14981,1,0)
 ;;=^124.21PI^9^4
 ;;^UTILITY("^GMRD(124.2,",$J,14981,1,3,0)
 ;;=2705^postural drainage q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14981,1,4,0)
 ;;=430^percussion q[frequency]^3^NURSC^1
