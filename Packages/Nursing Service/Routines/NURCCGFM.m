NURCCGFM ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,13,0)
 ;;=389^oxygen [numeric value]% per [flow rate]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,14,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,15,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,16,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,17,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,18,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,19,0)
 ;;=454^encourage rest^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,20,0)
 ;;=455^tracheostomy care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,21,0)
 ;;=434^provide calm, supportive environment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,22,0)
 ;;=14619^provide patient teaching (Gas Exchange, Impaired)^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,23,0)
 ;;=14631^assess for complications of mechanical ventilation^2^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,24,0)
 ;;=437^provide communication (see Communication, Impaired Verbal)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,25,0)
 ;;=2699^ear oximetry q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,26,0)
 ;;=2700^document use of accessory muscles q [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,27,0)
 ;;=2701^peak flows [frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,28,0)
 ;;=14641^bronchial hygiene q[frequency]hrs^2^NURSC^15
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,29,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,30,0)
 ;;=14655^refer for appropriate consults^2^NURSC^79
 ;;^UTILITY("^GMRD(124.2,",$J,14595,1,31,0)
 ;;=15108^[Extra Order]^3^NURSC^258
 ;;^UTILITY("^GMRD(124.2,",$J,14595,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14595,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14599,0)
 ;;=respiratory pattern q [frequency]^2^NURSC^11^29^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14599,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,14599,1,1,0)
 ;;=2697^respiratory altenans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14599,1,2,0)
 ;;=2698^paradoxical breathing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14599,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,14599,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14599,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14599,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14619,0)
 ;;=provide patient teaching (Gas Exchange, Impaired)^2^NURSC^11^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,1,0)
 ;;=457^discuss risk factors [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,2,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,3,0)
 ;;=459^medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,4,0)
 ;;=460^pulmonary hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,5,0)
 ;;=461^signs of infection (for reporting to health care provider)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,6,0)
 ;;=462^inhalation equipment and oxygen therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,7,0)
 ;;=463^fire and safety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,8,0)
 ;;=464^ventilator use, cleaning, assembly, and back-up equipment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,9,0)
 ;;=465^suctioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,10,0)
 ;;=466^emergency care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,1,11,0)
 ;;=2712^tracheostomy care q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14619,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,14619,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14619,9)
 ;;=D EN2^NURCCPU2
