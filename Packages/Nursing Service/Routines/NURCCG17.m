NURCCG17 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/28/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,3,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,4,0)
 ;;=425^identifies causative factors and preventive measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,5,0)
 ;;=2713^no signs of respiratory alternans or paradoxical breathing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,6,0)
 ;;=2714^no signs of paradoxical breathing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,7,0)
 ;;=450^remains free of S/S of hypoxia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,8,0)
 ;;=2715^remains free of hypercapnea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,9,0)
 ;;=613^verbalizes awareness of the cause/contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,10,0)
 ;;=836^verbalizes preventive measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,1,11,0)
 ;;=2874^[Extra Goal]^3^NURSC^51^0
 ;;^UTILITY("^GMRD(124.2,",$J,417,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,418,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^167^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,0)
 ;;=^124.21PI^31^31
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,4,0)
 ;;=426^level of consciousness q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,5,0)
 ;;=427^respiratory pattern q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,6,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,7,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,8,0)
 ;;=428^peak flows [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,9,0)
 ;;=330^elevate head of bed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,10,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,11,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,12,0)
 ;;=337^I&O q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,13,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,14,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,15,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,16,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,17,0)
 ;;=389^oxygen [numeric value]% per [flow rate]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,18,0)
 ;;=432^provide for relief of pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,19,0)
 ;;=433^use relaxation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,20,0)
 ;;=434^provide calm, supportive environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,21,0)
 ;;=435^provide patient teaching on the mechanical ventilator^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,22,0)
 ;;=436^assess for complications of mechanical ventilation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,23,0)
 ;;=437^provide communication (see Communication, Impaired Verbal)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,24,0)
 ;;=2700^document use of accessory muscles q [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,25,0)
 ;;=2699^ear oximetry q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,26,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,27,0)
 ;;=2701^peak flows [frequency]^3^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,28,0)
 ;;=2702^bronchial hygiene q[frequency]hrs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,29,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,418,1,30,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
