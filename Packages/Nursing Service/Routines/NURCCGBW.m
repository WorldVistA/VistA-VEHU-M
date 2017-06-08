NURCCGBW ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8939,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8939,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8940,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^283^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8940,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8940,1,1,0)
 ;;=8941^[Extra Order]^3^NURSC^351
 ;;^UTILITY("^GMRD(124.2,",$J,8940,1,2,0)
 ;;=8942^[Extra Order]^3^NURSC^352
 ;;^UTILITY("^GMRD(124.2,",$J,8940,1,3,0)
 ;;=8943^[Extra Order]^3^NURSC^353
 ;;^UTILITY("^GMRD(124.2,",$J,8940,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8940,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8941,0)
 ;;=[Extra Order]^3^NURSC^11^351^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8941,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8941,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8942,0)
 ;;=[Extra Order]^3^NURSC^11^352^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8942,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8942,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8943,0)
 ;;=[Extra Order]^3^NURSC^11^353^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8943,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8943,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8944,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8944,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8944,1,1,0)
 ;;=8945^Etiology/Related and/or Risk Factors^2^NURSC^122
 ;;^UTILITY("^GMRD(124.2,",$J,8944,1,2,0)
 ;;=8950^Related Problems^2^NURSC^104
 ;;^UTILITY("^GMRD(124.2,",$J,8944,1,3,0)
 ;;=8955^Goals/Expected Outcomes^2^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,8944,1,4,0)
 ;;=8970^Nursing Intervention/Orders^2^NURSC^103
 ;;^UTILITY("^GMRD(124.2,",$J,8944,1,5,0)
 ;;=9040^Defining Characteristics^2^NURSC^107
 ;;^UTILITY("^GMRD(124.2,",$J,8944,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8944,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8944,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8944,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,8944,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,8944,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,8944,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,8945,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^122^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8945,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,8945,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8945,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8945,1,4,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8945,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8950,0)
 ;;=Related Problems^2^NURSC^7^104^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8950,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8950,1,1,0)
 ;;=126^Hypoxia (see Gas Exchange, Impaired)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8950,1,2,0)
 ;;=2398^Breathing Pattern, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8950,1,3,0)
 ;;=125^Hypoventilation (see Breathing Pattern, Ineffective)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8950,1,4,0)
 ;;=2396^Airway Clearance, Ineffective^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8950,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8955,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^120^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8955,1,0)
 ;;=^124.21PI^12^3
 ;;^UTILITY("^GMRD(124.2,",$J,8955,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8955,1,11,0)
 ;;=9073^[Extra Goal]^3^NURSC^153
 ;;^UTILITY("^GMRD(124.2,",$J,8955,1,12,0)
 ;;=316^attains/maintains ABGs/pulse oximetry within normal range^3^NURSC^1
