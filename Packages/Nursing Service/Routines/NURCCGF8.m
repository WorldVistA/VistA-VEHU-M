NURCCGF8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14230,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^157^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,0)
 ;;=^124.21PI^33^33
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,4,0)
 ;;=324^monitor use of accessory muscles^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,5,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,6,0)
 ;;=326^cardiac rhythm q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,7,0)
 ;;=327^monitor peak flows q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,8,0)
 ;;=328^observe sputum for color, consistency, amount^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,9,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,10,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,11,0)
 ;;=331^position to mobilize secretions q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,12,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,13,0)
 ;;=333^chest percussion q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,14,0)
 ;;=334^pulmonary toilet q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,15,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,16,0)
 ;;=336^provide adequate hydration and nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,17,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,18,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,19,0)
 ;;=385^observe for anxiety; use calm, confident manner^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,20,0)
 ;;=386^incentive spirometer q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,21,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,22,0)
 ;;=388^sputum culture as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,23,0)
 ;;=389^oxygen [numeric value]% per [flow rate]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,24,0)
 ;;=390^humidity as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,25,0)
 ;;=391^explain procedures; be reassuring^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,26,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,27,0)
 ;;=393^splint incision while providing pulmonary toilet^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,28,0)
 ;;=394^teach methods to reduce pain, such as splinting^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,29,0)
 ;;=14274^provide patient teaching (Airway Clearance, Ineffective)^2^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,30,0)
 ;;=396^teach patient and SO procedures for quad cough^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,31,0)
 ;;=14308^respiratory pattern q [frequency]^2^NURSC^27
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,32,0)
 ;;=14315^refer for appropriate consults^2^NURSC^77
 ;;^UTILITY("^GMRD(124.2,",$J,14231,1,33,0)
 ;;=14744^[Extra Order]^3^NURSC^254
 ;;^UTILITY("^GMRD(124.2,",$J,14231,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14231,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14245,0)
 ;;=Alcohol/Drug Dependency Rehabilitation^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14245,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14245,1,1,0)
 ;;=14247^Etiology/Related and/or Risk Factors^2^NURSC^191
 ;;^UTILITY("^GMRD(124.2,",$J,14245,1,2,0)
 ;;=14275^Goals/Expected Outcomes^2^NURSC^188
