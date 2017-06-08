NURCCG89 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4389,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4390,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^204^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4390,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4390,1,1,0)
 ;;=4353^anxiety/threat of death^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4390,1,2,0)
 ;;=761^physiologic^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4390,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,0)
 ;;=maintain fluid/electrolytes WNL for patient^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4392,1,1,0)
 ;;=4393^electrolytes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,1,2,0)
 ;;=4394^BUN [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,1,3,0)
 ;;=4395^creatinine [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,1,4,0)
 ;;=4396^enzymes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4392,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4392,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4393,0)
 ;;=electrolytes [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4394,0)
 ;;=BUN [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4395,0)
 ;;=creatinine [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4396,0)
 ;;=enzymes [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4397,0)
 ;;=maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4397,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4397,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4398,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^11^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4398,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,4398,1,2,0)
 ;;=4402^Goals/Expected Outcomes^2^NURSC^200
 ;;^UTILITY("^GMRD(124.2,",$J,4398,1,3,0)
 ;;=4404^Nursing Intervention/Orders^2^NURSC^201
 ;;^UTILITY("^GMRD(124.2,",$J,4398,1,4,0)
 ;;=415^Etiology/Related and/or Risk Factors^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4398,1,5,0)
 ;;=4070^Defining Characteristics^2^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4398,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4398,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4398,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4400,0)
 ;;=[Extra Goal]^3^NURSC^9^118^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4400,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4400,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4402,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^200^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4402,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4402,1,2,0)
 ;;=4464^maintains nutritional intake to meet metabolic requirements^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4402,1,3,0)
 ;;=4482^[Extra Goal]^3^NURSC^48
 ;;^UTILITY("^GMRD(124.2,",$J,4402,1,4,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4402,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4403,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^201^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,1,0)
 ;;=4362^verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,3,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,4,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,5,0)
 ;;=2025^reports decrease in signs/symptoms of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4403,1,6,0)
 ;;=4518^[Extra Goal]^3^NURSC^6
