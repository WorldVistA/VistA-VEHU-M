NURCCG19 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,436,1,3,0)
 ;;=440^GI bleed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,436,1,4,0)
 ;;=441^pneumothorax^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,436,1,5,0)
 ;;=442^subcutaneous emphysema^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,436,5)
 ;;=; monitor and document:
 ;;^UTILITY("^GMRD(124.2,",$J,436,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,436,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,436,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,437,0)
 ;;=provide communication (see Communication, Impaired Verbal)^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,437,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,437,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,438,0)
 ;;=Hypotension^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,439,0)
 ;;=tube displacement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,440,0)
 ;;=GI bleed^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,441,0)
 ;;=pneumothorax^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,442,0)
 ;;=subcutaneous emphysema^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,443,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,443,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,443,1,1,0)
 ;;=447^alveoli-capillary membrane changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,443,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,443,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,443,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,443,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,444,0)
 ;;=Related Problems^2^NURSC^7^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,444,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,444,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,444,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,444,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,444,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,444,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,445,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,1,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,3,0)
 ;;=451^identifies etiology^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,4,0)
 ;;=452^complies with treatment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,5,0)
 ;;=2691^has improved breath sounds^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,6,0)
 ;;=313^has normal respiratory rate/breathing pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,7,0)
 ;;=2692^has no signs of paradoxical breathing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,8,0)
 ;;=2693^has no signs of respiratory alternans^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,9,0)
 ;;=2411^afebrile, specify temperature less than [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,10,0)
 ;;=2694^hemodynamically stable^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,1,11,0)
 ;;=2875^[Extra Goal]^3^NURSC^52^0
 ;;^UTILITY("^GMRD(124.2,",$J,445,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,446,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,0)
 ;;=^124.21PI^31^31
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,2,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,446,1,3,0)
 ;;=322^B/P q[frequency]^3^NURSC^1^0
