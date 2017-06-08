NURCCG9J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5018,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5019,0)
 ;;=[etiology]^3^NURSC^^51^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5020,0)
 ;;=assess ability to participate in and complete activities^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5020,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5020,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5021,0)
 ;;=assess for S/S of weakness or fatigue q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5021,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,5021,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5021,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5022,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^248^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5022,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5022,1,1,0)
 ;;=5023^[Extra Goal]^3^NURSC^299
 ;;^UTILITY("^GMRD(124.2,",$J,5022,1,2,0)
 ;;=5025^[Extra Goal]^3^NURSC^300
 ;;^UTILITY("^GMRD(124.2,",$J,5022,1,3,0)
 ;;=5027^[Extra Goal]^3^NURSC^301
 ;;^UTILITY("^GMRD(124.2,",$J,5022,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5023,0)
 ;;=[Extra Goal]^3^NURSC^9^299^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5023,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5023,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5024,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^14^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5024,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,5024,1,1,0)
 ;;=5028^Etiology/Related and/or Risk Factors^2^NURSC^244
 ;;^UTILITY("^GMRD(124.2,",$J,5024,1,3,0)
 ;;=5029^Goals/Expected Outcomes^2^NURSC^249
 ;;^UTILITY("^GMRD(124.2,",$J,5024,1,4,0)
 ;;=5033^Nursing Intervention/Orders^2^NURSC^250
 ;;^UTILITY("^GMRD(124.2,",$J,5024,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5024,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5024,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5025,0)
 ;;=[Extra Goal]^3^NURSC^9^300^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5025,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5025,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5026,0)
 ;;=assist to develop a plan to recognize & manage mood changes^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5026,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5026,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5027,0)
 ;;=[Extra Goal]^3^NURSC^9^301^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5027,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5027,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5028,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^244^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5028,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5028,1,1,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5028,1,2,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5028,1,3,0)
 ;;=447^alveoli-capillary membrane changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5028,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5029,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^249^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,5029,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,5029,1,1,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5029,1,2,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5029,1,4,0)
 ;;=4905^hemodynamically stable^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5029,1,5,0)
 ;;=5094^[Extra Goal]^3^NURSC^40
 ;;^UTILITY("^GMRD(124.2,",$J,5029,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5030,0)
 ;;=Pain, Chest^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5030,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5030,1,1,0)
 ;;=5031^Etiology/Related and/or Risk Factors^2^NURSC^245
