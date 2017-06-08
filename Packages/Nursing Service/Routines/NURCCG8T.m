NURCCG8T ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4684,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4684,1,1,0)
 ;;=4685^anesthesia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4684,1,2,0)
 ;;=4686^midline incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4684,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4685,0)
 ;;=anesthesia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4686,0)
 ;;=midline incision^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4687,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^222^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4687,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4687,1,1,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4687,1,2,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4687,1,3,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4687,1,4,0)
 ;;=4844^[Extra Goal]^3^NURSC^20
 ;;^UTILITY("^GMRD(124.2,",$J,4687,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4691,0)
 ;;=[Extra Goal]^3^NURSC^9^15^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4691,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4691,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4692,0)
 ;;=demonstrates skills & verbalizes knowledge in:^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4692,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4692,1,1,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4692,1,2,0)
 ;;=4698^treatment regime^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4692,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4692,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4692,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4693,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^222^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4693,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4693,1,1,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4693,1,2,0)
 ;;=4461^cough and deep breath q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4693,1,3,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4693,1,4,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4693,1,5,0)
 ;;=4720^[Extra Order]^3^NURSC^216
 ;;^UTILITY("^GMRD(124.2,",$J,4693,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4693,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4694,0)
 ;;=Cancer of the Larynx^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4694,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4694,1,1,0)
 ;;=4696^Gas Exchange, Impaired^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,4694,1,2,0)
 ;;=4824^Pain, Chronic^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4694,1,3,0)
 ;;=4855^Swallowing, Impaired^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4694,1,4,0)
 ;;=4881^Anxiety^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4694,1,5,0)
 ;;=4937^[Extra Problem]^2^NURSC^46
 ;;^UTILITY("^GMRD(124.2,",$J,4696,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4696,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4696,1,1,0)
 ;;=4700^Etiology/Related and/or Risk Factors^2^NURSC^218
 ;;^UTILITY("^GMRD(124.2,",$J,4696,1,2,0)
 ;;=4702^Goals/Expected Outcomes^2^NURSC^223
 ;;^UTILITY("^GMRD(124.2,",$J,4696,1,3,0)
 ;;=4742^Nursing Intervention/Orders^2^NURSC^226
 ;;^UTILITY("^GMRD(124.2,",$J,4696,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4696,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4696,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4698,0)
 ;;=treatment regime^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4699,0)
 ;;=[Extra Order]^3^NURSC^11^215^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4699,9)
 ;;=D EN2^NURCCPU2
