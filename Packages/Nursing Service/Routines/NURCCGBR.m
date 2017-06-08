NURCCGBR ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8552,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8552,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8552,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8552,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8552,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8587,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8587,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8587,1,1,0)
 ;;=8589^Etiology/Related and/or Risk Factors^2^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,8587,1,2,0)
 ;;=8598^Related Problems^2^NURSC^100
 ;;^UTILITY("^GMRD(124.2,",$J,8587,1,3,0)
 ;;=8609^Goals/Expected Outcomes^2^NURSC^116
 ;;^UTILITY("^GMRD(124.2,",$J,8587,1,4,0)
 ;;=8640^Nursing Intervention/Orders^2^NURSC^99
 ;;^UTILITY("^GMRD(124.2,",$J,8587,1,5,0)
 ;;=8715^Defining Characteristics^2^NURSC^104
 ;;^UTILITY("^GMRD(124.2,",$J,8587,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8587,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8587,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8587,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,8587,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,8587,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,8587,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,8589,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^118^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8589,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8589,1,1,0)
 ;;=447^alveoli-capillary membrane changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8589,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8589,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8589,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8589,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8598,0)
 ;;=Related Problems^2^NURSC^7^100^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8598,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8598,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8598,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8598,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8598,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8598,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8609,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^116^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8609,1,0)
 ;;=^124.21PI^12^4
 ;;^UTILITY("^GMRD(124.2,",$J,8609,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8609,1,10,0)
 ;;=8629^attain/maintain vital signs at patient's baseline values^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8609,1,11,0)
 ;;=8738^[Extra Goal]^3^NURSC^150
 ;;^UTILITY("^GMRD(124.2,",$J,8609,1,12,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8609,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8629,0)
 ;;=attain/maintain vital signs at patient's baseline values^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8629,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8629,1,1,0)
 ;;=279^appropriate pulse rate for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8629,1,2,0)
 ;;=2695^baseline B/P for pt [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8629,1,3,0)
 ;;=7604^skin color and texture WNL for pt^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,8629,1,4,0)
 ;;=4914^temperature=[specify]^3^NURSC^1
